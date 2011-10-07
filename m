From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: ams-delta: Let the core to register DAPM
	widgets/routes and controls
Date: Fri,  7 Oct 2011 12:03:19 +0300
Message-ID: <1317978199-14932-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id D83B2103B35
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 11:03:28 +0200 (CEST)
Received: by mail-bw0-f41.google.com with SMTP id zs2so5069418bkb.0
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 02:03:21 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: alsa-devel@alsa-project.org

Pass the DAPM widgets/routes and static controls via the
snd_soc_card struct to core. In this way the machine driver
does not need to handle the DAPM widgets/routes.

Move the setup for initial pin constellation to late_probe
time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/ams-delta.c |   56 +++++++++++++++----------------------------
 1 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 10d3d41..2153a1c 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -536,48 +536,23 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 
 	/* Register optional line discipline for over the modem control */
 	ret = tty_register_ldisc(N_V253, &cx81801_ops);
-	if (ret) {
+	if (ret)
 		dev_warn(card->dev,
 				"Failed to register line discipline, "
 				"will continue without any controls.\n");
-		return 0;
-	}
-
-	/* Add board specific DAPM widgets and routes */
-	ret = snd_soc_dapm_new_controls(dapm, ams_delta_dapm_widgets,
-					ARRAY_SIZE(ams_delta_dapm_widgets));
-	if (ret) {
-		dev_warn(card->dev,
-				"Failed to register DAPM controls, "
-				"will continue without any.\n");
-		return 0;
-	}
 
-	ret = snd_soc_dapm_add_routes(dapm, ams_delta_audio_map,
-					ARRAY_SIZE(ams_delta_audio_map));
-	if (ret) {
-		dev_warn(card->dev,
-				"Failed to set up DAPM routes, "
-				"will continue with codec default map.\n");
-		return 0;
-	}
+	return 0;
+}
 
+static int ams_delta_late_probe(struct snd_soc_card *card)
+{
 	/* Set up initial pin constellation */
-	snd_soc_dapm_disable_pin(dapm, "Mouthpiece");
-	snd_soc_dapm_enable_pin(dapm, "Earpiece");
-	snd_soc_dapm_enable_pin(dapm, "Microphone");
-	snd_soc_dapm_disable_pin(dapm, "Speaker");
-	snd_soc_dapm_disable_pin(dapm, "AGCIN");
-	snd_soc_dapm_disable_pin(dapm, "AGCOUT");
-	snd_soc_dapm_new_widgets(dapm);
-
-	/* Add virtual switch */
-	ret = snd_soc_add_controls(codec, ams_delta_audio_controls,
-					ARRAY_SIZE(ams_delta_audio_controls));
-	if (ret)
-		dev_warn(card->dev,
-				"Failed to register audio mode control, "
-				"will continue without it.\n");
+	snd_soc_dapm_disable_pin(&card->dapm, "Mouthpiece");
+	snd_soc_dapm_enable_pin(&card->dapm, "Earpiece");
+	snd_soc_dapm_enable_pin(&card->dapm, "Microphone");
+	snd_soc_dapm_disable_pin(&card->dapm, "Speaker");
+	snd_soc_dapm_disable_pin(&card->dapm, "AGCIN");
+	snd_soc_dapm_disable_pin(&card->dapm, "AGCOUT");
 
 	return 0;
 }
@@ -600,6 +575,15 @@ static struct snd_soc_card ams_delta_audio_card = {
 	.dai_link = &ams_delta_dai_link,
 	.num_links = 1,
 	.set_bias_level = ams_delta_set_bias_level,
+
+	.controls = ams_delta_audio_controls,
+	.num_controls = ARRAY_SIZE(ams_delta_audio_controls),
+	.dapm_widgets = ams_delta_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ams_delta_dapm_widgets),
+	.dapm_routes = ams_delta_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(ams_delta_audio_map),
+
+	.late_probe = ams_delta_late_probe,
 };
 
 /* Module init/exit */
-- 
1.7.7
