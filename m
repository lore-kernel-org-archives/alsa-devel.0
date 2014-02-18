From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 032/102] ASoC: da7210: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:48 +0100
Message-ID: <1392723517-12772-5-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 471F62655B9
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
 sound/soc/codecs/da7210.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index e62e294a8033..01e55fc72307 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -307,29 +307,29 @@ static const char * const da7210_hpf_cutoff_txt[] = {
 	"Fs/8192*pi", "Fs/4096*pi", "Fs/2048*pi", "Fs/1024*pi"
 };
 
-static const struct soc_enum da7210_dac_hpf_cutoff =
-	SOC_ENUM_SINGLE(DA7210_DAC_HPF, 0, 4, da7210_hpf_cutoff_txt);
+static SOC_ENUM_SINGLE_DECL(da7210_dac_hpf_cutoff,
+			    DA7210_DAC_HPF, 0, da7210_hpf_cutoff_txt);
 
-static const struct soc_enum da7210_adc_hpf_cutoff =
-	SOC_ENUM_SINGLE(DA7210_ADC_HPF, 0, 4, da7210_hpf_cutoff_txt);
+static SOC_ENUM_SINGLE_DECL(da7210_adc_hpf_cutoff,
+			    DA7210_ADC_HPF, 0, da7210_hpf_cutoff_txt);
 
 /* ADC and DAC voice (8kHz) high pass cutoff value */
 static const char * const da7210_vf_cutoff_txt[] = {
 	"2.5Hz", "25Hz", "50Hz", "100Hz", "150Hz", "200Hz", "300Hz", "400Hz"
 };
 
-static const struct soc_enum da7210_dac_vf_cutoff =
-	SOC_ENUM_SINGLE(DA7210_DAC_HPF, 4, 8, da7210_vf_cutoff_txt);
+static SOC_ENUM_SINGLE_DECL(da7210_dac_vf_cutoff,
+			    DA7210_DAC_HPF, 4, da7210_vf_cutoff_txt);
 
-static const struct soc_enum da7210_adc_vf_cutoff =
-	SOC_ENUM_SINGLE(DA7210_ADC_HPF, 4, 8, da7210_vf_cutoff_txt);
+static SOC_ENUM_SINGLE_DECL(da7210_adc_vf_cutoff,
+			    DA7210_ADC_HPF, 4, da7210_vf_cutoff_txt);
 
 static const char *da7210_hp_mode_txt[] = {
 	"Class H", "Class G"
 };
 
-static const struct soc_enum da7210_hp_mode_sel =
-	SOC_ENUM_SINGLE(DA7210_HP_CFG, 0, 2, da7210_hp_mode_txt);
+static SOC_ENUM_SINGLE_DECL(da7210_hp_mode_sel,
+			    DA7210_HP_CFG, 0, da7210_hp_mode_txt);
 
 /* ALC can be enabled only if noise suppression is disabled */
 static int da7210_put_alc_sw(struct snd_kcontrol *kcontrol,
-- 
1.8.5.2
