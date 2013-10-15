From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: generic-dmaengine-pcm: Add an
 interface to override its functions
Date: Tue, 15 Oct 2013 17:37:17 +0800
Message-ID: <20131015093717.GB18784@MrMyself>
References: <1381823360-8672-1-git-send-email-b42378@freescale.com>
 <525CF814.6090403@metafoo.de> <20131015082229.GA18714@MrMyself>
 <525D04B4.3050606@metafoo.de> <20131015092350.GA18784@MrMyself>
 <525D0D7A.8010309@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id E0490261664
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 11:47:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525D0D7A.8010309@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 15, 2013 at 11:40:10AM +0200, Lars-Peter Clausen wrote:
> On 10/15/2013 11:23 AM, Nicolin Chen wrote:
> > On Tue, Oct 15, 2013 at 11:02:44AM +0200, Lars-Peter Clausen wrote:
> >>> If this modification to sound/core/pcm_dmaengine.c is not fair,
> >>> what about moving the modification to soc-gerneric-dmaengine-pcm.c?
> >>>
> >>> For example, instead of using snd_dmaengine_pcm_trigger() directly
> >>> in gerneric soc dmaengine driver, we create a new one inside gerneric
> >>> soc dmaengine driver and check the override:
> >>>
> >>> static int snd_soc_dmaengine_pcm_trigger(substream, cmd) {
> >>> 	if (config->driver->ops->trigger)
> >>> 		return config->driver->ops->trigger(substream, cmd);
> >>> 		
> >>> 	return snd_dmaengine_pcm_trigger(substream, cmd);
> >>> }
> >>>
> >>> Since it happens inside generic dmaengine pcm ASoC driver, it won't break
> >>> those helper functions.
> >>>
> >>> I'm trying this just because I hope generic dmaengine can be more flexible
> >>> Admittedly, using helper functions might be more plausible way in current
> >>> ASoC structure. However, there might be so much change for an generic soc
> >>> dmaengine implementation even if it just wants to override one single func.
> >>
> >> Well the idea of the generic dmaengine driver is to be generic and not
> >> require SoC specific hacks since those should not be necessary if things are
> >> done right. What exactly do you want to implement in the overwritten ops?
> >>
> >> - Lars
> > 
> > Just like I mentioned in the commit comments, using on-chip memory would
> > need an alternative memory allocating function to replace the default one
> > from external DDR. imx-pcm-dma.c is now using ASoC generic dmaengine, so
> > if we turn it back to helper functions way, all cpu dai drivers might have
> > to be turned back as well.
> > 
> > ASoC generic dmaengine is quite concise and well-developed for us to use.
> > But after using it, its own limitation might make user waver to choose the
> > old fashion helper functions. So I just wish it could provide a back door
> > for an easy trick. Then we can continue to enjoy the convenience from it
> > and also be able to tackle these uncommon cases.
> 
> Wanting to use on-chip memory for the audio buffers is not that uncommon.
> I'd rather see this implemented generically in the generic driver instead of
> each SoC implementing its own version.
> 
> - Lars

Is that so? Actually, I did as you said in my internal branch, but I just
fear that might not be easy to upstream, so I tried to figure out another
plausible way. It looks like I took a detour :)

Thank you for the advice.
Nicolin Chen
