From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC v3] [PATCH 00/52] Enhancement for support of
	firewire devices
Date: Tue, 25 Feb 2014 12:41:20 +0900
Message-ID: <530C10E0.4050603@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
 <20140221165444.GA25817@redhat.com> <53080CB3.9000504@sakamocchi.jp>
 <20140224172846.GA880@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id C21F7265488
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 04:41:29 +0100 (CET)
In-Reply-To: <20140224172846.GA880@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jay Fenlason <fenlason@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jay,

> The RFC v3 patches.

BeBoB/OXFW driver in RFCv3 includes some bugs.

Please use latest patches:
  https://github.com/takaswie/sound
Or backport package for Linux 3.11/12/13.
  https://github.com/takaswie/snd-firewire-improve

 >> 1. PreSonus Inspire1394
 > [hack@precision ~]$ cat /proc/asound/card3/#formation
 > [hack@precision ~]$ cat /proc/asound/card3/#clock
 > [hack@precision ~]$ cat /proc/asound/card3/#firmware

OK. I can confirm BeBoB driver detect inspire1394 correctly.

 > [hack@precision ~]$ arecord --verbose -D plughw:3 /tmp/test.wav
 > [hack@precision ~]$ aplay --verbose -D plughw:3

It looks good.

I guess:
  - BeBoB driver in RFCv3 has a bug in access by several processes:
http://sourceforge.net/mailarchive/message.php?msg_id=31924100
  - When PulseAudio was installed your system, PulseAudio generate much 
access to detect inspire1394.
  - As a result, BeBoB driver works badly, often hungs your system.

>> 2. FireWave
> [hack@precision ~]$ cat /proc/asound/cards
> [hack@precision ~]$ hexdump -C /sys/bus/firewire/devices/fw3/config_rom

For 'struct snd_card.shortname', OXFW driver pick up model name from 
config_rom. In this case, the model name is 26 bytes (Griffin FireWave 
Surround). But OXFW driver keeps char[24] (char model[32] in 
name_card()). So the name is split.

I pushed fix for this issue:
https://github.com/takaswie/snd-firewire-improve/commit/cf4cec651de539e5debb2da274cee30a3847004d

But this long model name also affects 'struct snd_card.longname' 
(Griffin Technology Griffin FireWave Surrou (OXFW970 0104), GUID 
001292060052048). This shold have been 'Griffin Technology Griffin 
FireWave Surround (OXFW970 0104), GUID 001292060052048 at fw1,0. S400'. 
I'm under consideration about how to fix this...

> [hack@precision ~]$ cat /proc/asound/card2/#formation
> [hack@precision ~]$ aplay --verbose -D plughw:2
> /usr/share/sounds/alsa/Noise.wav
> Playing WAVE '/usr/share/sounds/alsa/Noise.wav' : Signed 16 bit Little
> Endian, Rate 48000 Hz, Mono
> aplay: set_params:1297: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 16
> FRAME_BITS: 16
> CHANNELS: 1
> RATE: 48000
> PERIOD_TIME: 125000
> PERIOD_SIZE: 6000
> PERIOD_BYTES: 12000
> PERIODS: 4
> BUFFER_TIME: 500000
> BUFFER_SIZE: 24000
> BUFFER_BYTES: 48000
> TICK_TIME: 0

This is a bug of OXFW driver in RFCv3. I already fix this.

 > Let me know if there is any other information you need.

I want you to test latest patches with FireWave to check regression.


Thank you

Takashi Sakamoto
o-takashi@sakamocchi.jp
