From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sta32x: Add support for XTI clock" to
	the asoc tree
Date: Fri, 19 Oct 2018 13:34:49 +0100 (BST)
Message-ID: <20181019123449.600A91122548@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 069EA267A90
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:34:49 +0200 (CEST)
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
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sta32x: Add support for XTI clock

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

>From fce9ec954a8af7e04cbf5b9daa8bec9c1df5cfe6 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 17 Oct 2018 13:37:03 +0200
Subject: [PATCH] ASoC: sta32x: Add support for XTI clock

The STA32x chips feature an XTI clock input that needs to be stable before
the reset signal is released. Therefore, the chip driver needs to get a
handle to the clock. Instead of relying on other parts of the system to
enable the clock, let the codec driver grab a handle itself.

In order to keep existing boards working, clock support is made optional.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/st,sta32x.txt   |  6 ++++
 sound/soc/codecs/sta32x.c                     | 28 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,sta32x.txt b/Documentation/devicetree/bindings/sound/st,sta32x.txt
index ff4a685a4303..52265fb757c5 100644
--- a/Documentation/devicetree/bindings/sound/st,sta32x.txt
+++ b/Documentation/devicetree/bindings/sound/st,sta32x.txt
@@ -19,6 +19,10 @@ Required properties:
 
 Optional properties:
 
+  - clocks, clock-names: Clock specifier for XTI input clock.
+	If specified, the clock will be enabled when the codec is probed,
+	and disabled when it is removed. The 'clock-names' must be set to 'xti'.
+
   -  st,output-conf: number, Selects the output configuration:
 	0: 2-channel (full-bridge) power, 2-channel data-out
 	1: 2 (half-bridge). 1 (full-bridge) on-board power
@@ -79,6 +83,8 @@ Example:
 codec: sta32x@38 {
 	compatible = "st,sta32x";
 	reg = <0x1c>;
+	clocks = <&clock>;
+	clock-names = "xti";
 	reset-gpios = <&gpio1 19 0>;
 	power-down-gpios = <&gpio1 16 0>;
 	st,output-conf = /bits/ 8  <0x3>;	// set output to 2-channel
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 22de1593443c..f753d2db0a5a 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
@@ -142,6 +143,7 @@ static const char *sta32x_supply_names[] = {
 /* codec private data */
 struct sta32x_priv {
 	struct regmap *regmap;
+	struct clk *xti_clk;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(sta32x_supply_names)];
 	struct snd_soc_component *component;
 	struct sta32x_platform_data *pdata;
@@ -879,6 +881,18 @@ static int sta32x_probe(struct snd_soc_component *component)
 	struct sta32x_priv *sta32x = snd_soc_component_get_drvdata(component);
 	struct sta32x_platform_data *pdata = sta32x->pdata;
 	int i, ret = 0, thermal = 0;
+
+	sta32x->component = component;
+
+	if (sta32x->xti_clk) {
+		ret = clk_prepare_enable(sta32x->xti_clk);
+		if (ret != 0) {
+			dev_err(component->dev,
+				"Failed to enable clock: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(sta32x->supplies),
 				    sta32x->supplies);
 	if (ret != 0) {
@@ -981,6 +995,9 @@ static void sta32x_remove(struct snd_soc_component *component)
 
 	sta32x_watchdog_stop(sta32x);
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
+
+	if (sta32x->xti_clk)
+		clk_disable_unprepare(sta32x->xti_clk);
 }
 
 static const struct snd_soc_component_driver sta32x_component = {
@@ -1097,6 +1114,17 @@ static int sta32x_i2c_probe(struct i2c_client *i2c,
 	}
 #endif
 
+	/* Clock */
+	sta32x->xti_clk = devm_clk_get(dev, "xti");
+	if (IS_ERR(sta32x->xti_clk)) {
+		ret = PTR_ERR(sta32x->xti_clk);
+
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		sta32x->xti_clk = NULL;
+	}
+
 	/* GPIOs */
 	sta32x->gpiod_nreset = devm_gpiod_get_optional(dev, "reset",
 						       GPIOD_OUT_LOW);
-- 
2.19.0.rc2
