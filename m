From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Use data base init for WM9081 DAPM
Date: Mon,  7 Mar 2011 16:41:26 +0000
Message-ID: <1299516086-23638-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299516086-23638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F37BA244CD
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 17:41:06 +0100 (CET)
In-Reply-To: <1299516086-23638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm9081.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 7883f3e..8b1b2c9 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -762,7 +762,7 @@ SND_SOC_DAPM_SUPPLY("TOCLK", WM9081_CLOCK_CONTROL_3, 2, 0, NULL, 0),
 };
 
 
-static const struct snd_soc_dapm_route audio_paths[] = {
+static const struct snd_soc_dapm_route wm9081_audio_paths[] = {
 	{ "DAC", NULL, "CLK_SYS" },
 	{ "DAC", NULL, "CLK_DSP" },
 
@@ -1232,7 +1232,6 @@ static struct snd_soc_dai_driver wm9081_dai = {
 static int wm9081_probe(struct snd_soc_codec *codec)
 {
 	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 	u16 reg;
 
@@ -1282,10 +1281,6 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 				     ARRAY_SIZE(wm9081_eq_controls));
 	}
 
-	snd_soc_dapm_new_controls(dapm, wm9081_dapm_widgets,
-				  ARRAY_SIZE(wm9081_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
-
 	return ret;
 }
 
@@ -1334,6 +1329,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm9081_reg_defaults,
 	.volatile_register = wm9081_volatile_register,
+	.dapm_widgets	  = wm9081_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm9081_dapm_widgets),
+	.dapm_routes     = wm9081_audio_paths,
+	.num_dapm_routes = ARRAY_SIZE(wm9081_audio_paths),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-- 
1.7.2.3
