From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: prealloc_buffer_size and buffer_bytes_max
Date: Thu, 21 May 2015 16:40:32 +0200
Message-ID: <555DEE60.7050602@lysator.liu.se>
References: <555DCF69.9090008@lysator.liu.se>
 <20150521125914.GA30345@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 634782614DD
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 16:40:35 +0200 (CEST)
In-Reply-To: <20150521125914.GA30345@piout.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 2015-05-21 14:59, Alexandre Belloni wrote:
> Hi,
> 
> On 21/05/2015 at 14:28:25 +0200, Peter Rosin wrote :
>> I got my hopes up when I read the commit message for c14e2591bf54
>> ASoC: atmel-pcm-dma: increase buffer_bytes_max. Quoting it:
>>
>> 	atmel-pcm-dma is not limited to a buffer size of 64kB like
>> 	atmel-pcm-pdc. Increase buffer_bytes_max to 512kB to allow
>> 	for higher bit rates (i.e. 32bps at 192kHz) to work correctly.
>> 	By default, keep the prealloc at 64kB.
>>
>> However, as I (think I) request a bigger buffer it still caps out at 64kB.
>> I'm using the latency argument of snd_pcm_set_params to control the buffer:
>>
>> 	snd_pcm_set_params(pcm,
>> 		SND_PCM_FORMAT_S32_LE,
>> 		SND_PCM_ACCESS_RW_INTERLEAVED,
>> 		2,      /* channels */
>> 		250000, /* rate */
>> 		0,      /* do not resample */
>> 		90000); /* latency in us */
>>
>> But snd_pcm_hw_params_get_buffer_size "only" returns 8192 frames (64kB)
>> even if I request 9us * 250kHz * 2 * 4 = 180kB. If I change the prealloc
>> from 64kB to 256kB I get a bigger buffer (and it works better too!).
>>
>> Admittedly I backported this patch on top of the linux-3.18-at91
>> branch from the Atmel git repo, so there might be some support
>> missing that has gone in after 3.18?
>>
>> Or have I completely misunderstood, and these are unrelated buffers?
>>
> 
> Those are somewhat related but not the same.
> 
>> Any insight in how I can get a big enough buffer without hacking the
>> prealloc is appreciated!
>>
> 
> You can change the prealloc size in
> /proc/asound/card0/pcm0p/sub0/prealloc or by using
> snd_pcm_lib_preallocate_pages_for_all(). I never experienced the issue
> but what I did solved it for someone doing 32bits per sample at 192kHz.

Great, exactly the sort of thing I was looking for, many thanks!

The bug I have been chasing (hopefully gone now, running without
incidents for 16 hours and counting) manifests as follows:

1. It all runs fine for somewhere between half an hour and several hours
   (probably a Poisson distribution)
2. Something bad happens and data from the wrong part of the buffer is
   fed to i2s (i.e. phase shift if playing sine wave) at 8192 byte
   intervals (the pcm period). In this bad mode there is also some
   probability of a whole series of these phase shifts (i.e. several
   phase shifts in a couple of dozen samples, essentially noise), in
   particular if the system is busy with some unrelated calculation.
3. After five minutes to an hour or so, something good happens, bringing
   the system back to state 1. I.e. it seems easier to exit the bad mode
   than it is to enter it.

The overall rate in the bad 2 state seems right, i.e. the sample
count appears to be right. However, no underrun or other errors are
reported. So, this corruption is silent (if you disconnect all
speakers, that is...).

Should there not -- ideally -- be some sort of error reported back
to a program that asks for more than the system can handle?

Cheers,
Peter
