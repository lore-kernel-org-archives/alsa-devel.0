From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCHv4 1/3] ASoC: sdp4430: Enable FM stereo pins
Date: Fri, 10 Dec 2010 20:45:14 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225CB@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 858682464F
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 03:45:17 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

Add FM stereo pins to the machine driver and add them as a
dapm widget.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/sdp4430.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index ebbd62f..0c37c51 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -101,6 +101,7 @@ static const struct snd_soc_dapm_widget sdp4430_twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
 	SND_SOC_DAPM_SPK("Earphone Spk", NULL),
+	SND_SOC_DAPM_INPUT("Aux/FM Stereo In"),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
@@ -123,6 +124,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	/* Earphone speaker */
 	{"Earphone Spk", NULL, "EP"},
+
+	/* Aux/FM Stereo In: AFML, AFMR */
+	{"AFML", NULL, "Aux/FM Stereo In"},
+	{"AFMR", NULL, "Aux/FM Stereo In"},
 };
 
 static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
@@ -149,13 +154,11 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	/* SDP4430 connected pins */
 	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
 	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+	snd_soc_dapm_enable_pin(dapm, "AFML");
+	snd_soc_dapm_enable_pin(dapm, "AFMR");
 	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
 	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
 
-	/* TWL6040 not connected pins */
-	snd_soc_dapm_nc_pin(dapm, "AFML");
-	snd_soc_dapm_nc_pin(dapm, "AFMR");
-
 	ret = snd_soc_dapm_sync(dapm);
 
 	return ret;
-- 
1.7.0.4
