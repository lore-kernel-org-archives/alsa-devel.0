From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 056/102] ASoC: wm8962: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:12 +0100
Message-ID: <1392723517-12772-29-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AA3982655DC
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8962.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c06bb5088e60..3924ee243745 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1658,16 +1658,16 @@ static const char *cap_hpf_mode_text[] = {
 	"Hi-fi", "Application"
 };
 
-static const struct soc_enum cap_hpf_mode =
-	SOC_ENUM_SINGLE(WM8962_ADC_DAC_CONTROL_2, 10, 2, cap_hpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(cap_hpf_mode,
+			    WM8962_ADC_DAC_CONTROL_2, 10, cap_hpf_mode_text);
 
 
 static const char *cap_lhpf_mode_text[] = {
 	"LPF", "HPF"
 };
 
-static const struct soc_enum cap_lhpf_mode =
-	SOC_ENUM_SINGLE(WM8962_LHPF1, 1, 2, cap_lhpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(cap_lhpf_mode,
+			    WM8962_LHPF1, 1, cap_lhpf_mode_text);
 
 static const struct snd_kcontrol_new wm8962_snd_controls[] = {
 SOC_DOUBLE("Input Mixer Switch", WM8962_INPUT_MIXER_CONTROL_1, 3, 2, 1, 1),
@@ -2014,40 +2014,40 @@ static int dsp2_event(struct snd_soc_dapm_widget *w,
 
 static const char *st_text[] = { "None", "Left", "Right" };
 
-static const struct soc_enum str_enum =
-	SOC_ENUM_SINGLE(WM8962_DAC_DSP_MIXING_1, 2, 3, st_text);
+static SOC_ENUM_SINGLE_DECL(str_enum,
+			    WM8962_DAC_DSP_MIXING_1, 2, st_text);
 
 static const struct snd_kcontrol_new str_mux =
 	SOC_DAPM_ENUM("Right Sidetone", str_enum);
 
-static const struct soc_enum stl_enum =
-	SOC_ENUM_SINGLE(WM8962_DAC_DSP_MIXING_2, 2, 3, st_text);
+static SOC_ENUM_SINGLE_DECL(stl_enum,
+			    WM8962_DAC_DSP_MIXING_2, 2, st_text);
 
 static const struct snd_kcontrol_new stl_mux =
 	SOC_DAPM_ENUM("Left Sidetone", stl_enum);
 
 static const char *outmux_text[] = { "DAC", "Mixer" };
 
-static const struct soc_enum spkoutr_enum =
-	SOC_ENUM_SINGLE(WM8962_SPEAKER_MIXER_2, 7, 2, outmux_text);
+static SOC_ENUM_SINGLE_DECL(spkoutr_enum,
+			    WM8962_SPEAKER_MIXER_2, 7, outmux_text);
 
 static const struct snd_kcontrol_new spkoutr_mux =
 	SOC_DAPM_ENUM("SPKOUTR Mux", spkoutr_enum);
 
-static const struct soc_enum spkoutl_enum =
-	SOC_ENUM_SINGLE(WM8962_SPEAKER_MIXER_1, 7, 2, outmux_text);
+static SOC_ENUM_SINGLE_DECL(spkoutl_enum,
+			    WM8962_SPEAKER_MIXER_1, 7, outmux_text);
 
 static const struct snd_kcontrol_new spkoutl_mux =
 	SOC_DAPM_ENUM("SPKOUTL Mux", spkoutl_enum);
 
-static const struct soc_enum hpoutr_enum =
-	SOC_ENUM_SINGLE(WM8962_HEADPHONE_MIXER_2, 7, 2, outmux_text);
+static SOC_ENUM_SINGLE_DECL(hpoutr_enum,
+			    WM8962_HEADPHONE_MIXER_2, 7, outmux_text);
 
 static const struct snd_kcontrol_new hpoutr_mux =
 	SOC_DAPM_ENUM("HPOUTR Mux", hpoutr_enum);
 
-static const struct soc_enum hpoutl_enum =
-	SOC_ENUM_SINGLE(WM8962_HEADPHONE_MIXER_1, 7, 2, outmux_text);
+static SOC_ENUM_SINGLE_DECL(hpoutl_enum,
+			    WM8962_HEADPHONE_MIXER_1, 7, outmux_text);
 
 static const struct snd_kcontrol_new hpoutl_mux =
 	SOC_DAPM_ENUM("HPOUTL Mux", hpoutl_enum);
-- 
1.8.5.2
