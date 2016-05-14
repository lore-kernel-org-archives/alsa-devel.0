From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add voice trigger output
	widget" to the asoc tree
Date: Sat, 14 May 2016 11:12:58 +0100
Message-ID: <E1b1WZ8-0004q9-3E@finisterre>
References: <1463154319-10070-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71F9E2606E3
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 12:22:16 +0200 (CEST)
In-Reply-To: <1463154319-10070-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add voice trigger output widget

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c35d447b7aefefc1062af1a7d3621fc877599257 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 13 May 2016 16:45:16 +0100
Subject: [PATCH] ASoC: arizona: Add voice trigger output widget

In some situations the voice control firmware will by used
to only provide a trigger notification event. In this case a
compressed stream will not be opened by user-space, as such we
need to provide a virtual output to power on the DSP in this
use-case. This patch adds a virtual output 'DSP Voice Trigger'
that can be used for this, and a switch that lets it be connected
to the core when required.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 8 ++++++++
 sound/soc/codecs/arizona.h | 2 ++
 sound/soc/codecs/cs47l24.c | 9 +++++++++
 sound/soc/codecs/wm5110.c  | 9 +++++++++
 4 files changed, 28 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 0239639823b1..7c9a48dbe3c8 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -798,6 +798,14 @@ const struct soc_enum arizona_output_anc_src[] = {
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
index 1ea8e4ecf8d4..6517555cb5fa 100644
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
index f1c9f5a54579..6de9d78e0bc3 100644
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
@@ -902,6 +907,10 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
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
index 69f5231f625b..4ded66cfc3fd 100644
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
2.8.1
