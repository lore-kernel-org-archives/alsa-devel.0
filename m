From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001197]: Realtek ALC650 output problem
Date: Fri, 24 Jun 2005 16:15:13 +0200
Message-ID: <e91971cffcc5afaf39a9e2e8287ae2b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0A324233
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 16:15:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1197> 
======================================================================
Reported By:                willits
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1197
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-16-2005 15:07 CEST
Last Modified:              06-24-2005 16:15 CEST
======================================================================
Summary:                    Realtek ALC650 output problem
Description: 
I have got a realtek ALC650 AC97 soundcard on my motherboard Abit BE7.
The problem is that I have got 5.1 speakers, and for have my subwoofer and
central speaker work, I need to put them on the "line in" connector
instead of the black connector (the black connector doesn't work).

I haven't got this problem with Windows.
======================================================================

----------------------------------------------------------------------
 willits - 06-24-05 15:24 
----------------------------------------------------------------------
$ cat /proc/asound/cards
0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 with ALC650E at 0xec001000, irq 5


White-Side:/proc/asound/card0/codec97#0 # cat ac97#0-0
0-0/0: Realtek ALC650E

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
Double rate slots: 10/11
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 22050Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked


White-Side:/proc/asound/card0/codec97#0 # cat ac97#0-0+regs
0:00 = 5980
0:02 = 0505
0:04 = 0000
0:06 = 801f
0:08 = 0000
0:0a = 0000
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9e1e
0:14 = 9f1f
0:16 = 9f1f
0:18 = 1111
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 05c7
0:2a = 05c1
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = 5622
0:34 = 0000
0:36 = 0700
0:38 = 0505
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
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 4600
0:6c = 0000
0:6e = 0014
0:70 = 0211
0:72 = 00a0
0:74 = 0043
0:76 = 0001
0:78 = 8002
0:7a = 57c7
0:7c = 414c
0:7e = 4720


---
There are this : "3D enhancement   : Realtek 3D Stereo Enhancement" in
capabilities, and this "3D enhancement   : off" in Current setup, how I
can enable this feature ?

----------------------------------------------------------------------
 tiwai - 06-24-05 16:15 
----------------------------------------------------------------------
Then chekc whether /usr/share/alsa/cards/ICH4.conf includes "route" plugin.
 Just grep route ICH4.conf.  If it exists, the configuration is old.  If
not, ... the problem is deeper.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-05 15:07 willits        New Issue                                    
06-16-05 15:07 willits        Kernel Version            => 2.6.11          
06-16-05 15:13 pzad           Note Added: 0005056                          
06-16-05 15:19 willits        Note Added: 0005057                          
06-16-05 15:21 pzad           Note Added: 0005058                          
06-16-05 15:25 willits        Note Added: 0005059                          
06-16-05 15:43 pzad           Note Added: 0005060                          
06-16-05 16:10 willits        Note Added: 0005062                          
06-16-05 16:11 willits        File Added: test.state                       
06-17-05 15:10 tiwai          Note Added: 0005075                          
06-17-05 20:32 willits        Note Added: 0005079                          
06-17-05 20:34 willits        Note Added: 0005080                          
06-22-05 18:12 tiwai          Note Added: 0005139                          
06-23-05 11:17 willits        Note Added: 0005168                          
06-23-05 11:23 willits        Note Added: 0005169                          
06-23-05 11:23 jcdutton       Note Added: 0005170                          
06-23-05 11:56 pzad           Note Added: 0005172                          
06-23-05 12:01 tiwai          Note Added: 0005174                          
06-23-05 19:21 willits        Note Added: 0005192                          
06-23-05 19:26 willits        Note Added: 0005193                          
06-23-05 22:42 pzad           Note Added: 0005196                          
06-24-05 14:37 willits        Note Added: 0005220                          
06-24-05 14:54 tiwai          Note Added: 0005221                          
06-24-05 15:07 jcdutton       Note Added: 0005225                          
06-24-05 15:19 tiwai          Note Added: 0005227                          
06-24-05 15:24 willits        Note Added: 0005228                          
06-24-05 16:15 tiwai          Note Added: 0005232                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
