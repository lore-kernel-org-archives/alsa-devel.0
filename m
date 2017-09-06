From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: cs4270: Use common error handling code
	in two functions
Date: Wed, 6 Sep 2017 19:34:50 +0200
Message-ID: <e7525d1e-0a92-92c5-b779-e2f356b45e45@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C690266A8A
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 19:35:33 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Sep 2017 19:09:31 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/cs4270.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 84f86745c30e..aa70d471cc57 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -362,10 +362,8 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 		reg |= cs4270_mode_ratios[i].speed_mode;
 
 	ret = snd_soc_write(codec, CS4270_MODE, reg);
-	if (ret < 0) {
-		dev_err(codec->dev, "i2c write failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto report_failure;
 
 	/* Set the DAI format */
 
@@ -385,11 +383,13 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = snd_soc_write(codec, CS4270_FORMAT, reg);
-	if (ret < 0) {
-		dev_err(codec->dev, "i2c write failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto report_failure;
+
+	return ret;
 
+report_failure:
+	dev_err(codec->dev, "i2c write failed\n");
 	return ret;
 }
 
@@ -512,10 +512,8 @@ static int cs4270_probe(struct snd_soc_codec *codec)
 	 * re-enabled it by using the controls.
 	 */
 	ret = snd_soc_update_bits(codec, CS4270_MUTE, CS4270_MUTE_AUTO, 0);
-	if (ret < 0) {
-		dev_err(codec->dev, "i2c write failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto report_failure;
 
 	/* Disable automatic volume control.  The hardware enables, and it
 	 * causes volume change commands to be delayed, sometimes until after
@@ -524,15 +522,17 @@ static int cs4270_probe(struct snd_soc_codec *codec)
 	 */
 	ret = snd_soc_update_bits(codec, CS4270_TRANS,
 		CS4270_TRANS_SOFT | CS4270_TRANS_ZERO, 0);
-	if (ret < 0) {
-		dev_err(codec->dev, "i2c write failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto report_failure;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
 				    cs4270->supplies);
 
 	return ret;
+
+report_failure:
+	dev_err(codec->dev, "i2c write failed\n");
+	return ret;
 }
 
 /**
-- 
2.14.1
