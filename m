From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V2 04/10] ASoc: mxs: add asoc configuration
	files
Date: Tue, 12 Jul 2011 23:04:39 +0800
Message-ID: <1310483085-31442-5-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by alsa0.perex.cz (Postfix) with ESMTP id 571AD247A6
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 16:42:18 +0200 (CEST)
In-Reply-To: <1310483085-31442-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/Kconfig      |    1 +
 sound/soc/Makefile     |    1 +
 sound/soc/mxs/Kconfig  |   19 +++++++++++++++++++
 sound/soc/mxs/Makefile |   10 ++++++++++
 4 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 8224db5..47d07ce 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -51,6 +51,7 @@ source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
 source "sound/soc/kirkwood/Kconfig"
 source "sound/soc/mid-x86/Kconfig"
+source "sound/soc/mxs/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 1ed61c5..fc4136e 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SND_SOC)	+= fsl/
 obj-$(CONFIG_SND_SOC)   += imx/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
 obj-$(CONFIG_SND_SOC)	+= mid-x86/
+obj-$(CONFIG_SND_SOC)	+= mxs/
 obj-$(CONFIG_SND_SOC)	+= nuc900/
 obj-$(CONFIG_SND_SOC)	+= omap/
 obj-$(CONFIG_SND_SOC)	+= kirkwood/
diff --git a/sound/soc/mxs/Kconfig b/sound/soc/mxs/Kconfig
new file mode 100644
index 0000000..778b2dc
--- /dev/null
+++ b/sound/soc/mxs/Kconfig
@@ -0,0 +1,19 @@
+menuconfig SND_MXS_SOC
+	tristate "SoC Audio for Freescale MXS CPUs"
+	depends on ARCH_MXS
+	select SND_PCM
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the MXS SAIF interface.
+
+
+if SND_MXS_SOC
+
+config SND_SOC_MXS_SGTL5000
+	tristate "SoC Audio support for i.MX boards with sgtl5000"
+	select SND_SOC_SGTL5000
+	help
+	  Say Y if you want to add support for SoC audio on an MXS board with
+	  a sgtl5000 codec.
+
+endif	# SND_MXS_SOC
diff --git a/sound/soc/mxs/Makefile b/sound/soc/mxs/Makefile
new file mode 100644
index 0000000..565b5b5
--- /dev/null
+++ b/sound/soc/mxs/Makefile
@@ -0,0 +1,10 @@
+# MXS Platform Support
+snd-soc-mxs-objs := mxs-saif.o
+snd-soc-mxs-pcm-objs := mxs-pcm.o
+
+obj-$(CONFIG_SND_MXS_SOC) += snd-soc-mxs.o snd-soc-mxs-pcm.o
+
+# i.MX Machine Support
+snd-soc-mxs-sgtl5000-objs := mxs-sgtl5000.o
+
+obj-$(CONFIG_SND_SOC_MXS_SGTL5000) += snd-soc-mxs-sgtl5000.o
-- 
1.7.0.4
