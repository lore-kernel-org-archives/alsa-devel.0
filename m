From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 08/10] ASoC: blackfin: bf5xx-ad193x: Use snd_soc_dai_set_tdm_slot_xlate()
Date: Wed, 26 Feb 2014 11:59:33 +0800
Message-ID: <1393387175-15539-9-git-send-email-Li.Xiubo@freescale.com>
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
 sound/soc/blackfin/bf5xx-ad193x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index 603ad1f..f622faa 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -53,11 +53,11 @@ static int bf5xx_ad193x_link_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 
 	/* set codec DAI slots, 8 channels, all channels are enabled */
-	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xFF, 0xFF, 8, 32);
+	ret = snd_soc_dai_set_tdm_slot_xlate(codec_dai, 8, 32);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xFF, 0xFF, 8, 32);
+	ret = snd_soc_dai_set_tdm_slot_xlate(cpu_dai, 8, 32);
 	if (ret < 0)
 		return ret;
 
-- 
1.8.4
