From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Convert WM8903 to table based DAPM
	setup
Date: Sun, 27 Mar 2011 14:42:14 +0100
Message-ID: <1301233336-21048-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1301233336-21048-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90EC7103875
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
 sound/soc/codecs/wm8903.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index c771c39..11baac9 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -931,7 +931,7 @@ SND_SOC_DAPM_SUPPLY("CLK_DSP", WM8903_CLOCK_RATES_2, 1, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("CLK_SYS", WM8903_CLOCK_RATES_2, 2, 0, NULL, 0),
 };
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_route wm8903_intercon[] = {
 
 	{ "CLK_DSP", NULL, "CLK_SYS" },
 	{ "Mic Bias", NULL, "CLK_SYS" },
@@ -1084,17 +1084,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "Right Line Output PGA", NULL, "Charge Pump" },
 };
 
-static int wm8903_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8903_dapm_widgets,
-				  ARRAY_SIZE(wm8903_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
@@ -2222,7 +2211,6 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, wm8903_snd_controls,
 				ARRAY_SIZE(wm8903_snd_controls));
-	wm8903_add_widgets(codec);
 
 	wm8903_init_gpio(codec);
 
@@ -2248,6 +2236,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
 	.reg_cache_default = wm8903_reg_defaults,
 	.volatile_register = wm8903_volatile_register,
 	.seq_notifier = wm8903_seq_notifier,
+	.dapm_widgets = wm8903_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8903_dapm_widgets),
+	.dapm_routes = wm8903_intercon,
+	.num_dapm_routes = ARRAY_SIZE(wm8903_intercon),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-- 
1.7.4.1
