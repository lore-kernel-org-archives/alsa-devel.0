From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Assign power_check when we allocate
	DAPM widgets
Date: Sun,  9 Oct 2011 11:28:29 +0100
Message-ID: <1318156113-3344-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2667245D3
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Oct 2011 12:28:37 +0200 (CEST)
In-Reply-To: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This ensures none of the rest of the code ever encounters a widget which
does not have a power check function.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   67 +++++++++++++++++++++++++++++---------------------
 1 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b9836ab..24e5d45 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2138,48 +2138,21 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		case snd_soc_dapm_switch:
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
-			w->power_check = dapm_generic_check_power;
 			dapm_new_mixer(w);
 			break;
 		case snd_soc_dapm_mux:
 		case snd_soc_dapm_virt_mux:
 		case snd_soc_dapm_value_mux:
-			w->power_check = dapm_generic_check_power;
 			dapm_new_mux(w);
 			break;
-		case snd_soc_dapm_adc:
-		case snd_soc_dapm_aif_out:
-			w->power_check = dapm_adc_check_power;
-			break;
-		case snd_soc_dapm_dac:
-		case snd_soc_dapm_aif_in:
-			w->power_check = dapm_dac_check_power;
-			break;
 		case snd_soc_dapm_pga:
 		case snd_soc_dapm_out_drv:
-			w->power_check = dapm_generic_check_power;
 			dapm_new_pga(w);
 			break;
-		case snd_soc_dapm_input:
-		case snd_soc_dapm_output:
-		case snd_soc_dapm_micbias:
-		case snd_soc_dapm_spk:
-		case snd_soc_dapm_hp:
-		case snd_soc_dapm_mic:
-		case snd_soc_dapm_line:
-			w->power_check = dapm_generic_check_power;
-			break;
-		case snd_soc_dapm_supply:
-			w->power_check = dapm_supply_check_power;
-		case snd_soc_dapm_vmid:
-		case snd_soc_dapm_pre:
-		case snd_soc_dapm_post:
+		default:
 			break;
 		}
 
-		if (!w->power_check)
-			w->power_check = dapm_always_on_check_power;
-
 		/* Read the initial power state from the device */
 		if (w->reg >= 0) {
 			val = soc_widget_read(w, w->reg);
@@ -2668,6 +2641,44 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	else
 		snprintf(w->name, name_len, "%s", widget->name);
 
+	switch (w->id) {
+	case snd_soc_dapm_switch:
+	case snd_soc_dapm_mixer:
+	case snd_soc_dapm_mixer_named_ctl:
+		w->power_check = dapm_generic_check_power;
+		break;
+	case snd_soc_dapm_mux:
+	case snd_soc_dapm_virt_mux:
+	case snd_soc_dapm_value_mux:
+		w->power_check = dapm_generic_check_power;
+		break;
+	case snd_soc_dapm_adc:
+	case snd_soc_dapm_aif_out:
+		w->power_check = dapm_adc_check_power;
+		break;
+	case snd_soc_dapm_dac:
+	case snd_soc_dapm_aif_in:
+		w->power_check = dapm_dac_check_power;
+		break;
+	case snd_soc_dapm_pga:
+	case snd_soc_dapm_out_drv:
+	case snd_soc_dapm_input:
+	case snd_soc_dapm_output:
+	case snd_soc_dapm_micbias:
+	case snd_soc_dapm_spk:
+	case snd_soc_dapm_hp:
+	case snd_soc_dapm_mic:
+	case snd_soc_dapm_line:
+		w->power_check = dapm_generic_check_power;
+		break;
+	case snd_soc_dapm_supply:
+		w->power_check = dapm_supply_check_power;
+		break;
+	default:
+		w->power_check = dapm_always_on_check_power;
+		break;
+	}
+
 	dapm->n_widgets++;
 	w->dapm = dapm;
 	w->codec = dapm->codec;
-- 
1.7.6.3
