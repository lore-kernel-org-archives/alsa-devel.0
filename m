From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Remove unneeded suspend bias
	managment from CODEC drivers
Date: Sun,  9 May 2010 13:08:34 +0100
Message-ID: <1273406918-17007-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100509120741.GA16918@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B69E424593
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 14:08:42 +0200 (CEST)
In-Reply-To: <20100509120741.GA16918@sirena.org.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The core will ensure that the device is in either STANDBY or OFF bias
before suspending, restoring the bias in the driver is unneeded. Some
drivers doing slightly more roundabout things have been left alone
for now.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4535.c      |    1 -
 sound/soc/codecs/cq93vc.c      |    2 +-
 sound/soc/codecs/ssm2602.c     |    1 -
 sound/soc/codecs/stac9766.c    |    3 ---
 sound/soc/codecs/tlv320aic23.c |    1 -
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 sound/soc/codecs/tlv320dac33.c |    3 ---
 sound/soc/codecs/twl4030.c     |    1 -
 sound/soc/codecs/twl6040.c     |    1 -
 sound/soc/codecs/uda1380.c     |    1 -
 sound/soc/codecs/wm8350.c      |    3 ---
 sound/soc/codecs/wm8510.c      |    2 +-
 sound/soc/codecs/wm8711.c      |    2 +-
 sound/soc/codecs/wm8728.c      |    2 +-
 sound/soc/codecs/wm8731.c      |    1 -
 sound/soc/codecs/wm8903.c      |    1 -
 sound/soc/codecs/wm8940.c      |    1 -
 sound/soc/codecs/wm8960.c      |    2 +-
 sound/soc/codecs/wm8974.c      |    2 +-
 sound/soc/codecs/wm9712.c      |    3 ---
 sound/soc/codecs/wm9713.c      |    3 ---
 21 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 2f6221b..b5917df 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -445,7 +445,6 @@ static int ak4535_resume(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->card->codec;
 	ak4535_sync(codec);
 	ak4535_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	ak4535_set_bias_level(codec, codec->suspend_bias_level);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 8f19b93..a320fb5 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -153,7 +153,7 @@ static int cq93vc_resume(struct platform_device *pdev)
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
 
-	cq93vc_set_bias_level(codec, codec->suspend_bias_level);
+	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 99ddec7..f18c8b2 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -559,7 +559,6 @@ static int ssm2602_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 	ssm2602_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	ssm2602_set_bias_level(codec, codec->suspend_bias_level);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index a1c7ca8..e90fe29 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -288,9 +288,6 @@ reset:
 	}
 	stac9766_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
-		stac9766_set_bias_level(codec, SND_SOC_BIAS_ON);
-
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index da589d8..40bcbba 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -633,7 +633,6 @@ static int tlv320aic23_resume(struct platform_device *pdev)
 	}
 
 	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	tlv320aic23_set_bias_level(codec, codec->suspend_bias_level);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d57372b..eafa164 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1143,7 +1143,7 @@ static int aic3x_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 
-	aic3x_set_bias_level(codec, codec->suspend_bias_level);
+	aic3x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index ad5e263..007fe83 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1386,9 +1386,6 @@ static int dac33_soc_resume(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->card->codec;
 
 	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
-		dac33_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
-	dac33_set_bias_level(codec, codec->suspend_bias_level);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index b717a03..0fe74d1 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2181,7 +2181,6 @@ static int twl4030_soc_resume(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->card->codec;
 
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	twl4030_set_bias_level(codec, codec->suspend_bias_level);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index ead6d4b..2ae442e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -996,7 +996,6 @@ static int twl6040_resume(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->card->codec;
 
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	twl6040_set_bias_level(codec, codec->suspend_bias_level);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index ecba686..2f925a2 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -670,7 +670,6 @@ static int uda1380_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	uda1380_set_bias_level(codec, codec->suspend_bias_level);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 145467d..e5a48da 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1336,9 +1336,6 @@ static int wm8350_resume(struct platform_device *pdev)
 
 	wm8350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
-		wm8350_set_bias_level(codec, SND_SOC_BIAS_ON);
-
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index af8cb69..d352700 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -556,7 +556,7 @@ static int wm8510_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	wm8510_set_bias_level(codec, codec->suspend_bias_level);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index f350c5e..5acd35b 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -375,7 +375,7 @@ static int wm8711_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 	wm8711_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	wm8711_set_bias_level(codec, codec->suspend_bias_level);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 3fb653b..bf56a58 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -237,7 +237,7 @@ static int wm8728_resume(struct platform_device *pdev)
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
 
-	wm8728_set_bias_level(codec, codec->suspend_bias_level);
+	wm8728_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 63f90c4..c4b6353 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -460,7 +460,6 @@ static int wm8731_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	wm8731_set_bias_level(codec, codec->suspend_bias_level);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 5a2510c..05b28cf 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1628,7 +1628,6 @@ static int wm8903_resume(struct platform_device *pdev)
 
 	/* Bring the codec back up to standby first to minimise pop/clicks */
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	wm8903_set_bias_level(codec, codec->suspend_bias_level);
 
 	/* Sync back everything else */
 	if (tmp_cache) {
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index b2f1282..e313ab5 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -691,7 +691,6 @@ static int wm8940_resume(struct platform_device *pdev)
 	ret = wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	if (ret)
 		goto error_ret;
-	ret = wm8940_set_bias_level(codec, codec->suspend_bias_level);
 
 error_ret:
 	return ret;
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 50b2376..518c84e 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -823,7 +823,7 @@ static int wm8960_resume(struct platform_device *pdev)
 	}
 
 	codec->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	codec->set_bias_level(codec, codec->suspend_bias_level);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 270eb95..44841fe 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -608,7 +608,7 @@ static int wm8974_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 	wm8974_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	wm8974_set_bias_level(codec, codec->suspend_bias_level);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index e237bf6..dd4b6ce 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -631,9 +631,6 @@ static int wm9712_soc_resume(struct platform_device *pdev)
 		}
 	}
 
-	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
-		wm9712_set_bias_level(codec, SND_SOC_BIAS_ON);
-
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index d2244c9..6a30b84 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1200,9 +1200,6 @@ static int wm9713_soc_resume(struct platform_device *pdev)
 		}
 	}
 
-	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
-		wm9713_set_bias_level(codec, SND_SOC_BIAS_ON);
-
 	return ret;
 }
 
-- 
1.7.0.5
