From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001014]: card detect function is never called in pxa2xx-ac97
Date: Sun, 3 Apr 2005 21:47:47 +0200
Message-ID: <2acc36185cb0b9bc400033b231333fa0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AA9841E7
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 21:47:47 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1014> 
======================================================================
Reported By:                twinsen
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1014
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               custom: PXA255/uClibc
Kernel Version:             2.6.11.5
======================================================================
Date Submitted:             03-25-2005 00:04 CET
Last Modified:              04-03-2005 21:47 CEST
======================================================================
Summary:                    card detect function is never called in pxa2xx-ac97
Description: 
Hi there,
I have a some problem with this driver. The environment:
ALSA source: alsa-driver-1.0.9rc1
Kernel source: linux-2.6.11.5 (stock)

I cross compiled the kernel and the alsa source for arm target with a 
toolchain from handhelds.org. I used the following configure command
line:

./configure --with-cards=pxa2xx-ac97 
--with-kernel=/home/twinsen/EmbeddedLinux/Kernel/linux-2.6.11.5 
--with-build=/home/twinsen/EmbeddedLinux/Kernel/linux-2.6.11.5 
--with-cross=/usr/local/arm/3.3.2/bin/arm-linux-

config runs without problems, when running make gcc complains about
"pci_dev_present" being redefined (alsa-driver-1.0.9rc1/include/adriver.h,
orig: include/linux/pci.h), but compiles ok. 

The problem:
I loaded all modules (snd, snd-timer, snd-page-alloc, snd-pcm,
snd-ac97-codec, snd-pxa2xx-pcm, snd-pxa2xx-ac97) but still no soundcard in
/proc/asound/cards.
I looked a bit inside the driver, and when snd-pxa2xx-ac97 is loaded, the
module init function registers the new driver:
driver_register(&pxa2xx_ac97_driver);

The driver struct contains a probe function:
.probe          = pxa2xx_ac97_probe,
but it's never called, so the driver doesn't even check the existance of
the sound card. Why is that? Did I srcew up the cross compiling?
Thanks:
	George
======================================================================

----------------------------------------------------------------------
 twinsen - 03-29-05 23:43 
----------------------------------------------------------------------
The driver actually fails here: 
<kernel>/drivers/base/bus.c
int driver_probe_device(struct device_driver * drv, struct device * dev)
{
        if (drv->bus->match && !drv->bus->match(dev, drv)) return
-ENODEV;

The device ID of the device doesn't match the device ID of the driver. (or
something like that according to the comment of this function)
Unfortunately i don't know too much about kernel internals, and have no
idea what to do... :(
Commenting the line out didn't help :) Nice kernel panic with looong
backtrace.

----------------------------------------------------------------------
 twinsen - 04-03-05 21:47 
----------------------------------------------------------------------
Partly Resolved! :)
The platform_device_register() call was missing from my board support
file. Now the driver load ok, but i get the following error messages when
trying to run speaker-test:

# speaker-test -c 2 -Dhw:0,0 -r 44100 -f 440 -F S16_LE

speaker-test 0.0.7

Playback device is hw:0,0
Stream parameters are 44100Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Trizeps2 audio startup
Rate set to 44100Hz (requested 44100Hz)
Buffer size range from 8 to 32Trizeps2 audio shutdown
768
Period size range from 8 to 2040
Periods = 4
Buffer time Trizeps2 audio startup
size 575
To choose buffer_size = 15052
To choose period_size =Trizeps2 audio shutdown
 3763
was set period_size = 0
was set buffer_size = 15056
UnaTrizeps2 audio startup
ble to set sw params for playback: Invalid argument
Setting of Trizeps2 audio shutdown
swparams failed: Invalid argument

(this goes on forever, until i hit ctrl-c)
 Do you have any idea why this happens? Cross-compilation problem? Where
to start debugging?
Thanks!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-05 00:04 twinsen        New Issue                                    
03-25-05 00:04 twinsen        Distribution              => custom: PXA255/uClibc
03-25-05 00:04 twinsen        Kernel Version            => 2.6.11.5        
03-29-05 16:25 tiwai          Note Added: 0004247                          
03-29-05 23:43 twinsen        Note Added: 0004259                          
04-03-05 21:47 twinsen        Note Added: 0004321                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
