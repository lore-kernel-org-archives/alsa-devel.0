From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Return early with -EINVAL if invalid dai format is
 detected
Date: Wed, 05 Oct 2011 09:45:34 +0800
Message-ID: <1317779135.2595.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Timur Tabi <timur@freescale.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
---
 sound/soc/codecs/cs4270.c  |    2 +-
 sound/soc/codecs/cs42l51.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 5830c93..e645d67 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -271,7 +271,7 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	default:
 		dev_err(codec->dev, "invalid dai format\n");
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
 	/* set master/slave audio interface */
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 286878d..779294b 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -298,7 +298,7 @@ static int cs42l51_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	default:
 		dev_err(codec->dev, "invalid DAI format\n");
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
 	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
-- 
1.7.4.1
