From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma coherent
	mask to 32bits
Date: Fri, 6 Dec 2013 12:25:43 +0000
Message-ID: <20131206122543.GL4360@n2100.arm.linux.org.uk>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
 <20131205095619.GC4360@n2100.arm.linux.org.uk> <52A09CDA.6010700@ti.com>
 <20131205192853.GH4360@n2100.arm.linux.org.uk> <s5h4n6nhxbt.wl%tiwai@suse.de>
 <20131205210707.GI4360@n2100.arm.linux.org.uk> <s5htxemgzyx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id E794B2610A3
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 13:26:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htxemgzyx.wl%tiwai@suse.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 06, 2013 at 09:12:22AM +0100, Takashi Iwai wrote:
> But, it's still unclear why only get_coherent_dma_mask() takes max_pfn
> into account for the check of dma_to_pfn(dev, mask).
> 
> In dma_supported(), 
> 
> 	unsigned long limit;
> 	limit = dma_to_pfn(dev, mask);
> 	if (limit < arm_dma_pfn_limit)
> 		return 0;
> 
> while in get_coherent_dma_mask(),
> 
> 	unsigned long max_dma_pfn;
> 	max_dma_pfn = min(max_pfn, arm_dma_pfn_limit);
> 	if (dma_to_pfn(dev, mask) < max_dma_pfn)
> 		return 0;
> 
> So, the current code looks to me that the results from
> dma_set_coherent_mask() and the actual allocation may conflict.

I did ask Peter to replace *both* with the same thing.
