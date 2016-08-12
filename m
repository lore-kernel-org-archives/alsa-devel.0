From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/17] ASoC: Intel: bytcr_rt5640: default
	routing and quirks on Baytrail-CR
Date: Fri, 12 Aug 2016 16:27:53 -0500
Message-ID: <1471037280-17433-11-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 94E2C266916
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:48 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Auto routing based on Baytrail/Baytrail-CR detection

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 42c7bd2..c4a3c57 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -24,6 +24,8 @@
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <asm/cpu_device_id.h>
+#include <asm/platform_sst_audio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -31,6 +33,7 @@
 #include "../../codecs/rt5640.h"
 #include "../atom/sst-atom-controls.h"
 #include "../common/sst-acpi.h"
+#include "../common/sst-dsp.h"
 
 enum {
 	BYT_RT5640_DMIC1_MAP,
@@ -189,7 +192,8 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		},
 		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
 						 BYT_RT5640_MONO_SPEAKER |
-						 BYT_RT5640_DIFF_MIC
+						 BYT_RT5640_DIFF_MIC |
+						 BYT_RT5640_SSP0_AIF2
 						 ),
 	},
 	{
@@ -464,6 +468,18 @@ static char byt_rt5640_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
 static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
 static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 
+static bool is_valleyview(void)
+{
+	static const struct x86_cpu_id cpu_ids[] __initconst = {
+		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
+		{}
+	};
+
+	if (!x86_match_cpu(cpu_ids))
+		return false;
+	return true;
+}
+
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
@@ -494,6 +510,20 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		byt_rt5640_dais[dai_index].codec_name = byt_rt5640_codec_name;
 	}
 
+	/*
+	 * swap SSP0 if bytcr is detected
+	 * (will be overridden if DMI quirk is detected)
+	 */
+	if (is_valleyview()) {
+		struct sst_platform_info *p_info = mach->pdata;
+		const struct sst_res_info *res_info = p_info->res_info;
+
+		/* TODO: use CHAN package info from BIOS to detect AIF1/AIF2 */
+		if (res_info->acpi_ipc_irq_index == 0) {
+			byt_rt5640_quirk |= BYT_RT5640_SSP0_AIF2;
+		}
+	}
+
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
 
-- 
2.5.0
