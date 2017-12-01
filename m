From: John Hsu <KCHSU0@nuvoton.com>
Subject: ASoC: nau8825: improve semaphore control
Date: Fri, 1 Dec 2017 10:01:50 +0800
Message-ID: <1512093710-11097-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D3B08267B70
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 03:01:53 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, cychiang@google.com, anatol.pomozov@gmail.com, WTLI@nuvoton.com, wuchengli@google.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

After reviewing the crosstalk protection, there are two flaws at
semaphore control. The first one is that the semaphore releases are
not enough; and the other is that down_interruptible has an risk to
make the ISR sleep.
Therefore, the driver add more releases before the funcitons return.
Take down_trylock to replace down_interruptible. The ISR can control
the protection as well and never sleep by semaphore.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 7947b11..2aea642 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -245,13 +245,14 @@ static const unsigned short logtable[256] = {
  * tasks are allowed to acquire the semaphore, calling this function will
  * put the task to sleep. If the semaphore is not released within the
  * specified number of jiffies, this function returns.
- * Acquires the semaphore without jiffies. If no more tasks are allowed
- * to acquire the semaphore, calling this function will put the task to
- * sleep until the semaphore is released.
  * If the semaphore is not released within the specified number of jiffies,
- * this function returns -ETIME.
- * If the sleep is interrupted by a signal, this function will return -EINTR.
- * It returns 0 if the semaphore was acquired successfully.
+ * this function returns -ETIME. If the sleep is interrupted by a signal,
+ * this function will return -EINTR. It returns 0 if the semaphore was
+ * acquired successfully.
+ *
+ * Acquires the semaphore without jiffies. Try to acquire the semaphore
+ * atomically. Returns 0 if the semaphore has been acquired successfully
+ * or 1 if it it cannot be acquired.
  */
 static int nau8825_sema_acquire(struct nau8825 *nau8825, long timeout)
 {
@@ -262,8 +263,8 @@ static int nau8825_sema_acquire(struct nau8825 *nau8825, long timeout)
 		if (ret < 0)
 			dev_warn(nau8825->dev, "Acquire semaphore timeout\n");
 	} else {
-		ret = down_interruptible(&nau8825->xtalk_sem);
-		if (ret < 0)
+		ret = down_trylock(&nau8825->xtalk_sem);
+		if (ret)
 			dev_warn(nau8825->dev, "Acquire semaphore fail\n");
 	}
 
@@ -1258,8 +1259,10 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 		regmap_read(nau8825->regmap, NAU8825_REG_DAC_CTRL1, &osr);
 		osr &= NAU8825_DAC_OVERSAMPLE_MASK;
 		if (nau8825_clock_check(nau8825, substream->stream,
-			params_rate(params), osr))
+			params_rate(params), osr)) {
+			nau8825_sema_release(nau8825);
 			return -EINVAL;
+		}
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_DAC_SRC_MASK,
 			osr_dac_sel[osr].clk_src << NAU8825_CLK_DAC_SRC_SFT);
@@ -1267,8 +1270,10 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 		regmap_read(nau8825->regmap, NAU8825_REG_ADC_RATE, &osr);
 		osr &= NAU8825_ADC_SYNC_DOWN_MASK;
 		if (nau8825_clock_check(nau8825, substream->stream,
-			params_rate(params), osr))
+			params_rate(params), osr)) {
+			nau8825_sema_release(nau8825);
 			return -EINVAL;
+		}
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_ADC_SRC_MASK,
 			osr_adc_sel[osr].clk_src << NAU8825_CLK_ADC_SRC_SFT);
@@ -1285,8 +1290,10 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 			bclk_div = 1;
 		else if (bclk_fs <= 128)
 			bclk_div = 0;
-		else
+		else {
+			nau8825_sema_release(nau8825);
 			return -EINVAL;
+		}
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
 			NAU8825_I2S_LRC_DIV_MASK | NAU8825_I2S_BLK_DIV_MASK,
 			((bclk_div + 1) << NAU8825_I2S_LRC_DIV_SFT) | bclk_div);
@@ -1306,6 +1313,7 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 		val_len |= NAU8825_I2S_DL_32;
 		break;
 	default:
+		nau8825_sema_release(nau8825);
 		return -EINVAL;
 	}
 
@@ -1324,8 +1332,6 @@ static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 	unsigned int ctrl1_val = 0, ctrl2_val = 0;
 
-	nau8825_sema_acquire(nau8825, 3 * HZ);
-
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
 		ctrl2_val |= NAU8825_I2S_MS_MASTER;
@@ -1367,6 +1373,8 @@ static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	nau8825_sema_acquire(nau8825, 3 * HZ);
+
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL1,
 		NAU8825_I2S_DL_MASK | NAU8825_I2S_DF_MASK |
 		NAU8825_I2S_BP_MASK | NAU8825_I2S_PCMB_MASK,
@@ -1713,7 +1721,7 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 					int ret;
 					nau8825->xtalk_protect = true;
 					ret = nau8825_sema_acquire(nau8825, 0);
-					if (ret < 0)
+					if (ret)
 						nau8825->xtalk_protect = false;
 				}
 				/* Startup cross talk detection process */
@@ -2399,7 +2407,7 @@ static int __maybe_unused nau8825_resume(struct snd_soc_codec *codec)
 	regcache_sync(nau8825->regmap);
 	nau8825->xtalk_protect = true;
 	ret = nau8825_sema_acquire(nau8825, 0);
-	if (ret < 0)
+	if (ret)
 		nau8825->xtalk_protect = false;
 	enable_irq(nau8825->irq);
 
-- 
2.6.4
