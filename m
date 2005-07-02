From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001227]: Audio output to headphone changes mapping when JACKD XRUN
Date: Sat, 2 Jul 2005 02:46:20 +0200
Message-ID: <87450579e0f0cdad7fb04f67dd1b607d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6BCB31AE
	for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2005 02:46:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1227> 
======================================================================
Reported By:                rfonseca
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1227
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3 with real time smp kernel from ccrma
Kernel Version:             2.6.10-2.1.ll.rhfc3.ccrmasmp
======================================================================
Date Submitted:             07-02-2005 01:24 CEST
Last Modified:              07-02-2005 02:46 CEST
======================================================================
Summary:                    Audio output to headphone changes mapping when JACKD
XRUN
Description: 
When running jack and there is an XRUN, the mapping of which output goes to
the headphone jack changes. For example, suppose there is an app connected
(via JACK) to playback_1 and playback_2 (controlled by mixer PCM).
Sometimes when there is an XRUN, the output will stop. Suddenly, the
output jack  (the headphones) is now fed by the surround channel. If I
connect the same application to playback_3 and playback_4, I can hear the
output, and the volume is controlled by mixer "Surround". Furhter XRUNS
will move the output to playback_5 and playback_6, and even other
combinations.
======================================================================

----------------------------------------------------------------------
 rfonseca - 07-02-05 01:37 
----------------------------------------------------------------------
I forgot to mention the soundcard is a ATI onboard with a SoundMax
chipset.
Modules loaded (relevant):

snd_seq                64272  3 snd_seq_dummy
snd_seq_device         13324  2 snd_seq_dummy,snd_seq
snd_atiixp             25568  10 
snd_ac97_codec         83064  1 snd_atiixp
snd_pcm_oss            67488  0 
snd_mixer_oss          25344  2 snd_pcm_oss
snd_pcm               111492  3 snd_atiixp,snd_ac97_codec,snd_pcm_oss
snd_timer              32004  2 snd_seq,snd_pcm
snd                    73092  29
snd_seq_dummy,snd_seq,snd_seq_device,snd_atiixp,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              13792  2 snd
snd_page_alloc         14724  2 snd_atiixp,snd_pcm

----------------------------------------------------------------------
 rfonseca - 07-02-05 02:46 
----------------------------------------------------------------------
More details:
>From lspci:
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97
Audio Controller (rev 01)
>From alsamixer: Card: ATI IXP  Chip: Analog Devices AD1888 

>From /proc/asound/card0/codec97#0/ac97#0-0:
0-0/0: Analog Devices AD1888

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic2
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=0 AMAP LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=7/8 SPDIF VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

>From  /proc/asound/card0/codec97#0/ac97#0-0+regs:
0:00 = 0090
0:02 = 0707
0:04 = 0000
0:06 = 000b
0:08 = 0000
0:0a = 0000
0:0c = 801f
0:0e = 8052
0:10 = 9090
0:12 = 0d0d
0:14 = 0000
0:16 = 8e8e
0:18 = 0000
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0100
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 03c7
0:2a = 05d5
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 1f1f
0:38 = 0e0e
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
0:60 = 8080
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0004
0:74 = 1001
0:76 = 7800
0:78 = 0000
0:7a = 0000
0:7c = 4144
0:7e = 5368

>From /proc/asound/card0/pcm0p/info:

card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ATI IXP AC97
name: ATI IXP AC97
subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-02-05 01:24 rfonseca       New Issue                                    
07-02-05 01:24 rfonseca       Distribution              => Fedora Core 3 with
real time smp kernel from ccrma
07-02-05 01:24 rfonseca       Kernel Version            =>
2.6.10-2.1.ll.rhfc3.ccrmasmp
07-02-05 01:37 rfonseca       Note Added: 0005345                          
07-02-05 01:39 rfonseca       Issue Monitored: rfonseca                    
07-02-05 02:46 rfonseca       Note Added: 0005346                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
