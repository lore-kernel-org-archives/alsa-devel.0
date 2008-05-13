From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/10] soc - neo1973_wm8753 - Convert to bulk
	DAPM registration APIs
Date: Tue, 13 May 2008 12:40:13 +0100
Message-ID: <1210678815-9755-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C36824AE7
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:18 +0200 (CEST)
In-Reply-To: <1210678815-9755-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Graeme Gregory <graeme@openmoko.org>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index e469186..79c5027 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -425,8 +425,7 @@ static const struct snd_soc_dapm_widget wm8753_dapm_widgets[] = {
 };
 
 
-/* example machine audio_mapnections */
-static const char *audio_map[][3] = {
+static const struct snd_soc_dapm_route dapm_routes[] = {
 
 	/* Connections to the lm4857 amp */
 	{"Audio Out", NULL, "LOUT1"},
@@ -449,8 +448,6 @@ static const char *audio_map[][3] = {
 
 	/* Connect the ALC pins */
 	{"ACIN", NULL, "ACOP"},
-
-	{NULL, NULL, NULL},
 };
 
 static const char *lm4857_mode[] = {
@@ -526,8 +523,8 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 	set_scenario_endpoints(codec, NEO_AUDIO_OFF);
 
 	/* Add neo1973 specific widgets */
-	for (i = 0; i < ARRAY_SIZE(wm8753_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &wm8753_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
+				  ARRAY_SIZE(wm8753_dapm_widgets));
 
 	/* add neo1973 specific controls */
 	for (i = 0; i < ARRAY_SIZE(wm8753_neo1973_controls); i++) {
@@ -538,11 +535,9 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 			return err;
 	}
 
-	/* set up neo1973 specific audio path audio_mapnects */
-	for (i = 0; audio_map[i][0] != NULL; i++) {
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
-	}
+	/* set up neo1973 specific audio routes */
+	err = snd_soc_dapm_add_routes(codec, dapm_routes,
+				      ARRAY_SIZE(dapm_routes));
 
 	snd_soc_dapm_sync_endpoints(codec);
 	return 0;
-- 
1.5.5.1
