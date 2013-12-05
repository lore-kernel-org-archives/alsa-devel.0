From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma coherent
	mask to 32bits
Date: Thu, 5 Dec 2013 09:56:19 +0000
Message-ID: <20131205095619.GC4360@n2100.arm.linux.org.uk>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 07EB5265098
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 10:56:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
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

On Thu, Dec 05, 2013 at 10:06:42AM +0200, Peter Ujfalusi wrote:
> The underlying API dma_coerce_mask_and_coherent() checks the requested bits
> mask against the size of dma_addr_t which is 32bits on OMAP.
> Because of the previously used 64bits mask audio was not probing after
> commit c9bd5e6 (and 4dcfa6007).
> 32bits for the DMA_BIT_MASK looks to be the correct one to use.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Mark,
> 
> This is the fix for OMAP audio for 3.13-rc2+. The dma coherent changes went in
> between -rc1 and -rc2 which broke things because omap-pcm was using 64bits for
> dma coherent mask.

Can you please try to understand _why_ it broke and post an explanation.
This breakage wasn't expected and shouldn't have happened.
