From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000839]: No AC3/DTS via SPDIF on Intel 82801DB-ICH4 with CS4299
Date: Sat, 30 Jul 2005 22:26:47 +0200
Message-ID: <75f89610d108eceaa676d92c31b3e687@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F020150
	for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2005 22:26:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=839> 
======================================================================
Reported By:                Mimosius
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   839
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               SuSE 9.2
Kernel Version:             2.6.8-24.10 + 2.6.10
======================================================================
Date Submitted:             01-21-2005 03:12 CET
Last Modified:              07-30-2005 22:26 CEST
======================================================================
Summary:                    No AC3/DTS via SPDIF on Intel 82801DB-ICH4 with
CS4299
Description: 
Audio-mode via SPDIF works fine but I can't get any non-audio passthru
working.

Using 'ac3play -C test.ac3' SPDIF output is set to AES0=0x2 AES1=0x82
AES2=0x0 AES3=0x2 and the PCM indicator on external decoder turns off, but
there seems to arrive no decodeable signal on receiver side.
There are no errors or warnings after loading soundrivers and there are no
other soundcards plugged in (notebook).


here are some system informations:

# cat /etc/modprobe.d/sound
alias snd-card-0 snd-intel8x0
options snd-ac97-codec
options snd-intel8x0 enable=1 index=0


# cat /proc/asound/pcm' 
00-00: Intel ICH : Intel 82801DB-ICH4 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel 82801DB-ICH4 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel 82801DB-ICH4 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel 82801DB-ICH4 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel 82801DB-ICH4 - IEC958 : playback 1


# cat /proc/asound/card0/codec97#0/ac97#0-0' (while playing ac3 using
ac3dec -C)
0-0/0: Cirrus Logic CS4299 rev 4

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Crystal Semi 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : Mic
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer Non-audio Category=0x2 Generation=1 Rate=48kHz
Enabled


# cat /proc/asound/card0/codec97#0/ac97#0-0+regs (while playing ac3 using
ac3dec -C)
0:00 = 1990
0:02 = 3f3f
0:04 = 9f1f
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 8000
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 8000
0:1a = 0606
0:1c = 0f0f
0:1e = 0000
0:20 = 0200
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 0201
0:2a = 0001
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
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
0:5a = 0404
0:5c = 0000
0:5e = 0080
0:60 = 0022
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 8826
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 003f
0:7a = 0000
0:7c = 4352
0:7e = 5934

======================================================================

----------------------------------------------------------------------
 mrbox - 07-30-05 21:23 
----------------------------------------------------------------------
[quote]
Yes, DDM bit might affect the output data. It's worthy to try.

You can change the register bit on the fly by writing proc file on ALSA
(when compiled with debug option).
As root, write the register value like:
  # echo 5e 0100 > /proc/asound/card0/codec97#0/ac97#0-0+regs
[/quote]

I got it working, but its still the same "chopper sound".



----------------------------------------------------------------------
 mrbox - 07-30-05 22:26 
----------------------------------------------------------------------
[quote]
I tried to play an AC3-file with mplayer using alsa-driver with hwac3
output and "ac3dec -C". Each test gives the same result, the value in
register 0x68 changed from 0x8824 to 0x8826, which shows that the
non-audio bit was set correctly.
[/qoute]
On my case when i set the non-audio bit myself the chopper sound stopped,
so on my case the non-audio bit isn't set correctly. Still no DD playback

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-21-05 03:12 Mimosius       New Issue                                    
01-21-05 03:12 Mimosius       Distribution              => SuSE 9.2        
01-21-05 03:12 Mimosius       Kernel Version            => 2.6.8-24.10 + 2.6.10
01-21-05 03:13 Mimosius       Issue Monitored: Mimosius                    
03-01-05 11:31 Mimosius       Note Added: 0003758                          
03-15-05 21:37 Mimosius       Note Added: 0003917                          
03-16-05 12:47 tiwai          Note Added: 0003945                          
03-16-05 12:47 tiwai          Note Added: 0003946                          
03-17-05 01:00 Mimosius       Note Added: 0003975                          
06-22-05 13:08 Mimosius       Note Added: 0005132                          
06-22-05 17:56 tiwai          Note Added: 0005137                          
06-22-05 18:58 Mimosius       Note Added: 0005143                          
07-14-05 15:50 mrbox          Note Added: 0005475                          
07-14-05 21:13 Mimosius       Note Added: 0005479                          
07-26-05 20:02 rziai          Issue Monitored: rziai                       
07-26-05 20:08 rziai          Note Added: 0005571                          
07-29-05 17:54 tiwai          Note Added: 0005581                          
07-30-05 18:57 mrbox          Note Added: 0005592                          
07-30-05 21:23 mrbox          Note Edited: 0005592                         
07-30-05 22:26 mrbox          Note Added: 0005593                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
