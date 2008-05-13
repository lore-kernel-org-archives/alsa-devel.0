From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/10] soc - tlv320aic3x - Convert to use bulk
	registration APIs
Date: Tue, 13 May 2008 12:40:10 +0100
Message-ID: <1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A651F24A9B
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:17 +0200 (CEST)
In-Reply-To: <1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 957996e..cb8365a 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -497,7 +497,7 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LINE2R"),
 };
 
-static const char *intercon[][3] = {
+static const struct snd_soc_dapm_route intercon[] = {
 	/* Left Output */
 	{"Left DAC Mux", "DAC_L1", "Left DAC"},
 	{"Left DAC Mux", "DAC_L2", "Left DAC"},
@@ -641,22 +641,15 @@ static const char *intercon[][3] = {
 	{"Right Line Out", NULL, "Right Line2 Bypass Mixer"},
 	{"Mono Out", NULL, "Right Line2 Bypass Mixer"},
 	{"Right HP Out", NULL, "Right Line2 Bypass Mixer"},
-
-	/* terminator */
-	{NULL, NULL, NULL},
 };
 
 static int aic3x_add_widgets(struct snd_soc_codec *codec)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(aic3x_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &aic3x_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, aic3x_dapm_widgets,
+				  ARRAY_SIZE(aic3x_dapm_widgets));
 
 	/* set up audio path interconnects */
-	for (i = 0; intercon[i][0] != NULL; i++)
-		snd_soc_dapm_connect_input(codec, intercon[i][0],
-					   intercon[i][1], intercon[i][2]);
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
 
 	snd_soc_dapm_new_widgets(codec);
 	return 0;
-- 
1.5.5.1
