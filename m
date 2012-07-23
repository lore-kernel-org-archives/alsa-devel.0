From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 12:47:19 +0200
Message-ID: <500D2BB7.2010802@perex.cz>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <s5hvcheu60x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 7364D265242
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 12:46:32 +0200 (CEST)
In-Reply-To: <s5hvcheu60x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Date 23.7.2012 12:27, Takashi Iwai wrote:
> At Mon, 23 Jul 2012 15:36:37 +0530,
> Vinod Koul wrote:
>>
>> In many modern SoCs the audio DSP can buffer the PCM ring buffer data. Today we
>> have no means to represent this buffering and ALSA wrongly detects an overrun
>> when hw_ptr reaches app_ptr value, though DSP may still have some buffered data.
>>
>> This patch tries to add a new field "soc_delay" to represent buffering done in
>> DSPs. This value is also used for the xrun calculations in ALSA.
>>
>> Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
>>
>> --
>> Once we are okay with this approach, I will send a follow up patch which adds
>> this notion in ASoC and uses this to compute cpu_dai delay. The codec_dai delay
>> along with FIFO delay from cpu_dai should be added and reresented by today's
>> notion of delay.
> 
> Hmm, it's confusing to have both delay and soc_delay fields.
> 
> And, if the XRUN detection is the only problem, we can provide a flag
> to correct avail with runtime->delay.

I agree. The runtime->delay variable should handle all situations for
queued samples.

But the point is - we have data in some FIFO, but the DMA ring buffer is
empty. If you use the delay value in the snd_pcm_update_state(), you'll
probably allow to transfer invalid samples to the FIFO (probably
previous samples from the ring buffer, because application has not
provided new ones). That was the purpose of the check.

Of course, if you stop DMA according the appl_ptr and wait on
application to provide new data in the "FIFO time window", then the
check should be updated for this type of hw.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
