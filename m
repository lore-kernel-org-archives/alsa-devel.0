From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Convert playpaq_wm8510 to bulk route
	registration API
Date: Thu, 16 Oct 2008 11:00:06 +0100
Message-ID: <1224151207-5496-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 738F0103825
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 12:00:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/at32/playpaq_wm8510.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/at32/playpaq_wm8510.c b/sound/soc/at32/playpaq_wm8510.c
index 98a2d58..b1966e4 100644
--- a/sound/soc/at32/playpaq_wm8510.c
+++ b/sound/soc/at32/playpaq_wm8510.c
@@ -304,7 +304,7 @@ static const struct snd_soc_dapm_widget playpaq_dapm_widgets[] = {
 
 
 
-static const char *intercon[][3] = {
+static const struct snd_soc_dapm_route intercon[] = {
 	/* speaker connected to SPKOUT */
 	{"Ext Spk", NULL, "SPKOUTP"},
 	{"Ext Spk", NULL, "SPKOUTN"},
@@ -312,9 +312,6 @@ static const char *intercon[][3] = {
 	{"Mic Bias", NULL, "Int Mic"},
 	{"MICN", NULL, "Mic Bias"},
 	{"MICP", NULL, "Mic Bias"},
-
-	/* Terminator */
-	{NULL, NULL, NULL},
 };
 
 
@@ -334,11 +331,8 @@ static int playpaq_wm8510_init(struct snd_soc_codec *codec)
 	/*
 	 * Setup audio path interconnects
 	 */
-	for (i = 0; intercon[i][0] != NULL; i++) {
-		snd_soc_dapm_connect_input(codec,
-					   intercon[i][0],
-					   intercon[i][1], intercon[i][2]);
-	}
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
 
 
 	/* always connected pins */
-- 
1.5.6.5
