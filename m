From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 2/8] ASoC: TWL4030: Remove wrapper for power
	down
Date: Wed, 26 May 2010 11:38:15 +0300
Message-ID: <1274863101-18514-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id BC200103943
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 10:38:42 +0200 (CEST)
In-Reply-To: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

There is no need for the power down wrapper.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 9a3e999..1e0aba5 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -319,15 +319,6 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 	twl4030_codec_enable(codec, 1);
 }

-/*
- * Unconditional power down
- */
-static void twl4030_power_down(struct snd_soc_codec *codec)
-{
-	/* power down */
-	twl4030_codec_enable(codec, 0);
-}
-
 /* Earpiece */
 static const struct snd_kcontrol_new twl4030_dapm_earpiece_controls[] = {
 	SOC_DAPM_SINGLE("Voice", TWL4030_REG_EAR_CTL, 0, 1, 0),
@@ -1607,7 +1598,7 @@ static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 			twl4030_power_up(codec);
 		break;
 	case SND_SOC_BIAS_OFF:
-		twl4030_power_down(codec);
+		twl4030_codec_enable(codec, 0);
 		break;
 	}
 	codec->bias_level = level;
@@ -2321,7 +2312,7 @@ static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 	return 0;

 error_codec:
-	twl4030_power_down(codec);
+	twl4030_codec_enable(codec, 0);
 	kfree(codec->reg_cache);
 error_cache:
 	kfree(twl4030);
--
1.7.1
