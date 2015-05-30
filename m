From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: add config to enable/disable asoc
	compress
Date: Sat, 30 May 2015 21:28:31 +0800
Message-ID: <1432992511-864-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 39ADB26061E
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 15:24:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: vivian.zhang@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: "vivian,zhang" <vivian.zhang@intel.com>

To reduce memory footprint, we can disable asoc compress when it
is not used. Here add SND_SOC_COMPRESS to configure it.

Signed-off-by: vivian,zhang <vivian.zhang@intel.com>
Modified-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 include/sound/soc.h |  7 +++++++
 sound/soc/Kconfig   | 10 +++++++++-
 sound/soc/Makefile  |  6 +++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f6226914..6e2da70 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -430,7 +430,14 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
 int snd_soc_platform_write(struct snd_soc_platform *platform,
 					unsigned int reg, unsigned int val);
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
+#ifdef CONFIG_SND_SOC_COMPRESS
 int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
+#else
+static inline int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
+{
+       return -EPERM;
+}
+#endif
 
 struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 		const char *dai_link, int stream);
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 3ba52da..7e7a8e1 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -9,7 +9,7 @@ menuconfig SND_SOC
 	select SND_JACK if INPUT=y || INPUT=SND
 	select REGMAP_I2C if I2C
 	select REGMAP_SPI if SPI_MASTER
-	select SND_COMPRESS_OFFLOAD
+	select SND_COMPRESS_OFFLOAD if SND_SOC_COMPRESS
 	---help---
 
 	  If you want ASoC support, you should say Y here and also to the
@@ -30,6 +30,14 @@ config SND_SOC_GENERIC_DMAENGINE_PCM
 	bool
 	select SND_DMAENGINE_PCM
 
+config SND_SOC_COMPRESS
+	bool "Asoc compress offload support" if EXPERT
+	default y
+	help
+	  Say 'N" to disable Asoc compress offload support, which may reduce code
+	  size about 10KB on X86_64 platform.
+	  If unsure say Y.
+
 # All the supported SoCs
 source "sound/soc/adi/Kconfig"
 source "sound/soc/atmel/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 974ba70..0832c3b 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
-snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o soc-devres.o soc-ops.o
+snd-soc-core-objs += soc-pcm.o soc-io.o soc-devres.o soc-ops.o
 
 ifneq ($(CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM),)
 snd-soc-core-objs += soc-generic-dmaengine-pcm.o
@@ -9,6 +9,10 @@ ifneq ($(CONFIG_SND_SOC_AC97_BUS),)
 snd-soc-core-objs += soc-ac97.o
 endif
 
+ifneq ($(CONFIG_SND_SOC_COMPRESS),)
+snd-soc-core-objs += soc-compress.o
+endif
+
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
 obj-$(CONFIG_SND_SOC)	+= generic/
-- 
1.9.1
