From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000745]: Crash when unplugging USB Headset
Date: Fri, 24 Dec 2004 13:03:26 +0100
Message-ID: <c61f88d2616ee582f96d1712ea5e4829@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 67807230
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2004 13:03:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=745> 
======================================================================
Reported By:                greve
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   745
Category:                   USB - usb-audio
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.10-rc3 (also happened with 2.6.9)
======================================================================
Date Submitted:             12-24-2004 12:56 CET
Last Modified:              12-24-2004 13:03 CET
======================================================================
Summary:                    Crash when unplugging USB Headset
Description: 
Discovered this when trying to get a Logitech USB Headset to work.

All this with 2.6.9:

When first plugging it in, snd-usb-audio was missing, so recompiled
kernel, loaded module without rebooting (yes. i know. i was lazy.) and the
Headset worked perfectly fine.

When booting the machine the next time, headset was recognized propely,
usb-audio driver loaded, /proc/asound showed Headset soundcard, mixer
worked fine, no warning messages, but: NO SOUND. Everything CLAIMED to be
working fine, but the headset remained silent.

Tried around a couple of times with different settings of compiling things
into the kernel/as module and eventually gave kernel 2.6.10-rc3 a try.

While trying around with 2.6.9 and 2.6.10-rc3 both, at some time the
keyboard would stop to work while fiddling with the USB Headset
(pluggin/unplugging), while the mouse (also USB) was still working fine.
The machine would hang during reboot and had to be reset by button.

Below is the syslog output from the kernel for the latest crash.

I know this may not be the most helpful error report ever written -- but I
don't quite know where to look. Help appreciated.

If you need more info, please let me know.
======================================================================

----------------------------------------------------------------------
 greve - 12-24-04 13:03 
----------------------------------------------------------------------
Hoping that it will help, this is one of the message-blocks when plugging
the headset in:

Dec 23 19:59:26 reason kernel: hub 1-2:1.0: port 2, status 0101, change
0001, 12 Mb/s
Dec 23 19:59:26 reason kernel: hub 1-2:1.0: debounce: port 2: total 100ms
stable 100ms status 0x101
Dec 23 19:59:26 reason kernel: usb 1-2.2: new full speed USB device using
address 4
Dec 23 19:59:26 reason kernel: usb 1-2.2: skipped 11 descriptors after
interface
Dec 23 19:59:26 reason kernel: usb 1-2.2: skipped 2 descriptors after
interface
Dec 23 19:59:26 reason kernel: usb 1-2.2: skipped 1 descriptor after
endpoint
Dec 23 19:59:26 reason kernel: usb 1-2.2: skipped 2 descriptors after
interface
Dec 23 19:59:26 reason kernel: usb 1-2.2: skipped 1 descriptor after
endpoint
Dec 23 19:59:26 reason kernel: usb 1-2.2: skipped 2 descriptors after
interface
Dec 23 19:59:26 reason kernel: usb 1-2.2: skipped 1 descriptor after
endpoint
Dec 23 19:59:26 reason kernel: usb 1-2.2: new device strings: Mfr=1,
Product=2, SerialNumber=0
Dec 23 19:59:26 reason kernel: usb 1-2.2: default language 0x0409
Dec 23 19:59:26 reason kernel: usb 1-2.2: Product: Logitech USB Headset
Dec 23 19:59:26 reason kernel: usb 1-2.2: Manufacturer: Logitech
Dec 23 19:59:26 reason kernel: usb 1-2.2: hotplug
Dec 23 19:59:27 reason kernel: usb 1-2.2: adding 1-2.2:1.0 (config
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1,
interface 0)
Dec 23 19:59:27 reason kernel: usb 1-2.2:1.0: hotplug
Dec 23 19:59:27 reason kernel: audio 1-2.2:1.0: usb_probe_interface
Dec 23 19:59:27 reason kernel: audio 1-2.2:1.0: usb_probe_interface - got
id
Dec 23 19:59:27 reason kernel: usbaudio: device 4 audiocontrol interface 0
has 1 input and 1 output AudioStreaming interfaces
Dec 23 19:59:27 reason kernel: usbaudio: valid input sample rate 8000
Dec 23 19:59:27 reason kernel: usbaudio: valid input sample rate 48000
Dec 23 19:59:27 reason kernel: usbaudio: valid input sample rate 44100
Dec 23 19:59:27 reason kernel: usbaudio: valid input sample rate 22050
Dec 23 19:59:27 reason kernel: usbaudio: valid input sample rate 11025
Dec 23 19:59:27 reason kernel: usbaudio: device 4 interface 2 altsetting
1: format 0x00000010 sratelo 8000 sratehi 48000 attributes 0x01
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 8000
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 48000
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 44100
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 22050
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 11025
Dec 23 19:59:27 reason kernel: usbaudio: device 4 interface 1 altsetting
1: format 0x80000010 sratelo 8000 sratehi 48000 attributes 0x01
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 8000
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 48000
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 44100
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 22050
Dec 23 19:59:27 reason kernel: usbaudio: valid output sample rate 11025
Dec 23 19:59:27 reason kernel: usbaudio: device 4 interface 1 altsetting
2: format 0x00000010 sratelo 8000 sratehi 48000 attributes 0x01
Dec 23 19:59:27 reason kernel: usbaudio: registered dsp 14,3
Dec 23 19:59:27 reason kernel: usbaudio: constructing mixer for Terminal
14 type 0x0301
Dec 23 19:59:27 reason kernel: usbaudio: warning: found 1 of 2 logical
channels.
Dec 23 19:59:27 reason kernel: usbaudio: assuming that a stereo channel
connected directly to a mixer is missing in search (got Labtec headset?).
Should be
fine.
Dec 23 19:59:27 reason kernel: usbaudio: registered mixer 14,16
Dec 23 19:59:27 reason kernel: usbaudio: constructing mixer for Terminal
10 type 0x0101
Dec 23 19:59:28 reason kernel: usbaudio: registered mixer 14,32
Dec 23 19:59:28 reason kernel: usb_audio_parsecontrol: usb_audio_state at
cff6a220
Dec 23 19:59:28 reason kernel: usb 1-2.2: adding 1-2.2:1.1 (config
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1,
interface 1)
Dec 23 19:59:28 reason kernel: usb 1-2.2:1.1: hotplug
Dec 23 19:59:28 reason kernel: usb 1-2.2: adding 1-2.2:1.2 (config
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1,
interface 2)
Dec 23 19:59:28 reason kernel: usb 1-2.2:1.2: hotplug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-24-04 12:56 greve          New Issue                                    
12-24-04 12:56 greve          Distribution              => Debian GNU/Linux
12-24-04 12:56 greve          Kernel Version            => 2.6.10-rc3 (also
happened with 2.6.9)
12-24-04 13:03 greve          Note Added: 0002930                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
