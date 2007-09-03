From: Markus Korber <korbse@gmx.at>
Subject: Re: ALSA lib troubles with xine
Date: Mon, 03 Sep 2007 11:24:02 +0200
Message-ID: <6zir6sayq5.fsf@odpc25.int.ondemand.co.at>
References: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at>
	<6zd4x0f9q3.fsf@odpc25.int.ondemand.co.at>
	<Pine.LNX.4.61.0709031024070.14792@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 8FFF824339
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 11:24:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>, Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thus spake Jaroslav Kysela:

> On Mon, 3 Sep 2007, Markus Korber wrote:
>
>> Thus spake Markus Korber:
>
>>> I've got problems using ALSA (hg) and xine-lib (1.1.7).  I'm trying to
>>> use fbxine for playback but ALSA debug logging gives me:
>>> [...]
>>> So buffer and period sizes seem to be wrong and therefore I get no
>>> sound.  (audio_alsa_out logging from [1].)  Next I've tried to run
>>> speaker-test and the ouptut look good:
>
>> Sorry for the wrong information (Must have taken an older version of
>> libasound).  I've recompiled alsa-lib 1.0.15rc1 and alsa-utils 1.0.15rc1
>> and now speaker-test also fails:
>
> Try compile alsa-lib with '--with-versioned=no' and recompile
> (relink) speaker-test and other apps against this library.

Ok, speaker-test works again:

,----
| [root@(none) ~]# speaker-test 
| 
| speaker-test 1.0.15rc1
| 
| Playback device is default
| Stream parameters are 48000Hz, S16_LE, 1 channels
| Using 16 octaves of pink noise
| Rate set to 48000Hz (requested 48000Hz)
| Buffer size range from 4096 to 4096
| Period size range from 2048 to 2048
| Using max buffer size 4096
| Periods = 4
| was set period_size = 2048
| was set buffer_size = 4096
|  0 - Front Left
`----

And also fbxine now (kind of) works:

,----
| audio_alsa_out: Audio Device name = default
| audio_alsa_out: Number of channels = 2
| Buffer size range from 4096 to 4096
| Period size range from 2048 to 2048
| Buffer time size 44100
| To choose buffer_size = 4096
| To choose period_size = 512
| was set period_size = 2048
| was set buffer_size = 4096
| ACCESS:  RW_INTERLEAVED
| FORMAT:  S16_LE
| SUBFORMAT:  STD
| SAMPLE_BITS: 16
| FRAME_BITS: 32
| CHANNELS: 2
| RATE: 44100
| PERIOD_TIME: (46439 46440)
| PERIOD_SIZE: 2048
| PERIOD_BYTES: 8192
| PERIODS: 2
| BUFFER_TIME: (92879 92880)
| BUFFER_SIZE: 4096
| BUFFER_BYTES: 16384
| TICK_TIME: 10000
|   stream       : PLAYBACK
|   access       : RW_INTERLEAVED
|   format       : S16_LE
|   subformat    : STD
|   channels     : 2
|   rate         : 44100
|   exact rate   : 44100 (44100/1)
|   msbits       : 16
|   buffer_size  : 4096
|   period_size  : 2048
|   period_time  : 46439
|   tick_time    : 10000
|   tstamp_mode  : NONE
|   period_step  : 1
|   sleep_min    : 0
|   avail_min    : 2048
|   xfer_align   : 1
|   start_threshold  : 2048
|   stop_threshold   : 4096
|   silence_threshold: 0
|   silence_size : 0
|   boundary     : 1073741824
| start_mode: DATA
| xrun_mode: STOP
| tstamp_mode: NONE
| period_step: 1
| sleep_min: 0
| avail_min: 2048
| xfer_align: 1
| silence_threshold: 0
| silence_size: 0
| boundary: 1073741824
| output sample rate 44100
| xine_play
`----

However, the sound is stuttering a lot (I guess this is a xine-lib
issue).

Nevertheless thanks Jaroslav and Clemens for your help!

Regards,
Markus Korber
