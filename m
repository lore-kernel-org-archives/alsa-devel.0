From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm9081: Move WM9081 IRQ platform
	data handling into I2C probe
Date: Sun, 12 Feb 2012 18:37:42 +0000
Message-ID: <1329071863-19064-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19F662415A
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 17:07:07 +0100 (CET)
Received: from finisterre.wolfsonmicro.main (unknown [108.60.121.130])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 7FD8C110565
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 16:07:06 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Better style and better supports idle_bias_off which we're going to
implement.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 7b09b1f..5f464ab 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1258,7 +1258,6 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 {
 	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
 	int ret;
-	u16 reg;
 
 	codec->control_data = wm9081->regmap;
 
@@ -1268,16 +1267,6 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	reg = 0;
-	if (wm9081->pdata.irq_high)
-		reg |= WM9081_IRQ_POL;
-	if (!wm9081->pdata.irq_cmos)
-		reg |= WM9081_IRQ_OP_CTRL;
-	snd_soc_update_bits(codec, WM9081_INTERRUPT_CONTROL,
-			    WM9081_IRQ_POL | WM9081_IRQ_OP_CTRL, reg);
-
-	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	/* Enable zero cross by default */
 	snd_soc_update_bits(codec, WM9081_ANALOGUE_LINEOUT,
 			    WM9081_LINEOUTZC, WM9081_LINEOUTZC);
@@ -1395,6 +1384,15 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 		memcpy(&wm9081->pdata, dev_get_platdata(&i2c->dev),
 		       sizeof(wm9081->pdata));
 
+	reg = 0;
+	if (wm9081->pdata.irq_high)
+		reg |= WM9081_IRQ_POL;
+	if (!wm9081->pdata.irq_cmos)
+		reg |= WM9081_IRQ_OP_CTRL;
+	regmap_update_bits(wm9081->regmap, WM9081_INTERRUPT_CONTROL,
+			   WM9081_IRQ_POL | WM9081_IRQ_OP_CTRL, reg);
+
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm9081, &wm9081_dai, 1);
 	if (ret < 0)
-- 
1.7.9.rc1
