From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Fix off by one error in the loop stucture.
Date: Mon, 24 Nov 2014 20:37:12 +0200
Message-ID: <1416854232-29432-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, dcb314@hotmail.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Fix off by one read beyond the end of a table.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 145fe5b..93de5dd 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -911,12 +911,13 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	}
 	aic31xx->p_div = i;
 
-	for (i = 0; aic31xx_divs[i].mclk_p != freq/aic31xx->p_div; i++) {
-		if (i == ARRAY_SIZE(aic31xx_divs)) {
-			dev_err(aic31xx->dev, "%s: Unsupported frequency %d\n",
-				__func__, freq);
-			return -EINVAL;
-		}
+	for (i = 0; i < ARRAY_SIZE(aic31xx_divs) &&
+		     aic31xx_divs[i].mclk_p != freq/aic31xx->p_div; i++)
+		;
+	if (i == ARRAY_SIZE(aic31xx_divs)) {
+		dev_err(aic31xx->dev, "%s: Unsupported frequency %d\n",
+			__func__, freq);
+		return -EINVAL;
 	}
 
 	/* set clock on MCLK, BCLK, or GPIO1 as PLL input */
-- 
1.7.9.5

