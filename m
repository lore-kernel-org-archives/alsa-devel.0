From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 6/7] ASoC: hda - enable ASoC Skylake HD
	audio driver
Date: Fri, 17 Apr 2015 14:43:19 +0530
Message-ID: <1429262000-21517-7-git-send-email-vinod.koul@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A568260581
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 11:18:52 +0200 (CEST)
In-Reply-To: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Add makefile and Kconfig to enable Skylake
HD audio driver

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/Kconfig      |    1 +
 sound/soc/Makefile     |    1 +
 sound/soc/hda/Kconfig  |   29 +++++++++++++++++++++++++++++
 sound/soc/hda/Makefile |    3 +++
 4 files changed, 34 insertions(+)
 create mode 100644 sound/soc/hda/Kconfig
 create mode 100644 sound/soc/hda/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 3ba52da18bc6..d3903580cb10 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -40,6 +40,7 @@ source "sound/soc/cirrus/Kconfig"
 source "sound/soc/davinci/Kconfig"
 source "sound/soc/dwc/Kconfig"
 source "sound/soc/fsl/Kconfig"
+source "sound/soc/hda/Kconfig"
 source "sound/soc/jz4740/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 974ba708b482..8741d6a38bf6 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_SND_SOC)	+= cirrus/
 obj-$(CONFIG_SND_SOC)	+= davinci/
 obj-$(CONFIG_SND_SOC)	+= dwc/
 obj-$(CONFIG_SND_SOC)	+= fsl/
+obj-$(CONFIG_SND_SOC)	+= hda/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
 obj-$(CONFIG_SND_SOC)	+= intel/
 obj-$(CONFIG_SND_SOC)	+= mxs/
diff --git a/sound/soc/hda/Kconfig b/sound/soc/hda/Kconfig
new file mode 100644
index 000000000000..f4a7cfa24eb7
--- /dev/null
+++ b/sound/soc/hda/Kconfig
@@ -0,0 +1,29 @@
+menu "SKL-HD-Audio"
+
+config SND_SOC_HDA
+        tristate
+        select SND_HDA_CORE
+
+if SND_SOC_HDA
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
+endif
+
+config SND_SOC_HDA_SKL
+	tristate "ASoC Intel HD Audio"
+	select SND_SOC_HDA
+	help
+	Say Y here to include support for ASoC Intel "High Definition
+	Audio" (Azalia) and its compatible devices.
+
+	To compile this driver as a module, choose M here: the module
+	will be called snd-soc-hda-skl.
+endmenu
diff --git a/sound/soc/hda/Makefile b/sound/soc/hda/Makefile
new file mode 100644
index 000000000000..99aee14b85ed
--- /dev/null
+++ b/sound/soc/hda/Makefile
@@ -0,0 +1,3 @@
+snd-soc-hda-skl-objs := hda_skl.o hda_skl_pcm.o
+
+obj-$(CONFIG_SND_SOC_HDA_SKL) += snd-soc-hda-skl.o
-- 
1.7.9.5
