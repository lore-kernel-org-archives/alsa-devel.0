From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [alsa-devel] Calling omap_pcm_prepare() results in BUG() on
 OMAP1
Date: Wed, 21 Oct 2009 10:16:37 +0300
Message-ID: <20091021101637.e8167edb.jhnikula@gmail.com>
References: <200910210511.08263.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <200910210511.08263.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Wed, 21 Oct 2009 05:11:06 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Hi,
> After DMA burst mode has been introduced in sound/soc/omap/omap-pcm.c, 
> omap_pcm_prepare() unconditionally calls:
> 
> 	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> 	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> 
> AFAICS, current implementation of those two functions found in 
> arch/arm/plat-ompa/dma.c doesn't support OMAP_DMA_DATA_BURST_16 on OMAP1 at 
> all, so they both end with BUG() on that machine. That seems to result in 
> ASoC being completely unusable, at least on my OMAP5910 based Amstrad Delta.
> 
Thanks for reporting the issue. Nobody didn't realize when those calls
were added that indeed they will end up to BUG() in
arch/arm/plat-omap/dma.c on OMAP1.

> Is calling BUG() for OMAP1 from those functions intentional?
> 
> If not intentional, can those be corrected by simply putting break; before 
> defalut:?
> 
I'd let it on as it is as it will point out immediately invalid
argument for OMAP1 and those functions do not have return value.

> If intentional, can those function calls be conditionally omited, at least for 
> OMAP1510, in sound/soc/omap/omap-pcm.c?
> 
Yep, just put cpu_class_is_omap1() test in sound/soc/omap/omap-pcm.c
since we should not try to set unsupported burst size for OMAP1.


-- 
Jarkko
