From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/5] ASoC: twl6040: Remove leftover code from
	hs/hf ramp implementation
Date: Fri, 11 Jan 2013 11:32:35 +0100
Message-ID: <1357900355-5055-6-git-send-email-peter.ujfalusi@ti.com>
References: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BB2C2625FC
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 11:32:44 +0100 (CET)
In-Reply-To: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The code to do the ramp has been removed a long time ago. Remove the
remaining code as well since this is not needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 6c2aa93..6ad2909 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -69,10 +69,6 @@ struct twl6040_data {
 	int hs_power_mode_locked;
 	unsigned int clk_in;
 	unsigned int sysclk;
-	u16 hs_left_step;
-	u16 hs_right_step;
-	u16 hf_left_step;
-	u16 hf_right_step;
 	struct twl6040_jack_data hs_jack;
 	struct snd_soc_codec *codec;
 	struct mutex mutex;
@@ -1127,7 +1123,6 @@ static int twl6040_resume(struct snd_soc_codec *codec)
 static int twl6040_probe(struct snd_soc_codec *codec)
 {
 	struct twl6040_data *priv;
-	struct twl6040_codec_data *pdata = dev_get_platdata(codec->dev);
 	struct platform_device *pdev = container_of(codec->dev,
 						   struct platform_device, dev);
 	int ret = 0;
@@ -1141,22 +1136,6 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	priv->codec = codec;
 	codec->control_data = dev_get_drvdata(codec->dev->parent);
 
-	if (pdata && pdata->hs_left_step && pdata->hs_right_step) {
-		priv->hs_left_step = pdata->hs_left_step;
-		priv->hs_right_step = pdata->hs_right_step;
-	} else {
-		priv->hs_left_step = 1;
-		priv->hs_right_step = 1;
-	}
-
-	if (pdata && pdata->hf_left_step && pdata->hf_right_step) {
-		priv->hf_left_step = pdata->hf_left_step;
-		priv->hf_right_step = pdata->hf_right_step;
-	} else {
-		priv->hf_left_step = 1;
-		priv->hf_right_step = 1;
-	}
-
 	priv->plug_irq = platform_get_irq(pdev, 0);
 	if (priv->plug_irq < 0) {
 		dev_err(codec->dev, "invalid irq\n");
-- 
1.8.1
