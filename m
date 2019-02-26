From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 3/7] ASoC: stm32: i2s: fix stream count management
Date: Tue, 26 Feb 2019 14:51:06 +0100
Message-ID: <1551189070-15469-4-git-send-email-olivier.moysan@st.com>
References: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Move counter handling to trigger start section
to manage multiple start/stop events.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 7d4c67433916..7f56d7b51ba3 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -554,10 +554,6 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	spin_lock(&i2s->lock_fd);
-	i2s->refcount++;
-	spin_unlock(&i2s->lock_fd);
-
 	return regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
 				 I2S_IFCR_MASK, I2S_IFCR_MASK);
 }
@@ -613,18 +609,19 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
 				  I2S_IFCR_MASK, I2S_IFCR_MASK);
 
+		spin_lock(&i2s->lock_fd);
+		i2s->refcount++;
 		if (playback_flg) {
 			ier = I2S_IER_UDRIE;
 		} else {
 			ier = I2S_IER_OVRIE;
 
-			spin_lock(&i2s->lock_fd);
 			if (i2s->refcount == 1)
 				/* dummy write to trigger capture */
 				regmap_write(i2s->regmap,
 					     STM32_I2S_TXDR_REG, 0);
-			spin_unlock(&i2s->lock_fd);
 		}
+		spin_unlock(&i2s->lock_fd);
 
 		if (STM32_I2S_IS_SLAVE(i2s))
 			ier |= I2S_IER_TIFREIE;
@@ -649,7 +646,6 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			spin_unlock(&i2s->lock_fd);
 			break;
 		}
-		spin_unlock(&i2s->lock_fd);
 
 		dev_dbg(cpu_dai->dev, "stop I2S\n");
 
@@ -657,8 +653,10 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 					 I2S_CR1_SPE, 0);
 		if (ret < 0) {
 			dev_err(cpu_dai->dev, "Error %d disabling I2S\n", ret);
+			spin_unlock(&i2s->lock_fd);
 			return ret;
 		}
+		spin_unlock(&i2s->lock_fd);
 
 		cfg1_mask = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
 		regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
-- 
2.7.4
