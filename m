From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: arizona-ldo1: Avoid potential memory leak reading init_data" to the regulator tree
Date: Thu, 30 Mar 2017 22:23:17 +0100
Message-ID: <E1cthXJ-0008Fy-NA@debutante>
References: <1490710484-25277-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490710484-25277-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.comlinux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   regulator: arizona-ldo1: Avoid potential memory leak reading init_data

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From 0feb837a42c95fee901e03f76a1266db85ceb6ec Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 28 Mar 2017 15:14:38 +0100
Subject: [PATCH] regulator: arizona-ldo1: Avoid potential memory leak reading
 init_data

The device argument passed to of_get_regulator_init_data is used to
do some devres memory allocation. Currently the driver passes the MFD
device pointer to this function, this could result in the init_data
allocation being leaked if the regulator is unbound but the MFD isn't.

Correct this issue by correctly passing the local platform device.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 302b57cb89c6..cf558168664d 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -186,7 +186,8 @@ static const struct regulator_init_data arizona_ldo1_wm5110 = {
 	.num_consumer_supplies = 1,
 };
 
-static int arizona_ldo1_of_get_pdata(struct arizona *arizona,
+static int arizona_ldo1_of_get_pdata(struct device *dev,
+				     struct arizona *arizona,
 				     struct regulator_config *config,
 				     const struct regulator_desc *desc)
 {
@@ -212,8 +213,7 @@ static int arizona_ldo1_of_get_pdata(struct arizona *arizona,
 	if (init_node) {
 		config->of_node = init_node;
 
-		init_data = of_get_regulator_init_data(arizona->dev, init_node,
-						       desc);
+		init_data = of_get_regulator_init_data(dev, init_node, desc);
 
 		if (init_data) {
 			init_data->consumer_supplies = &ldo1->supply;
@@ -283,7 +283,8 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_OF)) {
 		if (!dev_get_platdata(arizona->dev)) {
-			ret = arizona_ldo1_of_get_pdata(arizona, &config, desc);
+			ret = arizona_ldo1_of_get_pdata(&pdev->dev, arizona,
+							&config, desc);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.11.0
