From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Add a fix voltage regulator for
	DA7219 and ADAU7002" to the asoc tree
Date: Thu, 26 Jul 2018 14:10:56 +0100 (BST)
Message-ID: <20180726131056.B4661440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 960ED26776E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 15:11:00 +0200 (CEST)
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
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002

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

>From c183fec10ae6b3d1dfb77471d4158e576f6b43ae Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Wed, 25 Jul 2018 17:00:59 +0800
Subject: [PATCH] ASoC: AMD: Add a fix voltage regulator for DA7219 and
 ADAU7002

DA7219 for our platform need to be configured for 1.8V.
Hence, we add a volatge regulator with supplies
of 1.8V in the machine driver.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig                |  1 +
 sound/soc/amd/acp-da7219-max98357a.c | 43 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf4d1a4..58c1dcb4d255 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -8,6 +8,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_ADAU7002
+	select REGULATOR
 	depends on SND_SOC_AMD_ACP && I2C
 	help
 	 This option enables machine driver for DA7219 and MAX9835.
diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index f42606e5879e..cd3cf6e691a9 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -32,6 +32,8 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/driver.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/acpi.h>
@@ -320,11 +322,52 @@ static struct snd_soc_card cz_card = {
 	.num_controls = ARRAY_SIZE(cz_mc_controls),
 };
 
+static struct regulator_consumer_supply acp_da7219_supplies[] = {
+	REGULATOR_SUPPLY("VDD", "i2c-DLGS7219:00"),
+	REGULATOR_SUPPLY("VDDMIC", "i2c-DLGS7219:00"),
+	REGULATOR_SUPPLY("VDDIO", "i2c-DLGS7219:00"),
+	REGULATOR_SUPPLY("IOVDD", "ADAU7002:00"),
+};
+
+static struct regulator_init_data acp_da7219_data = {
+	.constraints = {
+		.always_on = 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(acp_da7219_supplies),
+	.consumer_supplies = acp_da7219_supplies,
+};
+
+static struct regulator_config acp_da7219_cfg = {
+	.init_data = &acp_da7219_data,
+};
+
+static struct regulator_ops acp_da7219_ops = {
+};
+
+static struct regulator_desc acp_da7219_desc = {
+	.name = "reg-fixed-1.8V",
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &acp_da7219_ops,
+	.fixed_uV = 1800000, /* 1.8V */
+	.n_voltages = 1,
+};
+
 static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
 	struct acp_platform_info *machine;
+	struct regulator_dev *rdev;
+
+	acp_da7219_cfg.dev = &pdev->dev;
+	rdev = devm_regulator_register(&pdev->dev, &acp_da7219_desc,
+				       &acp_da7219_cfg);
+	if (IS_ERR(rdev)) {
+		dev_err(&pdev->dev, "Failed to register regulator: %d\n",
+			ret);
+		return -EINVAL;
+	}
 
 	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info),
 			       GFP_KERNEL);
-- 
2.18.0
