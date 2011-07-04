From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/6] ASoC: twl6040: No need to convert the PLL ID
Date: Mon, 4 Jul 2011 13:05:58 +0300
Message-ID: <1309773958-14608-7-git-send-email-peter.ujfalusi@ti.com>
References: <1309773958-14608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309773958-14608-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Since the PLL handling has been simplified, and
rebased on 0, there is no longer need for converting
the PLL ID.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 407c79e..a03f57e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1100,10 +1100,7 @@ int twl6040_get_clk_id(struct snd_soc_codec *codec)
 {
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
-	if (priv->pll_power_mode)
-		return TWL6040_SYSCLK_SEL_HPPLL;
-	else
-		return TWL6040_SYSCLK_SEL_LPPLL;
+	return priv->pll_power_mode;
 }
 EXPORT_SYMBOL_GPL(twl6040_get_clk_id);
 
-- 
1.7.6
