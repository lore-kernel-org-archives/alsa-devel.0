From: Benny Sjostrand <gorm@cucumelo.org>
Subject: alsaplayer and jackd faild on snd_pcm_hw_params_set_period_size(...)
 call
Date: Sun, 11 Aug 2002 18:36:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5692AB.80303@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

Trying some native ALSA applications I got some problems,  "alsaplayer" 
and the "jackd" both seems to fail
on the same call: snd_pcm_hw_params_set_period_size(...) in alsa-lib
 
the jackd:
[gorm@cactus alsa-driver]$ jackd -d alsa -p 1024 -d pcm.cs46xx
jackd 0.34.0
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

creating alsa driver ... pcm.cs46xx|1024|2|48000|swmon
ALSA: cannot set period size to 1024 frames for capture
ALSA: cannot configure capture channel
cannot load driver module alsa
jack main caught signal 15
[gorm@cactus alsa-driver]$

the alsaplayer output:
error on set_period_size (1024)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (11609 11610)
PERIOD_SIZE: 512
PERIOD_BYTES: 2048
PERIODS: [2 32]
BUFFER_TIME: (23219 371520)
BUFFER_SIZE: [1024 16384]
BUFFER_BYTES: [4096 65536]
TICK_TIME: 10000
failed to configure output device...trying OSS

 (I just hate to mess around with the user mode stuffs ....)

As you probably can guess I'm using the latest CVS with my recently 
patched cs46xx driver, what I dont understand
is how is the snd_pcm_hw_params_set_period_size(..)  function is mapped 
down to the HW driver ??????

The other thing is that all OSS application works without any problems, 
like XMMS, etc.

I've been looking around in the alsa-lib, well,.. probably you can give 
some hints about this, I'm still a newbie
to the ALSA architecture.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
