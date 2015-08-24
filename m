From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 10/10] ALSA: axd: add Makefile
Date: Mon, 24 Aug 2015 13:39:19 +0100
Message-ID: <1440419959-14315-11-git-send-email-qais.yousef@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Now all necessary files are added, allow axd to be selected through Kconfig and
compiled.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/Kconfig          |  1 +
 sound/soc/Makefile         |  1 +
 sound/soc/img/Kconfig      | 11 +++++++++++
 sound/soc/img/Makefile     |  1 +
 sound/soc/img/axd/Makefile | 13 +++++++++++++
 5 files changed, 27 insertions(+)
 create mode 100644 sound/soc/img/Kconfig
 create mode 100644 sound/soc/img/Makefile
 create mode 100644 sound/soc/img/axd/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 2ae9619443d1..8f29af1d397e 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -44,6 +44,7 @@ source "sound/soc/jz4740/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
 source "sound/soc/kirkwood/Kconfig"
+source "sound/soc/img/Kconfig"
 source "sound/soc/intel/Kconfig"
 source "sound/soc/mediatek/Kconfig"
 source "sound/soc/mxs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index e189903fabf4..c6a1c04b8e39 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_SND_SOC)	+= davinci/
 obj-$(CONFIG_SND_SOC)	+= dwc/
 obj-$(CONFIG_SND_SOC)	+= fsl/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
+obj-$(CONFIG_SND_SOC)	+= img/
 obj-$(CONFIG_SND_SOC)	+= intel/
 obj-$(CONFIG_SND_SOC)	+= mediatek/
 obj-$(CONFIG_SND_SOC)	+= mxs/
diff --git a/sound/soc/img/Kconfig b/sound/soc/img/Kconfig
new file mode 100644
index 000000000000..5a089b7d4929
--- /dev/null
+++ b/sound/soc/img/Kconfig
@@ -0,0 +1,11 @@
+config SND_SOC_IMG_AXD
+	tristate "Imagination AXD Audio Processing IP"
+	depends on MIPS && COMMON_CLK && CMA
+	---help---
+	  Say Y or M here if you to add support for AXD Audio Processing IP.
+
+config SND_SOC_IMG_AXD_DEBUGFS
+	bool "AXD debugfs support"
+	depends on SND_SOC_IMG_AXD && DEBUG_FS
+	---help---
+	  Say Y if you want to create AXD debugfs nodes
diff --git a/sound/soc/img/Makefile b/sound/soc/img/Makefile
new file mode 100644
index 000000000000..189abf5d927c
--- /dev/null
+++ b/sound/soc/img/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SND_SOC_IMG_AXD) += axd/
diff --git a/sound/soc/img/axd/Makefile b/sound/soc/img/axd/Makefile
new file mode 100644
index 000000000000..cfa1f412bf19
--- /dev/null
+++ b/sound/soc/img/axd/Makefile
@@ -0,0 +1,13 @@
+obj-$(CONFIG_SND_SOC_IMG_AXD) := axd.o
+
+axd-objs = axd_alsa_ops.o \
+	   axd_buffers.o \
+	   axd_cmds.o \
+	   axd_cmds_config.o \
+	   axd_cmds_decoder_config.o \
+	   axd_cmds_info.o \
+	   axd_cmds_internal.o \
+	   axd_cmds_pipes.o \
+	   axd_hdr.o \
+	   axd_module.o \
+	   axd_platform_$(ARCH).o \
-- 
2.1.0
