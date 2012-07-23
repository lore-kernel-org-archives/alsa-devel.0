From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 16:44:12 +0530
Message-ID: <1343042052.1726.4892.camel@vkoul-udesk3>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <s5hvcheu60x.wl%tiwai@suse.de>  <500D2BB7.2010802@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C784260324
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 13:14:09 +0200 (CEST)
In-Reply-To: <500D2BB7.2010802@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-07-23 at 12:47 +0200, Jaroslav Kysela wrote:
> mm, it's confusing to have both delay and soc_delay fields.
> > 
> > And, if the XRUN detection is the only problem, we can provide a flag
> > to correct avail with runtime->delay.
> 
> I agree. The runtime->delay variable should handle all situations for
> queued samples.
> But the point is - we have data in some FIFO, but the DMA ring buffer is
> empty. 
In a DSP you can have input buffer (from the ring buffer), which is post
processed and sent to output DMA buffer. This buffering is dynamic in
nature and since input buffer is memory copy, it would buffer ahead of
time unlike the output buffer which will run at PCM rate. The samples at
input DMA and various modules doing DSP processing are still before
output circular DMA and should be considered when we do xrun
calculation.

> If you use the delay value in the snd_pcm_update_state(), you'll
> probably allow to transfer invalid samples to the FIFO (probably
> previous samples from the ring buffer, because application has not
> provided new ones). That was the purpose of the check.
Yes and the right one. But what about samples still there before DMA,
this patch just attempts to represent those. not the ones at and after
DMA, they are correctly represented today in runtime->delay.

> Of course, if you stop DMA according the appl_ptr and wait on
> application to provide new data in the "FIFO time window", then the
> check should be updated for this type of hw.
> 


>                                         Jaroslav 
-- 
~Vinod
