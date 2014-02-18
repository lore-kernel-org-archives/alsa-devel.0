From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 067/102] ASoC: wm2200: Use
	SOC_ENUM_SINGLE_*_DECL()
Date: Tue, 18 Feb 2014 12:38:23 +0100
Message-ID: <1392723517-12772-40-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A72422655DA
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
 sound/soc/codecs/cs42l51.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index e53c8714591f..f46b7c6f1f3b 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -117,8 +117,7 @@ static const char *chan_mix[] = {
 	"R L",
 };
 
-static const struct soc_enum cs42l51_chan_mix =
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(chan_mix), chan_mix);
+static SOC_ENUM_SINGLE_EXT_DECL(cs42l51_chan_mix, chan_mix);
 
 static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 	SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
@@ -174,22 +173,22 @@ static int cs42l51_pdn_event(struct snd_soc_dapm_widget *w,
 
 static const char *cs42l51_dac_names[] = {"Direct PCM",
 	"DSP PCM", "ADC"};
-static const struct soc_enum cs42l51_dac_mux_enum =
-	SOC_ENUM_SINGLE(CS42L51_DAC_CTL, 6, 3, cs42l51_dac_names);
+static SOC_ENUM_SINGLE_DECL(cs42l51_dac_mux_enum,
+			    CS42L51_DAC_CTL, 6, cs42l51_dac_names);
 static const struct snd_kcontrol_new cs42l51_dac_mux_controls =
 	SOC_DAPM_ENUM("Route", cs42l51_dac_mux_enum);
 
 static const char *cs42l51_adcl_names[] = {"AIN1 Left", "AIN2 Left",
 	"MIC Left", "MIC+preamp Left"};
-static const struct soc_enum cs42l51_adcl_mux_enum =
-	SOC_ENUM_SINGLE(CS42L51_ADC_INPUT, 4, 4, cs42l51_adcl_names);
+static SOC_ENUM_SINGLE_DECL(cs42l51_adcl_mux_enum,
+			    CS42L51_ADC_INPUT, 4, cs42l51_adcl_names);
 static const struct snd_kcontrol_new cs42l51_adcl_mux_controls =
 	SOC_DAPM_ENUM("Route", cs42l51_adcl_mux_enum);
 
 static const char *cs42l51_adcr_names[] = {"AIN1 Right", "AIN2 Right",
 	"MIC Right", "MIC+preamp Right"};
-static const struct soc_enum cs42l51_adcr_mux_enum =
-	SOC_ENUM_SINGLE(CS42L51_ADC_INPUT, 6, 4, cs42l51_adcr_names);
+static SOC_ENUM_SINGLE_DECL(cs42l51_adcr_mux_enum,
+			    CS42L51_ADC_INPUT, 6, cs42l51_adcr_names);
 static const struct snd_kcontrol_new cs42l51_adcr_mux_controls =
 	SOC_DAPM_ENUM("Route", cs42l51_adcr_mux_enum);
 
-- 
1.8.5.2
