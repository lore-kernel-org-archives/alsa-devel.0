From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001870]: Variable Sample Rate Audio (VSR/VRA) feature not implemented for chip AD1981B to allow output at sample rate other than 48000
Date: Thu, 23 Feb 2006 18:23:47 +0100
Message-ID: <54d8a93453d8f41d0a328abf39b8feac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C871E1A7
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2006 18:23:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1870> 
======================================================================
Reported By:                bmill
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1870
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-r2
======================================================================
Date Submitted:             02-23-2006 01:08 CET
Last Modified:              02-23-2006 18:23 CET
======================================================================
Summary:                    Variable Sample Rate Audio (VSR/VRA) feature not
implemented for chip AD1981B to allow output at sample rate other than 48000
Description: 
For soundcards using the audio chip Analog Devices AC '97 SoundMAX Codec
AD1981B, the driver intel8x0 is used. These chips have Variable Sample
Rate Audio which gives Full-Duplex Variable Sample Rate Audio from 7040 hz
to 48 khz in 1 hz increments (see datasheet). The software driver,
however, does not have this feature implemented but rather hardcodes 48000
as the default sample rate without the ability to alter it.

Playback at other sample rates is desired to skip the step of resampling
audio material at samples other than 48000, resultin in better sound
quality with less distortion due to resampling artifacts.

Requesting an implementation of altering the output sample rate via VRA.
======================================================================

----------------------------------------------------------------------
 bmill - 02-23-06 11:34 
----------------------------------------------------------------------
HVLinuxMobile hara # cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Analog Devices AD1981B

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic2
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 48000Hz
PCM ADC          : 22050Hz

AD18XX configuration
Unchained        : 0x1000,0x0000,0x0000
Chained          : 0x0000,0x0000,0x0000

HVLinuxMobile hara # lspci        #output filtered
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)

HVLinuxMobile hara # lspci -nv    #output filtered
00:1f.5 0401: 8086:24c5 (rev 03)
        Subsystem: 1179:0241
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at be00 [size=256]
        I/O ports at bdc0 [size=64]
        Memory at cfdffe00 (32-bit, non-prefetchable) [size=512]
        Memory at cfdffd00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

----------------------------------------------------------------------
 Clemens Ladisch - 02-23-06 18:23 
----------------------------------------------------------------------
Looks OK.

Does the "PCM font DAC" frequency change after you run "aplay -D plughw:0
something.wav"?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-06 01:08 bmill          New Issue                                    
02-23-06 01:08 bmill          Distribution              => Gentoo          
02-23-06 01:08 bmill          Kernel Version            => 2.6.14-r2       
02-23-06 01:14 bmill          File Added: ad1981B.pdf                      
02-23-06 11:08 Clemens LadischNote Added: 0008166                          
02-23-06 11:34 bmill          Note Added: 0008167                          
02-23-06 18:23 Clemens LadischNote Added: 0008168                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
