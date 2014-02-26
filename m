From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 06/10] ASoC: simple-card: Use snd_soc_dai_set_tdm_slot_xlate()
Date: Wed, 26 Feb 2014 11:59:31 +0800
Message-ID: <1393387175-15539-7-git-send-email-Li.Xiubo@freescale.com>
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

This will use the DAI driver specified .of_xlate_tdm_slot_mask to generate
the TDM slot TX/RX mask, or the default snd_soc_of_xlate_tdm_slot_mask will
be used instead if it's absent.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index bdd176d..22efa83 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -48,11 +48,10 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 	}
 
 	if (set->slots) {
-		ret = snd_soc_dai_set_tdm_slot(dai, 0, 0,
-						set->slots,
-						set->slot_width);
+		ret = snd_soc_dai_set_tdm_slot_xlate(dai, set->slots,
+						     set->slot_width);
 		if (ret && ret != -ENOTSUPP) {
-			dev_err(dai->dev, "simple-card: set_tdm_slot error\n");
+			dev_err(dai->dev, "simple-card: set_tdm_slot_xlate error\n");
 			goto err;
 		}
 	}
-- 
1.8.4
