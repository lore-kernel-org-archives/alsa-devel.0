From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 2/2] ASoC: AMD: Add an always on fixed 1.8V regulator for da7219 VDDIO
Date: Tue, 17 Jul 2018 18:49:09 -0600
Message-ID: <20180718004909.213735-3-djkurtz@chromium.org>
References: <20180718004909.213735-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718004909.213735-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dylan Reid <dgreid@chromium.org>, Jimmy Cheng-Yi Chiang <cychiang@google.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wei Yongjun <weiyongjun1@huawei.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

DA7219's VDDIO for our platform need to be configured for 1.8V.
Hence we register a fixed 1.8V voltage regulator in the machine driver.

Change-Id: I65fd93e1dd37c3e0d38265b4b1492ea53b93afd4
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/Kconfig                |  1 +
 sound/soc/amd/acp-da7219-max98357a.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf4d1a4c2..58c1dcb4d2550f 100644
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
index ccddc6650b9c79..6ea0f42f5b7692 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -32,6 +32,8 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/acpi.h>
@@ -278,11 +280,23 @@ static struct snd_soc_card cz_card = {
 	.num_controls = ARRAY_SIZE(cz_mc_controls),
 };
 
+static struct regulator_consumer_supply acp_da7219_supplies[] = {
+	REGULATOR_SUPPLY("VDDIO", "i2c-DLGS7219:00")
+};
+
 static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
 	struct acp_platform_info *machine;
+	struct platform_device *reg;
+
+	reg = regulator_register_always_on(0, "fixed-1.8V",
+					   acp_da7219_supplies,
+					   ARRAY_SIZE(acp_da7219_supplies),
+					   1800000);
+	if (!reg)
+		return -ENOMEM;
 
 	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info),
 			       GFP_KERNEL);
-- 
2.18.0.203.gfac676dfb9-goog
