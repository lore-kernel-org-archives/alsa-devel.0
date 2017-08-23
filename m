From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: rt5645: add quirks for Asus
	T100HA" to the asoc tree
Date: Wed, 23 Aug 2017 12:24:29 +0100
Message-ID: <E1dkTlt-00076Z-Tn@debutante>
References: <20170822203239.19891-11-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 13FCF2664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:24:32 +0200 (CEST)
In-Reply-To: <20170822203239.19891-11-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: rt5645: add quirks for Asus T100HA

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

>From cb0236eca79c8ceb5cdb8d2a15ce272e754d2921 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 22 Aug 2017 15:32:35 -0500
Subject: [PATCH] ASoC: codecs: rt5645: add quirks for Asus T100HA

Fix jack detection and dmic setup

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ec58166f7c4..500bb42d0804 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3637,6 +3637,24 @@ static const struct dmi_system_id dmi_platform_gpd_win[] = {
 	{}
 };
 
+static struct rt5645_platform_data general_platform_data2 = {
+	.dmic1_data_pin = RT5645_DMIC_DATA_IN2N,
+	.dmic2_data_pin = RT5645_DMIC2_DISABLE,
+	.jd_mode = 3,
+	.inv_jd1_1 = true,
+};
+
+static struct dmi_system_id dmi_platform_asus_t100ha[] = {
+	{
+		.ident = "ASUS T100HAN",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T100HAN"),
+		},
+	},
+	{ }
+};
+
 static bool rt5645_check_dp(struct device *dev)
 {
 	if (device_property_present(dev, "realtek,in2-differential") ||
@@ -3689,6 +3707,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		rt5645->pdata = general_platform_data;
 	else if (dmi_check_system(dmi_platform_gpd_win))
 		rt5645->pdata = gpd_win_platform_data;
+	else if (dmi_check_system(dmi_platform_asus_t100ha))
+		rt5645->pdata = general_platform_data2;
 
 	if (quirk != -1) {
 		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
-- 
2.14.1
