From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/8] ASoC: tlv320aic3x: Use uniform tlv320aic
	naming
Date: Wed,  8 Oct 2008 10:37:57 +0100
Message-ID: <1223458680-9506-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081008093611.GA9425@rakim.wolfsonmicro.main>
	<1223458680-9506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F337C244CE
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 11:38:15 +0200 (CEST)
In-Reply-To: <1223458680-9506-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic3x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 566a427..57fc5af 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -991,7 +991,7 @@ EXPORT_SYMBOL_GPL(aic3x_headset_detected);
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 struct snd_soc_dai aic3x_dai = {
-	.name = "aic3x",
+	.name = "tlv320aic3x",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -1055,7 +1055,7 @@ static int aic3x_init(struct snd_soc_device *socdev)
 	struct aic3x_setup_data *setup = socdev->codec_data;
 	int reg, ret = 0;
 
-	codec->name = "aic3x";
+	codec->name = "tlv320aic3x";
 	codec->owner = THIS_MODULE;
 	codec->read = aic3x_read_reg_cache;
 	codec->write = aic3x_write;
-- 
1.5.6.5
