From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 09/14] ASoC: Intel: bytcr_rt5651: filter codec
	name
Date: Tue, 22 Aug 2017 15:32:34 -0500
Message-ID: <20170822203239.19891-10-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FFBA267041
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:15 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Use same fix as other codecs to work around BIOS/ACPI issues

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index b813c4c..17d3e144 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -33,6 +33,7 @@
 #include <sound/jack.h>
 #include "../../codecs/rt5651.h"
 #include "../atom/sst-atom-controls.h"
+#include "../common/sst-acpi.h"
 
 enum {
 	BYT_RT5651_DMIC_MAP,
@@ -443,9 +444,15 @@ static struct snd_soc_card byt_rt5651_card = {
 	.fully_routed = true,
 };
 
+static char byt_rt5651_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
+	struct sst_acpi_mach *mach;
+	const char *i2c_name = NULL;
+	int i;
+	int dai_index;
 	struct byt_rt5651_private *priv;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
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
+	if (i2c_name != NULL) {
+		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
+			"%s%s", "i2c-", i2c_name);
+
+		byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
+	}
 
 	mach = byt_rt5651_card.dev->platform_data;
 	snd_soc_card_set_drvdata(&byt_rt5651_card, priv);
-- 
2.9.3
