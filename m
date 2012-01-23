From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: sgtl5000: Convert to table based DAPM
	and control init
Date: Mon, 23 Jan 2012 00:17:56 -0200
Message-ID: <1327285076-27501-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 86BD0103883
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 03:18:12 +0100 (CET)
Received: by yhoo47 with SMTP id o47so998789yho.38
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 18:18:09 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Convert to table based DAPM and control init.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fixed typo in codec name (500 instead of 5000)
 sound/soc/codecs/sgtl5000.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 7f4ba81..d6f76cf 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -227,7 +227,7 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
 };
 
 /* routes for sgtl5000 */
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
 	{"Capture Mux", "LINE_IN", "LINE_IN"},	/* line_in --> adc_mux */
 	{"Capture Mux", "MIC_IN", "MIC_IN"},	/* mic_in --> adc_mux */
 
@@ -1353,15 +1353,6 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	if (ret)
 		goto err;
 
-	snd_soc_add_controls(codec, sgtl5000_snd_controls,
-			     ARRAY_SIZE(sgtl5000_snd_controls));
-
-	snd_soc_dapm_new_controls(&codec->dapm, sgtl5000_dapm_widgets,
-				  ARRAY_SIZE(sgtl5000_dapm_widgets));
-
-	snd_soc_dapm_add_routes(&codec->dapm, audio_map,
-				ARRAY_SIZE(audio_map));
-
 	snd_soc_dapm_new_widgets(&codec->dapm);
 
 	return 0;
@@ -1402,6 +1393,12 @@ static struct snd_soc_codec_driver sgtl5000_driver = {
 	.reg_cache_step = 2,
 	.reg_cache_default = sgtl5000_regs,
 	.volatile_register = sgtl5000_volatile_register,
+	.controls = sgtl5000_snd_controls,
+	.num_controls = ARRAY_SIZE(sgtl5000_snd_controls),
+	.dapm_widgets = sgtl5000_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(sgtl5000_dapm_widgets),
+	.dapm_routes = sgtl5000_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(sgtl5000_dapm_routes),
 };
 
 static __devinit int sgtl5000_i2c_probe(struct i2c_client *client,
-- 
1.7.1
