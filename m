From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma coherent
	mask to 32bits
Date: Thu, 5 Dec 2013 19:28:53 +0000
Message-ID: <20131205192853.GH4360@n2100.arm.linux.org.uk>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
 <20131205095619.GC4360@n2100.arm.linux.org.uk> <52A09CDA.6010700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id CB169261A81
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 20:30:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <52A09CDA.6010700@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 05, 2013 at 05:33:46PM +0200, Peter Ujfalusi wrote:
> I'm not that familiar with this part of the code (mm, dma-mapping) but so far
> this is what I found:
> 
> ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(64));
> is successful, no failure to set the mask to 64.
> 
> later on when requesting the dma channel however:
> arm_dma_alloc() -> get_coherent_dma_mask()  fails.
> 
> As far I can see we have different checks in case of
> dma_coerce_mask_and_coherent() and arm_dma_alloc():
> 
> [1] dma_coerce_mask_and_coherent() -> dma_supported()
> 
>  	if (sizeof(mask) != sizeof(dma_addr_t) &&
>  	    mask > (dma_addr_t)~0 &&
>  	    dma_to_pfn(dev, ~0) > arm_dma_pfn_limit)  /* !!! */
>  		return 0;
> 
> 
> [2] arm_dma_alloc() -> get_coherent_dma_mask()
> 
>  	if (sizeof(mask) != sizeof(dma_addr_t) &&
>  	    mask > (dma_addr_t)~0 &&
>  	    dma_to_pfn(dev, ~0) > min(max_pfn, arm_dma_pfn_limit)) /* !!! */
>  		return 0;
> 
> On omap4:
> max_pfn: 0xc0000, arm_dma_pfn_limit: 0xfffff

Obviously, we should not be saying that the mask is okay, and then failing
with that same mask.

I've thinking about what the right fix here is - it's been quite a while
since I devised those tests and the knowledge I had back then has been
swapped out...

The point of these tests are to deal with masks which are larger than
dma_addr_t allows, and to only deny if we have sufficient system memory
that we may overflow dma_addr_t.

So...

	sizeof(u64) != sizeof(dma_addr_t)

detects when we have non-64 bit dma_addr_t.

	mask > (dma_addr_t)~0

detects if the mask is larger than 4GiB.

	dma_to_pfn(dev, ~0)

gives us the very last PFN which the bus associated with dev is able to
address.  Hmm - so I got the test wrong on both twice - they should both
be:

 	if (sizeof(mask) != sizeof(dma_addr_t) &&
 	    mask > (dma_addr_t)~0 &&
 	    dma_to_pfn(dev, ~0) < min(max_pfn, arm_dma_pfn_limit))
		return 0;

since we want to fail if we have _more_ memory than the bus will allow.
Can you try the above in both locations please?
