From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Implement basic WM8993 interrupt
	support
Date: Tue, 17 Jan 2012 16:47:50 +0000
Message-ID: <1326818870-10206-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1326818870-10206-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 403F7103A33
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 17:47:52 +0100 (CET)
In-Reply-To: <1326818870-10206-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

If an interrupt is supplied then use it for thermal warning and FLL lock
notifications. When using the interrupt raise the timeout for the FLL lock
substantially to reduce the chances of spurious warnings.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c |   94 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 69f5491..dd687c3 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -204,9 +204,11 @@ static struct {
 
 struct wm8993_priv {
 	struct wm_hubs_data hubs_data;
+	struct device *dev;
 	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8993_NUM_SUPPLIES];
 	struct wm8993_platform_data pdata;
+	struct completion fll_lock;
 	int master;
 	int sysclk_source;
 	int tdm_slots;
@@ -225,6 +227,7 @@ static bool wm8993_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM8993_SOFTWARE_RESET:
+	case WM8993_GPIO_CTRL_1:
 	case WM8993_DC_SERVO_0:
 	case WM8993_DC_SERVO_READBACK_0:
 	case WM8993_DC_SERVO_READBACK_1:
@@ -467,8 +470,10 @@ static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 			  unsigned int Fref, unsigned int Fout)
 {
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	struct i2c_client *i2c = to_i2c_client(codec->dev);
 	u16 reg1, reg4, reg5;
 	struct _fll_div fll_div;
+	unsigned int timeout;
 	int ret;
 
 	/* Any change? */
@@ -539,14 +544,22 @@ static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	reg5 |= fll_div.fll_clk_ref_div << WM8993_FLL_CLK_REF_DIV_SHIFT;
 	snd_soc_write(codec, WM8993_FLL_CONTROL_5, reg5);
 
+	/* If we've got an interrupt wired up make sure we get it */
+	if (i2c->irq)
+		timeout = msecs_to_jiffies(20);
+	else if (Fref < 1000000)
+		timeout = msecs_to_jiffies(3);
+	else
+		timeout = msecs_to_jiffies(1);
+
+	try_wait_for_completion(&wm8993->fll_lock);
+
 	/* Enable the FLL */
 	snd_soc_write(codec, WM8993_FLL_CONTROL_1, reg1 | WM8993_FLL_ENA);
 
-	/* Both overestimates */
-	if (Fref < 1000000)
-		msleep(3);
-	else
-		msleep(1);
+	timeout = wait_for_completion_timeout(&wm8993->fll_lock, timeout);
+	if (i2c->irq && !timeout)
+		dev_warn(codec->dev, "Timed out waiting for FLL\n");
 
 	dev_dbg(codec->dev, "FLL enabled at %dHz->%dHz\n", Fref, Fout);
 
@@ -1471,6 +1484,45 @@ out:
 	return 0;
 }
 
+static irqreturn_t wm8993_irq(int irq, void *data)
+{
+	struct wm8993_priv *wm8993 = data;
+	int mask, val, ret;
+
+	ret = regmap_read(wm8993->regmap, WM8993_GPIO_CTRL_1, &val);
+	if (ret != 0) {
+		dev_err(wm8993->dev, "Failed to read interrupt status: %d\n",
+			ret);
+		return IRQ_NONE;
+	}
+
+	ret = regmap_read(wm8993->regmap, WM8993_GPIOCTRL_2, &mask);
+	if (ret != 0) {
+		dev_err(wm8993->dev, "Failed to read interrupt mask: %d\n",
+			ret);
+		return IRQ_NONE;
+	}
+
+	/* The IRQ pin status is visible in the register too */
+	val &= ~(mask | WM8993_IRQ);
+	if (!val)
+		return IRQ_NONE;
+
+	if (val & WM8993_TEMPOK_EINT)
+		dev_crit(wm8993->dev, "Thermal warning\n");
+
+	if (val & WM8993_FLL_LOCK_EINT) {
+		dev_dbg(wm8993->dev, "FLL locked\n");
+		complete(&wm8993->fll_lock);
+	}
+
+	ret = regmap_write(wm8993->regmap, WM8993_GPIO_CTRL_1, val);
+	if (ret != 0)
+		dev_err(wm8993->dev, "Failed to ack interrupt: %d\n", ret);
+
+	return IRQ_HANDLED;
+}
+
 static const struct snd_soc_dai_ops wm8993_ops = {
 	.set_sysclk = wm8993_set_sysclk,
 	.set_fmt = wm8993_set_dai_fmt,
@@ -1672,6 +1724,9 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 	if (wm8993 == NULL)
 		return -ENOMEM;
 
+	wm8993->dev = &i2c->dev;
+	init_completion(&wm8993->fll_lock);
+
 	wm8993->regmap = regmap_init_i2c(i2c, &wm8993_regmap);
 	if (IS_ERR(wm8993->regmap)) {
 		ret = PTR_ERR(wm8993->regmap);
@@ -1714,6 +1769,22 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		goto err_enable;
 
+	if (i2c->irq) {
+		/* Put GPIO1 into interrupt mode (only GPIO1 can output IRQ) */
+		ret = regmap_update_bits(wm8993->regmap, WM8993_GPIO1,
+					 WM8993_GPIO1_PD |
+					 WM8993_GPIO1_SEL_MASK, 7);
+		if (ret != 0)
+			goto err_enable;
+
+		ret = request_threaded_irq(i2c->irq, NULL, wm8993_irq,
+					   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					   "wm8993", wm8993);
+		if (ret != 0)
+			goto err_enable;
+
+	}
+
 	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 
 	regcache_cache_only(wm8993->regmap, true);
@@ -1722,11 +1793,14 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 			&soc_codec_dev_wm8993, &wm8993_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		goto err_enable;
+		goto err_irq;
 	}
 
 	return 0;
 
+err_irq:
+	if (i2c->irq)
+		free_irq(i2c->irq, wm8993);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 err_get:
@@ -1736,11 +1810,13 @@ err:
 	return ret;
 }
 
-static __devexit int wm8993_i2c_remove(struct i2c_client *client)
+static __devexit int wm8993_i2c_remove(struct i2c_client *i2c)
 {
-	struct wm8993_priv *wm8993 = i2c_get_clientdata(client);
+	struct wm8993_priv *wm8993 = i2c_get_clientdata(i2c);
 
-	snd_soc_unregister_codec(&client->dev);
+	snd_soc_unregister_codec(&i2c->dev);
+	if (i2c->irq)
+		free_irq(i2c->irq, wm8993);
 	regmap_exit(wm8993->regmap);
 	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
-- 
1.7.7.3
