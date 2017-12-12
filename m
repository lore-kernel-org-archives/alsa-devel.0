From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 03/10] ASoC: tlv320aic32x4: Drop define mapping
	from number to number
Date: Tue, 12 Dec 2017 16:43:04 -0600
Message-ID: <20171212224311.24045-3-afd@ti.com>
References: <20171212224311.24045-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 92A802671F3
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 23:43:14 +0100 (CET)
In-Reply-To: <20171212224311.24045-1-afd@ti.com>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Drop definition of frequencies that only map from one number to
the same number. This is not needed and if misused can hide
bugs.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 46 ++++++++++++++++++++--------------------
 sound/soc/codecs/tlv320aic32x4.h |  4 ----
 2 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index c0ccf3f23a04..e37ab968a938 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -265,34 +265,34 @@ static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 
 static const struct aic32x4_rate_divs aic32x4_divs[] = {
 	/* 8k rate */
-	{AIC32X4_FREQ_12000000, 8000, 1, 7, 6800, 768, 5, 3, 128, 5, 18, 24},
-	{AIC32X4_FREQ_24000000, 8000, 2, 7, 6800, 768, 15, 1, 64, 45, 4, 24},
-	{AIC32X4_FREQ_25000000, 8000, 2, 7, 3728, 768, 15, 1, 64, 45, 4, 24},
+	{12000000, 8000, 1, 7, 6800, 768, 5, 3, 128, 5, 18, 24},
+	{24000000, 8000, 2, 7, 6800, 768, 15, 1, 64, 45, 4, 24},
+	{25000000, 8000, 2, 7, 3728, 768, 15, 1, 64, 45, 4, 24},
 	/* 11.025k rate */
-	{AIC32X4_FREQ_12000000, 11025, 1, 7, 5264, 512, 8, 2, 128, 8, 8, 16},
-	{AIC32X4_FREQ_24000000, 11025, 2, 7, 5264, 512, 16, 1, 64, 32, 4, 16},
+	{12000000, 11025, 1, 7, 5264, 512, 8, 2, 128, 8, 8, 16},
+	{24000000, 11025, 2, 7, 5264, 512, 16, 1, 64, 32, 4, 16},
 	/* 16k rate */
-	{AIC32X4_FREQ_12000000, 16000, 1, 7, 6800, 384, 5, 3, 128, 5, 9, 12},
-	{AIC32X4_FREQ_24000000, 16000, 2, 7, 6800, 384, 15, 1, 64, 18, 5, 12},
-	{AIC32X4_FREQ_25000000, 16000, 2, 7, 3728, 384, 15, 1, 64, 18, 5, 12},
+	{12000000, 16000, 1, 7, 6800, 384, 5, 3, 128, 5, 9, 12},
+	{24000000, 16000, 2, 7, 6800, 384, 15, 1, 64, 18, 5, 12},
+	{25000000, 16000, 2, 7, 3728, 384, 15, 1, 64, 18, 5, 12},
 	/* 22.05k rate */
-	{AIC32X4_FREQ_12000000, 22050, 1, 7, 5264, 256, 4, 4, 128, 4, 8, 8},
-	{AIC32X4_FREQ_24000000, 22050, 2, 7, 5264, 256, 16, 1, 64, 16, 4, 8},
-	{AIC32X4_FREQ_25000000, 22050, 2, 7, 2253, 256, 16, 1, 64, 16, 4, 8},
+	{12000000, 22050, 1, 7, 5264, 256, 4, 4, 128, 4, 8, 8},
+	{24000000, 22050, 2, 7, 5264, 256, 16, 1, 64, 16, 4, 8},
+	{25000000, 22050, 2, 7, 2253, 256, 16, 1, 64, 16, 4, 8},
 	/* 32k rate */
-	{AIC32X4_FREQ_12000000, 32000, 1, 7, 1680, 192, 2, 7, 64, 2, 21, 6},
-	{AIC32X4_FREQ_24000000, 32000, 2, 7, 1680, 192, 7, 2, 64, 7, 6, 6},
+	{12000000, 32000, 1, 7, 1680, 192, 2, 7, 64, 2, 21, 6},
+	{24000000, 32000, 2, 7, 1680, 192, 7, 2, 64, 7, 6, 6},
 	/* 44.1k rate */
-	{AIC32X4_FREQ_12000000, 44100, 1, 7, 5264, 128, 2, 8, 128, 2, 8, 4},
-	{AIC32X4_FREQ_24000000, 44100, 2, 7, 5264, 128, 8, 2, 64, 8, 4, 4},
-	{AIC32X4_FREQ_25000000, 44100, 2, 7, 2253, 128, 8, 2, 64, 8, 4, 4},
+	{12000000, 44100, 1, 7, 5264, 128, 2, 8, 128, 2, 8, 4},
+	{24000000, 44100, 2, 7, 5264, 128, 8, 2, 64, 8, 4, 4},
+	{25000000, 44100, 2, 7, 2253, 128, 8, 2, 64, 8, 4, 4},
 	/* 48k rate */
-	{AIC32X4_FREQ_12000000, 48000, 1, 8, 1920, 128, 2, 8, 128, 2, 8, 4},
-	{AIC32X4_FREQ_24000000, 48000, 2, 8, 1920, 128, 8, 2, 64, 8, 4, 4},
-	{AIC32X4_FREQ_25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4},
+	{12000000, 48000, 1, 8, 1920, 128, 2, 8, 128, 2, 8, 4},
+	{24000000, 48000, 2, 8, 1920, 128, 8, 2, 64, 8, 4, 4},
+	{25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4},
 
 	/* 96k rate */
-	{AIC32X4_FREQ_25000000, 96000, 2, 7, 8643, 64, 4, 4, 64, 4, 4, 1},
+	{25000000, 96000, 2, 7, 8643, 64, 4, 4, 64, 4, 4, 1},
 };
 
 static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
@@ -585,9 +585,9 @@ static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
 
 	switch (freq) {
-	case AIC32X4_FREQ_12000000:
-	case AIC32X4_FREQ_24000000:
-	case AIC32X4_FREQ_25000000:
+	case 12000000:
+	case 24000000:
+	case 25000000:
 		aic32x4->sysclk = freq;
 		return 0;
 	}
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 1255f8a30fbd..1e3d1e04888a 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -90,10 +90,6 @@ int aic32x4_remove(struct device *dev);
 #define AIC32X4_LMICPGAVOL	AIC32X4_REG(1, 59)
 #define AIC32X4_RMICPGAVOL	AIC32X4_REG(1, 60)
 
-#define AIC32X4_FREQ_12000000 12000000
-#define AIC32X4_FREQ_24000000 24000000
-#define AIC32X4_FREQ_25000000 25000000
-
 #define AIC32X4_WORD_LEN_16BITS		0x00
 #define AIC32X4_WORD_LEN_20BITS		0x01
 #define AIC32X4_WORD_LEN_24BITS		0x02
-- 
2.15.0
