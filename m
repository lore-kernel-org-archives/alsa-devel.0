From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 4/4] ASoC: wm_adsp: Add mechanism to preload
	firmware on a core
Date: Mon, 26 Sep 2016 10:15:25 +0100
Message-ID: <1474881325-9466-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1474881325-9466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 73BB0265338
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 11:15:26 +0200 (CEST)
In-Reply-To: <1474881325-9466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

As requirements to bring up audio paths are continuous getting tighter
and the DSP download to most ADSP devices happens over an external bus
it can become an important factor in the path bring up time. As such
sometimes it is a reasonable trade off to download the firmware ahead of
when it will be required and take a small hit on power consumption for
keeping the core powered up.

This "preloading" adds an additional control for each DSP core "DSPx
Preload Switch" that when set to true will power up the DSP core and
download the firmware currently selected in the "DSPx Firmware" control.
Whilst the core is preloaded the current firmware can not be changed and
the CODEC will be kept powered up and SYSCLK held on. Although future
improvements may allow the SYSCLK to be powered down as well because
the hardware only requires SYSCLK whilst the download is actually taking
place, but this is not covered in this series.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

No changes since v1.

 sound/soc/codecs/arizona.h |  1 +
 sound/soc/codecs/cs47l24.c |  3 +++
 sound/soc/codecs/wm5102.c  |  2 ++
 sound/soc/codecs/wm5110.c  |  5 +++++
 sound/soc/codecs/wm_adsp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h | 11 +++++++++++
 6 files changed, 65 insertions(+)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 9d0997b..8ea3657 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -191,6 +191,7 @@ extern unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 #define ARIZONA_DSP_ROUTES(name) \
 	{ name, NULL, name " Preloader"}, \
 	{ name " Preloader", NULL, "SYSCLK" }, \
+	{ name " Preload", NULL, name " Preloader"}, \
 	{ name, NULL, name " Aux 1" }, \
 	{ name, NULL, name " Aux 2" }, \
 	{ name, NULL, name " Aux 3" }, \
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 7df6a67..f321ea8 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -173,6 +173,9 @@ SOC_ENUM("ISRC2 FSH", arizona_isrc_fsh[1]),
 SOC_ENUM("ISRC3 FSH", arizona_isrc_fsh[2]),
 SOC_ENUM("ASRC RATE 1", arizona_asrc_rate1),
 
+WM_ADSP2_PRELOAD_SWITCH("DSP2", 2),
+WM_ADSP2_PRELOAD_SWITCH("DSP3", 3),
+
 ARIZONA_MIXER_CONTROLS("DSP2L", ARIZONA_DSP2LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP2R", ARIZONA_DSP2RMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP3L", ARIZONA_DSP3LMIX_INPUT_1_SOURCE),
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index bb3de5b..07b6058 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -855,6 +855,8 @@ ARIZONA_LHPF_CONTROL("LHPF2 Coefficients", ARIZONA_HPLPF2_2),
 ARIZONA_LHPF_CONTROL("LHPF3 Coefficients", ARIZONA_HPLPF3_2),
 ARIZONA_LHPF_CONTROL("LHPF4 Coefficients", ARIZONA_HPLPF4_2),
 
+WM_ADSP2_PRELOAD_SWITCH("DSP1", 1),
+
 ARIZONA_MIXER_CONTROLS("DSP1L", ARIZONA_DSP1LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP1R", ARIZONA_DSP1RMIX_INPUT_1_SOURCE),
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 407dc4a..0fee2d9 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -778,6 +778,11 @@ SOC_ENUM("ISRC2 FSH", arizona_isrc_fsh[1]),
 SOC_ENUM("ISRC3 FSH", arizona_isrc_fsh[2]),
 SOC_ENUM("ASRC RATE 1", arizona_asrc_rate1),
 
+WM_ADSP2_PRELOAD_SWITCH("DSP1", 1),
+WM_ADSP2_PRELOAD_SWITCH("DSP2", 2),
+WM_ADSP2_PRELOAD_SWITCH("DSP3", 3),
+WM_ADSP2_PRELOAD_SWITCH("DSP4", 4),
+
 ARIZONA_MIXER_CONTROLS("DSP1L", ARIZONA_DSP1LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP1R", ARIZONA_DSP1RMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP2L", ARIZONA_DSP2LMIX_INPUT_1_SOURCE),
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b943dde..93d1f05 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2316,6 +2316,43 @@ static void wm_adsp2_set_dspclk(struct wm_adsp *dsp, unsigned int freq)
 		adsp_err(dsp, "Failed to set clock rate: %d\n", ret);
 }
 
+int wm_adsp2_preloader_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = dsp->preloaded;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_preloader_get);
+
+int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	char preload[32];
+
+	snprintf(preload, ARRAY_SIZE(preload), "DSP%d Preload", mc->shift);
+
+	dsp->preloaded = ucontrol->value.integer.value[0];
+
+	if (ucontrol->value.integer.value[0])
+		snd_soc_dapm_force_enable_pin(dapm, preload);
+	else
+		snd_soc_dapm_disable_pin(dapm, preload);
+
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_preloader_put);
+
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event,
 			 unsigned int freq)
@@ -2441,6 +2478,12 @@ EXPORT_SYMBOL_GPL(wm_adsp2_event);
 
 int wm_adsp2_codec_probe(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	char preload[32];
+
+	snprintf(preload, ARRAY_SIZE(preload), "DSP%d Preload", dsp->num);
+	snd_soc_dapm_disable_pin(dapm, preload);
+
 	wm_adsp2_init_debugfs(dsp, codec);
 
 	return snd_soc_add_codec_controls(codec,
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 362dd7c..74f117b 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -62,6 +62,7 @@ struct wm_adsp {
 	int fw;
 	int fw_ver;
 
+	bool preloaded;
 	bool booted;
 	bool running;
 
@@ -86,7 +87,12 @@ struct wm_adsp {
 	SND_SOC_DAPM_PGA_E(wname, SND_SOC_NOPM, num, 0, NULL, 0, \
 		wm_adsp1_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
 
+#define WM_ADSP2_PRELOAD_SWITCH(wname, num) \
+	SOC_SINGLE_EXT(wname " Preload Switch", SND_SOC_NOPM, num, 1, 0, \
+		wm_adsp2_preloader_get, wm_adsp2_preloader_put)
+
 #define WM_ADSP2(wname, num, event_fn) \
+	SND_SOC_DAPM_SPK(wname " Preload", NULL), \
 {	.id = snd_soc_dapm_supply, .name = wname " Preloader", \
 	.reg = SND_SOC_NOPM, .shift = num, .event = event_fn, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD, \
@@ -110,6 +116,11 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 
+int wm_adsp2_preloader_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol);
+int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol);
+
 extern int wm_adsp_compr_open(struct wm_adsp *dsp,
 			      struct snd_compr_stream *stream);
 extern int wm_adsp_compr_free(struct snd_compr_stream *stream);
-- 
2.1.4
