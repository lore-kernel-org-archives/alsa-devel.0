From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm2000: Remove wm2000_read helper
	function" to the asoc tree
Date: Sun, 21 Oct 2018 13:06:10 +0200 (CEST)
Message-ID: <20181021110610.A7921440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 292172677D1
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2018 13:06:12 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Tanure <tanureal@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm2000: Remove wm2000_read helper function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c5d09485def41cab9e75ba23abbf87080183183c Mon Sep 17 00:00:00 2001
From: Lucas Tanure <tanureal@opensource.cirrus.com>
Date: Fri, 19 Oct 2018 17:44:22 +0100
Subject: [PATCH] ASoC: wm2000: Remove wm2000_read helper function

The return type "unsigned int" was used by the wm2000_read()
function despite of the aspect that it will eventually return
a negative error code.
The resulting function doesn't add much to the code, so replace
wm2000_read with regmap_read.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2000.c | 54 ++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index c5ae07234a00..bba330e30162 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -88,19 +88,6 @@ static int wm2000_write(struct i2c_client *i2c, unsigned int reg,
 	return regmap_write(wm2000->regmap, reg, value);
 }
 
-static unsigned int wm2000_read(struct i2c_client *i2c, unsigned int r)
-{
-	struct wm2000_priv *wm2000 = i2c_get_clientdata(i2c);
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(wm2000->regmap, r, &val);
-	if (ret < 0)
-		return -1;
-
-	return val;
-}
-
 static void wm2000_reset(struct wm2000_priv *wm2000)
 {
 	struct i2c_client *i2c = wm2000->i2c;
@@ -115,14 +102,15 @@ static void wm2000_reset(struct wm2000_priv *wm2000)
 static int wm2000_poll_bit(struct i2c_client *i2c,
 			   unsigned int reg, u8 mask)
 {
+	struct wm2000_priv *wm2000 = i2c_get_clientdata(i2c);
 	int timeout = 4000;
-	int val;
+	unsigned int val;
 
-	val = wm2000_read(i2c, reg);
+	regmap_read(wm2000->regmap, reg, &val);
 
 	while (!(val & mask) && --timeout) {
 		msleep(1);
-		val = wm2000_read(i2c, reg);
+		regmap_read(wm2000->regmap, reg, &val);
 	}
 
 	if (timeout == 0)
@@ -135,6 +123,7 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
 	unsigned long rate;
+	unsigned int val;
 	int ret;
 
 	if (WARN_ON(wm2000->anc_mode != ANC_OFF))
@@ -213,12 +202,17 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 			     WM2000_MODE_THERMAL_ENABLE);
 	}
 
-	ret = wm2000_read(i2c, WM2000_REG_SPEECH_CLARITY);
+	ret = regmap_read(wm2000->regmap, WM2000_REG_SPEECH_CLARITY, &val);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Unable to read Speech Clarity: %d\n", ret);
+		regulator_bulk_disable(WM2000_NUM_SUPPLIES, wm2000->supplies);
+		return ret;
+	}
 	if (wm2000->speech_clarity)
-		ret |= WM2000_SPEECH_CLARITY;
+		val |= WM2000_SPEECH_CLARITY;
 	else
-		ret &= ~WM2000_SPEECH_CLARITY;
-	wm2000_write(i2c, WM2000_REG_SPEECH_CLARITY, ret);
+		val &= ~WM2000_SPEECH_CLARITY;
+	wm2000_write(i2c, WM2000_REG_SPEECH_CLARITY, val);
 
 	wm2000_write(i2c, WM2000_REG_SYS_START0, 0x33);
 	wm2000_write(i2c, WM2000_REG_SYS_START1, 0x02);
@@ -824,7 +818,7 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 	const char *filename;
 	const struct firmware *fw = NULL;
 	int ret, i;
-	int reg;
+	unsigned int reg;
 	u16 id;
 
 	wm2000 = devm_kzalloc(&i2c->dev, sizeof(*wm2000), GFP_KERNEL);
@@ -860,9 +854,17 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 	}
 
 	/* Verify that this is a WM2000 */
-	reg = wm2000_read(i2c, WM2000_REG_ID1);
+	ret = regmap_read(wm2000->regmap, WM2000_REG_ID1, &reg);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Unable to read ID1: %d\n", ret);
+		return ret;
+	}
 	id = reg << 8;
-	reg = wm2000_read(i2c, WM2000_REG_ID2);
+	ret = regmap_read(wm2000->regmap, WM2000_REG_ID2, &reg);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Unable to read ID2: %d\n", ret);
+		return ret;
+	}
 	id |= reg & 0xff;
 
 	if (id != 0x2000) {
@@ -871,7 +873,11 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 		goto err_supplies;
 	}
 
-	reg = wm2000_read(i2c, WM2000_REG_REVISON);
+	ret = regmap_read(wm2000->regmap, WM2000_REG_REVISON, &reg);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Unable to read Revision: %d\n", ret);
+		return ret;
+	}
 	dev_info(&i2c->dev, "revision %c\n", reg + 'A');
 
 	wm2000->mclk = devm_clk_get(&i2c->dev, "MCLK");
-- 
2.19.0
