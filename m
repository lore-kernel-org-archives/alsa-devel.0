From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: sdp4430: Fix string for FM input name
Date: Wed, 6 Jul 2011 21:18:05 +0300
Message-ID: <1309976285-25319-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E31924406
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 20:18:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Misael Lopez Cruz <misael.lopez@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The name contains invalid valid character (/), which
causes problems when trying to create the debugfs
directory structure:
ASoC: Failed to create Aux/FM Stereo In debugfs file

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp4430.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index a951774..d462f1a 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -88,7 +88,7 @@ static const struct snd_soc_dapm_widget sdp4430_twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
 	SND_SOC_DAPM_SPK("Earphone Spk", NULL),
-	SND_SOC_DAPM_INPUT("Aux/FM Stereo In"),
+	SND_SOC_DAPM_INPUT("FM Stereo In"),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
@@ -113,8 +113,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Earphone Spk", NULL, "EP"},
 
 	/* Aux/FM Stereo In: AFML, AFMR */
-	{"AFML", NULL, "Aux/FM Stereo In"},
-	{"AFMR", NULL, "Aux/FM Stereo In"},
+	{"AFML", NULL, "FM Stereo In"},
+	{"AFMR", NULL, "FM Stereo In"},
 };
 
 static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
-- 
1.7.6
