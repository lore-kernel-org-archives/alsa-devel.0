From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000883]: Odd Mixer Controls with i810 on Fujitsu S6210
Date: Fri, 4 Feb 2005 18:01:13 +0100
Message-ID: <3623355edb0cab4242dbb496ceb263bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 50AD01ED
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2005 18:01:14 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=883> 
======================================================================
Reported By:                tonym
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   883
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-04-2005 12:35 CET
Last Modified:              02-04-2005 18:01 CET
======================================================================
Summary:                    Odd Mixer Controls with i810 on Fujitsu S6210
Description: 
I have some very odd mixer controls with my integrated i810 audio
lspci -v -n -s 00:1f.5
0000:00:1f.5 Class 0401: 8086:24c5 (rev 03)
        Subsystem: 10cf:1253
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1c00
        I/O ports at 18c0 [size=64]
        Memory at d0100c00 (32-bit, non-prefetchable) [size=512]
        Memory at d0100800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2


List of controls and what they do:
control.2 Master Playback Volume - no effect (so l/r doesn't work either)
control.4 Headphone Playback Volume - controls all vol, headphones and
speakers
control.6 Master Mono Playback Volume - no effect
control.8 PC Speaker Playback Volume - no effect
control.23 PCM Playback Volume - Works as should
control.33 External Amplifier - disables the builtin speakers, headphones
still work

Other controls I deemed irrelevent...

I suspect this is just a quirk of this laptop, but I don't know what info
you need, so please ask me.
======================================================================

----------------------------------------------------------------------
 tonym - 02-04-05 17:53 
----------------------------------------------------------------------
ac97_quirk=1 works (don't think alsa-1.0.6 in 2.6.10 supports hp_only),
thanks.

First post contains lspci -nv, here is the other files:
0-0/0: SigmaTel STAC9750/51

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 20-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz

...and...

0:00 = 6a90
0:02 = 9f1f
0:04 = 1c1c
0:06 = 801f
0:08 = 0000
0:0a = 0016
0:0c = 801f
0:0e = 0007
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 0000
0:1a = 0505
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0601
0:2a = 0001
0:2c = ac44
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0100
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0003
0:4e = ffff
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
0:68 = 0000
0:6a = 0000
0:6c = 0002
0:6e = 1000
0:70 = 0000
0:72 = 0000
0:74 = 0800
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 8384
0:7e = 7650

----------------------------------------------------------------------
 tiwai - 02-04-05 18:01 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-04-05 12:35 tonym          New Issue                                    
02-04-05 12:35 tonym          Distribution              => Gentoo          
02-04-05 12:35 tonym          Kernel Version            => 2.6.10          
02-04-05 13:02 tiwai          Note Added: 0003498                          
02-04-05 17:53 tonym          Note Added: 0003510                          
02-04-05 18:01 tiwai          Status                   new => resolved     
02-04-05 18:01 tiwai          Resolution               open => fixed       
02-04-05 18:01 tiwai          Assigned To               => tiwai           
02-04-05 18:01 tiwai          Note Added: 0003511                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
