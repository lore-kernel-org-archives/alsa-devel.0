From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001942]: [PATCH] added support uncommon "rate"
Date: Fri, 24 Mar 2006 21:38:15 +0100
Message-ID: <7ef608f9e1afe79a87cf661a0c628850@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B48DA1DE
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 21:38:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1942> 
======================================================================
Reported By:                os-bebas
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1942
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               UBuntu Dapper Drake
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             03-18-2006 23:48 CET
Last Modified:              03-24-2006 21:38 CET
======================================================================
Summary:                    [PATCH] added support uncommon "rate"
Description: 
attached you can find a simple patch to match
"uncommon" rate in some USB speaker to the fixed
conv_rates in usbaudio.c.

Signed-off-by: S. Effendi <osbebas@yahoo.co.id>

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 03-24-06 14:35 
----------------------------------------------------------------------
>From your computer's POV, the device runs at about 45148 Hz.  You might try
"count=40000" for a more precise measurement.

Anyway, mpg123 shouldn't complain, the OSS emulation is able to resample
from any frequency.

Please try to use the ALSA interface instead of OSS.

----------------------------------------------------------------------
 os-bebas - 03-24-06 21:38 
----------------------------------------------------------------------
> From your computer's POV, the device runs at about 45148 Hz. You might
try "count=40000" for a more precise measurement.

hm... not repeating myself but as I said:
It's better for me to hear sounds as to get error message: "no supported
rate".
Even if it is not the "perfect sound", better than "not supported!" at
all.

> Anyway, mpg123 shouldn't complain, the OSS emulation is able to resample
from any frequency.
> Please try to use the ALSA interface instead of OSS. 

I hope I don't misunderstand you. Without my patch neither OSS nor ALSA is
working. I get following errors without the patch:
---
root@d1:/lib/modules# time ( dd if=/dev/zero bs=1000 count=4000 | aplay -D
hw:1 -t raw -f cd - )
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
aplay: set_params:874: Broken configuration for this PCM: no
configurations available

real    0m0.052s
user    0m0.015s
sys     0m0.003s

xmms failed with following error:
ALSA lib pcm_params.c:2154:(snd_pcm_hw_refine_slave) Slave PCM not usable

*** WARNING **: alsa_setup(): No configuration available for playback:
Invalid argument
---

Again, with the patch applied I get following result:
---
root@d1:/lib/modules# time ( dd if=/dev/zero bs=1000 count=40000 | aplay
-D hw:1 -t raw -f cd - )
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
40000+0 records in
40000+0 records out
40000000 bytes (40 MB) copied, 225.744 seconds, 177 kB/s

real    3m46.764s
user    0m0.030s
sys     0m0.119s
---
root@d1:/lib/modules# cat /proc/asound/card1/stream0 USB Audio Device at
usb-0000:00:1d.0-2.1, full speed : USB Audio

Playback:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 OUT (ADAPTIVE)
    Rates: 44100

and xmms using ALSA or with OSS-emulation works just fine.

best regards.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-18-06 23:48 os-bebas       New Issue                                    
03-18-06 23:48 os-bebas       File Added: alsa_usbaudio_conv_rates_fixed.patch  
                 
03-18-06 23:48 os-bebas       Distribution              => UBuntu Dapper Drake
03-18-06 23:48 os-bebas       Kernel Version            => 2.6.15.6        
03-20-06 09:09 Clemens LadischNote Added: 0008712                          
03-23-06 18:30 os-bebas       Note Added: 0008900                          
03-23-06 19:09 Clemens LadischNote Added: 0008901                          
03-23-06 23:47 os-bebas       Note Added: 0008906                          
03-24-06 14:35 Clemens LadischNote Added: 0008917                          
03-24-06 21:38 os-bebas       Note Added: 0008938                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
