From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: rt5670: add jack detection
	quirk for Dell Venue 5585" to the asoc tree
Date: Wed, 23 Aug 2017 12:24:26 +0100
Message-ID: <E1dkTlq-00075k-Qq@debutante>
References: <20170822203239.19891-13-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 02E3C2664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:24:30 +0200 (CEST)
In-Reply-To: <20170822203239.19891-13-pierre-louis.bossart@linux.intel.com>
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

   ASoC: codecs: rt5670: add jack detection quirk for Dell Venue 5585

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

>From c26d8389be4dab2bb5a8ac16211a9966bf67091a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 22 Aug 2017 15:32:37 -0500
Subject: [PATCH] ASoC: codecs: rt5670: add jack detection quirk for Dell Venue
 5585

Jack is not detected by default, using jdmode=3 works fine

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0f4e5bc4476f..4ea51b487b8c 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2851,6 +2851,17 @@ static const struct dmi_system_id dmi_platform_intel_bytcht_jdmode2[] = {
 	{}
 };
 
+static const struct dmi_system_id dmi_platform_intel_bytcht_jdmode3[] = {
+	{
+		.ident = "Dell Venue 8 Pro 5855",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5855"),
+		},
+	},
+	{}
+};
+
 static int rt5670_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -2880,6 +2891,11 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 		rt5670->pdata.dmic1_data_pin = RT5670_DMIC_DATA_IN2P;
 		rt5670->pdata.dev_gpio = true;
 		rt5670->pdata.jd_mode = 2;
+	} else if (dmi_check_system(dmi_platform_intel_bytcht_jdmode3)) {
+		rt5670->pdata.dmic_en = true;
+		rt5670->pdata.dmic1_data_pin = RT5670_DMIC_DATA_IN2P;
+		rt5670->pdata.dev_gpio = true;
+		rt5670->pdata.jd_mode = 3;
 	}
 
 	rt5670->regmap = devm_regmap_init_i2c(i2c, &rt5670_regmap);
-- 
2.14.1
