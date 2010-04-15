From: EasyLife21 x3dre <easylife21@hotmail.com>
Subject: Problem with sound on an HP HDX9200
Date: Thu, 15 Apr 2010 14:30:15 +0000
Message-ID: <BLU119-W28589FD64F4D3C414B73C3C40F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s8.blu0.hotmail.com (blu0-omc3-s8.blu0.hotmail.com
	[65.55.116.83]) by alsa0.perex.cz (Postfix) with ESMTP id 315EA24399
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Apr 2010 16:30:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Development Team,

I have been working with wirechief & Thingol into trying to get my speaker system working with alsabut I have run into problems making sound work on the internal Altec Lansing  speakers.
To start I use sidux distro and I am running kernel 2.6.33-2 which since using this kernel, all soundonboard ceased to work through the speakers. Though through the ports at the front of the laptopthe headphone port plays sound. Which is the only way to hear music from the laptop to my headphones.
When I was using 2.6.29 kernels, I never had a problem with sound and all the speakers worked well.So I think something must have been deprecated in the 2.6.3x series of kernels, that has killed my sound output.
Below is the pins I used from windows on configuring sound to work. Though what is happening now isthat I hear sounds using speaker-test -Dplug:surround51 -c6 -twav but the sound is split between ;
 0 - Front Left    = sound through headphones jack port on front of laptop
 4 - Center        = no sound
 1 - Front Right   = sound through headphones jack port on front of laptop
 3 - Rear Right    = sound through laptop speakers
 2 - Rear Left     = sound through laptop speakers
 5 - LFE           = no sound

 
echo 0x0a 0x0221201f > /sys/class/sound/hwC0D0/user_pin_configsecho 0x0b 0x0221201f > /sys/class/sound/hwC0D0/user_pin_configsecho 0x0c 0x9017001f > /sys/class/sound/hwC0D0/user_pin_configsecho 0x0d 0x01112014 > /sys/class/sound/hwC0D0/user_pin_configsecho 0x0e 0x02a12021 > /sys/class/sound/hwC0D0/user_pin_configsecho 0x0f 0x01116011 > /sys/class/sound/hwC0D0/user_pin_configsecho 0x10 0x01113012 > /sys/class/sound/hwC0D0/user_pin_configsecho 0x11 0x01114010 > /sys/class/sound/hwC0D0/user_pin_configsecho 0x12 0x95a30020 > /sys/class/sound/hwC0D0/user_pin_configsecho 0x21 0x20441030 > /sys/class/sound/hwC0D0/user_pin_configs echo 1 > /sys/class/sound/hwC0D0/reconfig

http://paste.debian.net/68912/  (old alsa-info), http://pastebin.ca/1861801 (windows .ini file), http://pastebin.com/4ckCBq0z (user_pin_configs)  http://paste.debian.net/68997/ (new alsa-info)
www.alsa-project.org/db/?f=4d48c4a628c0a739a395db728b599fc310a0c534

tia
Dre  :)

 		 	   		  
_________________________________________________________________
http://clk.atdmt.com/UKM/go/195013117/direct/01/
We want to hear all your funny, exciting and crazy Hotmail stories. Tell us now
