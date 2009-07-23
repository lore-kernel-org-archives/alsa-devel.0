From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: multi-channel playback regression
Date: Thu, 23 Jul 2009 16:33:08 +0800
Message-ID: <20090723083308.GA32173@localhost>
References: <20090723065345.GA1884@localhost> <s5hskgnx4qm.wl%tiwai@suse.de>
	<20090723072253.GA15878@localhost> <s5hprbrx3dd.wl%tiwai@suse.de>
	<20090723075620.GA21405@localhost> <s5hiqhjx1a8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 00F4410399B
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 10:33:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hiqhjx1a8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 04:15:59PM +0800, Takashi Iwai wrote:
> At Thu, 23 Jul 2009 15:56:20 +0800,
> Wu Fengguang wrote:
> > 
> > On Thu, Jul 23, 2009 at 03:30:54PM +0800, Takashi Iwai wrote:
> > > At Thu, 23 Jul 2009 15:22:53 +0800,
> > > Wu Fengguang wrote:
> > > > 
> > > > On Thu, Jul 23, 2009 at 03:01:21PM +0800, Takashi Iwai wrote:
> > > > > At Thu, 23 Jul 2009 14:53:45 +0800,
> > > > > Wu Fengguang wrote:
> > > > > > 
> > > > > > Hi Takashi,
> > > > > > 
> > > > > > When doing multi-channel playback tests on IbexPeak, I found that the
> > > > > > following patch makes the playback enter an infinite loop, repeatedly
> > > > > > playing a range of ~0.5s audio content. (Seems that some buffer
> > > > > > pointer can never advance.)
> > > > > 
> > > > > Could you set 1 to /proc/asound/card0/pcm0p/xrun_debug and give the
> > > > > messages?  Also, please show /proc/.../pcm0p/sub0/hw_params, too.
> > > > > 
> > > > > The change affects only the code path for the problematic hardware
> > > > > that reports wrong DMA position.  So, if this change regresses, it
> > > > > means that the device has been already problematic from the
> > > > > beginning...
> > > > 
> > > > I caught some messages:
> > > 
> > > Is this with the patched (as is on sound git tree) kernel?
> > 
> > Yes, it's unmodified latest git tree.
> > 
> > > What if changing from #if 1 to #if 0?
> > 
> > This makes 8-channel playback work again.
> 
> OK, then could you apply the patch below, and do
> "echo 9 > /proc/../xrun_debug", then gather the messages with both
> #if 1 and #if 0?  This will record the each snd_pcm_period_elpased()
> so beware that you may get flood of messages.

OK, but for now this box is doing something else that cannot interrupted.
So I'll try the patch some time later. Sorry.

Thanks,
Fengguang

> ---
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index 3b673e2..065eaf0 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -233,6 +233,18 @@ static int snd_pcm_update_hw_ptr_interrupt(struct snd_pcm_substream *substream)
>  		xrun(substream);
>  		return -EPIPE;
>  	}
> +	if (xrun_debug(substream, 8)) {
> +		char name[16];
> +		pcm_debug_name(substream, name, sizeof(name));
> +		snd_printd("period_update: %s: pos=0x%x/0x%x/0x%x, "
> +			   "hwptr=0x%lx, hw_base=0x%lx, hw_intr=0x%lx\n",
> +			   name, pos,
> +			   (int)runtime->period_size,
> +			   (int)runtime->buffer_size,
> +			   (long)old_hw_ptr,
> +			   (long)runtime->hw_ptr_base,
> +			   (long)runtime->hw_ptr_interrupt);
> +	}
>  	hw_base = runtime->hw_ptr_base;
>  	new_hw_ptr = hw_base + pos;
>  	hw_ptr_interrupt = runtime->hw_ptr_interrupt + runtime->period_size;
> @@ -353,6 +365,19 @@ int snd_pcm_update_hw_ptr(struct snd_pcm_substream *substream)
>  		xrun(substream);
>  		return -EPIPE;
>  	}
> +	if (xrun_debug(substream, 16)) {
> +		char name[16];
> +		pcm_debug_name(substream, name, sizeof(name));
> +		snd_printd("hw_update: %s: pos=0x%x/0x%x/0x%x, "
> +			   "hwptr=0x%lx, hw_base=0x%lx, hw_intr=0x%lx\n",
> +			   name, pos,
> +			   (int)runtime->period_size,
> +			   (int)runtime->buffer_size,
> +			   (long)old_hw_ptr,
> +			   (long)runtime->hw_ptr_base,
> +			   (long)runtime->hw_ptr_interrupt);
> +	}
> +
>  	hw_base = runtime->hw_ptr_base;
>  	new_hw_ptr = hw_base + pos;
>  
