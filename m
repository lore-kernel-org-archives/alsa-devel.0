From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000871]: Distortion in sound output.
Date: Sat, 5 Feb 2005 01:33:07 +0100
Message-ID: <a6ddcae70ff74a28d77d0883fd1180f0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6E4791CF
	for <alsa-devel@alsa-project.org>; Sat,  5 Feb 2005 01:33:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=871> 
======================================================================
Reported By:                Mutant_Fruit
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   871
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.8
======================================================================
Date Submitted:             01-31-2005 21:18 CET
Last Modified:              02-05-2005 01:33 CET
======================================================================
Summary:                    Distortion in sound output.
Description: 
There is distortion in the sound output. This occurs in two ways.

1) When the volume in the mixers gets set to high (i.e. into the red)
there is severe distortion in the sound.

2) Occasionally i notice a distortion in the right channel. Not too sure
how to describe it other than its like an intermittant buzz, and isn't
supposed to be in the music.

If you need any more info, gimme a shout. I'm new at this.
======================================================================

----------------------------------------------------------------------
 tiwai - 02-02-05 11:21 
----------------------------------------------------------------------
Attach the output of /proc/asound/card0/codec97#0/* files.
My rough guess is that your codec chip applys gain over 80% master/pcm
volume up to +12dB. resulting in overload.

----------------------------------------------------------------------
 Mutant_Fruit - 02-05-05 01:33 
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 21:18 Mutant_Fruit   New Issue                                    
01-31-05 21:18 Mutant_Fruit   Distribution              => Debian Sarge    
01-31-05 21:18 Mutant_Fruit   Kernel Version            => 2.6.8           
02-02-05 11:21 tiwai          Note Added: 0003484                          
02-05-05 01:33 Mutant_Fruit   Note Added: 0003517                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
