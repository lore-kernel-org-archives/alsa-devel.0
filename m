From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/15] ASoC: Intel: broadwell: platform name
	fixup support
Date: Fri, 25 Jan 2019 14:34:57 -0600
Message-ID: <20190125203509.22994-4-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 63FB526680F
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
 sound/soc/intel/boards/broadwell.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 99f2a0156ae8..b86c746d9b7a 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -21,6 +21,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
+#include <sound/soc-acpi.h>
 
 #include "../common/sst-dsp.h"
 #include "../haswell/sst-haswell-ipc.h"
@@ -267,7 +268,22 @@ static struct snd_soc_card broadwell_rt286 = {
 
 static int broadwell_audio_probe(struct platform_device *pdev)
 {
+	struct snd_soc_acpi_mach *mach;
+	const char *platform_name = NULL;
+	int ret;
+
 	broadwell_rt286.dev = &pdev->dev;
+
+	/* override plaform name, if required */
+	mach = (&pdev->dev)->platform_data;
+	if (mach) /* extra check since legacy does not pass parameters */
+		platform_name = mach->mach_params.platform;
+
+	ret = snd_soc_fixup_dai_links_platform_name(&broadwell_rt286,
+						    platform_name);
+	if (ret)
+		return ret;
+
 	return devm_snd_soc_register_card(&pdev->dev, &broadwell_rt286);
 }
 
-- 
2.17.1
