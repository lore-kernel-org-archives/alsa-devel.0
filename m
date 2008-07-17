From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Factor PGA DAPM handling into main
Date: Thu, 17 Jul 2008 11:59:36 +0100
Message-ID: <1216292376-2583-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1216292376-2583-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFFED24403
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 12:59:37 +0200 (CEST)
In-Reply-To: <1216292376-2583-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This allows pre and post event hooks to be provided for PGA widgets.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9307b10..54908f6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -523,24 +523,6 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 				continue;
 			}
 
-			/* programmable gain/attenuation */
-			if (w->id == snd_soc_dapm_pga) {
-				int on;
-				in = is_connected_input_ep(w);
-				dapm_clear_walk(w->codec);
-				out = is_connected_output_ep(w);
-				dapm_clear_walk(w->codec);
-				w->power = on = (out != 0 && in != 0) ? 1 : 0;
-
-				if (!on)
-					dapm_set_pga(w, on); /* lower volume to reduce pops */
-				dapm_update_bits(w);
-				if (on)
-					dapm_set_pga(w, on); /* restore volume from zero */
-
-				continue;
-			}
-
 			/* pre and post event widgets */
 			if (w->id == snd_soc_dapm_pre) {
 				if (!w->event)
@@ -608,8 +590,16 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 					return ret;
 			}
 
+			/* Lower PGA volume to reduce pops */
+			if (w->id == snd_soc_dapm_pga && !power)
+				dapm_set_pga(w, power);
+
 			dapm_update_bits(w);
 
+			/* Raise PGA volume to reduce pops */
+			if (w->id == snd_soc_dapm_pga && power)
+				dapm_set_pga(w, power);
+
 			/* power up post event */
 			if (power_change && power && w->event &&
 			    w->event_flags & SND_SOC_DAPM_POST_PMU){
-- 
1.5.6.2
