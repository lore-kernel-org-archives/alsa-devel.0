From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Ensure WM8958 gets all WM8994 late
	revision widgets
Date: Wed,  9 Mar 2011 19:11:24 +0000
Message-ID: <1299697884-15482-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299697884-15482-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E35EB103A16
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 20:12:36 +0100 (CET)
In-Reply-To: <1299697884-15482-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Without this fix the driver won't instantiate properly on relevant
devices.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index d926733..c6c958e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3325,6 +3325,12 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	case WM8958:
 		snd_soc_add_controls(codec, wm8958_snd_controls,
 				     ARRAY_SIZE(wm8958_snd_controls));
+		snd_soc_dapm_new_controls(dapm, wm8994_lateclk_widgets,
+					  ARRAY_SIZE(wm8994_lateclk_widgets));
+		snd_soc_dapm_new_controls(dapm, wm8994_adc_widgets,
+					  ARRAY_SIZE(wm8994_adc_widgets));
+		snd_soc_dapm_new_controls(dapm, wm8994_dac_widgets,
+					  ARRAY_SIZE(wm8994_dac_widgets));
 		snd_soc_dapm_new_controls(dapm, wm8958_dapm_widgets,
 					  ARRAY_SIZE(wm8958_dapm_widgets));
 		break;
@@ -3350,6 +3356,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		}
 		break;
 	case WM8958:
+		snd_soc_dapm_add_routes(dapm, wm8994_lateclk_intercon,
+					ARRAY_SIZE(wm8994_lateclk_intercon));
 		snd_soc_dapm_add_routes(dapm, wm8958_intercon,
 					ARRAY_SIZE(wm8958_intercon));
 		break;
-- 
1.7.4.1
