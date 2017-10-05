From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/6] ASoC: Intel: bytcr_rt5651: filter codec
	name and fix variable declarations
Date: Thu,  5 Oct 2017 13:52:39 -0500
Message-ID: <20171005185243.4174-3-pierre-louis.bossart@linux.intel.com>
References: <20171005185243.4174-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C70652675B1
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 20:52:53 +0200 (CEST)
In-Reply-To: <20171005185243.4174-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Use same fix as other codecs to work around BIOS/ACPI issues

Also reorder variables in reverse x-mas tree as suggested by Andy

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e41c7ea91bd9..1b97aa735747 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -32,6 +32,7 @@
 #include <sound/jack.h>
 #include "../../codecs/rt5651.h"
 #include "../atom/sst-atom-controls.h"
+#include "../common/sst-acpi.h"
 
 enum {
 	BYT_RT5651_DMIC_MAP,
@@ -244,11 +245,11 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 
 static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 {
-	int ret;
 	struct snd_soc_card *card = runtime->card;
-	const struct snd_soc_dapm_route *custom_map;
 	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
+	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
+	int ret;
 
 	card->dapm.idle_bias_off = true;
 
@@ -443,10 +444,16 @@ static struct snd_soc_card byt_rt5651_card = {
 	.fully_routed = true,
 };
 
+static char byt_rt5651_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
-	int ret_val = 0;
 	struct byt_rt5651_private *priv;
+	struct sst_acpi_mach *mach;
+	const char *i2c_name = NULL;
+	int ret_val = 0;
+	int dai_index;
+	int i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
 	if (!priv)
@@ -454,6 +461,25 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* register the soc card */
 	byt_rt5651_card.dev = &pdev->dev;
+	mach = byt_rt5651_card.dev->platform_data;
+
+	/* fix index of codec dai */
+	dai_index = MERR_DPCM_COMPR + 1;
+	for (i = 0; i < ARRAY_SIZE(byt_rt5651_dais); i++) {
+		if (!strcmp(byt_rt5651_dais[i].codec_name, "i2c-10EC5651:00")) {
+			dai_index = i;
+			break;
+		}
+	}
+
+	/* fixup codec name based on HID */
+	i2c_name = sst_acpi_find_name_from_hid(mach->id);
+	if (i2c_name) {
+		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
+			"%s%s", "i2c-", i2c_name);
+
+		byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
+	}
 
 	mach = byt_rt5651_card.dev->platform_data;
 	snd_soc_card_set_drvdata(&byt_rt5651_card, priv);
@@ -469,7 +495,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	i2c_name = sst_acpi_find_name_from_hid(mach->id);
-	if (i2c_name != NULL) {
+	if (i2c_name) {
 		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
 			"%s%s", "i2c-", i2c_name);
 
-- 
2.11.0
