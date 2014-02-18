From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 036/102] ASoC: da9055: Use
	SOC_*_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:52 +0100
Message-ID: <1392723517-12772-9-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E7E92655BE
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

Just replace with the helper macros.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/max98088.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index bb1ecfc4459b..4b9274deb9a3 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -597,28 +597,27 @@ static const unsigned int max98088_exmode_values[] = {
        0x00, 0x43, 0x10, 0x20, 0x30, 0x40, 0x11, 0x22, 0x32
 };
 
-static const struct soc_enum max98088_exmode_enum =
-       SOC_VALUE_ENUM_SINGLE(M98088_REG_41_SPKDHP, 0, 127,
-                             ARRAY_SIZE(max98088_exmode_texts),
-                             max98088_exmode_texts,
-                             max98088_exmode_values);
+static SOC_VALUE_ENUM_SINGLE_DECL(max98088_exmode_enum,
+				  M98088_REG_41_SPKDHP, 0, 127,
+				  max98088_exmode_texts,
+				  max98088_exmode_values);
 
 static const char *max98088_ex_thresh[] = { /* volts PP */
        "0.6", "1.2", "1.8", "2.4", "3.0", "3.6", "4.2", "4.8"};
-static const struct soc_enum max98088_ex_thresh_enum[] = {
-       SOC_ENUM_SINGLE(M98088_REG_42_SPKDHP_THRESH, 0, 8,
-               max98088_ex_thresh),
-};
+static SOC_ENUM_SINGLE_DECL(max98088_ex_thresh_enum,
+			    M98088_REG_42_SPKDHP_THRESH, 0,
+			    max98088_ex_thresh);
 
 static const char *max98088_fltr_mode[] = {"Voice", "Music" };
-static const struct soc_enum max98088_filter_mode_enum[] = {
-       SOC_ENUM_SINGLE(M98088_REG_18_DAI1_FILTERS, 7, 2, max98088_fltr_mode),
-};
+static SOC_ENUM_SINGLE_DECL(max98088_filter_mode_enum,
+			    M98088_REG_18_DAI1_FILTERS, 7,
+			    max98088_fltr_mode);
 
 static const char *max98088_extmic_text[] = { "None", "MIC1", "MIC2" };
 
-static const struct soc_enum max98088_extmic_enum =
-       SOC_ENUM_SINGLE(M98088_REG_48_CFG_MIC, 0, 3, max98088_extmic_text);
+static SOC_ENUM_SINGLE_DECL(max98088_extmic_enum,
+			    M98088_REG_48_CFG_MIC, 0,
+			    max98088_extmic_text);
 
 static const struct snd_kcontrol_new max98088_extmic_mux =
        SOC_DAPM_ENUM("External MIC Mux", max98088_extmic_enum);
@@ -626,12 +625,12 @@ static const struct snd_kcontrol_new max98088_extmic_mux =
 static const char *max98088_dai1_fltr[] = {
        "Off", "fc=258/fs=16k", "fc=500/fs=16k",
        "fc=258/fs=8k", "fc=500/fs=8k", "fc=200"};
-static const struct soc_enum max98088_dai1_dac_filter_enum[] = {
-       SOC_ENUM_SINGLE(M98088_REG_18_DAI1_FILTERS, 0, 6, max98088_dai1_fltr),
-};
-static const struct soc_enum max98088_dai1_adc_filter_enum[] = {
-       SOC_ENUM_SINGLE(M98088_REG_18_DAI1_FILTERS, 4, 6, max98088_dai1_fltr),
-};
+static SOC_ENUM_SINGLE_DECL(max98088_dai1_dac_filter_enum,
+			    M98088_REG_18_DAI1_FILTERS, 0,
+			    max98088_dai1_fltr);
+static SOC_ENUM_SINGLE_DECL(max98088_dai1_adc_filter_enum,
+			    M98088_REG_18_DAI1_FILTERS, 4,
+			    max98088_dai1_fltr);
 
 static int max98088_mic1pre_set(struct snd_kcontrol *kcontrol,
                                struct snd_ctl_elem_value *ucontrol)
-- 
1.8.5.2
