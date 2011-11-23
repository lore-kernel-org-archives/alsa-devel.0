From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert wm8776 to table based control
	and DAPM init
Date: Wed, 23 Nov 2011 10:14:01 +0000
Message-ID: <1322043241-20383-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9063A243A0
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 11:14:05 +0100 (CET)
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
 sound/soc/codecs/wm8776.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index bfdc523..f967c59d 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -414,12 +414,6 @@ static int wm8776_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8776_HPRVOL, 0x100, 0x100);
 	snd_soc_update_bits(codec, WM8776_DACRVOL, 0x100, 0x100);
 
-	snd_soc_add_controls(codec, wm8776_snd_controls,
-			     ARRAY_SIZE(wm8776_snd_controls));
-	snd_soc_dapm_new_controls(dapm, wm8776_dapm_widgets,
-				  ARRAY_SIZE(wm8776_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, routes, ARRAY_SIZE(routes));
-
 	return ret;
 }
 
@@ -439,6 +433,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
 	.reg_cache_size = ARRAY_SIZE(wm8776_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8776_reg,
+
+	.controls = wm8776_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8776_snd_controls),
+	.dapm_widgets = wm8776_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8776_dapm_widgets),
+	.dapm_routes = routes,
+	.num_dapm_routes = ARRAY_SIZE(routes),
 };
 
 static const struct of_device_id wm8776_of_match[] = {
-- 
1.7.7.3
