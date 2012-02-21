From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] ASoC: twl4030: Debug code cleanup
Date: Tue, 21 Feb 2012 09:34:20 +0200
Message-ID: <1329809660-22077-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 29F56103DA5
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2012 08:34:23 +0100 (CET)
Received: by lamf4 with SMTP id f4so8658197lam.0
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 23:34:20 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Replace the printk(KERN_ERR* instances with dev_err in the driver.
While we are here clean up some of the debug messages as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi Mark,

your branch was ahead of Liam's, and Takashi's asoc tree that is why it failed
to apply cleanly.
I have created this patch against your for-next branch.
There were  one typo fix which caused the git am failure.
No other chganges since v1.

Regards,
Peter

 sound/soc/codecs/twl4030.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index d7eee0d..170cf9a 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1002,8 +1002,8 @@ static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned short mask, bitmask;
 
 	if (twl4030->configured) {
-		printk(KERN_ERR "twl4030 operation mode cannot be "
-			"changed on-the-fly\n");
+		dev_err(codec->dev,
+			"operation mode cannot be changed on-the-fly\n");
 		return -EBUSY;
 	}
 
@@ -1800,7 +1800,7 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 		mode |= TWL4030_APLL_RATE_96000;
 		break;
 	default:
-		printk(KERN_ERR "TWL4030 hw params: unknown rate %d\n",
+		dev_err(codec->dev, "%s: unknown rate %d\n", __func__,
 			params_rate(params));
 		return -EINVAL;
 	}
@@ -1817,7 +1817,7 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 		format |= TWL4030_DATA_WIDTH_32S_24W;
 		break;
 	default:
-		printk(KERN_ERR "TWL4030 hw params: unknown format %d\n",
+		dev_err(codec->dev, "%s: unknown format %d\n", __func__,
 			params_format(params));
 		return -EINVAL;
 	}
@@ -1867,13 +1867,13 @@ static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	case 38400000:
 		break;
 	default:
-		dev_err(codec->dev, "Unsupported APLL mclk: %u\n", freq);
+		dev_err(codec->dev, "Unsupported HFCLKIN: %u\n", freq);
 		return -EINVAL;
 	}
 
 	if ((freq / 1000) != twl4030->sysclk) {
 		dev_err(codec->dev,
-			"Mismatch in APLL mclk: %u (configured: %u)\n",
+			"Mismatch in HFCLKIN: %u (configured: %u)\n",
 			freq, twl4030->sysclk * 1000);
 		return -EINVAL;
 	}
@@ -1983,9 +1983,9 @@ static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 	 * not available.
 	 */
 	if (twl4030->sysclk != 26000) {
-		dev_err(codec->dev, "The board is configured for %u Hz, while"
-			"the Voice interface needs 26MHz APLL mclk\n",
-			twl4030->sysclk * 1000);
+		dev_err(codec->dev,
+			"%s: HFCLKIN is %u KHz, voice interface needs 26MHz\n",
+			__func__, twl4030->sysclk);
 		return -EINVAL;
 	}
 
@@ -1996,8 +1996,8 @@ static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 		& TWL4030_OPT_MODE;
 
 	if (mode != TWL4030_OPTION_2) {
-		printk(KERN_ERR "TWL4030 voice startup: "
-			"the codec mode is not option2\n");
+		dev_err(codec->dev, "%s: the codec mode is not option2\n",
+			__func__);
 		return -EINVAL;
 	}
 
@@ -2038,7 +2038,7 @@ static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 		mode |= TWL4030_SEL_16K;
 		break;
 	default:
-		printk(KERN_ERR "TWL4030 voice hw params: unknown rate %d\n",
+		dev_err(codec->dev, "%s: unknown rate %d\n", __func__,
 			params_rate(params));
 		return -EINVAL;
 	}
@@ -2067,13 +2067,14 @@ static int twl4030_voice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	if (freq != 26000000) {
-		dev_err(codec->dev, "Unsupported APLL mclk: %u, the Voice"
-			"interface needs 26MHz APLL mclk\n", freq);
+		dev_err(codec->dev,
+			"%s: HFCLKIN is %u KHz, voice interface needs 26MHz\n",
+			__func__, freq / 1000);
 		return -EINVAL;
 	}
 	if ((freq / 1000) != twl4030->sysclk) {
 		dev_err(codec->dev,
-			"Mismatch in APLL mclk: %u (configured: %u)\n",
+			"Mismatch in HFCLKIN: %u (configured: %u)\n",
 			freq, twl4030->sysclk * 1000);
 		return -EINVAL;
 	}
@@ -2221,7 +2222,7 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 
 	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
 	if (twl4030 == NULL) {
-		printk("Can not allocate memory\n");
+		dev_err(codec->dev, "Can not allocate memory\n");
 		return -ENOMEM;
 	}
 	snd_soc_codec_set_drvdata(codec, twl4030);
-- 
1.7.8.4
