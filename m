From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma coherent
	mask to 32bits
Date: Thu, 5 Dec 2013 21:07:07 +0000
Message-ID: <20131205210707.GI4360@n2100.arm.linux.org.uk>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
 <20131205095619.GC4360@n2100.arm.linux.org.uk> <52A09CDA.6010700@ti.com>
 <20131205192853.GH4360@n2100.arm.linux.org.uk> <s5h4n6nhxbt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id B3CB9261A80
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 22:07:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h4n6nhxbt.wl%tiwai@suse.de>
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

On Thu, Dec 05, 2013 at 09:11:50PM +0100, Takashi Iwai wrote:
> Does the check of dma_to_pfn(dev, ~0) is really necessary?

Of course.

> In get_coherent_dma_mask(), it checks further
> 
> 		if (dma_to_pfn(dev, mask) < max_dma_pfn) {
> 
> and since mask > ~0, this check should suffice, I think.

dma_to_pfn() takes a dma_addr_t as the second argument.  At this point,
we've ascertained that 'mask' is larger than dma_addr_t, so the above
will truncate the mask.

The whole point of this is to protect the following code which does
exactly that from this truncation.
