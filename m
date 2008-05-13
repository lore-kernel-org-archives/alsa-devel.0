From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/10] soc - n810 - Update for bulk DAPM
	registration APIs
Date: Tue, 13 May 2008 12:40:15 +0100
Message-ID: <1210678815-9755-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-9-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6CFE24AC0
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:18 +0200 (CEST)
In-Reply-To: <1210678815-9755-9-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/omap/n810.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 83b1eb4..1340f73 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -177,7 +177,7 @@ static const struct snd_soc_dapm_widget aic33_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", n810_jack_event),
 };
 
-static const char *audio_map[][3] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 	{"Headphone Jack", NULL, "HPLOUT"},
 	{"Headphone Jack", NULL, "HPROUT"},
 
@@ -217,13 +217,11 @@ static int n810_aic33_init(struct snd_soc_codec *codec)
 	}
 
 	/* Add N810 specific widgets */
-	for (i = 0; i < ARRAY_SIZE(aic33_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &aic33_dapm_widgets[i]);
+	snd_soc_dapm_new_controls(codec, aic33_dapm_widgets,
+				  ARRAY_SIZE(aic33_dapm_widgets));
 
 	/* Set up N810 specific audio path audio_map */
-	for (i = 0; i < ARRAY_SIZE(audio_map); i++)
-		snd_soc_dapm_connect_input(codec, audio_map[i][0],
-			audio_map[i][1], audio_map[i][2]);
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_dapm_sync_endpoints(codec);
 
-- 
1.5.5.1
