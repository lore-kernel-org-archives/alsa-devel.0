From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/10] ASoC: dapm: Make widget power register
	settings more flexible
Date: Mon, 29 Jul 2013 17:14:01 +0200
Message-ID: <1375110845-8069-7-git-send-email-lars@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 50D0526260F
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 17:13:16 +0200 (CEST)
In-Reply-To: <1375110845-8069-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently the DAPM code is limited to only setting or clearing a single bit in a
register to power a widget up or down. This patch extends the DAPM code to be
more flexible in that regard and allow widgets to use arbitrary values to be
used to put a widget in either on or off state.

Since the snd_soc_dapm_widget struct already contains a on_val and off_val field
no additional fields need to be added and in fact the invert field can even be
removed. Also the generated code is slightly smaller.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 163 +++++++++++++++++++++++++++--------------------
 sound/soc/soc-dapm.c     |  34 ++++------
 2 files changed, 106 insertions(+), 91 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 693c75b..3575721 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -70,121 +70,144 @@ struct device;
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 
+#define SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert) \
+	.reg = wreg, .mask = 1, .shift = wshift, \
+	.on_val = winvert ? 0 : 1, .off_val = winvert ? 1 : 0
+
 /* path domain */
 #define SND_SOC_DAPM_PGA(wname, wreg, wshift, winvert,\
 	 wcontrols, wncontrols) \
-{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
+{	.id = snd_soc_dapm_pga, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_OUT_DRV(wname, wreg, wshift, winvert,\
 	 wcontrols, wncontrols) \
-{	.id = snd_soc_dapm_out_drv, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
+{	.id = snd_soc_dapm_out_drv, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MIXER(wname, wreg, wshift, winvert, \
 	 wcontrols, wncontrols)\
-{	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
+{	.id = snd_soc_dapm_mixer, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MIXER_NAMED_CTL(wname, wreg, wshift, winvert, \
 	 wcontrols, wncontrols)\
-{       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, .reg = wreg, \
-	.shift = wshift, .invert = winvert, .kcontrol_news = wcontrols, \
-	.num_kcontrols = wncontrols}
+{       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
-{	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = NULL, .num_kcontrols = 0}
+{	.id = snd_soc_dapm_micbias, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = NULL, .num_kcontrols = 0}
 #define SND_SOC_DAPM_SWITCH(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1}
+{	.id = snd_soc_dapm_switch, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1}
+{	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, \
+	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_VIRT_MUX(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_virt_mux, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1}
+{	.id = snd_soc_dapm_virt_mux, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_VALUE_MUX(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_value_mux, .name = wname, .reg = wreg, \
-	.shift = wshift, .invert = winvert, .kcontrol_news = wcontrols, \
-	.num_kcontrols = 1}
+{	.id = snd_soc_dapm_value_mux, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_ARRAY(wname, wreg, wshift, winvert,\
 	 wcontrols) \
-{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
+{	.id = snd_soc_dapm_pga, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
 #define SOC_MIXER_ARRAY(wname, wreg, wshift, winvert, \
 	 wcontrols)\
-{	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
+{	.id = snd_soc_dapm_mixer, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
 #define SOC_MIXER_NAMED_CTL_ARRAY(wname, wreg, wshift, winvert, \
 	 wcontrols)\
-{       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, .reg = wreg, \
-	.shift = wshift, .invert = winvert, .kcontrol_news = wcontrols, \
-	.num_kcontrols = ARRAY_SIZE(wcontrols)}
+{       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
 
 /* path domain with event - event handler must return 0 for success */
 #define SND_SOC_DAPM_PGA_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
-{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
+{	.id = snd_soc_dapm_pga, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_OUT_DRV_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
-{	.id = snd_soc_dapm_out_drv, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
+{	.id = snd_soc_dapm_out_drv, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MIXER_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
-{	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
+{	.id = snd_soc_dapm_mixer, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MIXER_NAMED_CTL_E(wname, wreg, wshift, winvert, \
 	wcontrols, wncontrols, wevent, wflags) \
-{       .id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, \
+{       .id = snd_soc_dapm_mixer, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, \
 	.num_kcontrols = wncontrols, .event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_SWITCH_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1, \
+{	.id = snd_soc_dapm_switch, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1, \
+{	.id = snd_soc_dapm_mux, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_VIRT_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_virt_mux, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = 1, \
+{	.id = snd_soc_dapm_virt_mux, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 
 /* additional sequencing control within an event type */
 #define SND_SOC_DAPM_PGA_S(wname, wsubseq, wreg, wshift, winvert, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .event = wevent, .event_flags = wflags, \
+{	.id = snd_soc_dapm_pga, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.event = wevent, .event_flags = wflags, \
 	.subseq = wsubseq}
 #define SND_SOC_DAPM_SUPPLY_S(wname, wsubseq, wreg, wshift, winvert, wevent, \
 	wflags)	\
-{	.id = snd_soc_dapm_supply, .name = wname, .reg = wreg,	\
-	.shift = wshift, .invert = winvert, .event = wevent, \
-	.event_flags = wflags, .subseq = wsubseq}
+{	.id = snd_soc_dapm_supply, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.event = wevent, .event_flags = wflags, .subseq = wsubseq}
 
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
+{	.id = snd_soc_dapm_pga, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
 	.event = wevent, .event_flags = wflags}
 #define SOC_MIXER_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-{	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
+{	.id = snd_soc_dapm_mixer, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
 	.event = wevent, .event_flags = wflags}
 #define SOC_MIXER_NAMED_CTL_E_ARRAY(wname, wreg, wshift, winvert, \
 	wcontrols, wevent, wflags) \
-{       .id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrol_news = wcontrols, \
-	.num_kcontrols = ARRAY_SIZE(wcontrols), .event = wevent, .event_flags = wflags}
+{       .id = snd_soc_dapm_mixer, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
+	.event = wevent, .event_flags = wflags}
 
 /* events that are pre and post DAPM */
 #define SND_SOC_DAPM_PRE(wname, wevent) \
@@ -199,35 +222,36 @@ struct device;
 /* stream domain */
 #define SND_SOC_DAPM_AIF_IN(wname, stname, wslot, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
-	.reg = wreg, .shift = wshift, .invert = winvert }
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
 #define SND_SOC_DAPM_AIF_IN_E(wname, stname, wslot, wreg, wshift, winvert, \
 			      wevent, wflags)				\
 {	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
-	.reg = wreg, .shift = wshift, .invert = winvert, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags }
 #define SND_SOC_DAPM_AIF_OUT(wname, stname, wslot, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
-	.reg = wreg, .shift = wshift, .invert = winvert }
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
 #define SND_SOC_DAPM_AIF_OUT_E(wname, stname, wslot, wreg, wshift, winvert, \
 			     wevent, wflags)				\
 {	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
-	.reg = wreg, .shift = wshift, .invert = winvert, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags }
 #define SND_SOC_DAPM_DAC(wname, stname, wreg, wshift, winvert) \
-{	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, .reg = wreg, \
-	.shift = wshift, .invert = winvert}
+{	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert) }
 #define SND_SOC_DAPM_DAC_E(wname, stname, wreg, wshift, winvert, \
 			   wevent, wflags)				\
-{	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, .reg = wreg, \
-	.shift = wshift, .invert = winvert, \
+{	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags}
+
 #define SND_SOC_DAPM_ADC(wname, stname, wreg, wshift, winvert) \
-{	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, .reg = wreg, \
-	.shift = wshift, .invert = winvert}
+{	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), }
 #define SND_SOC_DAPM_ADC_E(wname, stname, wreg, wshift, winvert, \
 			   wevent, wflags)				\
-{	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, .reg = wreg, \
-	.shift = wshift, .invert = winvert, \
+{	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_CLOCK_SUPPLY(wname) \
 {	.id = snd_soc_dapm_clock_supply, .name = wname, \
@@ -241,14 +265,14 @@ struct device;
 	.on_val = won_val, .off_val = woff_val, .event = dapm_reg_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD}
 #define SND_SOC_DAPM_SUPPLY(wname, wreg, wshift, winvert, wevent, wflags) \
-{	.id = snd_soc_dapm_supply, .name = wname, .reg = wreg,	\
-	.shift = wshift, .invert = winvert, .event = wevent, \
-	.event_flags = wflags}
+{	.id = snd_soc_dapm_supply, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_REGULATOR_SUPPLY(wname, wdelay, wflags)	    \
 {	.id = snd_soc_dapm_regulator_supply, .name = wname, \
 	.reg = SND_SOC_NOPM, .shift = wdelay, .event = dapm_regulator_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD, \
-	.invert = wflags}
+	.on_val = wflags}
 
 
 /* dapm kcontrol types */
@@ -527,7 +551,6 @@ struct snd_soc_dapm_widget {
 	unsigned int on_val;			/* on state value */
 	unsigned int off_val;			/* off state value */
 	unsigned char power:1;			/* block power status */
-	unsigned char invert:1;			/* invert the power bit */
 	unsigned char active:1;			/* active stream on DAC, ADC's */
 	unsigned char connected:1;		/* connected codec pin */
 	unsigned char new:1;			/* cnew complete */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b779d36..59bcc66 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1122,7 +1122,7 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 	int ret;
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
+		if (w->on_val & SND_SOC_DAPM_REGULATOR_BYPASS) {
 			ret = regulator_allow_bypass(w->regulator, false);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
@@ -1132,7 +1132,7 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 
 		return regulator_enable(w->regulator);
 	} else {
-		if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
+		if (w->on_val & SND_SOC_DAPM_REGULATOR_BYPASS) {
 			ret = regulator_allow_bypass(w->regulator, true);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
@@ -1360,26 +1360,21 @@ static void dapm_seq_run_coalesced(struct snd_soc_card *card,
 				   struct list_head *pending)
 {
 	struct snd_soc_dapm_widget *w;
-	int reg, power;
+	int reg;
 	unsigned int value = 0;
 	unsigned int mask = 0;
-	unsigned int cur_mask;
 
 	reg = list_first_entry(pending, struct snd_soc_dapm_widget,
 			       power_list)->reg;
 
 	list_for_each_entry(w, pending, power_list) {
-		cur_mask = 1 << w->shift;
 		BUG_ON(reg != w->reg);
 
-		if (w->invert)
-			power = !w->power;
+		mask |= w->mask << w->shift;
+		if (w->power)
+			value |= w->on_val << w->shift;
 		else
-			power = w->power;
-
-		mask |= cur_mask;
-		if (power)
-			value |= cur_mask;
+			value |= w->off_val << w->shift;
 
 		pop_dbg(w->dapm->dev, card->pop_time,
 			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
@@ -1867,8 +1862,8 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 
 	if (w->reg >= 0)
 		ret += snprintf(buf + ret, PAGE_SIZE - ret,
-				" - R%d(0x%x) bit %d",
-				w->reg, w->reg, w->shift);
+				" - R%d(0x%x) mask 0x%x",
+				w->reg, w->reg, w->mask << w->shift);
 
 	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
 
@@ -2669,12 +2664,9 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 
 		/* Read the initial power state from the device */
 		if (w->reg >= 0) {
-			val = soc_widget_read(w, w->reg);
-			val &= 1 << w->shift;
-			if (w->invert)
-				val = !val;
-
-			if (val)
+			val = soc_widget_read(w, w->reg) >> w->shift;
+			val &= w->mask;
+			if (val == w->on_val)
 				w->power = 1;
 		}
 
@@ -3093,7 +3085,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			return NULL;
 		}
 
-		if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
+		if (w->on_val & SND_SOC_DAPM_REGULATOR_BYPASS) {
 			ret = regulator_allow_bypass(w->regulator, true);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
-- 
1.8.0
