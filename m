From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: add ACPI and OF support" to the
	asoc tree
Date: Wed, 23 Dec 2015 12:21:27 +0000
Message-ID: <E1aBiQ3-0006Ri-Kz@debutante>
References: <1450866249-15462-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4F6C265882
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 13:21:35 +0100 (CET)
In-Reply-To: <1450866249-15462-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: add ACPI and OF support

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3ae08dc0fc805bc15c5629f9794599c1171dc571 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 23 Dec 2015 18:24:09 +0800
Subject: [PATCH] ASoC: rt5651: add ACPI and OF support

Add required tables and the binding document for ACPI and OF matching.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5651.txt | 41 ++++++++++++++++++++++
 sound/soc/codecs/rt5651.c                          | 31 ++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5651.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5651.txt b/Documentation/devicetree/bindings/sound/rt5651.txt
new file mode 100644
index 000000000000..3875233095f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5651.txt
@@ -0,0 +1,41 @@
+RT5651 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5651".
+
+- reg : The I2C address of the device.
+
+Optional properties:
+
+- realtek,in2-differential
+  Boolean. Indicate MIC2 input are differential, rather than single-ended.
+
+- realtek,dmic-en
+  Boolean. true if dmic is used.
+
+Pins on the device (for linking into audio routes) for RT5651:
+
+  * DMIC L1
+  * DMIC R1
+  * IN1P
+  * IN2P
+  * IN2N
+  * IN3P
+  * HPOL
+  * HPOR
+  * LOUTL
+  * LOUTR
+  * PDML
+  * PDMR
+
+Example:
+
+codec: rt5651@1a {
+	compatible = "realtek,rt5651";
+	reg = <0x1a>;
+	realtek,dmic-en = "true";
+	realtek,in2-diff = "false";
+};
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 1d4031818966..7a6197042423 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -1735,12 +1736,38 @@ static const struct regmap_config rt5651_regmap = {
 	.num_ranges = ARRAY_SIZE(rt5651_ranges),
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id rt5651_of_match[] = {
+	{ .compatible = "realtek,rt5651", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5651_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt5651_acpi_match[] = {
+	{ "10EC5651", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, rt5651_acpi_match);
+#endif
+
 static const struct i2c_device_id rt5651_i2c_id[] = {
 	{ "rt5651", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
 
+static int rt5651_parse_dt(struct rt5651_priv *rt5651, struct device_node *np)
+{
+	rt5651->pdata.in2_diff = of_property_read_bool(np,
+		"realtek,in2-differential");
+	rt5651->pdata.dmic_en = of_property_read_bool(np,
+		"realtek,dmic-en");
+
+	return 0;
+}
+
 static int rt5651_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -1757,6 +1784,8 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5651->pdata = *pdata;
+	else if (i2c->dev.of_node)
+		rt5651_parse_dt(rt5651, i2c->dev.of_node);
 
 	rt5651->regmap = devm_regmap_init_i2c(i2c, &rt5651_regmap);
 	if (IS_ERR(rt5651->regmap)) {
@@ -1806,6 +1835,8 @@ static int rt5651_i2c_remove(struct i2c_client *i2c)
 static struct i2c_driver rt5651_i2c_driver = {
 	.driver = {
 		.name = "rt5651",
+		.acpi_match_table = ACPI_PTR(rt5651_acpi_match),
+		.of_match_table = of_match_ptr(rt5651_of_match),
 	},
 	.probe = rt5651_i2c_probe,
 	.remove   = rt5651_i2c_remove,
-- 
2.6.2
