From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 14/15] ASoC: Intel: bxt_rt298: platform name
	fixup support
Date: Fri, 25 Jan 2019 14:35:08 -0600
Message-ID: <20190125203509.22994-15-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A19CD2679A5
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:35:25 +0100 (CET)
In-Reply-To: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add helper to override dailink platform name, if passed as parameter

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 27308337ab12..e91057f83d20 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -21,6 +21,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
 #include "../../codecs/hdac_hdmi.h"
@@ -576,6 +577,9 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	struct bxt_rt286_private *ctx;
 	struct snd_soc_card *card =
 			(struct snd_soc_card *)pdev->id_entry->driver_data;
+	struct snd_soc_acpi_mach *mach;
+	const char *platform_name;
+	int ret;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(broxton_rt298_dais); i++) {
@@ -602,6 +606,15 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(card, ctx);
 
+	/* override plaform name, if required */
+	mach = (&pdev->dev)->platform_data;
+	platform_name = mach->mach_params.platform;
+
+	ret = snd_soc_fixup_dai_links_platform_name(card,
+						    platform_name);
+	if (ret)
+		return ret;
+
 	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
-- 
2.17.1
