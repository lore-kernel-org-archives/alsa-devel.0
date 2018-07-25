From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH v2] ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002
Date: Wed, 25 Jul 2018 17:00:59 +0800
Message-ID: <1532509274-8280-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wei Yongjun <weiyongjun1@huawei.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

DA7219 for our platform need to be configured for 1.8V.
Hence, we add a volatge regulator with supplies
of 1.8V in the machine driver.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/Kconfig                |  1 +
 sound/soc/amd/acp-da7219-max98357a.c | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf..58c1dcb 100644
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
index f42606e..cd3cf6e 100644
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
@@ -320,11 +322,52 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
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
1.9.1
