From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/15] ASoC: Intel: bxt_da7219_max98357a:
	platform name fixup support
Date: Fri, 25 Jan 2019 14:35:07 -0600
Message-ID: <20190125203509.22994-14-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 878512679A1
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
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 6f052fc8d1e2..c00925f9da73 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -23,6 +23,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include "../../codecs/hdac_hdmi.h"
 #include "../../codecs/da7219.h"
 #include "../../codecs/da7219-aad.h"
@@ -584,6 +585,9 @@ static struct snd_soc_card broxton_audio_card = {
 static int broxton_audio_probe(struct platform_device *pdev)
 {
 	struct bxt_card_private *ctx;
+	struct snd_soc_acpi_mach *mach;
+	const char *platform_name;
+	int ret;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -594,6 +598,15 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	broxton_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&broxton_audio_card, ctx);
 
+	/* override plaform name, if required */
+	mach = (&pdev->dev)->platform_data;
+	platform_name = mach->mach_params.platform;
+
+	ret = snd_soc_fixup_dai_links_platform_name(&broxton_audio_card,
+						    platform_name);
+	if (ret)
+		return ret;
+
 	return devm_snd_soc_register_card(&pdev->dev, &broxton_audio_card);
 }
 
-- 
2.17.1
