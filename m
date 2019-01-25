From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/15] ASoC: Intel: cht_bsw_nau8824: platform
	name fixup support
Date: Fri, 25 Jan 2019 14:35:04 -0600
Message-ID: <20190125203509.22994-11-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D554126680F
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:35:22 +0100 (CET)
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
 sound/soc/intel/boards/cht_bsw_nau8824.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 30c46977d53c..02c2fa239331 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -25,6 +25,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include <sound/jack.h>
 #include <linux/input.h>
 #include "../atom/sst-atom-controls.h"
@@ -246,6 +247,8 @@ static struct snd_soc_card snd_soc_card_cht = {
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	struct cht_mc_private *drv;
+	struct snd_soc_acpi_mach *mach;
+	const char *platform_name;
 	int ret_val;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
@@ -253,6 +256,15 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
+	/* override plaform name, if required */
+	mach = (&pdev->dev)->platform_data;
+	platform_name = mach->mach_params.platform;
+
+	ret_val = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cht,
+							platform_name);
+	if (ret_val)
+		return ret_val;
+
 	/* register the soc card */
 	snd_soc_card_cht.dev = &pdev->dev;
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
-- 
2.17.1
