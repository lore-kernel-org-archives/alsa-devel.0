From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: correct typo of semaphore
	comment
Date: Fri, 25 Aug 2017 11:35:44 +0800
Message-ID: <1503632144-32732-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 21D3F266998
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 05:35:51 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

There are a lot of typo about semaphore in the comment.
Correct it from semaphone to semaphore.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 000aa79..714ce17 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -260,11 +260,11 @@ static int nau8825_sema_acquire(struct nau8825 *nau8825, long timeout)
 	if (timeout) {
 		ret = down_timeout(&nau8825->xtalk_sem, timeout);
 		if (ret < 0)
-			dev_warn(nau8825->dev, "Acquire semaphone timeout\n");
+			dev_warn(nau8825->dev, "Acquire semaphore timeout\n");
 	} else {
 		ret = down_interruptible(&nau8825->xtalk_sem);
 		if (ret < 0)
-			dev_warn(nau8825->dev, "Acquire semaphone fail\n");
+			dev_warn(nau8825->dev, "Acquire semaphore fail\n");
 	}
 
 	return ret;
@@ -1299,7 +1299,7 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL1,
 		NAU8825_I2S_DL_MASK, val_len);
 
-	/* Release the semaphone. */
+	/* Release the semaphore. */
 	nau8825_sema_release(nau8825);
 
 	return 0;
@@ -1361,7 +1361,7 @@ static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
 		NAU8825_I2S_MS_MASK, ctrl2_val);
 
-	/* Release the semaphone. */
+	/* Release the semaphore. */
 	nau8825_sema_release(nau8825);
 
 	return 0;
@@ -2140,7 +2140,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 
 		break;
 	case NAU8825_CLK_MCLK:
-		/* Acquire the semaphone to synchronize the playback and
+		/* Acquire the semaphore to synchronize the playback and
 		 * interrupt handler. In order to avoid the playback inter-
 		 * fered by cross talk process, the driver make the playback
 		 * preparation halted until cross talk process finish.
@@ -2150,7 +2150,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		/* MCLK not changed by clock tree */
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_MCLK_SRC_MASK, 0);
-		/* Release the semaphone. */
+		/* Release the semaphore. */
 		nau8825_sema_release(nau8825);
 
 		ret = nau8825_mclk_prepare(nau8825, freq);
@@ -2188,7 +2188,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 
 		break;
 	case NAU8825_CLK_FLL_MCLK:
-		/* Acquire the semaphone to synchronize the playback and
+		/* Acquire the semaphore to synchronize the playback and
 		 * interrupt handler. In order to avoid the playback inter-
 		 * fered by cross talk process, the driver make the playback
 		 * preparation halted until cross talk process finish.
@@ -2201,7 +2201,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		regmap_update_bits(regmap, NAU8825_REG_FLL3,
 			NAU8825_FLL_CLK_SRC_MASK | NAU8825_GAIN_ERR_MASK,
 			NAU8825_FLL_CLK_SRC_MCLK | 0);
-		/* Release the semaphone. */
+		/* Release the semaphore. */
 		nau8825_sema_release(nau8825);
 
 		ret = nau8825_mclk_prepare(nau8825, freq);
@@ -2210,7 +2210,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 
 		break;
 	case NAU8825_CLK_FLL_BLK:
-		/* Acquire the semaphone to synchronize the playback and
+		/* Acquire the semaphore to synchronize the playback and
 		 * interrupt handler. In order to avoid the playback inter-
 		 * fered by cross talk process, the driver make the playback
 		 * preparation halted until cross talk process finish.
@@ -2226,7 +2226,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 			NAU8825_FLL_CLK_SRC_MASK | NAU8825_GAIN_ERR_MASK,
 			NAU8825_FLL_CLK_SRC_BLK |
 			(0xf << NAU8825_GAIN_ERR_SFT));
-		/* Release the semaphone. */
+		/* Release the semaphore. */
 		nau8825_sema_release(nau8825);
 
 		if (nau8825->mclk_freq) {
@@ -2236,7 +2236,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 
 		break;
 	case NAU8825_CLK_FLL_FS:
-		/* Acquire the semaphone to synchronize the playback and
+		/* Acquire the semaphore to synchronize the playback and
 		 * interrupt handler. In order to avoid the playback inter-
 		 * fered by cross talk process, the driver make the playback
 		 * preparation halted until cross talk process finish.
@@ -2252,7 +2252,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 			NAU8825_FLL_CLK_SRC_MASK | NAU8825_GAIN_ERR_MASK,
 			NAU8825_FLL_CLK_SRC_FS |
 			(0xf << NAU8825_GAIN_ERR_SFT));
-		/* Release the semaphone. */
+		/* Release the semaphore. */
 		nau8825_sema_release(nau8825);
 
 		if (nau8825->mclk_freq) {
@@ -2563,7 +2563,7 @@ static int nau8825_i2c_probe(struct i2c_client *i2c,
 		return PTR_ERR(nau8825->regmap);
 	nau8825->dev = dev;
 	nau8825->irq = i2c->irq;
-	/* Initiate parameters, semaphone and work queue which are needed in
+	/* Initiate parameters, semaphore and work queue which are needed in
 	 * cross talk suppression measurment function.
 	 */
 	nau8825->xtalk_state = NAU8825_XTALK_DONE;
-- 
2.6.4
