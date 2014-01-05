From: Daniel Matuschek <info@crazy-audio.com>
Subject: [PATCH] Patched to allow fine-grained control of PLL
 and clock dividers
Date: Sun, 5 Jan 2014 20:45:45 +0100
Message-ID: <20140107223047.59BCAE395C@parallels-Parallels-Virtual-Platform>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zhhdzmsp-nwas14.bluewin.ch (nwas14.bluewin.ch [195.186.228.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 25743261692
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 23:30:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Changes:
1. allow the driver to accept S32_LE PCM streams
2. fine-grained control of the PLL generation
WM8804 can run with PLL frequencies of 256xfs and 128xfs for most sample
rates. At 192kHz only 128xfs is supported. The existing driver selects
128xfs automatically for some lower samples rates. By using the "pllid" 
argument of the "set_pll" function is is now possible to control the
behaviour. This allows using 256xfs PLL frequency on all sample rates up
to 96kHz. It should allow lower jitter and better signal quality.
When pllid=0, the behaviour of the driver does not change.

---
 sound/soc/codecs/wm8804.c |   25 +++++++++++++++++--------
 sound/soc/codecs/wm8804.h |    7 +++++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 1704b1e..f3f73b2 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -2,6 +2,7 @@
  * wm8804.c  --  WM8804 S/PDIF transceiver driver
  *
  * Copyright 2010-11 Wolfson Microelectronics plc
+ *  patched by Daniel Matuschek <info@crazyaudio.com> to allow fine-grained
+ *  control of PLL and dividers
  *
  * Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
  *
@@ -277,6 +278,7 @@ static int wm8804_hw_params(struct snd_pcm_substream *substream,
 		blen = 0x1;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
 		blen = 0x2;
 		break;
 	default:
@@ -318,7 +320,7 @@ static struct {
 
 #define FIXED_PLL_SIZE ((1ULL << 22) * 10)
 static int pll_factors(struct pll_div *pll_div, unsigned int target,
-		       unsigned int source)
+		       unsigned int source, int mclk_div)
 {
 	u64 Kpart;
 	unsigned long int K, Ndiv, Nmod, tmp;
@@ -332,9 +334,14 @@ static int pll_factors(struct pll_div *pll_div, unsigned int target,
 		tmp = target * post_table[i].div;
 		if (tmp >= 90000000 && tmp <= 100000000) {
 			pll_div->freqmode = post_table[i].freqmode;
-			pll_div->mclkdiv = post_table[i].mclkdiv;
-			target *= post_table[i].div;
-			break;
+			if ((mclk_div == WM8804_MCLKDIV_DONTCARE) ||
+			    ((post_table[i].mclkdiv == 1) &&
+				(mclk_div == WM8804_MCLKDIV_1)) ||
+			    ((post_table[i].mclkdiv == 0) &&
+				(mclk_div == WM8804_MCLKDIV_0))) {
+				pll_div->mclkdiv = post_table[i].mclkdiv;
+				target *= post_table[i].div;
+				break;
+			}
 		}
 	}
 
@@ -388,7 +395,7 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 		int ret;
 		struct pll_div pll_div;
 
-		ret = pll_factors(&pll_div, freq_out, freq_in);
+		ret = pll_factors(&pll_div, freq_out, freq_in, pll_id);
 		if (ret)
 			return ret;
 
@@ -641,7 +648,8 @@ static const struct snd_soc_dai_ops wm8804_dai_ops = {
 };
 
 #define WM8804_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
-			SNDRV_PCM_FMTBIT_S24_LE)
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE | \
+			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE)
 
 #define WM8804_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
 		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_64000 | \
@@ -674,7 +682,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
 	.suspend = wm8804_suspend,
 	.resume = wm8804_resume,
 	.set_bias_level = wm8804_set_bias_level,
-	.idle_bias_off = true,
+	.idle_bias_off = false,
 
 	.controls = wm8804_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8804_snd_controls),
@@ -760,6 +768,7 @@ static int wm8804_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8804, &wm8804_dai, 1);
+
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wm8804.h b/sound/soc/codecs/wm8804.h
index 8ec14f5..0365177 100644
--- a/sound/soc/codecs/wm8804.h
+++ b/sound/soc/codecs/wm8804.h
@@ -58,4 +58,11 @@
 
 #define WM8804_CLKOUT_DIV			1
 
+#define WM8804_MCLKDIV_DONTCARE			0
+#define WM8804_MCLKDIV_0			1
+#define WM8804_MCLKDIV_1			2
+#define WM8804_PLL_MCLKDIV_DONTCARE		WM8804_MCLKDIV_DONTCARE
+#define WM8804_PLL_MCLKDIV_0			WM8804_MCLKDIV_0
+#define WM8804_PLL_MCLKDIV_1			WM8804_MCLKDIV_1
+
 #endif  /* _WM8804_H */
-- 
1.7.9.5
