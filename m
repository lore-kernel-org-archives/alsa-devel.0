From: Piers O'Hanlon <p.ohanlon@cs.ucl.ac.uk>
Subject: Re: Getting XRUN after writei in RUNNING state?
Date: Fri, 09 Nov 2007 17:07:19 +0000
Message-ID: <473493C7.1030800@cs.ucl.ac.uk>
References: <47348C2D.7020509@cs.ucl.ac.uk>
	<Pine.LNX.4.61.0711091746060.8935@tm8103-a.perex-int.cz>
Reply-To: p.ohanlon@cs.ucl.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bells.cs.ucl.ac.uk (bells.cs.ucl.ac.uk [128.16.5.31])
	by alsa0.perex.cz (Postfix) with SMTP id 75B22244B2
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 18:07:59 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0711091746060.8935@tm8103-a.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for getting back me.

Jaroslav Kysela wrote:
> On Fri, 9 Nov 2007, Piers O'Hanlon wrote:
> ....
>
> Could you do whole dump (snd_pcm_dump()) to see all plugins in chain?
> I judge from period_size that we have another problem with rate plugin.
> It would be better to do rate resampling in RAT.
>   
I set the period size to the match the closest to the expected minimum
audio packet size (20ms - 320 bytes in our case) - I wasn't sure the
best choice for all parameters. I initially set the buffer size to
approx 3 packets - though I tried increasing to twice that. It just
wasn't clear which parameters were causing it to go into XRUN (I also
set the stop threshold to maximum to make sure it was the stop
threshold  - though I guess it it overrun the buffer size we'll get
audio from the beginning of the ring buffer anyway wthat wouldn't sound
too good)

(snd_pcm_dump()) is below:

 
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 16000
  exact rate   : 16000 (16000/1)
  msbits       : 16
  buffer_size  : 2048
  period_size  : 341
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 341
  xfer_align   : 1
  start_threshold  : 341
  stop_threshold   : 2048
  silence_threshold: 0
  silence_size : 0
  boundary     : 536870912
Slave: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 6144
  period_size  : 1024
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 3
  start_threshold  : 1024
  stop_threshold   : 6144
  silence_threshold: 0
  silence_size : 0
  boundary     : 1610612736
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 6144
  period_size  : 1024
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 3
  start_threshold  : 1024
  stop_threshold   : 6144
  silence_threshold: 0
  silence_size : 0
  boundary     : 1610612736
Hardware PCM card 0 'AMD AMD8111' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tick_time    : 4000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 1
  stop_threshold   : 1073741824
  silence_threshold: 0
  silence_size : 1073741824
  boundary     : 1073741824

> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project
>   
