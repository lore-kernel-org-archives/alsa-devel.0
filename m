From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Clean up indentation for Haswell
	machine driver/Kconfig
Date: Thu,  6 Mar 2014 14:56:06 +0000
Message-ID: <1394117766-7242-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1394117766-7242-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AADF265442
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 15:56:44 +0100 (CET)
In-Reply-To: <1394117766-7242-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clean up some indentation.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/Kconfig           | 10 +++++-----
 sound/soc/intel/sst-haswell-dsp.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 274af16..4577b69 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -31,15 +31,15 @@ config SND_SOC_INTEL_BAYTRAIL
 	tristate
 
 config SND_SOC_INTEL_HASWELL_MACH
-        tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
-        depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
+	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
-          This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
+	  This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
 	  Ultrabook platforms.
-          Say Y if you have such a device
-          If unsure select "N".
+	  Say Y if you have such a device
+	  If unsure select "N".
 
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 12f7317..f5ebf36 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -503,7 +503,7 @@ static void hsw_free(struct sst_dsp *sst)
 
 struct sst_ops haswell_ops = {
 	.reset = hsw_reset,
-        .boot = hsw_boot,
+	.boot = hsw_boot,
 	.write = sst_shim32_write,
 	.read = sst_shim32_read,
 	.write64 = sst_shim32_write64,
-- 
1.8.3.2
