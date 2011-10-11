From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl4030: Convert to table based init
Date: Tue, 11 Oct 2011 13:11:32 +0300
Message-ID: <1318327892-7144-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 708871038A2
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 12:11:41 +0200 (CEST)
Received: by ywn1 with SMTP id 1so6406261ywn.10
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 03:11:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 7c244cd..f798247 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1609,17 +1609,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 };
 
-static int twl4030_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, twl4030_dapm_widgets,
-				 ARRAY_SIZE(twl4030_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
@@ -2241,9 +2230,6 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 
 	twl4030_init_chip(codec);
 
-	snd_soc_add_controls(codec, twl4030_snd_controls,
-				ARRAY_SIZE(twl4030_snd_controls));
-	twl4030_add_widgets(codec);
 	return 0;
 }
 
@@ -2269,6 +2255,13 @@ static struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 	.reg_cache_size = sizeof(twl4030_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = twl4030_reg,
+
+	.controls = twl4030_snd_controls,
+	.num_controls = ARRAY_SIZE(twl4030_snd_controls),
+	.dapm_widgets = twl4030_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(twl4030_dapm_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
 static int __devinit twl4030_codec_probe(struct platform_device *pdev)
-- 
1.7.7
