From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001510]: ac97 with SiS SI7012 [ALC203 rev 0] doesn't allow to control volume by master channel, PCM and headphones work
Date: Wed, 9 Nov 2005 15:27:52 +0100
Message-ID: <39dcd749cc7ac837dc142ff31f6e7fc9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 168CD1CB
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2005 15:27:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1510> 
======================================================================
Reported By:                wiktorw
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1510
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2005.1
Kernel Version:             2.6.13-gentoo-r4
======================================================================
Date Submitted:             10-28-2005 17:54 CEST
Last Modified:              11-09-2005 15:27 CET
======================================================================
Summary:                    ac97 with SiS SI7012 [ALC203 rev 0] doesn't allow to
control volume by master channel, PCM and headphones work
Description: 
On my Acer Aspire 5002LM laptop I have the following problem:
- Master channel does not control volume level (no matter if I slide it or
mute)
- PCM channel works
- Headphone/PCM-2 channel works

The Master/PCM/Headphone channels are for the "SiS SI7012 (Alsa Mixer)"
device, while Volume/PCM/PCM-2 channels are for the "Realtek ALC203 rev 0
(OSS Mixer)" device. They do the same thing: Master/Volume control in
gnome-volume-control applet doesn't change the volume level.

At first I thought that this problem is software-related, but in fact it
isn't. Now I have tested several things and all give me the same result. I
also suspect that not only I have such problems, althought the original
posters might not be aware of it. See here for the original discussion:

http://forums.gentoo.org/viewtopic-t-387739.html

======================================================================

----------------------------------------------------------------------
 wiktorw - 11-09-05 15:23 
----------------------------------------------------------------------
For me it is as follows:


# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC203 rev 0

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 7/8
Extended ID      : codec=0 rev=2 AMAP DSA=0 SPDIF DRA VRA
Extended status  : SPCV SPDIF=7/8 VRA
PCM front DAC    : 22050Hz
PCM ADC          : 22050Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

                    Gain     Inverted  Buffer delay  Location
Master Out       :   0.0 dBV    -      23/fs         Rear I/O Panel
AUX Out          :   0.0 dBV    -      23/fs         Rear I/O Panel
Center/LFE Out   :   0.0 dBV    -      23/fs         Rear I/O Panel
SPDIF Out        :   0.0 dBV    -      23/fs         Rear I/O Panel
Phone In         :   0.0 dBV    -      23/fs         Rear I/O Panel
Mic 1            :   0.0 dBV    -      23/fs         Rear I/O Panel
Mic 2            :   0.0 dBV    -      23/fs         Rear I/O Panel
Line In          :   0.0 dBV    -      23/fs         Rear I/O Panel
CD In            :   0.0 dBV    -      23/fs         Rear I/O Panel
Video In         :   0.0 dBV    -      23/fs         Rear I/O Panel
Aux In           :   0.0 dBV    -      23/fs         Rear I/O Panel
Mono Out         :   0.0 dBV    -      23/fs         Rear I/O Panel


# cat /proc/asound/card0/codec97#0/ac97#0-0+regs
0:00 = 0190
0:02 = 0c0c
0:04 = 0505
0:06 = 000b
0:08 = 0000
0:0a = 0012
0:0c = 801f
0:0e = 831f
0:10 = 0707
0:12 = 0202
0:14 = 0000
0:16 = 0d0d
0:18 = 0c0c
0:1a = 0000
0:1c = 0b0b
0:1e = 8000
0:20 = 2400
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0a07
0:2a = 0411
0:2c = 5622
0:2e = 0000
0:30 = 0000
0:32 = 5622
0:34 = bb80
0:36 = 0000
0:38 = 0000
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
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0aea
0:6a = 0308
0:6c = 3601
0:6e = 0014
0:70 = 0008
0:72 = 0000
0:74 = 0100
0:76 = 0000
0:78 = 0c07
0:7a = 6002
0:7c = 414c
0:7e = 4770

----------------------------------------------------------------------
 wiktorw - 11-09-05 15:27 
----------------------------------------------------------------------
My last post was the output of the commands I issued on the Gentoo Linux
machine with:

# uname -a
Linux widmo 2.6.14-gentoo #1 PREEMPT Mon Oct 31 08:14:56 CET 2005
i686 AMD Turion(tm) 64 Mobile Technology ML-30 AuthenticAMD GNU/Linux

media-libs/alsa-lib-1.0.9
media-sound/alsa-headers-1.0.9b
media-sound/alsa-tools-1.0.8-r1
media-sound/alsa-utils-1.0.9a

and the in-kernel alsa drivers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-28-05 17:54 wiktorw        New Issue                                    
10-28-05 17:54 wiktorw        Distribution              => Gentoo 2005.1   
10-28-05 17:54 wiktorw        Kernel Version            => 2.6.13-gentoo-r4
10-30-05 09:35 garfungiloops  Note Added: 0006573                          
10-30-05 09:36 garfungiloops  Issue Monitored: garfungiloops                    
11-08-05 08:44 mrblur         Note Added: 0006619                          
11-08-05 17:45 tiwai          Note Added: 0006626                          
11-08-05 19:37 garfungiloops  Note Added: 0006640                          
11-08-05 19:41 garfungiloops  Note Added: 0006641                          
11-09-05 15:23 wiktorw        Note Added: 0006654                          
11-09-05 15:27 wiktorw        Note Added: 0006655                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
