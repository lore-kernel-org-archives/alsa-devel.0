From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: tlv320aic32x4: Use snd_soc_dapm_context
	as required
Date: Mon,  7 Mar 2011 10:32:09 +0000
Message-ID: <1299493929-849-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1904E103818
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 11:32:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Fix compilation issues by using the snd_soc_dapm_context pointer
whenever it is required.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic32x4.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index ee82e38..c6c3520 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -340,13 +340,15 @@ static inline int aic32x4_get_divs(int mclk, int rate)
 
 static int aic32x4_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, aic32x4_dapm_widgets,
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_new_controls(dapm, aic32x4_dapm_widgets,
 				ARRAY_SIZE(aic32x4_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, aic32x4_dapm_routes,
+	snd_soc_dapm_add_routes(dapm, aic32x4_dapm_routes,
 				ARRAY_SIZE(aic32x4_dapm_routes));
 
-	snd_soc_dapm_new_widgets(codec);
+	snd_soc_dapm_new_widgets(dapm);
 	return 0;
 }
 
@@ -602,7 +604,7 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_OFF:
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
-- 
1.7.4.1
