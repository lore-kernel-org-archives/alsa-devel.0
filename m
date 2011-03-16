From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Treat WM8958 revision A as WM8994
	revision D
Date: Wed, 16 Mar 2011 15:48:50 +0000
Message-ID: <1300290532-30555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD16624497
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 16:49:02 +0100 (CET)
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

The first WM8958 revision requires similar treatment.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   36 ++++++++++++++++++++++++++----------
 1 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 3dc64c8..9458289 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3327,14 +3327,23 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	case WM8958:
 		snd_soc_add_controls(codec, wm8958_snd_controls,
 				     ARRAY_SIZE(wm8958_snd_controls));
-		snd_soc_dapm_new_controls(dapm, wm8994_lateclk_widgets,
-					  ARRAY_SIZE(wm8994_lateclk_widgets));
-		snd_soc_dapm_new_controls(dapm, wm8994_adc_widgets,
-					  ARRAY_SIZE(wm8994_adc_widgets));
-		snd_soc_dapm_new_controls(dapm, wm8994_dac_widgets,
-					  ARRAY_SIZE(wm8994_dac_widgets));
 		snd_soc_dapm_new_controls(dapm, wm8958_dapm_widgets,
 					  ARRAY_SIZE(wm8958_dapm_widgets));
+		if (wm8994->revision < 1) {
+			snd_soc_dapm_new_controls(dapm, wm8994_lateclk_revd_widgets,
+						  ARRAY_SIZE(wm8994_lateclk_revd_widgets));
+			snd_soc_dapm_new_controls(dapm, wm8994_adc_revd_widgets,
+						  ARRAY_SIZE(wm8994_adc_revd_widgets));
+			snd_soc_dapm_new_controls(dapm, wm8994_dac_revd_widgets,
+						  ARRAY_SIZE(wm8994_dac_revd_widgets));
+		} else {
+			snd_soc_dapm_new_controls(dapm, wm8994_lateclk_widgets,
+						  ARRAY_SIZE(wm8994_lateclk_widgets));
+			snd_soc_dapm_new_controls(dapm, wm8994_adc_widgets,
+						  ARRAY_SIZE(wm8994_adc_widgets));
+			snd_soc_dapm_new_controls(dapm, wm8994_dac_widgets,
+						  ARRAY_SIZE(wm8994_dac_widgets));
+		}
 		break;
 	}
 		
@@ -3358,10 +3367,17 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		}
 		break;
 	case WM8958:
-		snd_soc_dapm_add_routes(dapm, wm8994_lateclk_intercon,
-					ARRAY_SIZE(wm8994_lateclk_intercon));
-		snd_soc_dapm_add_routes(dapm, wm8958_intercon,
-					ARRAY_SIZE(wm8958_intercon));
+		if (wm8994->revision < 1) {
+			snd_soc_dapm_add_routes(dapm, wm8994_revd_intercon,
+						ARRAY_SIZE(wm8994_revd_intercon));
+			snd_soc_dapm_add_routes(dapm, wm8994_lateclk_revd_intercon,
+						ARRAY_SIZE(wm8994_lateclk_revd_intercon));
+		} else {
+			snd_soc_dapm_add_routes(dapm, wm8994_lateclk_intercon,
+						ARRAY_SIZE(wm8994_lateclk_intercon));
+			snd_soc_dapm_add_routes(dapm, wm8958_intercon,
+						ARRAY_SIZE(wm8958_intercon));
+		}
 		break;
 	}
 
-- 
1.7.4.1
