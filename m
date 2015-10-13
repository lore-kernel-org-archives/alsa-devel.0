From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v4] ASoC: soc-compress: add config item for
	soc-compress to make it compiled only when needed
Date: Tue, 13 Oct 2015 23:41:00 +0800
Message-ID: <1444750860-19355-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C765F261AA1
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 17:35:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

We don't always need soc-compress in soc, here add a config item
SND_SOC_COMPRESS, when nobody select it, the soc-compress will
not be compiled.

Here also change Kconfig to 'select SND_SOC_COMPRESS' for drivers
that needed soc-compress.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 include/sound/soc-dai.h                      |  2 +-
 include/sound/soc.h                          |  4 +++-
 sound/soc/Kconfig                            |  5 ++++-
 sound/soc/Makefile                           |  3 ++-
 sound/soc/intel/Kconfig                      |  1 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  2 +-
 sound/soc/soc-compress.c                     | 12 ++++++++++--
 sound/soc/soc-core.c                         |  4 ++--
 8 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 2df96b1..238200f 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -214,7 +214,7 @@ struct snd_soc_dai_driver {
 	int (*suspend)(struct snd_soc_dai *dai);
 	int (*resume)(struct snd_soc_dai *dai);
 	/* compress dai */
-	bool compress_dai;
+	int (*compress_new)(struct snd_soc_pcm_runtime *rtd, int num);
 	/* DAI is also used for the control bus */
 	bool bus_control;
 
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 98e080b..10b7802 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -459,7 +459,9 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
 int snd_soc_platform_write(struct snd_soc_platform *platform,
 					unsigned int reg, unsigned int val);
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
-int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
+#ifdef CONFIG_SND_SOC_COMPRESS
+int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
+#endif
 
 struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 		const char *dai_link, int stream);
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 7de792b..7ff7d88 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -9,7 +9,6 @@ menuconfig SND_SOC
 	select SND_JACK if INPUT=y || INPUT=SND
 	select REGMAP_I2C if I2C
 	select REGMAP_SPI if SPI_MASTER
-	select SND_COMPRESS_OFFLOAD
 	---help---
 
 	  If you want ASoC support, you should say Y here and also to the
@@ -30,6 +29,10 @@ config SND_SOC_GENERIC_DMAENGINE_PCM
 	bool
 	select SND_DMAENGINE_PCM
 
+config SND_SOC_COMPRESS
+	bool
+	select SND_COMPRESS_OFFLOAD
+
 config SND_SOC_TOPOLOGY
 	bool
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index af0a571..8eb06db 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,6 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
-snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o soc-devres.o soc-ops.o
+snd-soc-core-objs += soc-pcm.o soc-io.o soc-devres.o soc-ops.o
+snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
 
 ifneq ($(CONFIG_SND_SOC_TOPOLOGY),)
 snd-soc-core-objs += soc-topology.o
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 664df1f..aaafb13 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -12,6 +12,7 @@ config SND_MFLD_MACHINE
 
 config SND_SST_MFLD_PLATFORM
 	tristate
+	select SND_SOC_COMPRESS
 
 config SND_SST_IPC
 	tristate
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 5e9c316..0487cfa 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -512,7 +512,7 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 },
 {
 	.name = "compress-cpu-dai",
-	.compress_dai = 1,
+	.compress_new = snd_soc_new_compress,
 	.ops = &sst_compr_dai_ops,
 	.playback = {
 		.stream_name = "Compress Playback",
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 025c38f..12a9820 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -612,8 +612,15 @@ static struct snd_compr_ops soc_compr_dyn_ops = {
 	.get_codec_caps = soc_compr_get_codec_caps
 };
 
-/* create a new compress */
-int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
+/**
+ * snd_soc_new_compress - create a new compress.
+ *
+ * @rtd: The runtime for which we will create compress
+ * @num: the device index number (zero based - shared with normal PCMs)
+ *
+ * Return: 0 for success, else error.
+ */
+int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
@@ -703,3 +710,4 @@ compr_err:
 	kfree(compr);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_soc_new_compress);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3b471f9..24b0960 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1370,9 +1370,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 		soc_dpcm_debugfs_add(rtd);
 #endif
 
-	if (cpu_dai->driver->compress_dai) {
+	if (cpu_dai->driver->compress_new) {
 		/*create compress_device"*/
-		ret = soc_new_compress(rtd, num);
+		ret = cpu_dai->driver->compress_new(rtd, num);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: can't create compress %s\n",
 					 dai_link->stream_name);
-- 
1.9.1
