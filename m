From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] ASoC: cs42l56: Fix new value argument in
 snd_soc_update_bits calls
Date: Fri, 23 May 2014 08:51:42 +0800
Message-ID: <1400806302.21451.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f174.google.com (mail-ve0-f174.google.com
 [209.85.128.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 32D87265614
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 02:51:50 +0200 (CEST)
Received: by mail-ve0-f174.google.com with SMTP id jw12so5429230veb.19
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 17:51:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The new value argument needs proper shift to match the mask bit fields.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l56.c | 68 +++++++++++++++++++++-------------------------
 sound/soc/codecs/cs42l56.h | 13 +++++----
 2 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 5bb134b..5d7a800 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -763,14 +763,14 @@ static int cs42l56_set_sysclk(struct snd_soc_dai *codec_dai,
 	case CS42L56_MCLK_11P2896MHZ:
 	case CS42L56_MCLK_12MHZ:
 	case CS42L56_MCLK_12P288MHZ:
-		cs42l56->mclk_div2 = 1;
+		cs42l56->mclk_div2 = CS42L56_MCLK_DIV2;
 		cs42l56->mclk_prediv = 0;
 		break;
 	case CS42L56_MCLK_22P5792MHZ:
 	case CS42L56_MCLK_24MHZ:
 	case CS42L56_MCLK_24P576MHZ:
-		cs42l56->mclk_div2 = 1;
-		cs42l56->mclk_prediv = 1;
+		cs42l56->mclk_div2 = CS42L56_MCLK_DIV2;
+		cs42l56->mclk_prediv = CS42L56_MCLK_PREDIV;
 		break;
 	default:
 		return -EINVAL;
@@ -844,57 +844,51 @@ static int cs42l56_digital_mute(struct snd_soc_dai *dai, int mute)
 		/* Hit the DSP Mixer first */
 		snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
 				    CS42L56_ADCAMIX_MUTE_MASK |
-				CS42L56_ADCBMIX_MUTE_MASK |
-				CS42L56_PCMAMIX_MUTE_MASK |
-				CS42L56_PCMBMIX_MUTE_MASK |
-				CS42L56_MSTB_MUTE_MASK |
-				CS42L56_MSTA_MUTE_MASK,
-				CS42L56_MUTE);
+				    CS42L56_ADCBMIX_MUTE_MASK |
+				    CS42L56_PCMAMIX_MUTE_MASK |
+				    CS42L56_PCMBMIX_MUTE_MASK |
+				    CS42L56_MSTB_MUTE_MASK |
+				    CS42L56_MSTA_MUTE_MASK,
+				    CS42L56_MUTE_ALL_DSP);
 		/* Mute ADC's */
 		snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL,
-				CS42L56_ADCA_MUTE_MASK |
-				CS42L56_ADCB_MUTE_MASK,
-				CS42L56_MUTE);
+				    CS42L56_ADCA_MUTE_MASK |
+				    CS42L56_ADCB_MUTE_MASK,
+				    CS42L56_MUTE_ALL_ADC);
 		/* HP And LO */
 		snd_soc_update_bits(codec, CS42L56_HPA_VOLUME,
-				CS42L56_HP_MUTE_MASK,
-				CS42L56_MUTE);
+				    CS42L56_HP_MUTE_MASK, CS42L56_HP_MUTE_MASK);
 		snd_soc_update_bits(codec, CS42L56_HPB_VOLUME,
-				CS42L56_HP_MUTE_MASK,
-				CS42L56_MUTE);
+				    CS42L56_HP_MUTE_MASK, CS42L56_HP_MUTE_MASK);
 		snd_soc_update_bits(codec, CS42L56_LOA_VOLUME,
-				CS42L56_LO_MUTE_MASK,
-				CS42L56_MUTE);
+				    CS42L56_LO_MUTE_MASK, CS42L56_LO_MUTE_MASK);
 		snd_soc_update_bits(codec, CS42L56_LOB_VOLUME,
-				CS42L56_LO_MUTE_MASK,
-				CS42L56_MUTE);
+				    CS42L56_LO_MUTE_MASK, CS42L56_LO_MUTE_MASK);
 
 
 	} else {
 		snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
 				    CS42L56_ADCAMIX_MUTE_MASK |
-				CS42L56_ADCBMIX_MUTE_MASK |
-				CS42L56_PCMAMIX_MUTE_MASK |
-				CS42L56_PCMBMIX_MUTE_MASK |
-				CS42L56_MSTB_MUTE_MASK |
-				CS42L56_MSTA_MUTE_MASK,
-				CS42L56_UNMUTE);
+				    CS42L56_ADCBMIX_MUTE_MASK |
+				    CS42L56_PCMAMIX_MUTE_MASK |
+				    CS42L56_PCMBMIX_MUTE_MASK |
+				    CS42L56_MSTB_MUTE_MASK |
+				    CS42L56_MSTA_MUTE_MASK,
+				    CS42L56_UNMUTE);
+
 		snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL,
-				CS42L56_ADCA_MUTE_MASK |
-				CS42L56_ADCB_MUTE_MASK,
-				CS42L56_UNMUTE);
+				    CS42L56_ADCA_MUTE_MASK |
+				    CS42L56_ADCB_MUTE_MASK,
+				    CS42L56_UNMUTE);
+
 		snd_soc_update_bits(codec, CS42L56_HPA_VOLUME,
-				CS42L56_HP_MUTE_MASK,
-				CS42L56_UNMUTE);
+				    CS42L56_HP_MUTE_MASK, CS42L56_UNMUTE);
 		snd_soc_update_bits(codec, CS42L56_HPB_VOLUME,
-				CS42L56_HP_MUTE_MASK,
-				CS42L56_UNMUTE);
+				    CS42L56_HP_MUTE_MASK, CS42L56_UNMUTE);
 		snd_soc_update_bits(codec, CS42L56_LOA_VOLUME,
-				CS42L56_LO_MUTE_MASK,
-				CS42L56_UNMUTE);
+				    CS42L56_LO_MUTE_MASK, CS42L56_UNMUTE);
 		snd_soc_update_bits(codec, CS42L56_LOB_VOLUME,
-				CS42L56_LO_MUTE_MASK,
-				CS42L56_UNMUTE);
+				    CS42L56_LO_MUTE_MASK, CS42L56_UNMUTE);
 	}
 	return 0;
 }
diff --git a/sound/soc/codecs/cs42l56.h b/sound/soc/codecs/cs42l56.h
index ad2b50a..3fb73dc 100644
--- a/sound/soc/codecs/cs42l56.h
+++ b/sound/soc/codecs/cs42l56.h
@@ -80,19 +80,21 @@
 #define CS42L56_PDN_HPB_MASK		0xc0
 
 /* serial port and clk masks */
-#define CS42L56_MASTER_MODE		1
+#define CS42L56_MASTER_MODE		0x40
 #define CS42L56_SLAVE_MODE		0
 #define CS42L56_MS_MODE_MASK		0x40
-#define CS42L56_SCLK_INV		1
+#define CS42L56_SCLK_INV		0x20
 #define CS42L56_SCLK_INV_MASK		0x20
 #define CS42L56_SCLK_MCLK_MASK		0x18
+#define CS42L56_MCLK_PREDIV		0x04
 #define CS42L56_MCLK_PREDIV_MASK	0x04
+#define CS42L56_MCLK_DIV2		0x02
 #define CS42L56_MCLK_DIV2_MASK		0x02
 #define CS42L56_MCLK_DIS_MASK		0x01
 #define CS42L56_CLK_AUTO_MASK		0x20
 #define CS42L56_CLK_RATIO_MASK		0x1f
 #define CS42L56_DIG_FMT_I2S		0
-#define CS42L56_DIG_FMT_LEFT_J		1
+#define CS42L56_DIG_FMT_LEFT_J		0x08
 #define CS42L56_DIG_FMT_MASK		0x08
 
 /* Class H and misc ctl masks */
@@ -116,8 +118,6 @@
 #define CS42L56_DEEMPH_MASK		0x40
 #define CS42L56_PLYBCK_GANG_MASK	0x10
 #define CS42L56_PCM_INV_MASK		0x0c
-#define CS42L56_MUTE			1
-#define CS42L56_UNMUTE			0
 #define CS42L56_ADCAMIX_MUTE_MASK	0x40
 #define CS42L56_ADCBMIX_MUTE_MASK	0x80
 #define CS42L56_PCMAMIX_MUTE_MASK	0x10
@@ -128,6 +128,9 @@
 #define CS42L56_ADCB_MUTE_MASK		0x02
 #define CS42L56_HP_MUTE_MASK		0x80
 #define CS42L56_LO_MUTE_MASK		0x80
+#define CS42L56_MUTE_ALL_DSP		0xf3
+#define CS42L56_MUTE_ALL_ADC		0x03
+#define CS42L56_UNMUTE			0
 
 /* Beep masks */
 #define CS42L56_BEEP_FREQ_MASK		0xf0
-- 
1.8.3.2
