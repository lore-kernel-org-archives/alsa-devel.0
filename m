From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH] ASoC: factor out intel_scu_ipc related
	read/write
Date: Sat, 07 May 2011 21:43:18 +0800
Message-ID: <20110507134318.4225.54478.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EEE6243B3
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 15:41:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Koul Vinod <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

A new 'enum snd_soc_control_type' is added to indicate this operation.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 include/sound/soc.h        |    1 +
 sound/soc/codecs/sn95031.c |   33 ++++++--------------------------
 sound/soc/soc-cache.c      |   46 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6ce3e57..802b9a7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -251,6 +251,7 @@ enum snd_soc_control_type {
 	SND_SOC_CUSTOM = 1,
 	SND_SOC_I2C,
 	SND_SOC_SPI,
+	SND_SOC_INTEL_SCU,
 };
 
 enum snd_soc_compress_type {
diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 84ffdeb..a11e324 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -29,7 +29,6 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 
-#include <asm/intel_scu_ipc.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -166,30 +165,6 @@ static unsigned int sn95031_get_mic_bias(struct snd_soc_codec *codec)
 EXPORT_SYMBOL_GPL(sn95031_get_mic_bias);
 /*end - adc helper functions */
 
-static inline unsigned int sn95031_read(struct snd_soc_codec *codec,
-			unsigned int reg)
-{
-	u8 value = 0;
-	int ret;
-
-	ret = intel_scu_ipc_ioread8(reg, &value);
-	if (ret)
-		pr_err("read of %x failed, err %d\n", reg, ret);
-	return value;
-
-}
-
-static inline int sn95031_write(struct snd_soc_codec *codec,
-			unsigned int reg, unsigned int value)
-{
-	int ret;
-
-	ret = intel_scu_ipc_iowrite8(reg, value);
-	if (ret)
-		pr_err("write of %x failed, err %d\n", reg, ret);
-	return ret;
-}
-
 static int sn95031_set_vaud_bias(struct snd_soc_codec *codec,
 		enum snd_soc_bias_level level)
 {
@@ -827,8 +802,14 @@ EXPORT_SYMBOL_GPL(sn95031_jack_detection);
 /* codec registration */
 static int sn95031_codec_probe(struct snd_soc_codec *codec)
 {
+	int ret;
+
 	pr_debug("codec_probe called\n");
 
+	ret = snd_soc_codec_set_cache_io(codec, 16, 8, SND_SOC_INTEL_SCU);
+	if (ret < 0)
+		return ret;
+
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.idle_bias_off = 1;
 
@@ -891,8 +872,6 @@ static int sn95031_codec_remove(struct snd_soc_codec *codec)
 struct snd_soc_codec_driver sn95031_codec = {
 	.probe		= sn95031_codec_probe,
 	.remove		= sn95031_codec_remove,
-	.read		= sn95031_read,
-	.write		= sn95031_write,
 	.set_bias_level	= sn95031_set_vaud_bias,
 	.dapm_widgets	= sn95031_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(sn95031_dapm_widgets),
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index a217db2..65986a9 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -20,6 +20,42 @@
 
 #include <trace/events/asoc.h>
 
+#if defined(CONFIG_INTEL_SCU_IPC)
+#include <asm/intel_scu_ipc.h>
+static unsigned int snd_soc_16_8_intel_scu_read(struct snd_soc_codec *codec,
+						unsigned int reg)
+{
+	u8 value = 0;
+	int ret;
+
+	ret = intel_scu_ipc_ioread8(reg, &value);
+	if (ret < 0)
+		dev_err(codec->dev, "read of %x failed, err %d\n", reg, ret);
+	return value;
+}
+
+static int snd_soc_16_8_intel_scu_write(void *control_data,
+					const char *data, int len)
+{
+	struct snd_soc_codec *codec = control_data;
+	unsigned int reg, value;
+	int ret;
+
+	reg = (data[0] << 8) | data[1];
+	value = data[2];
+
+	ret = intel_scu_ipc_iowrite8(reg, value);
+	if (ret < 0) {
+		dev_err(codec->dev, "write of %x failed, err %d\n", reg, ret);
+		return ret;
+	}
+	return len;
+}
+#else
+#define snd_soc_16_8_intel_scu_read NULL
+#define snd_soc_16_8_intel_scu_write NULL
+#endif
+
 #if defined(CONFIG_SPI_MASTER)
 static int do_spi_write(void *control_data, const void *msg,
 			int len)
@@ -544,6 +580,16 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 						   struct spi_device,
 						   dev);
 		break;
+
+	case SND_SOC_INTEL_SCU:
+		if (io_types[i].addr_bits != 16 || io_types[i].data_bits != 8)
+			return -EINVAL;
+
+		codec->hw_read = snd_soc_16_8_intel_scu_read;
+		codec->hw_write = snd_soc_16_8_intel_scu_write;
+		codec->control_data = codec;
+
+		break;
 	}
 
 	return 0;
