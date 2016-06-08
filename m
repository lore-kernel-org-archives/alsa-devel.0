From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2] ASoC: cs53l30: Correct clock inversion check
Date: Wed,  8 Jun 2016 16:10:05 -0700
Message-ID: <1465427405-11344-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SND_SOC_DAIFMT_IB_NF = 0x3 (11b) | SND_SOC_DAIFMT_IB_IF = 0x4 (100b)
creates a mask 0x7 (111b) which also includes SND_SOC_DAIFMT_NB_IF
= 0x2 (10b).

So this patch uses the traditional way to check the clock inversion.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog:
v1->v2:
 * Correct one typo in the commit log

 sound/soc/codecs/cs53l30.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index ac90dd7..62daa0c 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -598,8 +598,14 @@ static int cs53l30_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* Check to see if the SCLK is inverted */
-	if (fmt & (SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_IB_IF))
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_IB_IF:
 		aspcfg ^= CS53L30_ASP_SCLK_INV;
+		break;
+	default:
+		break;
+	}
 
 	regmap_update_bits(priv->regmap, CS53L30_ASPCFG_CTL,
 			   CS53L30_ASP_MS | CS53L30_ASP_SCLK_INV, aspcfg);
-- 
2.1.4
