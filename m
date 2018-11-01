From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 3/7] ASoC: Intel: use standard interface for
	Atom machine drivers
Date: Thu,  1 Nov 2018 16:34:50 -0500
Message-ID: <20181101213454.18894-4-pierre-louis.bossart@linux.intel.com>
References: <20181101213454.18894-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 076022678EC
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 22:35:14 +0100 (CET)
In-Reply-To: <20181101213454.18894-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Don't rely on internal Atom/SST-specific data structures, use
generic interface to let other drivers use the same machine drivers
as is, e.g. SOF to support BYT-CR devices

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c     | 4 ++++
 sound/soc/intel/boards/bytcr_rt5640.c   | 6 +-----
 sound/soc/intel/boards/bytcr_rt5651.c   | 6 +-----
 sound/soc/intel/boards/cht_bsw_rt5645.c | 6 +-----
 4 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index c90b04cc071d..ac542535b9d5 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -341,6 +341,10 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		byt_rvp_platform_data.res_info = &bytcr_res_info;
 	}
 
+	/* update machine parameters */
+	mach->mach_params.acpi_ipc_irq_index =
+		pdata->res_info->acpi_ipc_irq_index;
+
 	plat_dev = platform_device_register_data(dev, pdata->platform, -1,
 						NULL, 0);
 	if (IS_ERR(plat_dev)) {
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 8587bd3d1cc1..09591144ea7d 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -29,7 +29,6 @@
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
-#include <asm/platform_sst_audio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -1152,10 +1151,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	 * (will be overridden if DMI quirk is detected)
 	 */
 	if (is_valleyview()) {
-		struct sst_platform_info *p_info = mach->pdata;
-		const struct sst_res_info *res_info = p_info->res_info;
-
-		if (res_info->acpi_ipc_irq_index == 0)
+		if (mach->mach_params.acpi_ipc_irq_index == 0)
 			is_bytcr = true;
 	}
 
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 8dffeecda55b..4c9508da8602 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include <asm/platform_sst_audio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -920,10 +919,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	 * (will be overridden if DMI quirk is detected)
 	 */
 	if (x86_match_cpu(baytrail_cpu_ids)) {
-		struct sst_platform_info *p_info = mach->pdata;
-		const struct sst_res_info *res_info = p_info->res_info;
-
-		if (res_info->acpi_ipc_irq_index == 0)
+		if (mach->mach_params.acpi_ipc_irq_index == 0)
 			is_bytcr = true;
 	}
 
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index f5a5ea6a093c..250a356a0cbf 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -27,7 +27,6 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
-#include <asm/platform_sst_audio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -585,10 +584,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	 * (will be overridden if DMI quirk is detected)
 	 */
 	if (is_valleyview()) {
-		struct sst_platform_info *p_info = mach->pdata;
-		const struct sst_res_info *res_info = p_info->res_info;
-
-		if (res_info->acpi_ipc_irq_index == 0)
+		if (mach->mach_params.acpi_ipc_irq_index == 0)
 			is_bytcr = true;
 	}
 
-- 
2.17.1
