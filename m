From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v5 3/4] ASoC: Intel - add makefile support for
	SKL driver
Date: Thu, 11 Jun 2015 22:03:57 +0530
Message-ID: <1434040438-14535-4-git-send-email-vinod.koul@intel.com>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B9356266585
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 18:32:53 +0200 (CEST)
In-Reply-To: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This adds makefile and Kconfig to enable Skylake HD audio PCM driver

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig          | 17 +++++++++++++++++
 sound/soc/intel/Makefile         |  1 +
 sound/soc/intel/skylake/Makefile |  3 +++
 3 files changed, 21 insertions(+)
 create mode 100644 sound/soc/intel/skylake/Makefile

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 791953ffbc41..c426d64723b1 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -132,3 +132,20 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
       This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
       platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
       If unsure select "N".
+
+config SND_SKL_PREALLOC_SIZE
+	int "Pre-allocated buffer size for skylake HD-audio driver"
+	range 0 32768
+	default 64
+	help
+	  Specifies the default pre-allocated buffer-size in kB for the
+	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
+	  for systems using PulseAudio.  The default 64 is chosen just
+	  for compatibility reasons.
+
+config SND_SOC_INTEL_SKYLAKE
+	tristate
+	select SND_HDA_EXT_CORE
+	help
+	  Say Y here to include support for ASoC Intel "High Definition
+	  Audio" (Skylake) and its compatible devices.
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 3853ec2ddbc7..2972699e1435 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
+obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += skylake/
 
 # Machine support
 obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
new file mode 100644
index 000000000000..734d17cafde7
--- /dev/null
+++ b/sound/soc/intel/skylake/Makefile
@@ -0,0 +1,3 @@
+snd-soc-skl-objs := skl.o skl-pcm.o
+
+obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
-- 
1.9.1
