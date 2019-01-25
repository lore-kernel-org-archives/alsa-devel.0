From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 04/15] ASoC: Intel: bdw-rt5677: platform name
	fixup support
Date: Fri, 25 Jan 2019 14:34:58 -0600
Message-ID: <20190125203509.22994-5-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DFCF6267350
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:35:17 +0100 (CET)
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
 sound/soc/intel/boards/bdw-rt5677.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index efcfd906c856..1844c88ea4e2 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -26,6 +26,7 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 #include <sound/jack.h>
+#include <sound/soc-acpi.h>
 
 #include "../common/sst-dsp.h"
 #include "../haswell/sst-haswell-ipc.h"
@@ -339,6 +340,9 @@ static struct snd_soc_card bdw_rt5677_card = {
 static int bdw_rt5677_probe(struct platform_device *pdev)
 {
 	struct bdw_rt5677_priv *bdw_rt5677;
+	struct snd_soc_acpi_mach *mach;
+	const char *platform_name = NULL;
+	int ret;
 
 	bdw_rt5677_card.dev = &pdev->dev;
 
@@ -350,6 +354,16 @@ static int bdw_rt5677_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	/* override plaform name, if required */
+	mach = (&pdev->dev)->platform_data;
+	if (mach) /* extra check since legacy does not pass parameters */
+		platform_name = mach->mach_params.platform;
+
+	ret = snd_soc_fixup_dai_links_platform_name(&bdw_rt5677_card,
+						    platform_name);
+	if (ret)
+		return ret;
+
 	snd_soc_card_set_drvdata(&bdw_rt5677_card, bdw_rt5677);
 
 	return devm_snd_soc_register_card(&pdev->dev, &bdw_rt5677_card);
-- 
2.17.1
