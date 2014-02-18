From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 066/102] ASoC: alc5632: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:22 +0100
Message-ID: <1392723517-12772-39-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C30F12655F0
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
 sound/soc/codecs/alc5632.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index fb001c56cf8d..d885056ad8f2 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -293,51 +293,59 @@ static const char * const alc5632_i2s_out_sel[] = {
 		"ADC LR", "Voice Stereo Digital"};
 
 /* auxout output mux */
-static const struct soc_enum alc5632_aux_out_input_enum =
-SOC_ENUM_SINGLE(ALC5632_OUTPUT_MIXER_CTRL, 6, 4, alc5632_aux_out_input_sel);
+static SOC_ENUM_SINGLE_DECL(alc5632_aux_out_input_enum,
+			    ALC5632_OUTPUT_MIXER_CTRL, 6,
+			    alc5632_aux_out_input_sel);
 static const struct snd_kcontrol_new alc5632_auxout_mux_controls =
 SOC_DAPM_ENUM("AuxOut Mux", alc5632_aux_out_input_enum);
 
 /* speaker output mux */
-static const struct soc_enum alc5632_spkout_input_enum =
-SOC_ENUM_SINGLE(ALC5632_OUTPUT_MIXER_CTRL, 10, 4, alc5632_spkout_input_sel);
+static SOC_ENUM_SINGLE_DECL(alc5632_spkout_input_enum,
+			    ALC5632_OUTPUT_MIXER_CTRL, 10,
+			    alc5632_spkout_input_sel);
 static const struct snd_kcontrol_new alc5632_spkout_mux_controls =
 SOC_DAPM_ENUM("SpeakerOut Mux", alc5632_spkout_input_enum);
 
 /* headphone left output mux */
-static const struct soc_enum alc5632_hpl_out_input_enum =
-SOC_ENUM_SINGLE(ALC5632_OUTPUT_MIXER_CTRL, 9, 2, alc5632_hpl_out_input_sel);
+static SOC_ENUM_SINGLE_DECL(alc5632_hpl_out_input_enum,
+			    ALC5632_OUTPUT_MIXER_CTRL, 9,
+			    alc5632_hpl_out_input_sel);
 static const struct snd_kcontrol_new alc5632_hpl_out_mux_controls =
 SOC_DAPM_ENUM("Left Headphone Mux", alc5632_hpl_out_input_enum);
 
 /* headphone right output mux */
-static const struct soc_enum alc5632_hpr_out_input_enum =
-SOC_ENUM_SINGLE(ALC5632_OUTPUT_MIXER_CTRL, 8, 2, alc5632_hpr_out_input_sel);
+static SOC_ENUM_SINGLE_DECL(alc5632_hpr_out_input_enum,
+			    ALC5632_OUTPUT_MIXER_CTRL, 8,
+			    alc5632_hpr_out_input_sel);
 static const struct snd_kcontrol_new alc5632_hpr_out_mux_controls =
 SOC_DAPM_ENUM("Right Headphone Mux", alc5632_hpr_out_input_enum);
 
 /* speaker output N select */
-static const struct soc_enum alc5632_spk_n_sour_enum =
-SOC_ENUM_SINGLE(ALC5632_OUTPUT_MIXER_CTRL, 14, 4, alc5632_spk_n_sour_sel);
+static SOC_ENUM_SINGLE_DECL(alc5632_spk_n_sour_enum,
+			    ALC5632_OUTPUT_MIXER_CTRL, 14,
+			    alc5632_spk_n_sour_sel);
 static const struct snd_kcontrol_new alc5632_spkoutn_mux_controls =
 SOC_DAPM_ENUM("SpeakerOut N Mux", alc5632_spk_n_sour_enum);
 
 /* speaker amplifier */
 static const char *alc5632_amp_names[] = {"AB Amp", "D Amp"};
-static const struct soc_enum alc5632_amp_enum =
-	SOC_ENUM_SINGLE(ALC5632_OUTPUT_MIXER_CTRL, 13, 2, alc5632_amp_names);
+static SOC_ENUM_SINGLE_DECL(alc5632_amp_enum,
+			    ALC5632_OUTPUT_MIXER_CTRL, 13,
+			    alc5632_amp_names);
 static const struct snd_kcontrol_new alc5632_amp_mux_controls =
 	SOC_DAPM_ENUM("AB-D Amp Mux", alc5632_amp_enum);
 
 /* ADC output select */
-static const struct soc_enum alc5632_adcr_func_enum =
-	SOC_ENUM_SINGLE(ALC5632_DAC_FUNC_SELECT, 5, 2, alc5632_adcr_func_sel);
+static SOC_ENUM_SINGLE_DECL(alc5632_adcr_func_enum,
+			    ALC5632_DAC_FUNC_SELECT, 5,
+			    alc5632_adcr_func_sel);
 static const struct snd_kcontrol_new alc5632_adcr_func_controls =
 	SOC_DAPM_ENUM("ADCR Mux", alc5632_adcr_func_enum);
 
 /* I2S out select */
-static const struct soc_enum alc5632_i2s_out_enum =
-	SOC_ENUM_SINGLE(ALC5632_I2S_OUT_CTL, 5, 2, alc5632_i2s_out_sel);
+static SOC_ENUM_SINGLE_DECL(alc5632_i2s_out_enum,
+			    ALC5632_I2S_OUT_CTL, 5,
+			    alc5632_i2s_out_sel);
 static const struct snd_kcontrol_new alc5632_i2s_out_controls =
 	SOC_DAPM_ENUM("I2SOut Mux", alc5632_i2s_out_enum);
 
-- 
1.8.5.2
