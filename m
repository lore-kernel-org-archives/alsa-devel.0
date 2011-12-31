From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/4] ASoC: Convert spitz to table based DAPM
	and control init
Date: Sat, 31 Dec 2011 08:44:04 +0800
Message-ID: <1325292244.3270.2.camel@phoenix>
References: <1325292030.3270.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2634B103B4D
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 01:44:13 +0100 (CET)
Received: by yhjj56 with SMTP id j56so8467233yhj.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:44:13 -0800 (PST)
In-Reply-To: <1325292030.3270.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/spitz.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 76288ad..90c5245 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -222,7 +222,7 @@ static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
 };
 
 /* Spitz machine audio_map */
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route spitz_audio_map[] = {
 
 	/* headphone connected to LOUT1, ROUT1 */
 	{"Headphone Jack", NULL, "LOUT1"},
@@ -265,7 +265,6 @@ static int spitz_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int err;
 
 	/* NC codec pins */
 	snd_soc_dapm_nc_pin(dapm, "RINPUT1");
@@ -276,19 +275,6 @@ static int spitz_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "OUT3");
 	snd_soc_dapm_nc_pin(dapm, "MONO1");
 
-	/* Add spitz specific controls */
-	err = snd_soc_add_controls(codec, wm8750_spitz_controls,
-				ARRAY_SIZE(wm8750_spitz_controls));
-	if (err < 0)
-		return err;
-
-	/* Add spitz specific widgets */
-	snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
-				  ARRAY_SIZE(wm8750_dapm_widgets));
-
-	/* Set up spitz specific audio paths */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	return 0;
 }
 
@@ -312,6 +298,13 @@ static struct snd_soc_card snd_soc_spitz = {
 	.owner = THIS_MODULE,
 	.dai_link = &spitz_dai,
 	.num_links = 1,
+
+	.controls = wm8750_spitz_controls,
+	.num_controls = ARRAY_SIZE(wm8750_spitz_controls),
+	.dapm_widgets = wm8750_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8750_dapm_widgets),
+	.dapm_routes = spitz_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(spitz_audio_map),
 };
 
 static struct platform_device *spitz_snd_device;
-- 
1.7.5.4
