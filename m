From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v7 3/4] ASoC: Intel - add makefile support for
	SKL driver
Date: Mon,  6 Jul 2015 08:54:25 +0530
Message-ID: <1436153066-23962-4-git-send-email-vinod.koul@intel.com>
References: <1436153066-23962-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 714912604ED
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 05:22:49 +0200 (CEST)
In-Reply-To: <1436153066-23962-1-git-send-email-vinod.koul@intel.com>
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
 sound/soc/intel/Kconfig          | 7 +++++++
 sound/soc/intel/Makefile         | 1 +
 sound/soc/intel/skylake/Makefile | 3 +++
 3 files changed, 11 insertions(+)
 create mode 100644 sound/soc/intel/skylake/Makefile

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index f3060a4ca040..9fa24c7003e5 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -132,3 +132,10 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
       This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
       platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
       If unsure select "N".
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
