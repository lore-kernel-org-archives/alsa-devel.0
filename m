From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: n810: Let the core to register DAPM
	widgets/routes and controls
Date: Fri,  7 Oct 2011 11:30:47 +0300
Message-ID: <1317976247-14600-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BB4B24664
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 10:30:46 +0200 (CEST)
Received: by mail-bw0-f45.google.com with SMTP id zv15so4805346bkb.32
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 01:30:39 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Pass the DAPM widgets/routes and static controls via the
snd_soc_card struct to core. In this way the machine driver
does not need to handle the DAPM widgets/routes.

Mark the not connected pins at late_probe time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/n810.c |   47 ++++++++++++++++++-----------------------------
 1 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index bda2aa4..625e886 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -253,36 +253,16 @@ static const struct snd_kcontrol_new aic33_n810_controls[] = {
 		     n810_get_input, n810_set_input),
 };
 
-static int n810_aic33_init(struct snd_soc_pcm_runtime *rtd)
+static int n810_aic33_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int err;
-
-	/* Not connected */
-	snd_soc_dapm_nc_pin(dapm, "MONO_LOUT");
-	snd_soc_dapm_nc_pin(dapm, "HPLCOM");
-	snd_soc_dapm_nc_pin(dapm, "HPRCOM");
-	snd_soc_dapm_nc_pin(dapm, "MIC3L");
-	snd_soc_dapm_nc_pin(dapm, "MIC3R");
-	snd_soc_dapm_nc_pin(dapm, "LINE1R");
-	snd_soc_dapm_nc_pin(dapm, "LINE2L");
-	snd_soc_dapm_nc_pin(dapm, "LINE2R");
-
-	/* Add N810 specific controls */
-	err = snd_soc_add_controls(codec, aic33_n810_controls,
-				ARRAY_SIZE(aic33_n810_controls));
-	if (err < 0)
-		return err;
-
-	/* Add N810 specific widgets */
-	snd_soc_dapm_new_controls(dapm, aic33_dapm_widgets,
-				  ARRAY_SIZE(aic33_dapm_widgets));
-
-	/* Set up N810 specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	snd_soc_dapm_new_widgets(dapm);
+	snd_soc_dapm_nc_pin(&card->dapm, "MONO_LOUT");
+	snd_soc_dapm_nc_pin(&card->dapm, "HPLCOM");
+	snd_soc_dapm_nc_pin(&card->dapm, "HPRCOM");
+	snd_soc_dapm_nc_pin(&card->dapm, "MIC3L");
+	snd_soc_dapm_nc_pin(&card->dapm, "MIC3R");
+	snd_soc_dapm_nc_pin(&card->dapm, "LINE1R");
+	snd_soc_dapm_nc_pin(&card->dapm, "LINE2L");
+	snd_soc_dapm_nc_pin(&card->dapm, "LINE2R");
 
 	return 0;
 }
@@ -306,6 +286,15 @@ static struct snd_soc_card snd_soc_n810 = {
 	.name = "N810",
 	.dai_link = &n810_dai,
 	.num_links = 1,
+
+	.controls = aic33_n810_controls,
+	.num_controls = ARRAY_SIZE(aic33_n810_controls),
+	.dapm_widgets = aic33_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aic33_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+
+	.late_probe = n810_aic33_late_probe,
 };
 
 static struct platform_device *n810_snd_device;
-- 
1.7.7
