From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: sdp4430: Let the core to register
	DAPM widgets/routes
Date: Fri,  7 Oct 2011 10:49:32 +0300
Message-ID: <1317973772-14127-2-git-send-email-peter.ujfalusi@ti.com>
References: <1317973772-14127-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67]) by alsa0.perex.cz (Postfix) with ESMTP id DB50424651
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 09:49:20 +0200 (CEST)
Received: by mail-bw0-f43.google.com with SMTP id s6so6644806bka.16
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 00:49:17 -0700 (PDT)
In-Reply-To: <1317973772-14127-1-git-send-email-peter.ujfalusi@ti.com>
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

Pass the DAPM widgets/routes via the snd_soc_card struct
to core. In this way the machine driver does not need to
handle the DAPM widgets/routes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp4430.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 3069226..cc3d792 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -120,22 +120,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret, hs_trim;
 
-	/* Add SDP4430 specific widgets */
-	ret = snd_soc_dapm_new_controls(dapm, sdp4430_twl6040_dapm_widgets,
-				ARRAY_SIZE(sdp4430_twl6040_dapm_widgets));
-	if (ret)
-		return ret;
-
-	/* Set up SDP4430 specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	ret = snd_soc_dapm_new_widgets(dapm);
-	if (ret)
-		return ret;
-
 	/*
 	 * Configure McPDM offset cancellation based on the HSOTRIM value from
 	 * twl6040.
@@ -178,6 +164,11 @@ static struct snd_soc_card snd_soc_sdp4430 = {
 	.name = "SDP4430",
 	.dai_link = &sdp4430_dai,
 	.num_links = 1,
+
+	.dapm_widgets = sdp4430_twl6040_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(sdp4430_twl6040_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *sdp4430_snd_device;
-- 
1.7.7
