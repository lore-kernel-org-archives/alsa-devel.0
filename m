From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/9] ASoC: n810: Let the core to register
	DAPM widgets/routes and controls
Date: Mon, 10 Oct 2011 15:34:10 +0300
Message-ID: <1318250056-26437-4-git-send-email-peter.ujfalusi@ti.com>
References: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 45E0D24521
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 14:34:56 +0200 (CEST)
Received: by mail-yw0-f44.google.com with SMTP id 3so6589894ywm.31
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 05:34:55 -0700 (PDT)
In-Reply-To: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
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

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/n810.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 4fa881b..7e3c20c 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -257,7 +257,6 @@ static int n810_aic33_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int err;
 
 	/* Not connected */
 	snd_soc_dapm_nc_pin(dapm, "MONO_LOUT");
@@ -269,18 +268,7 @@ static int n810_aic33_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "LINE2L");
 	snd_soc_dapm_nc_pin(dapm, "LINE2R");
 
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
-	return snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
+	return 0;
 }
 
 /* Digital audio interface glue - connects codec <--> CPU */
@@ -302,6 +290,13 @@ static struct snd_soc_card snd_soc_n810 = {
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
 };
 
 static struct platform_device *n810_snd_device;
-- 
1.7.7
