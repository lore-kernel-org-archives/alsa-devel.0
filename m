From: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Mon, 24 Mar 2003 22:15:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048540520.3e7f75685eb9e@albert.homedns.org>
References: <Pine.LNX.4.44.0303241115360.6755-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from yoda.planetinternet.be (anvers-smtp.planetinternet.be [195.95.30.152])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA20100
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2003 22:16:11 +0100
In-Reply-To: <Pine.LNX.4.44.0303241115360.6755-100000@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hello again,

Quoting Jaroslav Kysela <perex@suse.cz>:
> The 32-bit mixing code is not debugged. Please, could you try to change
> one line in pcm_dmix.c (alsa-lib/src/pcm/pcm_dmix.c) from
> '#ifdef __i386__' to '#ifdef __i386XX__' and recompile library?
> We'll see then if it's a problem with the i386 assembler code.
This works !!! It only plays to the last channel mentioned in the dmix configuration though (so channel 1, but not channel 0).

> Can I see the output from 'aplay -v -D plug:dmix_analog tv.wav'?
aplay -v -D plug:dmix_analog tv.wav
Playing WAVE 'tv.wav' : Signed 32 bit Little Endian, Rate 48000 Hz, Stereo
Plug PCM: Route conversion PCM (sformat=S32_LE)
Transformation table:
0 <- 0*0.5 + 1*0.5
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 32
buffer_size  : 6553
period_size  : 3276
period_time  : 68250
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 3276
xfer_align   : 3276
start_threshold  : 6552
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632
Slave: Direct Stream Mixing PCM

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 1
rate         : 48000
exact rate   : nan (0/0)
msbits       : 0
buffer_size  : 6553
period_size  : 3276
period_time  : 68250
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 3276
xfer_align   : 3276
start_threshold  : 6552
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632
Hardware PCM card 0 'M Audio Delta 410' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 10
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 24
buffer_size  : 6553
period_size  : 3276
period_time  : 68250
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 3276
xfer_align   : 3276
start_threshold  : 1
stop_threshold   : 1717829632
silence_threshold: 0
silence_size : 1717829632
boundary     : 1717829632

Cheers !

Kristof


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
