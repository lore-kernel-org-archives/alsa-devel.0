From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: add config item for
	soc-compress to make it compiled only when needed" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:32 +0900
Message-ID: <E1ZpOzE-0008RI-PJ@finisterre>
References: <1444750860-19355-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4F1F266B27
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:41 +0200 (CEST)
In-Reply-To: <1444750860-19355-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: add config item for soc-compress to make it compiled only when needed

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6f0c42269f000b1e346c84d9a589f17aa94c96d8 Mon Sep 17 00:00:00 2001
From: Jie Yang <yang.jie@intel.com>
Date: Tue, 13 Oct 2015 23:41:00 +0800
Subject: [PATCH] ASoC: compress: add config item for soc-compress to make it
 compiled only when needed

We don't always need soc-compress in soc, here add a config item
SND_SOC_COMPRESS, when nobody select it, the soc-compress will
not be compiled.

Here also change Kconfig to 'select SND_SOC_COMPRESS' for drivers
that needed soc-compress.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 71e0c05..a7bc82b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -440,7 +440,9 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
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
index 225bfda..3e4f444 100644
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
index 134aca1..280ac82 100644
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
index 05fde5e6e..221e3bd 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -12,6 +12,7 @@ config SND_MFLD_MACHINE
 
 config SND_SST_MFLD_PLATFORM
 	tristate
+	select SND_SOC_COMPRESS
 
 config SND_SST_IPC
 	tristate
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 683e501..4c734f5 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -529,7 +529,7 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
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
index 6173d15..6e543e1 100644
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
2.6.1
