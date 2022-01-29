local noclip = false
local noclip_speed = 3.0



function getPosition()
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	return x,y,z
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
	local pitch = GetGameplayCamRelativePitch()

	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)

	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end

	return x,y,z
end

function isNoclip()
	return noclip
end


RegisterCommand("noclip", function()
	local player = PlayerId()
	local ped = PlayerPedId
	
	local msg = "desactivado"
	if(noclip == false)then
	end

	noclip = not noclip

	if(noclip)then
		msg = "activado"
	end

	TriggerEvent("chatMessage", "Noclip ^2^*" .. msg)
		SetEntityVisible(GetPlayerPed(-1), true, 0)

	end)

	local heading = 0
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if noclip then
			local ped = GetPlayerPed(-1)
			local x,y,z = getPosition()
			local dx,dy,dz = getCamDirection()
			local speed = noclip_speed

			SetEntityVisible(GetPlayerPed(-1), false, 0)


			SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)


		if IsControlPressed(0,32) then -- MOVE UP
			x = x+speed*dx
			y = y+speed*dy
			z = z+speed*dz
		end

		if(IsControlPressed(1, 27))then
			noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 2.0)
		end
		if IsControlPressed(0,21) then
			noclip_speed = 0.75
		else
			noclip_speed = 3.0
		end

		if(IsControlPressed(1, 173))then
			noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -2.0)
		end

		if IsControlPressed(0,269) then
			x = x-speed*dx
			y = y-speed*dy
			z = z-speed*dz
		end

		SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
		end
	end
end)
