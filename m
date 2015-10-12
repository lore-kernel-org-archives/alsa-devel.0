From: Pavel Machek <pavel@ucw.cz>
Subject: multi-codec support for arizona-ldo1 was Re: System with multiple
 arizona (wm5102) codecs
Date: Mon, 12 Oct 2015 11:00:45 +0200
Message-ID: <20151012090045.GA7448@amd>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150914115255.GE11200@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

> I guess you would need to be careful with the machine driver as
> well, you will need to use a snd_soc_codec_conf structure for at
> least one (although I would do both) of the CODECs to give  a
> prefix for all the widget/control names, otherwise those will
> clash and everything will probably behave very strangely. See
> sound/soc/samsung/bells.c for an example doing this for wm9081.

wm9081 is indeed useful example.

Does this look like a step in right direction?

Thanks,
							Pavel

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 81d8681..2be9513 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -27,13 +27,17 @@
 #include <linux/mfd/arizona/registers.h>
 
 struct arizona_ldo1 {
+	char name[99];
 	struct regulator_dev *regulator;
 	struct arizona *arizona;
+	struct regulator_desc desc;
 
 	struct regulator_consumer_supply supply;
 	struct regulator_init_data init_data;
 };
 
+
+
 static int arizona_ldo1_hc_list_voltage(struct regulator_dev *rdev,
 					unsigned int selector)
 {
@@ -121,7 +125,6 @@ static struct regulator_ops arizona_ldo1_hc_ops = {
 };
 
 static const struct regulator_desc arizona_ldo1_hc = {
-	.name = "LDO1",
 	.supply_name = "LDOVDD",
 	.type = REGULATOR_VOLTAGE,
 	.ops = &arizona_ldo1_hc_ops,
@@ -146,7 +149,6 @@ static struct regulator_ops arizona_ldo1_ops = {
 };
 
 static const struct regulator_desc arizona_ldo1 = {
-	.name = "LDO1",
 	.supply_name = "LDOVDD",
 	.type = REGULATOR_VOLTAGE,
 	.ops = &arizona_ldo1_ops,
@@ -183,8 +185,8 @@ static const struct regulator_init_data arizona_ldo1_default = {
 static int arizona_ldo1_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
-	const struct regulator_desc *desc;
 	struct regulator_config config = { };
+	int id = 0;
 	struct arizona_ldo1 *ldo1;
 	int ret;
 
@@ -194,8 +196,10 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+
+
+	printk("Initializing arizona-ldo1 for codec %d\n", id);
 	ldo1->arizona = arizona;
-
 	/*
 	 * Since the chip usually supplies itself we provide some
 	 * default init_data for it.  This will be overridden with
@@ -203,15 +207,18 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	 */
 	switch (arizona->type) {
 	case WM5102:
-		desc = &arizona_ldo1_hc;
 		ldo1->init_data = arizona_ldo1_dvfs;
+		ldo1->desc = arizona_ldo1_hc;
 		break;
 	default:
-		desc = &arizona_ldo1;
 		ldo1->init_data = arizona_ldo1_default;
+		ldo1->desc = arizona_ldo1;
 		break;
 	}
 
+	ldo1->desc.name = ldo1->name;
+	sprintf(ldo1->name, "LDO1_%d", id);
+	
 	ldo1->init_data.consumer_supplies = &ldo1->supply;
 	ldo1->supply.supply = "DCVDD";
 	ldo1->supply.dev_name = dev_name(arizona->dev);
@@ -226,7 +233,7 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	else
 		config.init_data = &ldo1->init_data;
 
-	ldo1->regulator = regulator_register(desc, &config);
+	ldo1->regulator = regulator_register(&ldo1->desc, &config);
 	if (IS_ERR(ldo1->regulator)) {
 		ret = PTR_ERR(ldo1->regulator);
 		dev_err(arizona->dev, "Failed to register LDO1 supply: %d\n",

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
