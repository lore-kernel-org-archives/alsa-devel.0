From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/14] ASoC: Support DAPM events for DACs and
	ADCs
Date: Tue, 14 Apr 2009 13:33:10 +0100
Message-ID: <1239712393-6428-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5E672434C
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:33:17 +0200 (CEST)
In-Reply-To: <20090414123220.GA6342@rakim.wolfsonmicro.main>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |   10 ++++++++++
 sound/soc/soc-dapm.c     |   16 ++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a7def6a..fcc929d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -140,9 +140,19 @@
 #define SND_SOC_DAPM_DAC(wname, stname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, .reg = wreg, \
 	.shift = wshift, .invert = winvert}
+#define SND_SOC_DAPM_DAC_E(wname, stname, wreg, wshift, winvert, \
+			   wevent, wflags)				\
+{	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, .reg = wreg, \
+	.shift = wshift, .invert = winvert, \
+	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_ADC(wname, stname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, .reg = wreg, \
 	.shift = wshift, .invert = winvert}
+#define SND_SOC_DAPM_ADC_E(wname, stname, wreg, wshift, winvert, \
+			   wevent, wflags)				\
+{	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, .reg = wreg, \
+	.shift = wshift, .invert = winvert, \
+	.event = wevent, .event_flags = wflags}
 
 /* generic register modifier widget */
 #define SND_SOC_DAPM_REG(wid, wname, wreg, wshift, wmask, won_val, woff_val) \
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 713d125..a6d7337 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -598,18 +598,22 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 	if (w->id == snd_soc_dapm_adc && w->active) {
 		in = is_connected_input_ep(w);
 		dapm_clear_walk(w->codec);
-		w->power = (in != 0) ? 1 : 0;
-		dapm_update_bits(w);
-		return 0;
+		power = (in != 0) ? 1 : 0;
+		if (power == w->power)
+			return 0;
+		w->power = power;
+		return dapm_generic_apply_power(w);
 	}
 
 	/* active DAC */
 	if (w->id == snd_soc_dapm_dac && w->active) {
 		out = is_connected_output_ep(w);
 		dapm_clear_walk(w->codec);
-		w->power = (out != 0) ? 1 : 0;
-		dapm_update_bits(w);
-		return 0;
+		power = (out != 0) ? 1 : 0;
+		if (power == w->power)
+			return 0;
+		w->power = power;
+		return dapm_generic_apply_power(w);
 	}
 
 	/* pre and post event widgets */
-- 
1.6.2.2
