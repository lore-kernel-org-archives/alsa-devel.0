From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Separate regmap for rt5645 and
	rt5650" to the asoc tree
Date: Mon, 16 Nov 2015 17:51:51 +0000
Message-ID: <E1ZyNwV-0006pY-GC@debutante>
References: <1447145694-3508-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADDCC2604FA
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:51:56 +0100 (CET)
In-Reply-To: <1447145694-3508-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Separate regmap for rt5645 and rt5650

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

>From 49abc6cd58734803fb1428c3dfbb68fbc6ddb68c Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 10 Nov 2015 16:54:54 +0800
Subject: [PATCH] ASoC: rt5645: Separate regmap for rt5645 and rt5650

rt5645.c support both rt5645 and rt5650 codec. And the default
value of registers are not identical. So we use different regmap
for the two codecs.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 209 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 200 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4e81181c00c4..11cabf8e7551 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -226,6 +226,163 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0xff, 0x6308 },
 };
 
+static const struct reg_default rt5650_reg[] = {
+	{ 0x00, 0x0000 },
+	{ 0x01, 0xc8c8 },
+	{ 0x02, 0xc8c8 },
+	{ 0x03, 0xc8c8 },
+	{ 0x0a, 0x0002 },
+	{ 0x0b, 0x2827 },
+	{ 0x0c, 0xe000 },
+	{ 0x0d, 0x0000 },
+	{ 0x0e, 0x0000 },
+	{ 0x0f, 0x0808 },
+	{ 0x14, 0x3333 },
+	{ 0x16, 0x4b00 },
+	{ 0x18, 0x018b },
+	{ 0x19, 0xafaf },
+	{ 0x1a, 0xafaf },
+	{ 0x1b, 0x0001 },
+	{ 0x1c, 0x2f2f },
+	{ 0x1d, 0x2f2f },
+	{ 0x1e, 0x0000 },
+	{ 0x20, 0x0000 },
+	{ 0x27, 0x7060 },
+	{ 0x28, 0x7070 },
+	{ 0x29, 0x8080 },
+	{ 0x2a, 0x5656 },
+	{ 0x2b, 0x5454 },
+	{ 0x2c, 0xaaa0 },
+	{ 0x2d, 0x0000 },
+	{ 0x2f, 0x1002 },
+	{ 0x31, 0x5000 },
+	{ 0x32, 0x0000 },
+	{ 0x33, 0x0000 },
+	{ 0x34, 0x0000 },
+	{ 0x35, 0x0000 },
+	{ 0x3b, 0x0000 },
+	{ 0x3c, 0x007f },
+	{ 0x3d, 0x0000 },
+	{ 0x3e, 0x007f },
+	{ 0x3f, 0x0000 },
+	{ 0x40, 0x001f },
+	{ 0x41, 0x0000 },
+	{ 0x42, 0x001f },
+	{ 0x45, 0x6000 },
+	{ 0x46, 0x003e },
+	{ 0x47, 0x003e },
+	{ 0x48, 0xf807 },
+	{ 0x4a, 0x0004 },
+	{ 0x4d, 0x0000 },
+	{ 0x4e, 0x0000 },
+	{ 0x4f, 0x01ff },
+	{ 0x50, 0x0000 },
+	{ 0x51, 0x0000 },
+	{ 0x52, 0x01ff },
+	{ 0x53, 0xf000 },
+	{ 0x56, 0x0111 },
+	{ 0x57, 0x0064 },
+	{ 0x58, 0xef0e },
+	{ 0x59, 0xf0f0 },
+	{ 0x5a, 0xef0e },
+	{ 0x5b, 0xf0f0 },
+	{ 0x5c, 0xef0e },
+	{ 0x5d, 0xf0f0 },
+	{ 0x5e, 0xf000 },
+	{ 0x5f, 0x0000 },
+	{ 0x61, 0x0300 },
+	{ 0x62, 0x0000 },
+	{ 0x63, 0x00c2 },
+	{ 0x64, 0x0000 },
+	{ 0x65, 0x0000 },
+	{ 0x66, 0x0000 },
+	{ 0x6a, 0x0000 },
+	{ 0x6c, 0x0aaa },
+	{ 0x70, 0x8000 },
+	{ 0x71, 0x8000 },
+	{ 0x72, 0x8000 },
+	{ 0x73, 0x7770 },
+	{ 0x74, 0x3e00 },
+	{ 0x75, 0x2409 },
+	{ 0x76, 0x000a },
+	{ 0x77, 0x0c00 },
+	{ 0x78, 0x0000 },
+	{ 0x79, 0x0123 },
+	{ 0x7a, 0x0123 },
+	{ 0x80, 0x0000 },
+	{ 0x81, 0x0000 },
+	{ 0x82, 0x0000 },
+	{ 0x83, 0x0000 },
+	{ 0x84, 0x0000 },
+	{ 0x85, 0x0000 },
+	{ 0x8a, 0x0000 },
+	{ 0x8e, 0x0004 },
+	{ 0x8f, 0x1100 },
+	{ 0x90, 0x0646 },
+	{ 0x91, 0x0c06 },
+	{ 0x93, 0x0000 },
+	{ 0x94, 0x0200 },
+	{ 0x95, 0x0000 },
+	{ 0x9a, 0x2184 },
+	{ 0x9b, 0x010a },
+	{ 0x9c, 0x0aea },
+	{ 0x9d, 0x000c },
+	{ 0x9e, 0x0400 },
+	{ 0xa0, 0xa0a8 },
+	{ 0xa1, 0x0059 },
+	{ 0xa2, 0x0001 },
+	{ 0xae, 0x6000 },
+	{ 0xaf, 0x0000 },
+	{ 0xb0, 0x6000 },
+	{ 0xb1, 0x0000 },
+	{ 0xb2, 0x0000 },
+	{ 0xb3, 0x001f },
+	{ 0xb4, 0x020c },
+	{ 0xb5, 0x1f00 },
+	{ 0xb6, 0x0000 },
+	{ 0xbb, 0x0000 },
+	{ 0xbc, 0x0000 },
+	{ 0xbd, 0x0000 },
+	{ 0xbe, 0x0000 },
+	{ 0xbf, 0x3100 },
+	{ 0xc0, 0x0000 },
+	{ 0xc1, 0x0000 },
+	{ 0xc2, 0x0000 },
+	{ 0xc3, 0x2000 },
+	{ 0xcd, 0x0000 },
+	{ 0xce, 0x0000 },
+	{ 0xcf, 0x1813 },
+	{ 0xd0, 0x0690 },
+	{ 0xd1, 0x1c17 },
+	{ 0xd3, 0xb320 },
+	{ 0xd4, 0x0000 },
+	{ 0xd6, 0x0400 },
+	{ 0xd9, 0x0809 },
+	{ 0xda, 0x0000 },
+	{ 0xdb, 0x0003 },
+	{ 0xdc, 0x0049 },
+	{ 0xdd, 0x001b },
+	{ 0xdf, 0x0008 },
+	{ 0xe0, 0x4000 },
+	{ 0xe6, 0x8000 },
+	{ 0xe7, 0x0200 },
+	{ 0xec, 0xb300 },
+	{ 0xed, 0x0000 },
+	{ 0xf0, 0x001f },
+	{ 0xf1, 0x020c },
+	{ 0xf2, 0x1f00 },
+	{ 0xf3, 0x0000 },
+	{ 0xf4, 0x4000 },
+	{ 0xf8, 0x0000 },
+	{ 0xf9, 0x0000 },
+	{ 0xfa, 0x2060 },
+	{ 0xfb, 0x4040 },
+	{ 0xfc, 0x0000 },
+	{ 0xfd, 0x0002 },
+	{ 0xfe, 0x10ec },
+	{ 0xff, 0x6308 },
+};
+
 struct rt5645_eq_param_s {
 	unsigned short reg;
 	unsigned short val;
@@ -3316,6 +3473,31 @@ static const struct regmap_config rt5645_regmap = {
 	.num_ranges = ARRAY_SIZE(rt5645_ranges),
 };
 
+static const struct regmap_config rt5650_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.use_single_rw = true,
+	.max_register = RT5645_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5645_ranges) *
+					       RT5645_PR_SPACING),
+	.volatile_reg = rt5645_volatile_register,
+	.readable_reg = rt5645_readable_register,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = rt5650_reg,
+	.num_reg_defaults = ARRAY_SIZE(rt5650_reg),
+	.ranges = rt5645_ranges,
+	.num_ranges = ARRAY_SIZE(rt5645_ranges),
+};
+
+static const struct regmap_config temp_regmap = {
+	.name="nocache",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.use_single_rw = true,
+	.max_register = RT5645_VENDOR_ID2 + 1,
+	.cache_type = REGCACHE_NONE,
+};
+
 static const struct i2c_device_id rt5645_i2c_id[] = {
 	{ "rt5645", 0 },
 	{ "rt5650", 0 },
@@ -3426,6 +3608,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	struct rt5645_priv *rt5645;
 	int ret, i;
 	unsigned int val;
+	struct regmap *regmap;
 
 	rt5645 = devm_kzalloc(&i2c->dev, sizeof(struct rt5645_priv),
 				GFP_KERNEL);
@@ -3451,14 +3634,6 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		return PTR_ERR(rt5645->gpiod_hp_det);
 	}
 
-	rt5645->regmap = devm_regmap_init_i2c(i2c, &rt5645_regmap);
-	if (IS_ERR(rt5645->regmap)) {
-		ret = PTR_ERR(rt5645->regmap);
-		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
-			ret);
-		return ret;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
 		rt5645->supplies[i].supply = rt5645_supply_names[i];
 
@@ -3477,13 +3652,22 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt5645->regmap, RT5645_VENDOR_ID2, &val);
+	regmap = devm_regmap_init_i2c(i2c, &temp_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c->dev, "Failed to allocate temp register map: %d\n",
+			ret);
+		return ret;
+	}
+	regmap_read(regmap, RT5645_VENDOR_ID2, &val);
 
 	switch (val) {
 	case RT5645_DEVICE_ID:
+		rt5645->regmap = devm_regmap_init_i2c(i2c, &rt5645_regmap);
 		rt5645->codec_type = CODEC_TYPE_RT5645;
 		break;
 	case RT5650_DEVICE_ID:
+		rt5645->regmap = devm_regmap_init_i2c(i2c, &rt5650_regmap);
 		rt5645->codec_type = CODEC_TYPE_RT5650;
 		break;
 	default:
@@ -3494,6 +3678,13 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		goto err_enable;
 	}
 
+	if (IS_ERR(rt5645->regmap)) {
+		ret = PTR_ERR(rt5645->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
 	regmap_write(rt5645->regmap, RT5645_RESET, 0);
 
 	ret = regmap_register_patch(rt5645->regmap, init_list,
-- 
2.6.2
