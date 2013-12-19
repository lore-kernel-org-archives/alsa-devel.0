From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [RFC PATCH 2/2] ASoC: wm_adsp: Start DSP booting
	earlier in the DAPM process
Date: Thu, 19 Dec 2013 15:48:05 +0000
Message-ID: <1387468085-26176-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1387468085-26176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0EE082654A4
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 16:55:12 +0100 (CET)
In-Reply-To: <1387468085-26176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Move the start of booting the DSP to earlier in the DAPM process this
allows us to overlap some of the processing with other components of the
system being brought up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.h |   17 +++++++++--------
 sound/soc/codecs/wm_adsp.c |   24 +++++++++++++++++++++---
 sound/soc/codecs/wm_adsp.h |    5 +++++
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 6641f3d..bd1b9d2 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -166,20 +166,21 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	ARIZONA_MIXER_INPUT_ROUTES(name " Input 4")
 
 #define ARIZONA_DSP_ROUTES(name) \
-	{ name, NULL, name " Aux 1" }, \
-	{ name, NULL, name " Aux 2" }, \
-	{ name, NULL, name " Aux 3" }, \
-	{ name, NULL, name " Aux 4" }, \
-	{ name, NULL, name " Aux 5" }, \
-	{ name, NULL, name " Aux 6" }, \
+	{ name, NULL, name " Preloader"}, \
+	{ name " Preloader", NULL, name " Aux 1" }, \
+	{ name " Preloader", NULL, name " Aux 2" }, \
+	{ name " Preloader", NULL, name " Aux 3" }, \
+	{ name " Preloader", NULL, name " Aux 4" }, \
+	{ name " Preloader", NULL, name " Aux 5" }, \
+	{ name " Preloader", NULL, name " Aux 6" }, \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 1"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 2"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 3"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 4"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 5"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 6"), \
-	ARIZONA_MIXER_ROUTES(name, name "L"), \
-	ARIZONA_MIXER_ROUTES(name, name "R")
+	ARIZONA_MIXER_ROUTES(name " Preloader", name "L"), \
+	ARIZONA_MIXER_ROUTES(name " Preloader", name "R")
 
 #define ARIZONA_RATE_ENUM_SIZE 4
 extern const char *arizona_rate_text[ARIZONA_RATE_ENUM_SIZE];
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4475790..26de090 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1596,6 +1596,27 @@ err:
 			   ADSP2_SYS_ENA | ADSP2_CORE_ENA | ADSP2_START, 0);
 }
 
+int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
+	struct wm_adsp *dsp = &dsps[w->shift];
+
+	dsp->card = codec->card;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		schedule_work(&dsp->boot_work);
+		break;
+	default:
+		break;
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_early_event);
+
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event)
 {
@@ -1606,11 +1627,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	struct wm_coeff_ctl *ctl;
 	int ret;
 
-	dsp->card = codec->card;
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		schedule_work(&dsp->boot_work);
 		flush_work(&dsp->boot_work);
 
 		if (!dsp->running)
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 20b6b4b..2b41694 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -68,6 +68,9 @@ struct wm_adsp {
 		wm_adsp1_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
 
 #define WM_ADSP2(wname, num) \
+{	.id = snd_soc_dapm_dai_link, .name = wname " Preloader", \
+	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp2_early_event, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU }, \
 	SND_SOC_DAPM_PGA_E(wname, SND_SOC_NOPM, num, 0, NULL, 0, \
 		wm_adsp2_event, SND_SOC_DAPM_PRE_PMU | \
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
@@ -79,6 +82,8 @@ int wm_adsp1_init(struct wm_adsp *adsp);
 int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs);
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
+int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event);
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 
-- 
1.7.2.5
