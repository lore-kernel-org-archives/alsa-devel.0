From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: alsa timestamps
Date: Mon, 19 Nov 2007 15:41:46 +0200
Message-ID: <4741929A.5000005@cs.helsinki.fi>
References: <47413D60.9000404@cs.helsinki.fi> <47418778.20609@cs.helsinki.fi>
	<Pine.LNX.4.61.0711191405590.7813@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh01.mail.saunalahti.fi (emh01.mail.saunalahti.fi
	[62.142.5.107]) by alsa0.perex.cz (Postfix) with ESMTP id 7B0F424863
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 14:41:49 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0711191405590.7813@tm8103.perex-int.cz>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela kirjoitti:
> On Mon, 19 Nov 2007, Heikki Lindholm wrote:
> 
>> Heikki Lindholm kirjoitti:
>>> Hello list,
>>>
>>> I took up some old dusty code of mine that uses snd_pcm_state followed 
>>> by snd_pcm_status_get_tstamp when in capture mode. The code used to 
>>> work, but now the returned timestamps are all zeroes. Is there some API 
>>> change done recently or is the whole timestamping deprecated or 
>>> something? I've tried with different drivers on ubuntu's alsa .14 and 
>>> gentoo's .14. I've also tried mmap'ed and r/w modes, and I'm setting the 
>>> TSTAMP_MMAP sw param.
>> I figured out that this doesn't happen when using hw:x,y devices. Is it 
>> a documented feature that some (software?) devices don't fill in timestamps?
> 
> I think that it should be fixed. Could you send us 'snd_pcm_dump()' for a 
> non-working device? It's probably ommited code in direct pcm plugins (dmix 
> & etc.).

Here goes. The driver is snd_aoa. It seems as if the timestamp mode 
isn't propagated to the hw device.

Plug PCM: Rate conversion PCM (48000, sformat=S16_BE)
Its setup is:
   stream       : CAPTURE
   access       : RW_INTERLEAVED
   format       : S16_BE
   subformat    : STD
   channels     : 2
   rate         : 44100
   exact rate   : 44100 (44100/1)
   msbits       : 16
   buffer_size  : 15052
   period_size  : 940
   period_time  : 21333
   tick_time    : 0
   tstamp_mode  : MMAP
   period_step  : 1
   sleep_min    : 0
   avail_min    : 940
   xfer_align   : 940
   start_threshold  : 1
   stop_threshold   : 15052
   silence_threshold: 0
   silence_size : 0
   boundary     : 4236761349448794112
Slave: Direct Snoop PCM
Its setup is:
   stream       : CAPTURE
   access       : MMAP_INTERLEAVED
   format       : S16_BE
   subformat    : STD
   channels     : 2
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 16384
   period_size  : 1024
   period_time  : 21333
   tick_time    : 0
   tstamp_mode  : MMAP
   period_step  : 1
   sleep_min    : 0
   avail_min    : 1024
   xfer_align   : 1024
   start_threshold  : 1
   stop_threshold   : 16384
   silence_threshold: 0
   silence_size : 0
   boundary     : 4611686018427387904
Hardware PCM card 0 'SoundByLayout' device 0 subdevice 0
Its setup is:
   stream       : CAPTURE
   access       : MMAP_INTERLEAVED
   format       : S16_BE
   subformat    : STD
   channels     : 2
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 16384
   period_size  : 1024
   period_time  : 21333
   tick_time    : 1000
   tstamp_mode  : NONE
   period_step  : 1
   sleep_min    : 0
   avail_min    : 1024
   xfer_align   : 1024
   start_threshold  : 1
   stop_threshold   : 4611686018427387904
   silence_threshold: 0
   silence_size : 0
   boundary     : 4611686018427387904


-- Heikki Lindholm
