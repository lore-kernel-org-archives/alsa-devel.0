From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: safe support for rewind in ALSA
Date: Mon, 1 Feb 2010 23:28:01 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw02.mail.saunalahti.fi (gw02.mail.saunalahti.fi
	[195.197.172.116])
	by alsa0.perex.cz (Postfix) with ESMTP id F30AE2413F
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 22:31:38 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
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
Cc: pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

btw, another related thread:
James Courtier-Dutton - "DMA and delay feedback"
http://article.gmane.org/gmane.linux.alsa.devel/69262

So it seems this is a fairly frequenty-raised-topic nowadays here.;)

But then some actual comments inline:

On Mon, 1 Feb 2010, Jaroslav Kysela wrote:

>> of dealing with it.  This seems easier than trying to integrate the
>> information with the DMA data and more useful for latencies which we
>> know as actual time delays rather than buffer sizes in the hardware.
>
> +1 - the runtime->delay is exactly for this information (number of
> samples queued in hardware) and can be changed in the lowlevel driver at
> runtime depending on the actual hardware state.

As I already ack'ed in one of the older threads, this (btw fairly recent 
addition to ALSA) already solves part of the puzzle.

As James pointed out in the above thread from December, there are quite a 
few similar, but not quite identical, use-cases in play here. I'll now 
focus solely on the accurate a/v sync case with a buffering audio HW:

  - at T1, DMA interrupt, period is elapsed and hw_ptr is
    incremented by period-size, and driver can update runtime->delay
  - at T2, application wakes up (due to ALSA or possible e.g. by
    system-timer interrupt)
  - at T3, application calls snd_pcm_delay() to query how many samples
    of delay there is currently (e.g. if it write a sample to ALSA
    PCM device now, how long before it hits the speaker)
      - note that this is what snd_pcm_delay() is specifically for

... now note that this is a different problem than the rewind() case,
or getting more accurate pcm_avail() figures, although these all are 
related.

Anyways, the main problem is that snd_pcm_delay() accuracy is limited by
the transfer/burst size used to move samples from main memory to the sound 
chip, _although_ the hardware _is_ able to tell the exact current position 
(not related to status of the DMA transfer, but the status of what is 
currently played out to the codec).

Do you see the problem here?

In the same December thread, Eero Nurkkala posted one workaround for
this issue:
http://article.gmane.org/gmane.linux.alsa.devel/69287

So while snd_pcm_delay() provides a snapshot of the delay at the last DMA 
burst/block-transfer (when hw_ptr+runtime->delay were last updated in the 
driver), the information may be refined with snd_pcm_status_get_tstamp(), 
which essentially tells the diff between T1&T3. So essentially what the 
application is looking for is 'snd_pcm_delay()-(T3-T1)'.

Now this does work, and a big plus is that it works on top of existigng
ALSA driver interface. But for generic applications, this is a bit of a 
mess... when to use snd_pcm_delay() and when to augment the result with 
snd_pcm_status_get_tstamp()? With most "desktop audio drivers", the 
above calculation will provide the wrong result. So in the end this is a 
hack and applications must be customized for a specific piece of 
hardware/driver.

One idea is to tie this to the existing SNDRV_PCM_INFO_BATCH flag (e.g. 
quoting existing documentation in pcm_local.h -> "device transfers samples 
in batch"). So if the PCM has this flag set, application should interpret 
snd_pcm_delay() results as referring to the last batch.

What do you think? If this seems ok, an obvious next step is to provide a 
helper function snd_pcm_delay_foo()) which hides all of this from the 
apps (so that no if-else stuff for different types of drivers 
is needed in application code). Or.. (prepares to takes cover).. modify
snd_pcm_delay() to in fact do this implicitly.
