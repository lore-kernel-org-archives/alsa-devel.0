From: Eric Miao <eric.y.miao@gmail.com>
Subject: [RFC PATCH 4/5] ASoC: remove those unnecessary #ifdef CONFIG_PXA3xx
	.. #endif
Date: Thu, 23 Apr 2009 13:06:55 +0800
Message-ID: <f17812d70904222206h27c58e40t5c8383133df1a7d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <bshen9@marvell.com>
List-Id: alsa-devel@alsa-project.org

These are unnecessary since the compiler is smart enough to optimize
the code away if CONFIG_PXA3xx is not defined, when cpu_is_pxa3xx()
will just be expanded to constant 0.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 sound/soc/pxa/pxa-ssp.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index a65993c..2ce4fb6 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -360,24 +360,20 @@ static int pxa_ssp_set_dai_clkdiv(struct
snd_soc_dai *cpu_dai,
 	case PXA_SSP_AUDIO_DIV_SCDB:
 		val = ssp_read_reg(ssp, SSACD);
 		val &= ~SSACD_SCDB;
-#if defined(CONFIG_PXA3xx)
 		if (cpu_is_pxa3xx())
 			val &= ~SSACD_SCDX8;
-#endif
 		switch (div) {
 		case PXA_SSP_CLK_SCDB_1:
 			val |= SSACD_SCDB;
 			break;
 		case PXA_SSP_CLK_SCDB_4:
 			break;
-#if defined(CONFIG_PXA3xx)
 		case PXA_SSP_CLK_SCDB_8:
 			if (cpu_is_pxa3xx())
 				val |= SSACD_SCDX8;
 			else
 				return -EINVAL;
 			break;
-#endif
 		default:
 			return -EINVAL;
 		}
@@ -403,10 +399,8 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
 	struct ssp_device *ssp = priv->ssp;
 	u32 ssacd = ssp_read_reg(ssp, SSACD) & ~0x70;

-#if defined(CONFIG_PXA3xx)
 	if (cpu_is_pxa3xx())
 		ssp_write_reg(ssp, SSACDD, 0);
-#endif

 	switch (freq_out) {
 	case 5622000:
@@ -431,7 +425,6 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
 		break;

 	default:
-#ifdef CONFIG_PXA3xx
 		/* PXA3xx has a clock ditherer which can be used to generate
 		 * a wider range of frequencies - calculate a value for it.
 		 */
@@ -452,8 +445,6 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
 				val, freq_out);
 			break;
 		}
-#endif
-
 		return -EINVAL;
 	}

@@ -652,10 +643,8 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 	sscr0 = ssp_read_reg(ssp, SSCR0);
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-#ifdef CONFIG_PXA3xx
 		if (cpu_is_pxa3xx())
 			sscr0 |= SSCR0_FPCKE;
-#endif
 		sscr0 |= SSCR0_DataSize(16);
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
@@ -682,7 +671,6 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 			* needed for that mode are only available on PXA3xx.
 			*/

-#ifdef CONFIG_PXA3xx
 			if (!cpu_is_pxa3xx())
 				return -EINVAL;

@@ -691,9 +679,6 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 			sspsp |= SSPSP_EDMYSTOP(3);
 			sspsp |= SSPSP_DMYSTOP(3);
 			sspsp |= SSPSP_DMYSTRT(1);
-#else
-			return -EINVAL;
-#endif
 		} else {
 			/* The frame width is the width the LRCLK is
 			 * asserted for; the delay is expressed in
-- 
1.6.0.4

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
