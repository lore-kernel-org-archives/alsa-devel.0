From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] ASoC: tlv320aix31xx: Replace direct
	snd_soc_codec dapm field access
Date: Fri, 15 May 2015 12:32:56 +0200
Message-ID: <1431685980-6600-4-git-send-email-lars@metafoo.de>
References: <1431685980-6600-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-168.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 01C7C266299
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 12:33:05 +0200 (CEST)
In-Reply-To: <1431685980-6600-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and replace all
other manual access to codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic31xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index e629273..c4c960f 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -646,7 +646,7 @@ static int aic31xx_add_controls(struct snd_soc_codec *codec)
 
 static int aic31xx_add_widgets(struct snd_soc_codec *codec)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
@@ -1027,17 +1027,17 @@ static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
 	dev_dbg(codec->dev, "## %s: %d -> %d\n", __func__,
-		codec->dapm.bias_level, level);
+		snd_soc_codec_get_bias_level(codec), level);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY)
 			aic31xx_clk_on(codec);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		switch (codec->dapm.bias_level) {
+		switch (snd_soc_codec_get_bias_level(codec)) {
 		case SND_SOC_BIAS_OFF:
 			aic31xx_power_on(codec);
 			break;
@@ -1049,7 +1049,7 @@ static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY)
 			aic31xx_power_off(codec);
 		break;
 	}
-- 
1.8.0
