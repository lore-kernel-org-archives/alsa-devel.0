From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/4] ASoC: omap-abe-twl6040: Move Digital
	Mic widget into dapm table
Date: Wed, 16 May 2012 14:57:03 +0300
Message-ID: <1337169425-9449-3-git-send-email-peter.ujfalusi@ti.com>
References: <1337169425-9449-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog135.obsmtp.com (na3sys009aog135.obsmtp.com
	[74.125.149.84])
	by alsa0.perex.cz (Postfix) with ESMTP id AA4061043FB
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2012 13:57:26 +0200 (CEST)
Received: by laai10 with SMTP id i10so814882laa.27
	for <alsa-devel@alsa-project.org>; Wed, 16 May 2012 04:57:24 -0700 (PDT)
In-Reply-To: <1337169425-9449-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: devicetree-discuss@lists.ozlabs.org, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org

The needed change in routing will be done runtime for the non
twl6040 connected widgets, like the Digital microphone.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 31ab6fe..4388de9 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -128,6 +128,9 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Main Handset Mic", NULL),
 	SND_SOC_DAPM_MIC("Sub Handset Mic", NULL),
 	SND_SOC_DAPM_LINE("Line In", NULL),
+
+	/* Digital microphones */
+	SND_SOC_DAPM_MIC("Digital Mic", NULL),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
@@ -210,10 +213,6 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
-	SND_SOC_DAPM_MIC("Digital Mic", NULL),
-};
-
 static const struct snd_soc_dapm_route dmic_audio_map[] = {
 	{"DMic", NULL, "Digital Mic"},
 	{"Digital Mic", NULL, "Digital Mic1 Bias"},
@@ -223,12 +222,6 @@ static int omap_abe_dmic_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	ret = snd_soc_dapm_new_controls(dapm, dmic_dapm_widgets,
-				ARRAY_SIZE(dmic_dapm_widgets));
-	if (ret)
-		return ret;
 
 	return snd_soc_dapm_add_routes(dapm, dmic_audio_map,
 				ARRAY_SIZE(dmic_audio_map));
-- 
1.7.8.6
