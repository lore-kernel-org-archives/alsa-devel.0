From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 18/23] ASoC: tas2552: Configure the WCLK
	frequency based on the stream
Date: Thu, 4 Jun 2015 16:04:30 +0300
Message-ID: <1433423075-14142-19-git-send-email-peter.ujfalusi@ti.com>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 15DA9266572
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:05:20 +0200 (CEST)
In-Reply-To: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Instead of hard wiring the WCLK frequency at probe time do it runtime.
The hard wired 88_96KHz was not even setting the correct bits since it was
defined as (1 << 6) which will  change the I2S_OUT_SEL bit and will leave
the amplifier configured for 8KHz.
At the same time clean up and fix the CFG3 register bits.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/tas2552.h | 37 ++++++++++++++++++-------------------
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 13b435f9a9b1..891e2c529df3 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -168,7 +168,7 @@ static int tas2552_hw_params(struct snd_pcm_substream *substream,
 	int d;
 	int cpf;
 	u8 p, j;
-	u8 ser_ctrl1_reg;
+	u8 ser_ctrl1_reg, wclk_rate;
 
 	switch (params_width(params)) {
 	case 16:
@@ -206,6 +206,45 @@ static int tas2552_hw_params(struct snd_pcm_substream *substream,
 			    TAS2552_WORDLENGTH_MASK | TAS2552_CLKSPERFRAME_MASK,
 			    ser_ctrl1_reg);
 
+	switch (params_rate(params)) {
+	case 8000:
+		wclk_rate = TAS2552_WCLK_FREQ_8KHZ;
+		break;
+	case 11025:
+	case 12000:
+		wclk_rate = TAS2552_WCLK_FREQ_11_12KHZ;
+		break;
+	case 16000:
+		wclk_rate = TAS2552_WCLK_FREQ_16KHZ;
+		break;
+	case 22050:
+	case 24000:
+		wclk_rate = TAS2552_WCLK_FREQ_22_24KHZ;
+		break;
+	case 32000:
+		wclk_rate = TAS2552_WCLK_FREQ_32KHZ;
+		break;
+	case 44100:
+	case 48000:
+		wclk_rate = TAS2552_WCLK_FREQ_44_48KHZ;
+		break;
+	case 88200:
+	case 96000:
+		wclk_rate = TAS2552_WCLK_FREQ_88_96KHZ;
+		break;
+	case 176400:
+	case 192000:
+		wclk_rate = TAS2552_WCLK_FREQ_176_192KHZ;
+		break;
+	default:
+		dev_err(codec->dev, "Not supported sample rate: %d\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, TAS2552_CFG_3, TAS2552_WCLK_FREQ_MASK,
+			    wclk_rate);
+
 	if (!tas2552->pll_clkin)
 		return -EINVAL;
 
@@ -503,7 +542,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 
 	snd_soc_update_bits(codec, TAS2552_CFG_1, TAS2552_MUTE, TAS2552_MUTE);
 	snd_soc_write(codec, TAS2552_CFG_3, TAS2552_I2S_OUT_SEL |
-				TAS2552_DIN_SRC_SEL_AVG_L_R | TAS2552_88_96KHZ);
+					    TAS2552_DIN_SRC_SEL_AVG_L_R);
 	snd_soc_write(codec, TAS2552_DOUT, TAS2552_PDM_DATA_I);
 	snd_soc_write(codec, TAS2552_OUTPUT_DATA, TAS2552_PDM_DATA_V_I | 0x8);
 	snd_soc_write(codec, TAS2552_BOOST_PT_CTRL, TAS2552_APT_DELAY_200 |
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index de0ab0d27520..bbb820495516 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -62,6 +62,24 @@
 #define TAS2552_LIM_EN			(1 << 2)
 #define TAS2552_IVSENSE_EN		(1 << 1)
 
+/* CFG3 Register Masks */
+#define TAS2552_WCLK_FREQ_8KHZ		(0x0 << 0)
+#define TAS2552_WCLK_FREQ_11_12KHZ	(0x1 << 0)
+#define TAS2552_WCLK_FREQ_16KHZ		(0x2 << 0)
+#define TAS2552_WCLK_FREQ_22_24KHZ	(0x3 << 0)
+#define TAS2552_WCLK_FREQ_32KHZ		(0x4 << 0)
+#define TAS2552_WCLK_FREQ_44_48KHZ	(0x5 << 0)
+#define TAS2552_WCLK_FREQ_88_96KHZ	(0x6 << 0)
+#define TAS2552_WCLK_FREQ_176_192KHZ	(0x7 << 0)
+#define TAS2552_WCLK_FREQ_MASK		TAS2552_WCLK_FREQ_176_192KHZ
+#define TAS2552_DIN_SRC_SEL_MUTED	(0x0 << 3)
+#define TAS2552_DIN_SRC_SEL_LEFT	(0x1 << 3)
+#define TAS2552_DIN_SRC_SEL_RIGHT	(0x2 << 3)
+#define TAS2552_DIN_SRC_SEL_AVG_L_R	(0x3 << 3)
+#define TAS2552_PDM_IN_SEL		(1 << 5)
+#define TAS2552_I2S_OUT_SEL		(1 << 6)
+#define TAS2552_ANALOG_IN_SEL		(1 << 7)
+
 /* DOUT Register Masks */
 #define TAS2552_SDOUT_TRISTATE		(1 << 2)
 
@@ -84,25 +102,6 @@
 #define TAS2552_BCLKDIR			(1 << 6)
 #define TAS2552_WCLKDIR			(1 << 7)
 
-#define TAS2552_DIN_SRC_SEL_MUTED	0x00
-#define TAS2552_DIN_SRC_SEL_LEFT	(1 << 4)
-#define TAS2552_DIN_SRC_SEL_RIGHT	(1 << 5)
-#define TAS2552_DIN_SRC_SEL_AVG_L_R	(0x11 << 4)
-
-#define TAS2552_PDM_IN_SEL		(1 << 5)
-#define TAS2552_I2S_OUT_SEL		(1 << 6)
-#define TAS2552_ANALOG_IN_SEL	(1 << 7)
-
-/* CFG3 WCLK Dividers */
-#define TAS2552_8KHZ		0x00
-#define TAS2552_11_12KHZ	(1 << 1)
-#define TAS2552_16KHZ		(1 << 2)
-#define TAS2552_22_24KHZ	(1 << 3)
-#define TAS2552_32KHZ		(1 << 4)
-#define TAS2552_44_48KHZ	(1 << 5)
-#define TAS2552_88_96KHZ	(1 << 6)
-#define TAS2552_176_192KHZ	(1 << 7)
-
 /* OUTPUT_DATA register */
 #define TAS2552_PDM_DATA_I		0x00
 #define TAS2552_PDM_DATA_V		(1 << 6)
-- 
2.4.2
