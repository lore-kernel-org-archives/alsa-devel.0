From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] sound: soc: jz4740: Add support for
	multichannel audio on JZ4780
Date: Fri, 25 Jan 2019 17:30:09 -0300
Message-ID: <20190125203009.24301-2-paul@crapouillou.net>
References: <20190125203009.24301-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from crapouillou.net (outils.crapouillou.net [89.234.176.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 583EA2666B3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:30:22 +0100 (CET)
In-Reply-To: <20190125203009.24301-1-paul@crapouillou.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The jz4780 SoC offers the possibility to configure the number of
channels used for playback. Right now, the corresponding bits in the
configuration register are always zero, which means that the hardware is
only configured for monaural sound.

With this commit, the hardware is now correctly configured for the
number of channels requested by ALSA.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/jz4740-i2s.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index e099c0505b76..05a9d7c20fb0 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -65,6 +65,7 @@
 #define JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_MASK \
 			(0x1f <<  JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET)
 
+#define JZ_AIC_CTRL_CHANNELS_MASK (0x7 << 24)
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
 #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
@@ -81,6 +82,7 @@
 #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
 #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
 
+#define JZ_AIC_CTRL_CHANNELS_OFFSET 24
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
 
@@ -287,6 +289,12 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		else
 			ctrl &= ~JZ_AIC_CTRL_MONO_TO_STEREO;
 
+		if (i2s->version >= JZ_I2S_JZ4780) {
+			ctrl &= ~JZ_AIC_CTRL_CHANNELS_MASK;
+			ctrl |= (params_channels(params) - 1) <<
+				JZ_AIC_CTRL_CHANNELS_OFFSET;
+		}
+
 		div_reg &= ~I2SDIV_DV_MASK;
 		div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
 	} else {
-- 
2.11.0
