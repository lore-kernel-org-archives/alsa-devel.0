From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 11/11] ASoC: hda - enable ASoC Skylake HD audio
	driver
Date: Sun, 12 Apr 2015 18:06:18 +0530
Message-ID: <1428842178-7105-12-git-send-email-subhransu.s.prusty@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C2B6C2607F7
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 15:06:17 +0200 (CEST)
In-Reply-To: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Add makefile and Kconfig to enable Skylake
HD audio driver

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/Kconfig      |  3 ++-
 sound/soc/Makefile     |  1 +
 sound/soc/hda/Kconfig  | 29 +++++++++++++++++++++++++++++
 sound/soc/hda/Makefile |  6 ++++++
 4 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/hda/Kconfig
 create mode 100644 sound/soc/hda/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index dcc79aa..1baa2a4 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -14,7 +14,7 @@ menuconfig SND_SOC
 
 	  If you want ASoC support, you should say Y here and also to the
 	  specific driver for your SoC platform below.
-	  
+
 	  ASoC provides power efficient ALSA support for embedded battery powered
 	  SoC based systems like PDA's, Phones and Personal Media Players.
 
@@ -40,6 +40,7 @@ source "sound/soc/cirrus/Kconfig"
 source "sound/soc/davinci/Kconfig"
 source "sound/soc/dwc/Kconfig"
 source "sound/soc/fsl/Kconfig"
+source "sound/soc/hda/Kconfig"
 source "sound/soc/jz4740/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 5b3c8f6..3269d19 100644
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
index 0000000..1711126
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
+config SND_HDA_PREALLOC_SIZE
+	int "Pre-allocated buffer size for HD-audio driver"
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
index 0000000..7057b08
--- /dev/null
+++ b/sound/soc/hda/Makefile
@@ -0,0 +1,6 @@
+ccflags-y += -Werror
+
+snd-soc-hda-skl-objs := hda_skl.o hda_skl_pcm.o
+
+# common driver
+obj-$(CONFIG_SND_SOC_HDA_SKL) += snd-soc-hda-skl.o
-- 
1.9.0
