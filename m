From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 055/102] ASoC: wm8961: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:11 +0100
Message-ID: <1392723517-12772-28-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AFB4B2655DF
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
 sound/soc/codecs/wm8961.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 900328e28a15..ce8fa6e01cb4 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -317,15 +317,15 @@ static const char *adc_hpf_text[] = {
 	"Hi-fi", "Voice 1", "Voice 2", "Voice 3",
 };
 
-static const struct soc_enum adc_hpf =
-	SOC_ENUM_SINGLE(WM8961_ADC_DAC_CONTROL_2, 7, 4, adc_hpf_text);
+static SOC_ENUM_SINGLE_DECL(adc_hpf,
+			    WM8961_ADC_DAC_CONTROL_2, 7, adc_hpf_text);
 
 static const char *dac_deemph_text[] = {
 	"None", "32kHz", "44.1kHz", "48kHz",
 };
 
-static const struct soc_enum dac_deemph =
-	SOC_ENUM_SINGLE(WM8961_ADC_DAC_CONTROL_1, 1, 4, dac_deemph_text);
+static SOC_ENUM_SINGLE_DECL(dac_deemph,
+			    WM8961_ADC_DAC_CONTROL_1, 1, dac_deemph_text);
 
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(hp_sec_tlv, -700, 100, 0);
@@ -385,11 +385,11 @@ static const char *sidetone_text[] = {
 	"None", "Left", "Right"
 };
 
-static const struct soc_enum dacl_sidetone =
-	SOC_ENUM_SINGLE(WM8961_DSP_SIDETONE_0, 2, 3, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(dacl_sidetone,
+			    WM8961_DSP_SIDETONE_0, 2, sidetone_text);
 
-static const struct soc_enum dacr_sidetone =
-	SOC_ENUM_SINGLE(WM8961_DSP_SIDETONE_1, 2, 3, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(dacr_sidetone,
+			    WM8961_DSP_SIDETONE_1, 2, sidetone_text);
 
 static const struct snd_kcontrol_new dacl_mux =
 	SOC_DAPM_ENUM("DACL Sidetone", dacl_sidetone);
-- 
1.8.5.2
