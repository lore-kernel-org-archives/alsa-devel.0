From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH resend] ASoC: sdp4430: Fix string for FM input
	name
Date: Fri, 30 Sep 2011 11:39:50 +0300
Message-ID: <1317371990-5499-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id A757224337
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 10:39:48 +0200 (CEST)
Received: by mail-bw0-f54.google.com with SMTP id zs8so1758547bkb.41
	for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2011 01:39:46 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>

The name contains invalid valid character (/), which
causes problems when trying to create the debugfs
directory structure:
ASoC: Failed to create Aux/FM Stereo In debugfs file

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---

Hi Mark, Liam,

Could you take this patch, it has been not taken for upstream.

Thanks,
Peter

 sound/soc/omap/sdp4430.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 249d84b..79ec76d 100644
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
1.7.6.1
