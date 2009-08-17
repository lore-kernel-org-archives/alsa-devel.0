From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv4 16/20] ASoC: OMAP: Enable DMA burst mode
Date: Mon, 17 Aug 2009 16:25:00 +0300
Message-ID: <20090817162500.f01772a9.jhnikula__34210.2591334426$1250515429$gmane$org@gmail.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
	<1250509879-6703-17-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Mon__17_Aug_2009_16_25_00_+0300_KynOpZqwr8yOQKzQ"
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250509879-6703-17-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Mon__17_Aug_2009_16_25_00_+0300_KynOpZqwr8yOQKzQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2009 14:51:15 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  sound/soc/omap/omap-pcm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index f769a52..f037db0 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -193,6 +193,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>  	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ |
>  				(cpu_is_omap1510() ? OMAP_DMA_LAST_IRQ : 0));
>  
> +	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> +	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
> +
>  	return 0;

This seems to be based on first version of Janusz's "[RFC] [PATCH 3/3]
ASoC: OMAP: Enhance OMAP1510 DMA progress software counter".

I Attached a version which is based on "[PATCH 3/3 v3] ASoC: OMAP:
Enhance OMAP1510 DMA progress software counter.


-- 
Jarkko

--Multipart=_Mon__17_Aug_2009_16_25_00_+0300_KynOpZqwr8yOQKzQ
Content-Type: text/x-diff;
 name="0001-ASoC-OMAP-Enable-DMA-burst-mode.patch"
Content-Disposition: attachment;
 filename="0001-ASoC-OMAP-Enable-DMA-burst-mode.patch"
Content-Transfer-Encoding: 7bit

>From a5eb199316c4731c11c7f5f8d02612ede4de7199 Mon Sep 17 00:00:00 2001
From: Eduardo Valentin <eduardo.valentin@nokia.com>
Date: Mon, 17 Aug 2009 14:51:15 +0300
Subject: [PATCH] ASoC: OMAP: Enable DMA burst mode

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index eab4533..b9633d5 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -195,6 +195,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 	else
 		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
 
+	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+
 	return 0;
 }
 
-- 
1.6.3.3


--Multipart=_Mon__17_Aug_2009_16_25_00_+0300_KynOpZqwr8yOQKzQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Multipart=_Mon__17_Aug_2009_16_25_00_+0300_KynOpZqwr8yOQKzQ--
