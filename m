From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000238]: spdif output fails with atiixp
Date: Fri, 16 Sep 2005 16:32:08 +0200
Message-ID: <f91fdc5ebefd6d08313b3f26e8085e62@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0FA54187
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2005 16:32:09 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=238> 
======================================================================
Reported By:                pkashou
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   238
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               Gentoo
Kernel Version:             gentoo-dev-sources 2.6.5 (running cvs alsa in
kernel)
======================================================================
Date Submitted:             04-27-2004 03:54 CEST
Last Modified:              09-16-2005 16:32 CEST
======================================================================
Summary:                    spdif output fails with atiixp
Description: 
When running ALSA 1.0.4rc2 included in 2.6.5 kernel, spdif output was
intermittant, almost complete static. Updating kernel alsa to latest cvs
caused spdif output to stop completely. 

dmesg reports no errors. Everything appears configured, but there is zero
output on the spdif line - no light through wire.

>aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: IXP [ATI IXP], device 0: ATI IXP AC97 [ATI IXP AC97]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: IXP [ATI IXP], device 1: ATI IXP IEC958 [ATI IXP IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


>cat /proc/asound/devices
  1:       : sequencer
  0: [0- 0]: ctl
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

>aplay -D hw:0,1 <whatever>.wav returns:
Playing WAVE 'audiodump.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz) please,
try the plug plugin (-Dplug:hw:0,1)

Analog output is working correctly.

More info and logs on request.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-27-04 12:29 
----------------------------------------------------------------------
did you set correct IEC958 status bits?
you need either to pass parameters of iec958 plugin or set
statically via iecset program.

also, show the contents of AC97 codec and register dump in
/proc/asound/card0/codec97#0/*.

----------------------------------------------------------------------
 pkashou - 04-27-04 13:41 
----------------------------------------------------------------------
I have not set the bits manually, but they are set.

>iecset -x
AES0=0x00,AES1=0x82,AES2=0x00,AES3=0x02

>iecset -Dhw:0
Mode: consumer
Data: audio
Rate: 48000 Hz
Copyright: protected
Emphasis: none
Category: PCM coder
Original: original
Clock: 1000 ppm

>cat /proc/asound/card0/codec97#0/*
0-0/0: Realtek ALC650 rev 3

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : LDAC SDAC CDAC SPDIF=3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked
0:00 = 5980
0:02 = 0808
0:04 = 0000
0:06 = 0008
0:08 = 0000
0:0a = 8008
0:0c = 801f
0:0e = 801f
0:10 = 1f1f
0:12 = 9f1f
0:14 = 1f1f
0:16 = 8808
0:18 = 0808
0:1a = 0404
0:1c = 8b0b
0:1e = 0000
0:20 = 0000
0:22 = 0002
0:24 = 0000
0:26 = 800f
0:28 = 05c7
0:2a = 01c5
0:2c = ac44
0:2e = ac44
0:30 = ac44
0:32 = bb80
0:34 = 0000
0:36 = 0808
0:38 = 0808
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 8000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 1000
0:6c = 0000
0:6e = 0025
0:70 = 0231
0:72 = 00a0
0:74 = 0043
0:76 = 0001
0:78 = 8102
0:7a = 57c3
0:7c = 414c
0:7e = 4720

----------------------------------------------------------------------
 pkashou - 04-28-04 02:32 
----------------------------------------------------------------------
Uploaded my asound.state in case something strange was going on there.

----------------------------------------------------------------------
 tiwai - 04-30-04 11:34 
----------------------------------------------------------------------
the status seems ok.

could you try iec958 PCM name instead of hw:0,1?
or, try 'ac3dec -C something.ac3'.

----------------------------------------------------------------------
 pkashou - 05-01-04 01:02 
----------------------------------------------------------------------
Same result, no sound...no light at all with:

>ac3dec -C test.ac3
Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
AC3 Stream 48.0 KHz 448 kbps

I did notice that 'AES0' does not have the same value in ac3dec as from
'iecset -x'
Could there be a connection?

And 'aplay -D iec958 test.wav' did not have light/sound either.

edited on: 05-01-04 01:00

edited on: 05-01-04 01:02

----------------------------------------------------------------------
 tiwai - 05-01-04 10:33 
----------------------------------------------------------------------
to be sure: did you update alsa-lib, too?

----------------------------------------------------------------------
 pkashou - 05-01-04 21:17 
----------------------------------------------------------------------
Well...I had a long, in-depth note about what I did and what happened and
the ALSA bug system decided to crash. So..here it is again.

Yes I did have alsa-lib CVS installed.

I just downgraded my kernel to 1.0.4 and alsa-lib to 1.0.4. After
rebuild/restart I now get light and static with "aplay -D hw:0,1
test.wav". ac3dec now actually puts light on the line, but it plays an
entire ac3 song in less than a second, so I can't tell what the ouput is
(probably not good sound). Here are the new regs and iecset stuff for
comparison.

>iecset -x
AES0=0x00,AES1=0x82,AES2=0x00,AES3=0x00

>iecset -Dhw:0
Mode: consumer
Data: audio
Rate: 44100 Hz
Copyright: protected
Emphasis: none
Category: PCM coder
Original: original
Clock: 1000 ppm

>cat /proc/asound/card0/codec97#0/*
0-0/0: Realtek ALC650 rev 3

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : LDAC SDAC CDAC SPDIF=3/4 SPDIF VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=44.1kHz
SPDIF In Status  : Not Locked
0:00 = 5980
0:02 = 0808
0:04 = 0000
0:06 = 0008
0:08 = 0000
0:0a = 800a
0:0c = 801f
0:0e = 801f
0:10 = 1f1f
0:12 = 9f1f
0:14 = 1f1f
0:16 = 8808
0:18 = 0808
0:1a = 0404
0:1c = 8b0b
0:1e = 0000
0:20 = 0000
0:22 = 0002
0:24 = 0000
0:26 = 000f
0:28 = 05c7
0:2a = 01c5
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 0808
0:38 = 0808
0:3a = 0824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 8000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0025
0:70 = 0231
0:72 = 00a0
0:74 = 0043
0:76 = 0001
0:78 = 8102
0:7a = 57c3
0:7c = 414c
0:7e = 4720

----------------------------------------------------------------------
 pkashou - 05-24-04 15:02 
----------------------------------------------------------------------
Any sort of status update available? 

I saw that there was some experimental code added to CVS, but I have not
tested it. Are you waiting to do further testing?

Thanks.

----------------------------------------------------------------------
 pkashou - 06-12-04 16:41 
----------------------------------------------------------------------
Just tried out the latest CVS kernel and lib and still no sound or light on
iec958. Any ideas as to why only ALSA 1.0.4 works? If I change nothing
else on my system but the ALSA version, I get static with 1.0.4 and
1.0.4r2 and no output with later versions.

----------------------------------------------------------------------
 tiwai - 06-30-04 16:32 
----------------------------------------------------------------------
You may try spdif_aclink=1 module option.  With this mode, atiixp
driver uses the (so-called) direct-SPDIF mode.  I got reports that
this mode works on some boards.

This may not work well with non-audio (AC3) output, though...

----------------------------------------------------------------------
 pkashou - 08-27-04 13:50 
----------------------------------------------------------------------
Apologies for the long delay.

What you suggested did not work. I will be rebuilding the machine this
weekend and will attempt IEC958 output with alsa 1.0.6

----------------------------------------------------------------------
 tiwai - 08-27-04 19:34 
----------------------------------------------------------------------
On the latest alsa, spdif_aclink=1 as default.
Try spdif_aclink=0, too.  Anyway, don't forget to update alsa-lib, too.

----------------------------------------------------------------------
 sw25481 - 01-03-05 18:08 
----------------------------------------------------------------------
Did anyone get any further with this

I have the same hardware, ALC650 from Radion 9100 IGP in a shuttle Zen
st62k

I have the same problem, I can get analogue sound, but on the SPIDF I
can't even get a light.  I have confirmed the hardware with win98.  I am
running Gentoo with 2.6.9-gentoo-r9 and alsa-lib 1.0.7 but I have tried
kernels from 2.6.6 and ALSA from 1.0.5, (or posibly earlier).  I have
tried upgrading the ALSA in the kernel to CVS at various times ut am
running the stock drivers right now.  My iecset results are very simmilar
except I see

shuttle root # iecset -x
AES0=0x06,AES1=0x82,AES2=0x00,AES3=0x02

I'd love to get this working and am willing to try anything



----------------------------------------------------------------------
 sw25481 - 01-03-05 18:12 
----------------------------------------------------------------------

Could I ask, did you ever get the SPDIF working on your ATI IXP board?  I
seem to be suffering the same problem and I am just looking for someone
who has got it to work, to give me hope :-)

----------------------------------------------------------------------
 jdthood - 09-14-05 16:18 
----------------------------------------------------------------------
Submitter: You were asked to provide additional information.

----------------------------------------------------------------------
 pkashou - 09-16-05 01:16 
----------------------------------------------------------------------
No, I was never able to get it working nor have I read anywhere that anyone
has it working.

Sorry I couldn't provide more details.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-27-04 03:54 pkashou        New Issue                                    
04-27-04 03:54 pkashou        Distribution              => Gentoo          
04-27-04 03:54 pkashou        Kernel Version            => gentoo-dev-sources
2.6.5 (running cvs alsa in kernel)
04-27-04 12:29 tiwai          Note Added: 0000960                          
04-27-04 13:41 pkashou        Note Added: 0000961                          
04-28-04 02:31 pkashou        File Added: asound.state                     
04-28-04 02:32 pkashou        Note Added: 0000968                          
04-30-04 11:34 tiwai          Note Added: 0000979                          
05-01-04 00:56 pkashou        Note Added: 0000985                          
05-01-04 00:56 pkashou        Note Edited: 0000985                         
05-01-04 01:00 pkashou        Note Edited: 0000985                         
05-01-04 01:02 pkashou        Note Edited: 0000985                         
05-01-04 10:33 tiwai          Note Added: 0000993                          
05-01-04 21:17 pkashou        Note Added: 0001001                          
05-24-04 15:02 pkashou        Note Added: 0001185                          
06-12-04 16:41 pkashou        Note Added: 0001301                          
06-30-04 16:32 tiwai          Note Added: 0001356                          
08-27-04 13:50 pkashou        Note Added: 0001642                          
08-27-04 19:34 tiwai          Note Added: 0001645                          
12-28-04 18:59 sw25481        Note Added: 0002986                          
01-03-05 18:08 sw25481        Note Edited: 0002986                         
01-03-05 18:09 sw25481        Issue Monitored: sw25481                     
01-03-05 18:12 sw25481        Note Added: 0003072                          
09-14-05 16:18 jdthood        Note Added: 0006179                          
09-14-05 16:18 jdthood        Status                   assigned => feedback
09-16-05 01:16 pkashou        Note Added: 0006235                          
09-16-05 16:32 jdthood        Status                   feedback => acknowledged
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
