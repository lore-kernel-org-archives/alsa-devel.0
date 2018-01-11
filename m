From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 1/2] ASoC: Intel: bytcht_es8316: fix HID
	handling
Date: Thu, 11 Jan 2018 13:52:08 -0600
Message-ID: <20180111195209.5809-2-pierre-louis.bossart@linux.intel.com>
References: <20180111195209.5809-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A512D266EEC
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 20:52:38 +0100 (CET)
In-Reply-To: <20180111195209.5809-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jeremy@jcline.org, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Same problem as with previous machine drivers, the codec dai
uses a hard-coded name of "i2c-ESSX8316:00" but ACPI provides
"i2c-ESSX8316:01" in some systems.

Fix by overriding the hard-coded value with the codec name derived
from the HID information

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=189261
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig         |  1 +
 sound/soc/intel/boards/bytcht_es8316.c | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index de598dcbef30..d4e103615f51 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -139,6 +139,7 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	tristate "Baytrail & Cherrytrail with ES8316 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_ACPI
 	select SND_SOC_ES8316
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail &
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 8088396717e3..ae24f6205f05 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -232,15 +232,39 @@ static struct snd_soc_card byt_cht_es8316_card = {
 	.fully_routed = true,
 };
 
+static char codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
-	int ret = 0;
 	struct byt_cht_es8316_private *priv;
+	struct snd_soc_acpi_mach *mach;
+	const char *i2c_name = NULL;
+	int dai_index = 0;
+	int i;
+	int ret = 0;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
 	if (!priv)
 		return -ENOMEM;
 
+	mach = (&pdev->dev)->platform_data;
+	/* fix index of codec dai */
+	for (i = 0; i < ARRAY_SIZE(byt_cht_es8316_dais); i++) {
+		if (!strcmp(byt_cht_es8316_dais[i].codec_name,
+			    "i2c-ESSX8316:00")) {
+			dai_index = i;
+			break;
+		}
+	}
+
+	/* fixup codec name based on HID */
+	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
+	if (i2c_name) {
+		snprintf(codec_name, sizeof(codec_name),
+			"%s%s", "i2c-", i2c_name);
+		byt_cht_es8316_dais[dai_index].codec_name = codec_name;
+	}
+
 	/* register the soc card */
 	byt_cht_es8316_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&byt_cht_es8316_card, priv);
-- 
2.14.1
