From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 6/7] ASoC: intel - add makefile support for
	SKL driver
Date: Wed, 29 Apr 2015 01:24:29 +0530
Message-ID: <1430250870-3169-7-git-send-email-vinod.koul@intel.com>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 88FBD2654B2
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 21:57:42 +0200 (CEST)
In-Reply-To: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
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

Add makefile and Kconfig to enable Skylake HD audio driver

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig          |   20 ++++++++++++++++++++
 sound/soc/intel/Makefile         |    1 +
 sound/soc/intel/skylake/Makefile |    3 +++
 3 files changed, 24 insertions(+)
 create mode 100644 sound/soc/intel/skylake/Makefile

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ee03dbdda235..4ceca88de356 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -121,3 +121,23 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with RT5645 audio codec.
 	  If unsure select "N".
+
+config SND_SOC_HDA_PREALLOC_SIZE
+	int "Pre-allocated buffer size for skylake HD-audio driver"
+	range 0 32768
+	default 64
+	help
+	  Specifies the default pre-allocated buffer-size in kB for the
+	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
+	  for systems using PulseAudio.  The default 64 is chosen just
+	  for compatibility reasons.
+
+config SND_SOC_INTEL_HDA_SKYLAKE
+	tristate "ASoC Intel HD Audio"
+	select SND_SOC_HDA_CORE
+	help
+	Say Y here to include support for ASoC Intel "High Definition
+	Audio" (Skylake) and its compatible devices.
+
+	To compile this driver as a module, choose M here: the module
+	will be called snd-soc-hda-skl.
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index cd9aee9871a3..564a8d6e2195 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += atom/
+obj-$(CONFIG_SND_SOC_INTEL_HDA_SKYLAKE) += skylake/
 
 # Machine support
 obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
new file mode 100644
index 000000000000..1848ac809519
--- /dev/null
+++ b/sound/soc/intel/skylake/Makefile
@@ -0,0 +1,3 @@
+snd-soc-hda-skl-objs := hda-skl.o hda-skl-pcm.o
+
+obj-$(CONFIG_SND_SOC_INTEL_HDA_SKYLAKE) += snd-soc-hda-skl.o
-- 
1.7.9.5
