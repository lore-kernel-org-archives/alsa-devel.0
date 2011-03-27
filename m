From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Convert WM8731 to table based DAPM
	setup
Date: Sun, 27 Mar 2011 14:42:15 +0100
Message-ID: <1301233336-21048-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1301233336-21048-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F0E2103870
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 15:42:11 +0200 (CEST)
In-Reply-To: <1301233336-21048-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8731.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 0a67c31..44a591e 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -201,7 +201,7 @@ static int wm8731_check_osc(struct snd_soc_dapm_widget *source,
 	return wm8731->sysclk_type == WM8731_SYSCLK_MCLK;
 }
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_route wm8731_intercon[] = {
 	{"DAC", NULL, "OSC", wm8731_check_osc},
 	{"ADC", NULL, "OSC", wm8731_check_osc},
 
@@ -227,17 +227,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Mic Bias", NULL, "MICIN"},
 };
 
-static int wm8731_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8731_dapm_widgets,
-				  ARRAY_SIZE(wm8731_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 struct _coeff_div {
 	u32 mclk;
 	u32 rate;
@@ -599,7 +588,6 @@ static int wm8731_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, wm8731_snd_controls,
 			     ARRAY_SIZE(wm8731_snd_controls));
-	wm8731_add_widgets(codec);
 
 	/* Regulators will have been enabled by bias management */
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
@@ -636,6 +624,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
 	.reg_cache_size = ARRAY_SIZE(wm8731_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8731_reg,
+	.dapm_widgets = wm8731_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8731_dapm_widgets),
+	.dapm_routes = wm8731_intercon,
+	.num_dapm_routes = ARRAY_SIZE(wm8731_intercon),
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.7.4.1
