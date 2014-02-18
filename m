From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 096/102] ASoC: wm8753: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:42 +0100
Message-ID: <1392724308-13375-16-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AD0626576F
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:52 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
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

... for improving readability and maintainability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8753.c | 58 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index be85da93a268..39abbdadcfb7 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -199,35 +199,35 @@ static const char *wm8753_dat_sel[] = {"Stereo", "Left ADC", "Right ADC",
 static const char *wm8753_rout2_phase[] = {"Non Inverted", "Inverted"};
 
 static const struct soc_enum wm8753_enum[] = {
-SOC_ENUM_SINGLE(WM8753_BASS, 7, 2, wm8753_base),
-SOC_ENUM_SINGLE(WM8753_BASS, 4, 6, wm8753_base_filter),
-SOC_ENUM_SINGLE(WM8753_TREBLE, 6, 2, wm8753_treble),
-SOC_ENUM_SINGLE(WM8753_ALC1, 7, 4, wm8753_alc_func),
-SOC_ENUM_SINGLE(WM8753_NGATE, 1, 2, wm8753_ng_type),
-SOC_ENUM_SINGLE(WM8753_3D, 7, 2, wm8753_3d_func),
-SOC_ENUM_SINGLE(WM8753_3D, 6, 2, wm8753_3d_uc),
-SOC_ENUM_SINGLE(WM8753_3D, 5, 2, wm8753_3d_lc),
-SOC_ENUM_SINGLE(WM8753_DAC, 1, 4, wm8753_deemp),
-SOC_ENUM_SINGLE(WM8753_DAC, 4, 4, wm8753_mono_mix),
-SOC_ENUM_SINGLE(WM8753_DAC, 6, 2, wm8753_dac_phase),
-SOC_ENUM_SINGLE(WM8753_INCTL1, 3, 4, wm8753_line_mix),
-SOC_ENUM_SINGLE(WM8753_INCTL1, 2, 2, wm8753_mono_mux),
-SOC_ENUM_SINGLE(WM8753_INCTL1, 1, 2, wm8753_right_mux),
-SOC_ENUM_SINGLE(WM8753_INCTL1, 0, 2, wm8753_left_mux),
-SOC_ENUM_SINGLE(WM8753_INCTL2, 6, 4, wm8753_rxmsel),
-SOC_ENUM_SINGLE(WM8753_INCTL2, 4, 4, wm8753_sidetone_mux),
-SOC_ENUM_SINGLE(WM8753_OUTCTL, 7, 4, wm8753_mono2_src),
-SOC_ENUM_SINGLE(WM8753_OUTCTL, 0, 3, wm8753_out3),
-SOC_ENUM_SINGLE(WM8753_ADCTL2, 7, 3, wm8753_out4),
-SOC_ENUM_SINGLE(WM8753_ADCIN, 2, 3, wm8753_radcsel),
-SOC_ENUM_SINGLE(WM8753_ADCIN, 0, 3, wm8753_ladcsel),
-SOC_ENUM_SINGLE(WM8753_ADCIN, 4, 4, wm8753_mono_adc),
-SOC_ENUM_SINGLE(WM8753_ADC, 2, 4, wm8753_adc_hp),
-SOC_ENUM_SINGLE(WM8753_ADC, 4, 2, wm8753_adc_filter),
-SOC_ENUM_SINGLE(WM8753_MICBIAS, 6, 3, wm8753_mic_sel),
-SOC_ENUM_SINGLE(WM8753_IOCTL, 2, 4, wm8753_dai_mode),
-SOC_ENUM_SINGLE(WM8753_ADC, 7, 4, wm8753_dat_sel),
-SOC_ENUM_SINGLE(WM8753_OUTCTL, 2, 2, wm8753_rout2_phase),
+SOC_ENUM_SINGLE_CONST(WM8753_BASS, 7, wm8753_base),
+SOC_ENUM_SINGLE_CONST(WM8753_BASS, 4, wm8753_base_filter),
+SOC_ENUM_SINGLE_CONST(WM8753_TREBLE, 6, wm8753_treble),
+SOC_ENUM_SINGLE_CONST(WM8753_ALC1, 7, wm8753_alc_func),
+SOC_ENUM_SINGLE_CONST(WM8753_NGATE, 1, wm8753_ng_type),
+SOC_ENUM_SINGLE_CONST(WM8753_3D, 7, wm8753_3d_func),
+SOC_ENUM_SINGLE_CONST(WM8753_3D, 6, wm8753_3d_uc),
+SOC_ENUM_SINGLE_CONST(WM8753_3D, 5, wm8753_3d_lc),
+SOC_ENUM_SINGLE_CONST(WM8753_DAC, 1, wm8753_deemp),
+SOC_ENUM_SINGLE_CONST(WM8753_DAC, 4, wm8753_mono_mix),
+SOC_ENUM_SINGLE_CONST(WM8753_DAC, 6, wm8753_dac_phase),
+SOC_ENUM_SINGLE_CONST(WM8753_INCTL1, 3, wm8753_line_mix),
+SOC_ENUM_SINGLE_CONST(WM8753_INCTL1, 2, wm8753_mono_mux),
+SOC_ENUM_SINGLE_CONST(WM8753_INCTL1, 1, wm8753_right_mux),
+SOC_ENUM_SINGLE_CONST(WM8753_INCTL1, 0, wm8753_left_mux),
+SOC_ENUM_SINGLE_CONST(WM8753_INCTL2, 6, wm8753_rxmsel),
+SOC_ENUM_SINGLE_CONST(WM8753_INCTL2, 4, wm8753_sidetone_mux),
+SOC_ENUM_SINGLE_CONST(WM8753_OUTCTL, 7, wm8753_mono2_src),
+SOC_ENUM_SINGLE_CONST(WM8753_OUTCTL, 0, wm8753_out3),
+SOC_ENUM_SINGLE_CONST(WM8753_ADCTL2, 7, wm8753_out4),
+SOC_ENUM_SINGLE_CONST(WM8753_ADCIN, 2, wm8753_radcsel),
+SOC_ENUM_SINGLE_CONST(WM8753_ADCIN, 0, wm8753_ladcsel),
+SOC_ENUM_SINGLE_CONST(WM8753_ADCIN, 4, wm8753_mono_adc),
+SOC_ENUM_SINGLE_CONST(WM8753_ADC, 2, wm8753_adc_hp),
+SOC_ENUM_SINGLE_CONST(WM8753_ADC, 4, wm8753_adc_filter),
+SOC_ENUM_SINGLE_CONST(WM8753_MICBIAS, 6, wm8753_mic_sel),
+SOC_ENUM_SINGLE_CONST(WM8753_IOCTL, 2, wm8753_dai_mode),
+SOC_ENUM_SINGLE_CONST(WM8753_ADC, 7, wm8753_dat_sel),
+SOC_ENUM_SINGLE_CONST(WM8753_OUTCTL, 2, wm8753_rout2_phase),
 };
 
 
-- 
1.8.5.2
