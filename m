From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/12] ASoC: core: add support to snd_soc_dai_get_channel_map()
Date: Mon, 23 Jul 2018 16:54:03 +0100
Message-ID: <20180723155410.9494-6-srinivas.kandagatla@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Qualcomm platforms, specifically with SLIMbus interfaced codecs,
the codec slim channel numbers are passed to DSP while configuring
the slim audio path. Having get_channel_map() would allow dais to
share such information across multiple dais.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc-dai.h |  8 ++++++++
 sound/soc/soc-core.c    | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index a14bc0608ae9..f5d70041108f 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -138,6 +138,11 @@ int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 			     int direction);
 
+
+int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
+		unsigned int *tx_num, unsigned int *tx_slot,
+		unsigned int *rx_num, unsigned int *rx_slot);
+
 int snd_soc_dai_is_dummy(struct snd_soc_dai *dai);
 
 struct snd_soc_dai_ops {
@@ -165,6 +170,9 @@ struct snd_soc_dai_ops {
 	int (*set_channel_map)(struct snd_soc_dai *dai,
 		unsigned int tx_num, unsigned int *tx_slot,
 		unsigned int rx_num, unsigned int *rx_slot);
+	int (*get_channel_map)(struct snd_soc_dai *dai,
+			unsigned int *tx_num, unsigned int *tx_slot,
+			unsigned int *rx_num, unsigned int *rx_slot);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
 	int (*set_sdw_stream)(struct snd_soc_dai *dai,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad5b0ef16d82..81b27923303d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2679,6 +2679,28 @@ int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_channel_map);
 
+/**
+ * snd_soc_dai_get_channel_map - Get DAI audio channel map
+ * @dai: DAI
+ * @tx_num: how many TX channels
+ * @tx_slot: pointer to an array which imply the TX slot number channel
+ *           0~num-1 uses
+ * @rx_num: how many RX channels
+ * @rx_slot: pointer to an array which imply the RX slot number channel
+ *           0~num-1 uses
+ */
+int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
+	unsigned int *tx_num, unsigned int *tx_slot,
+	unsigned int *rx_num, unsigned int *rx_slot)
+{
+	if (dai->driver->ops->get_channel_map)
+		return dai->driver->ops->get_channel_map(dai, tx_num, tx_slot,
+			rx_num, rx_slot);
+	else
+		return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_get_channel_map);
+
 /**
  * snd_soc_dai_set_tristate - configure DAI system or master clock.
  * @dai: DAI
-- 
2.16.2
