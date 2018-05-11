From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: Use
	device-property for differential mics" to the asoc tree
Date: Fri, 11 May 2018 03:48:35 +0100 (BST)
Message-ID: <20180511024835.2619244007C@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 76699267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 04:48:46 +0200 (CEST)
In-Reply-To: <20180508153604.23711-10-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: Use device-property for differential mics

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

>From 6a7c05e55c0a3d6d4f092d734cd8fee798cf044b Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 8 May 2018 17:35:54 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Use device-property for
 differential mics

Set the "realtek,in1-differential" or "realtek,in3-differential"
device-property when the BYT_RT5640_DIFF_MIC quirk is set instead of
directly poking the codec registers.

This also fixes the BYT_RT5640_DIFF_MIC quirk not working when
combined with BYT_RT5640_IN3_MAP.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 48 ++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index c540dfdf045d..404aa7355912 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -17,6 +17,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -54,6 +55,9 @@ enum {
 #define BYT_RT5640_MCLK_EN	BIT(22)
 #define BYT_RT5640_MCLK_25MHZ	BIT(23)
 
+/* in-diff + terminating empty entry */
+#define MAX_NO_PROPS 2
+
 struct byt_rt5640_private {
 	struct clk *mclk;
 };
@@ -438,6 +442,39 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{}
 };
 
+/*
+ * Note this MUST be called before snd_soc_register_card(), so that the props
+ * are in place before the codec component driver's probe function parses them.
+ */
+static int byt_rt5640_add_codec_device_props(const char *i2c_dev_name)
+{
+	struct property_entry props[MAX_NO_PROPS] = {};
+	struct device *i2c_dev;
+	int ret, cnt = 0;
+
+	i2c_dev = bus_find_device_by_name(&i2c_bus_type, NULL, i2c_dev_name);
+	if (!i2c_dev)
+		return -EPROBE_DEFER;
+
+	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
+	case BYT_RT5640_IN1_MAP:
+		if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
+			props[cnt++] =
+				PROPERTY_ENTRY_BOOL("realtek,in1-differential");
+		break;
+	case BYT_RT5640_IN3_MAP:
+		if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
+			props[cnt++] =
+				PROPERTY_ENTRY_BOOL("realtek,in3-differential");
+		break;
+	}
+
+	ret = device_add_properties(i2c_dev, props);
+	put_device(i2c_dev);
+
+	return ret;
+}
+
 static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
@@ -519,11 +556,6 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
-	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC) {
-		snd_soc_component_update_bits(component,  RT5640_IN1_IN2, RT5640_IN_DF1,
-				    RT5640_IN_DF1);
-	}
-
 	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
 		ret = rt5640_dmic_enable(component, 0, 0);
 		if (ret)
@@ -841,6 +873,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			 (unsigned int)byt_rt5640_quirk, quirk_override);
 		byt_rt5640_quirk = quirk_override;
 	}
+
+	/* Must be called before register_card, also see declaration comment. */
+	ret_val = byt_rt5640_add_codec_device_props(byt_rt5640_codec_name);
+	if (ret_val)
+		return ret_val;
+
 	log_quirks(&pdev->dev);
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
-- 
2.17.0
