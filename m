From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: neo1973_wm8753: Convert to table
	based setup
Date: Sat,  1 Mar 2014 16:17:03 +0100
Message-ID: <1393687023-17584-2-git-send-email-lars@metafoo.de>
References: <1393687023-17584-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-194.synserver.de
 [212.40.185.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 6934026534C
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 16:16:41 +0100 (CET)
In-Reply-To: <1393687023-17584-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the controls and DAPM widgets and routes.
This on one hand makes the code a bit shorter and cleaner and on the other hand
the board level DAPM elements get registered in the card's DAPM context rather
than in the CODEC's DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/neo1973_wm8753.c | 60 +++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 0125d9d..b080033 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -272,48 +272,29 @@ static const struct snd_kcontrol_new neo1973_wm8753_controls[] = {
 static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
+	struct snd_soc_card *card = rtd->card;
 
 	/* set up NC codec pins */
-	snd_soc_dapm_nc_pin(dapm, "OUT3");
-	snd_soc_dapm_nc_pin(dapm, "OUT4");
-	snd_soc_dapm_nc_pin(dapm, "LINE1");
-	snd_soc_dapm_nc_pin(dapm, "LINE2");
-
-	/* Add neo1973 specific widgets */
-	ret = snd_soc_dapm_new_controls(dapm, neo1973_wm8753_dapm_widgets,
-			ARRAY_SIZE(neo1973_wm8753_dapm_widgets));
-	if (ret)
-		return ret;
-
-	/* add neo1973 specific controls */
-	ret = snd_soc_add_card_controls(rtd->card, neo1973_wm8753_controls,
-			ARRAY_SIZE(neo1973_wm8753_controls));
-	if (ret)
-		return ret;
-
-	/* set up neo1973 specific audio routes */
-	ret = snd_soc_dapm_add_routes(dapm, neo1973_wm8753_routes,
-			ARRAY_SIZE(neo1973_wm8753_routes));
-	if (ret)
-		return ret;
+	snd_soc_dapm_nc_pin(&codec->dapm, "OUT3");
+	snd_soc_dapm_nc_pin(&codec->dapm, "OUT4");
+	snd_soc_dapm_nc_pin(&codec->dapm, "LINE1");
+	snd_soc_dapm_nc_pin(&codec->dapm, "LINE2");
 
 	/* set endpoints to default off mode */
-	snd_soc_dapm_disable_pin(dapm, "GSM Line Out");
-	snd_soc_dapm_disable_pin(dapm, "GSM Line In");
-	snd_soc_dapm_disable_pin(dapm, "Headset Mic");
-	snd_soc_dapm_disable_pin(dapm, "Handset Mic");
-	snd_soc_dapm_disable_pin(dapm, "Stereo Out");
-	snd_soc_dapm_disable_pin(dapm, "Handset Spk");
+	snd_soc_dapm_disable_pin(&card->dapm, "GSM Line Out");
+	snd_soc_dapm_disable_pin(&card->dapm, "GSM Line In");
+	snd_soc_dapm_disable_pin(&card->dapm, "Headset Mic");
+	snd_soc_dapm_disable_pin(&card->dapm, "Handset Mic");
+	snd_soc_dapm_disable_pin(&card->dapm, "Stereo Out");
+	snd_soc_dapm_disable_pin(&card->dapm, "Handset Spk");
 
 	/* allow audio paths from the GSM modem to run during suspend */
-	snd_soc_dapm_ignore_suspend(dapm, "GSM Line Out");
-	snd_soc_dapm_ignore_suspend(dapm, "GSM Line In");
-	snd_soc_dapm_ignore_suspend(dapm, "Headset Mic");
-	snd_soc_dapm_ignore_suspend(dapm, "Handset Mic");
-	snd_soc_dapm_ignore_suspend(dapm, "Stereo Out");
-	snd_soc_dapm_ignore_suspend(dapm, "Handset Spk");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "GSM Line Out");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "GSM Line In");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Headset Mic");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Handset Mic");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Stereo Out");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Handset Spk");
 
 	return 0;
 }
@@ -367,6 +348,13 @@ static struct snd_soc_card neo1973 = {
 	.num_aux_devs = ARRAY_SIZE(neo1973_aux_devs),
 	.codec_conf = neo1973_codec_conf,
 	.num_configs = ARRAY_SIZE(neo1973_codec_conf),
+
+	.controls = neo1973_wm8753_controls,
+	.num_controls = ARRAY_SIZE(neo1973_wm8753_controls),
+	.dapm_widgets = neo1973_wm8753_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(neo1973_wm8753_dapm_widgets),
+	.dapm_routes = neo1973_wm8753_routes,
+	.num_dapm_routes = ARRAY_SIZE(neo1973_wm8753_routes),
 };
 
 static struct platform_device *neo1973_snd_device;
-- 
1.8.0
