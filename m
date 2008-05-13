From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/10] soc - davinci-evm - Update for bulk DAPM
	registration APIs
Date: Tue, 13 May 2008 12:40:14 +0100
Message-ID: <1210678815-9755-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-8-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E06B24AEB
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:18 +0200 (CEST)
In-Reply-To: <1210678815-9755-8-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/davinci/davinci-evm.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index fcd1652..4c70a0e 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -71,7 +71,7 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 };
 
 /* davinci-evm machine audio_mapnections to the codec pins */
-static const char *audio_map[][3] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 	/* Headphone connected to HPLOUT, HPROUT */
 	{"Headphone Jack", NULL, "HPLOUT"},
 	{"Headphone Jack", NULL, "HPROUT"},
@@ -90,23 +90,17 @@ static const char *audio_map[][3] = {
 	{"LINE2L", NULL, "Line In"},
 	{"LINE1R", NULL, "Line In"},
 	{"LINE2R", NULL, "Line In"},
-
-	{NULL, NULL, NULL},
 };
 
 /* Logic for a aic3x as connected on a davinci-evm */
 static int evm_aic3x_init(struct snd_soc_codec *codec)
 {
-	int i;
-
 	/* Add davinci-evm specific widgets */
-	for (i = 0; i < ARRAY_SIZE(aic3x_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &aic3x_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, aic3x_dapm_widgets,
+				  ARRAY_SIZE(aic3x_dapm_widgets));
 
 	/* Set up davinci-evm specific audio path audio_map */
-	for (i = 0; audio_map[i][0] != NULL; i++)
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-					   audio_map[i][1], audio_map[i][2]);
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	/* not connected */
 	snd_soc_dapm_set_endpoint(codec, "MONO_LOUT", 0);
-- 
1.5.5.1
