From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/5] ASoC: da7213: Add checking of SRM lock status before
 enabling DAI
Date: Tue, 10 May 2016 16:11:05 +0100
Message-ID: <5e2ccd9429829fc8cacf94ee8595efa6d11834f4.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

When the codec is DAI clk slave, and the SRM feature of the PLL
is being used, the enabling of the DAI should occur only after
the PLL has locked to the incoming WCLK. This update adds checking
to the the DAI widget event, so it waits for SRM to lock. There is
also a timeout if that lock doesn't occur within a given time.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 23 +++++++++++++++++++++++
 sound/soc/codecs/da7213.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 701bd62..680d111 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -734,6 +734,9 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
+	u8 pll_ctrl, pll_status;
+	int i = 0;
+	bool srm_lock = false;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -742,6 +745,26 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 			snd_soc_update_bits(codec, DA7213_DAI_CLK_MODE,
 					    DA7213_DAI_CLK_EN_MASK,
 					    DA7213_DAI_CLK_EN_MASK);
+
+		/* Slave mode, if SRM not enabled no need for status checks */
+		pll_ctrl = snd_soc_read(codec, DA7213_PLL_CTRL);
+		if (!(pll_ctrl & DA7213_PLL_SRM_EN))
+			return 0;
+
+		/* Check SRM has locked */
+		do {
+			pll_status = snd_soc_read(codec, DA7213_PLL_STATUS);
+			if (pll_status & DA7219_PLL_SRM_LOCK) {
+				srm_lock = true;
+			} else {
+				++i;
+				msleep(50);
+			}
+		} while ((i < DA7213_SRM_CHECK_RETRIES) & (!srm_lock));
+
+		if (!srm_lock)
+			dev_warn(codec->dev, "SRM failed to lock\n");
+
 		return 0;
 	case SND_SOC_DAPM_POST_PMD:
 		/* Disable DAI clks if in master mode */
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 5de5c29..af75340 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -142,6 +142,9 @@
  * Bit fields
  */
 
+/* DA7213_PLL_STATUS = 0x03 */
+#define DA7219_PLL_SRM_LOCK					(0x1 << 1)
+
 /* DA7213_SR = 0x22 */
 #define DA7213_SR_8000						(0x1 << 0)
 #define DA7213_SR_11025						(0x2 << 0)
@@ -502,6 +505,7 @@
 #define DA7213_PLL_INDIV_10_20_MHZ_VAL	4
 #define DA7213_PLL_INDIV_20_40_MHZ_VAL	8
 #define DA7213_PLL_INDIV_40_54_MHZ_VAL	16
+#define DA7213_SRM_CHECK_RETRIES	8
 
 enum da7213_clk_src {
 	DA7213_CLKSRC_MCLK = 0,
-- 
1.9.3
