From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Minor code modification" to the
	asoc tree
Date: Tue, 18 Sep 2018 18:44:52 +0100 (BST)
Message-ID: <20180918174452.614B7440078@finisterre.ee.mobilebroadband>
References: <1537271513-5737-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 94B6C26788C
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 19:44:56 +0200 (CEST)
In-Reply-To: <1537271513-5737-1-git-send-email-shumingf@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: Minor code modification

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

>From 37efe23dcca3c59cee662f1c28835020bef31cc0 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 18 Sep 2018 19:51:53 +0800
Subject: [PATCH] ASoC: rt5682: Minor code modification

Minor code changes are:
 - improve the readability in patch list
 - add i2c remove function
 - regmap_register_patch changes to regmap_multi_reg_write

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 18099668e960..340f90497d07 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -67,7 +67,7 @@ struct rt5682_priv {
 };
 
 static const struct reg_sequence patch_list[] = {
-	{0x01c1, 0x1000},
+	{RT5682_HP_IMP_SENS_CTRL_19, 0x1000},
 	{RT5682_DAC_ADC_DIG_VOL1, 0xa020},
 };
 
@@ -2584,7 +2584,7 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 	rt5682_calibrate(rt5682);
 
-	ret = regmap_register_patch(rt5682->regmap, patch_list,
+	ret = regmap_multi_reg_write(rt5682->regmap, patch_list,
 				    ARRAY_SIZE(patch_list));
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
@@ -2659,11 +2659,17 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 	}
 
-	return devm_snd_soc_register_component(&i2c->dev,
-			&soc_component_dev_rt5682,
+	return snd_soc_register_component(&i2c->dev, &soc_component_dev_rt5682,
 			rt5682_dai, ARRAY_SIZE(rt5682_dai));
 }
 
+static int rt5682_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_component(&i2c->dev);
+
+	return 0;
+}
+
 static void rt5682_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
@@ -2694,6 +2700,7 @@ static struct i2c_driver rt5682_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5682_acpi_match),
 	},
 	.probe = rt5682_i2c_probe,
+	.remove = rt5682_i2c_remove,
 	.shutdown = rt5682_i2c_shutdown,
 	.id_table = rt5682_i2c_id,
 };
-- 
2.19.0
