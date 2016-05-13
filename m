From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: arizona: Add voice trigger output
	widget
Date: Fri, 13 May 2016 16:45:16 +0100
Message-ID: <1463154319-10070-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1463154319-10070-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B012126691E
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 17:45:21 +0200 (CEST)
In-Reply-To: <1463154319-10070-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

In some situations the voice control firmware will by used
to only provide a trigger notification event. In this case a
compressed stream will not be opened by user-space, as such we
need to provide a virtual output to power on the DSP in this
use-case. This patch adds a virtual output 'DSP Voice Trigger'
that can be used for this, and a switch that lets it be connected
to the core when required.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 8 ++++++++
 sound/soc/codecs/arizona.h | 2 ++
 sound/soc/codecs/cs47l24.c | 9 +++++++++
 sound/soc/codecs/wm5110.c  | 9 +++++++++
 4 files changed, 28 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 664a8c0..a6e3881 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -810,6 +810,14 @@ const struct soc_enum arizona_output_anc_src[] = {
 };
 EXPORT_SYMBOL_GPL(arizona_output_anc_src);
 
+const struct snd_kcontrol_new arizona_voice_trigger_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0),
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 1, 1, 0),
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 2, 1, 0),
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 3, 1, 0),
+};
+EXPORT_SYMBOL_GPL(arizona_voice_trigger_switch);
+
 static void arizona_in_set_vu(struct snd_soc_codec *codec, int ena)
 {
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index ce0531b..02d836c 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -248,6 +248,8 @@ extern const struct soc_enum arizona_anc_input_src[];
 extern const struct soc_enum arizona_anc_ng_enum;
 extern const struct soc_enum arizona_output_anc_src[];
 
+extern const struct snd_kcontrol_new arizona_voice_trigger_switch[];
+
 extern int arizona_in_ev(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol,
 			 int event);
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 23a14be..af681f8 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -359,6 +359,11 @@ SND_SOC_DAPM_INPUT("IN2R"),
 SND_SOC_DAPM_OUTPUT("DRC1 Signal Activity"),
 SND_SOC_DAPM_OUTPUT("DRC2 Signal Activity"),
 
+SND_SOC_DAPM_OUTPUT("DSP Voice Trigger"),
+
+SND_SOC_DAPM_SWITCH("DSP3 Voice Trigger", SND_SOC_NOPM, 2, 0,
+		    &arizona_voice_trigger_switch[2]),
+
 SND_SOC_DAPM_PGA_E("IN1L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN1L_ENA_SHIFT,
 		   0, NULL, 0, arizona_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
@@ -905,6 +910,10 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 	{ "DRC2 Signal Activity", NULL, "DRC2L" },
 	{ "DRC2 Signal Activity", NULL, "DRC2R" },
+
+	{ "DSP Voice Trigger", NULL, "SYSCLK" },
+	{ "DSP Voice Trigger", NULL, "DSP3 Voice Trigger" },
+	{ "DSP3 Voice Trigger", "Switch", "DSP3" },
 };
 
 static int cs47l24_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index c2a9edc..1638b09 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1104,6 +1104,11 @@ SND_SOC_DAPM_INPUT("IN4R"),
 SND_SOC_DAPM_OUTPUT("DRC1 Signal Activity"),
 SND_SOC_DAPM_OUTPUT("DRC2 Signal Activity"),
 
+SND_SOC_DAPM_OUTPUT("DSP Voice Trigger"),
+
+SND_SOC_DAPM_SWITCH("DSP3 Voice Trigger", SND_SOC_NOPM, 2, 0,
+		    &arizona_voice_trigger_switch[2]),
+
 SND_SOC_DAPM_PGA_E("IN1L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN1L_ENA_SHIFT,
 		   0, NULL, 0, wm5110_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
@@ -2003,6 +2008,10 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 	{ "DRC2 Signal Activity", NULL, "DRC2L" },
 	{ "DRC2 Signal Activity", NULL, "DRC2R" },
+
+	{ "DSP Voice Trigger", NULL, "SYSCLK" },
+	{ "DSP Voice Trigger", NULL, "DSP3 Voice Trigger" },
+	{ "DSP3 Voice Trigger", "Switch", "DSP3" },
 };
 
 static int wm5110_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
-- 
2.1.4
