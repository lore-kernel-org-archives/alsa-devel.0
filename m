From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2] ASoC: Return early with -EINVAL if invalid
 dai format is detected
Date: Thu, 06 Oct 2011 07:29:56 +0800
Message-ID: <1317857396.6291.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id BA93524556
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 01:30:09 +0200 (CEST)
Received: by ywn1 with SMTP id 1so2420077ywn.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 16:30:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
---
 sound/soc/codecs/cs4270.c  |    8 ++++----
 sound/soc/codecs/cs42l51.c |    9 ++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 5830c93..f1f237e 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -261,7 +261,6 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0;
 
 	/* set DAI format */
 	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -271,7 +270,7 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	default:
 		dev_err(codec->dev, "invalid dai format\n");
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
 	/* set master/slave audio interface */
@@ -284,10 +283,11 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	default:
 		/* all other modes are unsupported by the hardware */
-		ret = -EINVAL;
+		dev_err(codec->dev, "Unknown master/slave configuration\n");
+		return -EINVAL;
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 286878d..8c3c820 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -288,7 +288,6 @@ static int cs42l51_set_dai_fmt(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0;
 
 	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -298,7 +297,7 @@ static int cs42l51_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	default:
 		dev_err(codec->dev, "invalid DAI format\n");
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
 	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -309,11 +308,11 @@ static int cs42l51_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		cs42l51->func = MODE_SLAVE_AUTO;
 		break;
 	default:
-		ret = -EINVAL;
-		break;
+		dev_err(codec->dev, "Unknown master/slave configuration\n");
+		return -EINVAL;
 	}
 
-	return ret;
+	return 0;
 }
 
 struct cs42l51_ratios {
-- 
1.7.4.1
