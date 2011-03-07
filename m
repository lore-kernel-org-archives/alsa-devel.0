From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Fix outdated API usage in
	tlv320aic32x4
Date: Mon,  7 Mar 2011 11:11:04 +0000
Message-ID: <1299496265-8090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90F0F10384E
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 12:11:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic32x4.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index ee82e38..e93b9d1 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -340,13 +340,13 @@ static inline int aic32x4_get_divs(int mclk, int rate)
 
 static int aic32x4_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, aic32x4_dapm_widgets,
-				ARRAY_SIZE(aic32x4_dapm_widgets));
+	snd_soc_dapm_new_controls(&codec->dapm, aic32x4_dapm_widgets,
+				  ARRAY_SIZE(aic32x4_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, aic32x4_dapm_routes,
+	snd_soc_dapm_add_routes(&codec->dapm, aic32x4_dapm_routes,
 				ARRAY_SIZE(aic32x4_dapm_routes));
 
-	snd_soc_dapm_new_widgets(codec);
+	snd_soc_dapm_new_widgets(&codec->dapm);
 	return 0;
 }
 
@@ -602,7 +602,7 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_OFF:
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
-- 
1.7.2.3
