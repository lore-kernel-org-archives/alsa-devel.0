From: Corina Palade <corina.palade103@gmail.com>
Subject: [PATCH] soc: xtensa: Replace "unsigned" with "unsigned int"
Date: Sat, 25 Feb 2017 02:29:58 -0800
Message-ID: <1488018598-13338-1-git-send-email-corina.palade103@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jcmvbkbc@gmail.com, tiwai@suse.com, perex@perex.cz
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-xtensa@linux-xtensa.org, alsa-devel@alsa-project.org, corina.palade103@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl.

Signed-off-by: Corina Palade <corina.palade103@gmail.com>
---
 sound/soc/xtensa/xtfpga-i2s.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 8382ffa..01a2622 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -76,22 +76,22 @@ struct xtfpga_i2s {
 	 * handler by means of synchronize_rcu call.
 	 */
 	struct snd_pcm_substream __rcu *tx_substream;
-	unsigned (*tx_fn)(struct xtfpga_i2s *i2s,
+	unsigned int (*tx_fn)(struct xtfpga_i2s *i2s,
 			  struct snd_pcm_runtime *runtime,
-			  unsigned tx_ptr);
-	unsigned tx_ptr; /* next frame index in the sample buffer */
+			  unsigned int tx_ptr);
+	unsigned int tx_ptr; /* next frame index in the sample buffer */
 
 	/* current fifo level estimate.
 	 * Doesn't have to be perfectly accurate, but must be not less than
 	 * the actual FIFO level in order to avoid stall on push attempt.
 	 */
-	unsigned tx_fifo_level;
+	unsigned int tx_fifo_level;
 
 	/* FIFO level at which level interrupt occurs */
-	unsigned tx_fifo_low;
+	unsigned int tx_fifo_low;
 
 	/* maximal FIFO level */
-	unsigned tx_fifo_high;
+	unsigned int tx_fifo_high;
 };
 
 static bool xtfpga_i2s_wr_reg(struct device *dev, unsigned int reg)
@@ -130,9 +130,9 @@ static const struct regmap_config xtfpga_i2s_regmap_config = {
  * the LSB of each word is used.
  */
 #define xtfpga_pcm_tx_fn(channels, sample_bits) \
-static unsigned xtfpga_pcm_tx_##channels##x##sample_bits( \
+static unsigned int xtfpga_pcm_tx_##channels##x##sample_bits( \
 	struct xtfpga_i2s *i2s, struct snd_pcm_runtime *runtime, \
-	unsigned tx_ptr) \
+	unsigned int tx_ptr) \
 { \
 	const u##sample_bits (*p)[channels] = \
 		(void *)runtime->dma_area; \
@@ -165,8 +165,8 @@ static bool xtfpga_pcm_push_tx(struct xtfpga_i2s *i2s)
 	tx_substream = rcu_dereference(i2s->tx_substream);
 	tx_active = tx_substream && snd_pcm_running(tx_substream);
 	if (tx_active) {
-		unsigned tx_ptr = ACCESS_ONCE(i2s->tx_ptr);
-		unsigned new_tx_ptr = i2s->tx_fn(i2s, tx_substream->runtime,
+		unsigned int tx_ptr = ACCESS_ONCE(i2s->tx_ptr);
+		unsigned int new_tx_ptr = i2s->tx_fn(i2s, tx_substream->runtime,
 						 tx_ptr);
 
 		cmpxchg(&i2s->tx_ptr, tx_ptr, new_tx_ptr);
@@ -178,8 +178,8 @@ static bool xtfpga_pcm_push_tx(struct xtfpga_i2s *i2s)
 
 static void xtfpga_pcm_refill_fifo(struct xtfpga_i2s *i2s)
 {
-	unsigned int_status;
-	unsigned i;
+	unsigned int int_status;
+	unsigned int i;
 
 	regmap_read(i2s->regmap, XTFPGA_I2S_INT_STATUS,
 		    &int_status);
@@ -227,7 +227,7 @@ static irqreturn_t xtfpga_i2s_threaded_irq_handler(int irq, void *dev_id)
 {
 	struct xtfpga_i2s *i2s = dev_id;
 	struct snd_pcm_substream *tx_substream;
-	unsigned config, int_status, int_mask;
+	unsigned int config, int_status, int_mask;
 
 	regmap_read(i2s->regmap, XTFPGA_I2S_CONFIG, &config);
 	regmap_read(i2s->regmap, XTFPGA_I2S_INT_MASK, &int_mask);
@@ -284,11 +284,11 @@ static int xtfpga_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct xtfpga_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	unsigned srate = params_rate(params);
-	unsigned channels = params_channels(params);
-	unsigned period_size = params_period_size(params);
-	unsigned sample_size = snd_pcm_format_width(params_format(params));
-	unsigned freq, ratio, level;
+	unsigned int srate = params_rate(params);
+	unsigned int channels = params_channels(params);
+	unsigned int period_size = params_period_size(params);
+	unsigned int sample_size = snd_pcm_format_width(params_format(params));
+	unsigned int freq, ratio, level;
 	int err;
 
 	regmap_update_bits(i2s->regmap, XTFPGA_I2S_CONFIG,
@@ -393,7 +393,7 @@ static int xtfpga_pcm_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct xtfpga_i2s *i2s = runtime->private_data;
-	unsigned channels = params_channels(hw_params);
+	unsigned int channels = params_channels(hw_params);
 
 	switch (channels) {
 	case 1:
-- 
2.7.4
