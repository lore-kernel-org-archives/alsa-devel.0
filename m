From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH] ASoC: dapm: Add speaker driver widget.
Date: Mon, 6 Dec 2010 16:34:37 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E707724454
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 23:34:40 +0100 (CET)
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

In some cases it was not possible to follow the appropiate power
ON/OFF sequence.
Add a widget to support speaker drivers where power ON/OFF
ordering is important.

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 include/sound/soc-dapm.h |   10 ++++++++++
 sound/soc/soc-dapm.c     |    6 ++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 041e98b..3b438e5 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -71,6 +71,10 @@
 	 wcontrols, wncontrols) \
 {	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
+#define SND_SOC_DAPM_DRV(wname, wreg, wshift, winvert,\
+	 wcontrols, wncontrols) \
+{	.id = snd_soc_dapm_drv, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MIXER(wname, wreg, wshift, winvert, \
 	 wcontrols, wncontrols)\
 {	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
@@ -115,6 +119,11 @@
 {	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
+#define SND_SOC_DAPM_DRV_E(wname, wreg, wshift, winvert, wcontrols, \
+	wncontrols, wevent, wflags) \
+{	.id = snd_soc_dapm_drv, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
+	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MIXER_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
 {	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
@@ -368,6 +377,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_mixer,			/* mixes several analog signals together */
 	snd_soc_dapm_mixer_named_ctl,		/* mixer with named controls */
 	snd_soc_dapm_pga,			/* programmable gain/attenuation (volume) */
+	snd_soc_dapm_drv,			/* speaker driver */
 	snd_soc_dapm_adc,			/* analog to digital converter */
 	snd_soc_dapm_dac,			/* digital to analog converter */
 	snd_soc_dapm_micbias,		/* microphone bias (power) */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6a29d59..4726b65 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -61,6 +61,7 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_mixer] = 7,
 	[snd_soc_dapm_mixer_named_ctl] = 7,
 	[snd_soc_dapm_pga] = 8,
+	[snd_soc_dapm_drv] = 9,
 	[snd_soc_dapm_adc] = 9,
 	[snd_soc_dapm_hp] = 10,
 	[snd_soc_dapm_spk] = 10,
@@ -72,6 +73,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_adc] = 1,
 	[snd_soc_dapm_hp] = 2,
 	[snd_soc_dapm_spk] = 2,
+	[snd_soc_dapm_drv] = 3,
 	[snd_soc_dapm_pga] = 4,
 	[snd_soc_dapm_mixer_named_ctl] = 5,
 	[snd_soc_dapm_mixer] = 5,
@@ -231,6 +233,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	break;
 	/* does not effect routing - always connected */
 	case snd_soc_dapm_pga:
+	case snd_soc_dapm_drv:
 	case snd_soc_dapm_output:
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_input:
@@ -1243,6 +1246,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 		case snd_soc_dapm_dac:
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_pga:
+		case snd_soc_dapm_drv:
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
 		case snd_soc_dapm_supply:
@@ -1421,6 +1425,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_pga:
+	case snd_soc_dapm_drv:
 	case snd_soc_dapm_input:
 	case snd_soc_dapm_output:
 	case snd_soc_dapm_micbias:
@@ -1538,6 +1543,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 			w->power_check = dapm_dac_check_power;
 			break;
 		case snd_soc_dapm_pga:
+		case snd_soc_dapm_drv:
 			w->power_check = dapm_generic_check_power;
 			dapm_new_pga(dapm, w);
 			break;
-- 
1.7.0.4
