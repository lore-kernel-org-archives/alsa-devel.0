From: Joel Metelius <joel.metelius@home.se>
Subject: intel8x0 working better in kernel 2.6.3-gentoo-r2
Date: Wed, 25 Feb 2004 21:52:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077742332.7913.29.camel@p4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fep05-svc.swip.net (fep05.swip.net [130.244.199.133])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA08059
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2004 21:51:24 +0100
Received: from [192.168.1.113] ([213.100.44.190]) by fep05-svc.swip.net
          with ESMTP
          id <20040225205115.TRZ27629.fep05-svc.swip.net@[192.168.1.113]>
          for <alsa-devel@alsa-project.org>;
          Wed, 25 Feb 2004 21:51:15 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

But there is still some issues:

Before I had to use "duplicate front" and "line-in as surround", and all
sound I got was from line-in.

Now I get sound from main speakers and with better quality than before
(using headphones), so far very good! But If I keep the setting as
before there is squeeking noice on line-out (besides the music). And one
time the sound just dissapeared and I had to restart alsa. The quality
is also very bad if PCM is above 75% even if MASTER is low. Is that
expected?

I can give more if anyone is interested.

Does it matter if i810_audio and ac97_codec is loaded as a modules as
well?

/joel

# cat /proc/asound/card0/codec97#0/*
0-0/0: Realtek ALC658 rev 0
 
Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement
 
Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : LDAC SDAC CDAC SPDIF=3/4 VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
0:00 = 0180
0:02 = 0909
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 0a0a
0:14 = 0000
0:16 = 8000
0:18 = 0000
0:1a = 0505
0:1c = 8000
0:1e = 8000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 09c7
0:2a = 01c1
0:2c = ac44
0:2e = ac44
0:30 = ac44
0:32 = bb80
0:34 = bb80
0:36 = bfbb
0:38 = 9090
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
0:68 = 0aea
0:6a = 8000
0:6c = 3601
0:6e = 0002
0:70 = 0008
0:72 = 0000
0:74 = 0105
0:76 = 0000
0:78 = 0002
0:7a = 40b2
0:7c = 414c
0:7e = 4780




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
