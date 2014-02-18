From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 030/102] ASoC: alc5623: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:46 +0100
Message-ID: <1392723517-12772-3-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 462BC2655B7
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
 sound/soc/codecs/alc5623.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index d3036283482a..ba61c07ebbb2 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -228,32 +228,37 @@ static const char *alc5623_aux_out_input_sel[] = {
 		"Vmid", "HPOut Mix", "Speaker Mix", "Mono Mix"};
 
 /* auxout output mux */
-static const struct soc_enum alc5623_aux_out_input_enum =
-SOC_ENUM_SINGLE(ALC5623_OUTPUT_MIXER_CTRL, 6, 4, alc5623_aux_out_input_sel);
+static SOC_ENUM_SINGLE_DECL(alc5623_aux_out_input_enum,
+			    ALC5623_OUTPUT_MIXER_CTRL, 6,
+			    alc5623_aux_out_input_sel);
 static const struct snd_kcontrol_new alc5623_auxout_mux_controls =
 SOC_DAPM_ENUM("Route", alc5623_aux_out_input_enum);
 
 /* speaker output mux */
-static const struct soc_enum alc5623_spkout_input_enum =
-SOC_ENUM_SINGLE(ALC5623_OUTPUT_MIXER_CTRL, 10, 4, alc5623_spkout_input_sel);
+static SOC_ENUM_SINGLE_DECL(alc5623_spkout_input_enum,
+			    ALC5623_OUTPUT_MIXER_CTRL, 10,
+			    alc5623_spkout_input_sel);
 static const struct snd_kcontrol_new alc5623_spkout_mux_controls =
 SOC_DAPM_ENUM("Route", alc5623_spkout_input_enum);
 
 /* headphone left output mux */
-static const struct soc_enum alc5623_hpl_out_input_enum =
-SOC_ENUM_SINGLE(ALC5623_OUTPUT_MIXER_CTRL, 9, 2, alc5623_hpl_out_input_sel);
+static SOC_ENUM_SINGLE_DECL(alc5623_hpl_out_input_enum,
+			    ALC5623_OUTPUT_MIXER_CTRL, 9,
+			    alc5623_hpl_out_input_sel);
 static const struct snd_kcontrol_new alc5623_hpl_out_mux_controls =
 SOC_DAPM_ENUM("Route", alc5623_hpl_out_input_enum);
 
 /* headphone right output mux */
-static const struct soc_enum alc5623_hpr_out_input_enum =
-SOC_ENUM_SINGLE(ALC5623_OUTPUT_MIXER_CTRL, 8, 2, alc5623_hpr_out_input_sel);
+static SOC_ENUM_SINGLE_DECL(alc5623_hpr_out_input_enum,
+			    ALC5623_OUTPUT_MIXER_CTRL, 8,
+			    alc5623_hpr_out_input_sel);
 static const struct snd_kcontrol_new alc5623_hpr_out_mux_controls =
 SOC_DAPM_ENUM("Route", alc5623_hpr_out_input_enum);
 
 /* speaker output N select */
-static const struct soc_enum alc5623_spk_n_sour_enum =
-SOC_ENUM_SINGLE(ALC5623_OUTPUT_MIXER_CTRL, 14, 4, alc5623_spk_n_sour_sel);
+static SOC_ENUM_SINGLE_DECL(alc5623_spk_n_sour_enum,
+			    ALC5623_OUTPUT_MIXER_CTRL, 14,
+			    alc5623_spk_n_sour_sel);
 static const struct snd_kcontrol_new alc5623_spkoutn_mux_controls =
 SOC_DAPM_ENUM("Route", alc5623_spk_n_sour_enum);
 
@@ -338,8 +343,9 @@ SND_SOC_DAPM_VMID("Vmid"),
 };
 
 static const char *alc5623_amp_names[] = {"AB Amp", "D Amp"};
-static const struct soc_enum alc5623_amp_enum =
-	SOC_ENUM_SINGLE(ALC5623_OUTPUT_MIXER_CTRL, 13, 2, alc5623_amp_names);
+static SOC_ENUM_SINGLE_DECL(alc5623_amp_enum,
+			    ALC5623_OUTPUT_MIXER_CTRL, 13,
+			    alc5623_amp_names);
 static const struct snd_kcontrol_new alc5623_amp_mux_controls =
 	SOC_DAPM_ENUM("Route", alc5623_amp_enum);
 
-- 
1.8.5.2
