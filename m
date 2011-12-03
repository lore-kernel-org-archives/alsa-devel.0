From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 14/21] ASoC: Convert WM8741 to table based DAPM
	and control init
Date: Sat,  3 Dec 2011 21:33:22 +0000
Message-ID: <1322948009-27658-14-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D324103854
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:43 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8741.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 24d8ec5..3941f50 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -85,24 +85,13 @@ SND_SOC_DAPM_OUTPUT("VOUTRP"),
 SND_SOC_DAPM_OUTPUT("VOUTRN"),
 };
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_route wm8741_dapm_routes[] = {
 	{ "VOUTLP", NULL, "DACL" },
 	{ "VOUTLN", NULL, "DACL" },
 	{ "VOUTRP", NULL, "DACR" },
 	{ "VOUTRN", NULL, "DACR" },
 };
 
-static int wm8741_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8741_dapm_widgets,
-				  ARRAY_SIZE(wm8741_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 static struct {
 	int value;
 	int ratio;
@@ -456,10 +445,6 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8741_DACRMSB_ATTENUATION,
 			    WM8741_UPDATERM, WM8741_UPDATERM);
 
-	snd_soc_add_controls(codec, wm8741_snd_controls,
-			     ARRAY_SIZE(wm8741_snd_controls));
-	wm8741_add_widgets(codec);
-
 	dev_dbg(codec->dev, "Successful registration\n");
 	return ret;
 
@@ -488,6 +473,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8741 = {
 	.reg_cache_size = ARRAY_SIZE(wm8741_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8741_reg_defaults,
+
+	.controls = wm8741_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8741_snd_controls),
+	.dapm_widgets = wm8741_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8741_dapm_widgets),
+	.dapm_routes = wm8741_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8741_dapm_routes),
 };
 
 static const struct of_device_id wm8741_of_match[] = {
-- 
1.7.7.3
