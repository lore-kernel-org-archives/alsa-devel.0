From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000872]: Mixer not functioning correctly
Date: Wed, 9 Feb 2005 12:06:57 +0100
Message-ID: <6668aaa7fcfe5e0b9ad03e42e4231d3a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0D88925E
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 12:06:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=872> 
======================================================================
Reported By:                Mutant_Fruit
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   872
Category:                   CORE OSS - mixer
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Debian Testing (Sarge)
Kernel Version:             2.6.8
======================================================================
Date Submitted:             01-31-2005 21:29 CET
Last Modified:              02-09-2005 12:06 CET
======================================================================
Summary:                    Mixer not functioning correctly
Description: 
Some things seem to not be set up correctly in the volume controls in
alsamixer (and therefore possibly everything based on alsamixer).

1) The "Master" volume has no effect when i'm using headphones.

2) If i turn everything off except "Headphones" i still get sound in
headphones when i play music. I would have assumed this wouldn't be the
case, as PCM volume is at zero. However if i mute PCM, i get no sound. The
same is true for when i take out headphones and turn everything off except
the master volume.

3) I'm not sure if this is a bug with the mixer or the intel drivers, so i
posted this as a bug for the drivers... I get severe distortion when the
PCM volume is turned up.
======================================================================

----------------------------------------------------------------------
 Mutant_Fruit - 02-05-05 01:32 
----------------------------------------------------------------------
Hope this helps. This is the contents of the two files in that directory.

Here's AC97#0-0:
0-0/0: SigmaTel STAC9750/51

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 20-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=10/11 VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz


and AC97#0-0+regs:

0:00 = 6a90
0:02 = 1d1d
0:04 = 1f1f
0:06 = 001f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 1010
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 2000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0605
0:2a = 0431
0:2c = ac44
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2824
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
 tiwai - 02-09-05 12:06 
----------------------------------------------------------------------
First, use ac97_quirk=hp_only option.  This will control the headphone
volume as the master volume.

STAC9750/51 has a switch to bypass the PCM volume control.  This is
labelled as a different name "PCM Output Path & Mute".  Choose "pre 3D" to
avoid bypassing.  This strange control must be fixed in the future
version.

The PCM volume of this codec can be up to +12dB, i.e. when you raise more
than 75%, it'll be overloaded.

If ac97_quirk=hp_only works, please  provide the output of lspci -nv to
set this option as default.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 21:29 Mutant_Fruit   New Issue                                    
01-31-05 21:29 Mutant_Fruit   Distribution              => Debian Testing
(Sarge)
01-31-05 21:29 Mutant_Fruit   Kernel Version            => 2.6.8           
02-04-05 13:21 tiwai          Note Added: 0003505                          
02-05-05 01:32 Mutant_Fruit   Note Added: 0003516                          
02-09-05 12:06 tiwai          Note Added: 0003546                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
