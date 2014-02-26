From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 10/10] ASoC: fsl: wm1133-ev1: Use snd_soc_dai_set_tdm_slot_xlate()
Date: Wed, 26 Feb 2014 11:59:35 +0800
Message-ID: <1393387175-15539-11-git-send-email-Li.Xiubo@freescale.com>
References: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: timur@tabi.org, tiwai@suse.de, lars@metafoo.de, Guangyu.Chen@freescale.com, fabio.estevam@freescale.com, shawn.guo@linaro.org, denis@eukrea.com, mpa@pengutronix.de, s.hauer@pengutronix.de, moinejf@free.fr, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_dai_set_tdm_slot_xlate instead of snd_soc_dai_set_tdm_slot.
This will use the default snd_soc_of_xlate_tdm_slot_mask to generate
the TDM slot TX/RX mask using the slot parameter.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/wm1133-ev1.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index fce6325..4519b08 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -114,16 +114,7 @@ static int wm1133_ev1_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_dai_set_fmt(cpu_dai, dai_format);
 
 	/* TODO: The SSI driver should figure this out for us */
-	switch (channels) {
-	case 2:
-		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
-		break;
-	case 1:
-		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffe, 0xffffffe, 1, 0);
-		break;
-	default:
-		return -EINVAL;
-	}
+	snd_soc_dai_set_tdm_slot_xlate(cpu_dai, channels, 0);
 
 	/* set MCLK as the codec system clock for DAC and ADC */
 	snd_soc_dai_set_sysclk(codec_dai, WM8350_MCLK_SEL_PLL_MCLK,
-- 
1.8.4
