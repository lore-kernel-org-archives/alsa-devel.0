From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/10] soc - eti_b1_wm8731 - Convert to use
	bulk DAPM control registration
Date: Tue, 13 May 2008 12:40:12 +0100
Message-ID: <1210678815-9755-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0921824AF2
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:19 +0200 (CEST)
In-Reply-To: <1210678815-9755-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Frank Mandarino <fmandarino@endrelia.com>
---
 sound/soc/at91/eti_b1_wm8731.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/sound/soc/at91/eti_b1_wm8731.c b/sound/soc/at91/eti_b1_wm8731.c
index 1347dcf..4a383a4 100644
--- a/sound/soc/at91/eti_b1_wm8731.c
+++ b/sound/soc/at91/eti_b1_wm8731.c
@@ -191,7 +191,7 @@ static const struct snd_soc_dapm_widget eti_b1_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 };
 
-static const char *intercon[][3] = {
+static const struct snd_soc_dapm_route intercon[] = {
 
 	/* speaker connected to LHPOUT */
 	{"Ext Spk", NULL, "LHPOUT"},
@@ -199,9 +199,6 @@ static const char *intercon[][3] = {
 	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
 	{"MICIN", NULL, "Mic Bias"},
 	{"Mic Bias", NULL, "Int Mic"},
-
-	/* terminator */
-	{NULL, NULL, NULL},
 };
 
 /*
@@ -209,20 +206,14 @@ static const char *intercon[][3] = {
  */
 static int eti_b1_wm8731_init(struct snd_soc_codec *codec)
 {
-	int i;
-
 	DBG("eti_b1_wm8731_init() called\n");
 
 	/* Add specific widgets */
-	for(i = 0; i < ARRAY_SIZE(eti_b1_dapm_widgets); i++) {
-		snd_soc_dapm_new_control(codec, &eti_b1_dapm_widgets[i]);
-	}
+	snd_soc_dapm_new_controls(codec, eti_b1_dapm_widgets,
+				  ARRAY_SIZE(eti_b1_dapm_widgets));
 
 	/* Set up specific audio path interconnects */
-	for(i = 0; intercon[i][0] != NULL; i++) {
-		snd_soc_dapm_connect_input(codec, intercon[i][0],
-			intercon[i][1], intercon[i][2]);
-	}
+	snd_soc_dapm_add_route(codec, intercon, ARRAY_SIZE(intercon));
 
 	/* not connected */
 	snd_soc_dapm_set_endpoint(codec, "RLINEIN", 0);
-- 
1.5.5.1
