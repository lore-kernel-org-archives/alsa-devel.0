From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH v2 1/2] ASoC: dwc: Add record capability in PIO mode
Date: Mon,  9 Jan 2017 13:43:27 +0000
Message-ID: <d48579ac3374b6931ef3c1f21ae3d8bf921d2c24.1483969112.git.joabreu@synopsys.com>
References: <cover.1483969112.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1483969112.git.joabreu@synopsys.com>
In-Reply-To: <cover.1483969112.git.joabreu@synopsys.com>
References: <cover.1483969112.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Up until now PIO mode offered only playback support. With
this patch we add support for record mode. The PCM was
refactored so that we could reuse the existing infrastructure
without many changes.

We have support for 16 and 32 bits of sample size using
only 2 channels.

Tested in a x86_64 platform and in ARC AXS101 SDP platform.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/dwc/designware_i2s.c |  9 +++-
 sound/soc/dwc/designware_pcm.c | 97 +++++++++++++++++++++++++++++++++---------
 sound/soc/dwc/local.h          |  9 +++-
 3 files changed, 92 insertions(+), 23 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index bdf8398..9c46e41 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -121,9 +121,14 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 			irq_valid = true;
 		}
 
-		/* Data available. Record mode not supported in PIO mode */
-		if (isr[i] & ISR_RXDA)
+		/*
+		 * Data available. Retrieve samples from FIFO
+		 * NOTE: Only two channels supported
+		 */
+		if ((isr[i] & ISR_RXDA) && (i == 0) && dev->use_pio) {
+			dw_pcm_pop_rx(dev);
 			irq_valid = true;
+		}
 
 		/* Error Handling: TX */
 		if (isr[i] & ISR_TXFO) {
diff --git a/sound/soc/dwc/designware_pcm.c b/sound/soc/dwc/designware_pcm.c
index 4a83a22..b063c86 100644
--- a/sound/soc/dwc/designware_pcm.c
+++ b/sound/soc/dwc/designware_pcm.c
@@ -41,10 +41,33 @@
 	return tx_ptr; \
 }
 
+#define dw_pcm_rx_fn(sample_bits) \
+static unsigned int dw_pcm_rx_##sample_bits(struct dw_i2s_dev *dev, \
+		struct snd_pcm_runtime *runtime, unsigned int rx_ptr, \
+		bool *period_elapsed) \
+{ \
+	u##sample_bits (*p)[2] = (void *)runtime->dma_area; \
+	unsigned int period_pos = rx_ptr % runtime->period_size; \
+	int i; \
+\
+	for (i = 0; i < dev->fifo_th; i++) { \
+		p[rx_ptr][0] = ioread32(dev->i2s_base + LRBR_LTHR(0)); \
+		p[rx_ptr][1] = ioread32(dev->i2s_base + RRBR_RTHR(0)); \
+		period_pos++; \
+		if (++rx_ptr >= runtime->buffer_size) \
+			rx_ptr = 0; \
+	} \
+	*period_elapsed = period_pos >= runtime->period_size; \
+	return rx_ptr; \
+}
+
 dw_pcm_tx_fn(16);
 dw_pcm_tx_fn(32);
+dw_pcm_rx_fn(16);
+dw_pcm_rx_fn(32);
 
 #undef dw_pcm_tx_fn
+#undef dw_pcm_rx_fn
 
 static const struct snd_pcm_hardware dw_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
@@ -68,27 +91,51 @@
 	.fifo_size = 16,
 };
 
-void dw_pcm_push_tx(struct dw_i2s_dev *dev)
+static void dw_pcm_transfer(struct dw_i2s_dev *dev, bool push)
 {
-	struct snd_pcm_substream *tx_substream;
-	bool tx_active, period_elapsed;
+	struct snd_pcm_substream *substream;
+	bool active, period_elapsed;
 
 	rcu_read_lock();
-	tx_substream = rcu_dereference(dev->tx_substream);
-	tx_active = tx_substream && snd_pcm_running(tx_substream);
-	if (tx_active) {
-		unsigned int tx_ptr = READ_ONCE(dev->tx_ptr);
-		unsigned int new_tx_ptr = dev->tx_fn(dev, tx_substream->runtime,
-				tx_ptr, &period_elapsed);
-		cmpxchg(&dev->tx_ptr, tx_ptr, new_tx_ptr);
+	if (push)
+		substream = rcu_dereference(dev->tx_substream);
+	else
+		substream = rcu_dereference(dev->rx_substream);
+	active = substream && snd_pcm_running(substream);
+	if (active) {
+		unsigned int ptr;
+		unsigned int new_ptr;
+
+		if (push) {
+			ptr = READ_ONCE(dev->tx_ptr);
+			new_ptr = dev->tx_fn(dev, substream->runtime, ptr,
+					&period_elapsed);
+			cmpxchg(&dev->tx_ptr, ptr, new_ptr);
+		} else {
+			ptr = READ_ONCE(dev->rx_ptr);
+			new_ptr = dev->rx_fn(dev, substream->runtime, ptr,
+					&period_elapsed);
+			cmpxchg(&dev->rx_ptr, ptr, new_ptr);
+		}
 
 		if (period_elapsed)
-			snd_pcm_period_elapsed(tx_substream);
+			snd_pcm_period_elapsed(substream);
 	}
 	rcu_read_unlock();
 }
+
+void dw_pcm_push_tx(struct dw_i2s_dev *dev)
+{
+	dw_pcm_transfer(dev, true);
+}
 EXPORT_SYMBOL_GPL(dw_pcm_push_tx);
 
+void dw_pcm_pop_rx(struct dw_i2s_dev *dev)
+{
+	dw_pcm_transfer(dev, false);
+}
+EXPORT_SYMBOL_GPL(dw_pcm_pop_rx);
+
 static int dw_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -126,20 +173,17 @@ static int dw_pcm_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(hw_params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		dev->tx_fn = dw_pcm_tx_16;
+		dev->rx_fn = dw_pcm_rx_16;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		dev->tx_fn = dw_pcm_tx_32;
+		dev->rx_fn = dw_pcm_rx_32;
 		break;
 	default:
 		dev_err(dev->dev, "invalid format\n");
 		return -EINVAL;
 	}
 
-	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK) {
-		dev_err(dev->dev, "only playback is available\n");
-		return -EINVAL;
-	}
-
 	ret = snd_pcm_lib_malloc_pages(substream,
 			params_buffer_bytes(hw_params));
 	if (ret < 0)
@@ -163,13 +207,21 @@ static int dw_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		WRITE_ONCE(dev->tx_ptr, 0);
-		rcu_assign_pointer(dev->tx_substream, substream);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			WRITE_ONCE(dev->tx_ptr, 0);
+			rcu_assign_pointer(dev->tx_substream, substream);
+		} else {
+			WRITE_ONCE(dev->rx_ptr, 0);
+			rcu_assign_pointer(dev->rx_substream, substream);
+		}
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		rcu_assign_pointer(dev->tx_substream, NULL);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			rcu_assign_pointer(dev->tx_substream, NULL);
+		else
+			rcu_assign_pointer(dev->rx_substream, NULL);
 		break;
 	default:
 		ret = -EINVAL;
@@ -183,7 +235,12 @@ static snd_pcm_uframes_t dw_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct dw_i2s_dev *dev = runtime->private_data;
-	snd_pcm_uframes_t pos = READ_ONCE(dev->tx_ptr);
+	snd_pcm_uframes_t pos;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		pos = READ_ONCE(dev->tx_ptr);
+	else
+		pos = READ_ONCE(dev->rx_ptr);
 
 	return pos < runtime->buffer_size ? pos : 0;
 }
diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
index 68afd75..91dc70a 100644
--- a/sound/soc/dwc/local.h
+++ b/sound/soc/dwc/local.h
@@ -105,20 +105,27 @@ struct dw_i2s_dev {
 	struct i2s_clk_config_data config;
 	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
 
-	/* data related to PIO transfers (TX) */
+	/* data related to PIO transfers */
 	bool use_pio;
 	struct snd_pcm_substream __rcu *tx_substream;
+	struct snd_pcm_substream __rcu *rx_substream;
 	unsigned int (*tx_fn)(struct dw_i2s_dev *dev,
 			struct snd_pcm_runtime *runtime, unsigned int tx_ptr,
 			bool *period_elapsed);
+	unsigned int (*rx_fn)(struct dw_i2s_dev *dev,
+			struct snd_pcm_runtime *runtime, unsigned int rx_ptr,
+			bool *period_elapsed);
 	unsigned int tx_ptr;
+	unsigned int rx_ptr;
 };
 
 #if IS_ENABLED(CONFIG_SND_DESIGNWARE_PCM)
 void dw_pcm_push_tx(struct dw_i2s_dev *dev);
+void dw_pcm_pop_rx(struct dw_i2s_dev *dev);
 int dw_pcm_register(struct platform_device *pdev);
 #else
 void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
+void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
 int dw_pcm_register(struct platform_device *pdev)
 {
 	return -EINVAL;
-- 
1.9.1
