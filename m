From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 054/102] ASoC: wm8940: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:10 +0100
Message-ID: <1392723517-12772-27-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A4E372655D9
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
 sound/soc/codecs/wm8940.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index b404c26c1753..87f032d0d19f 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -154,22 +154,22 @@ static const struct reg_default wm8940_reg_defaults[] = {
 };
 
 static const char *wm8940_companding[] = { "Off", "NC", "u-law", "A-law" };
-static const struct soc_enum wm8940_adc_companding_enum
-= SOC_ENUM_SINGLE(WM8940_COMPANDINGCTL, 1, 4, wm8940_companding);
-static const struct soc_enum wm8940_dac_companding_enum
-= SOC_ENUM_SINGLE(WM8940_COMPANDINGCTL, 3, 4, wm8940_companding);
+static SOC_ENUM_SINGLE_DECL(wm8940_adc_companding_enum,
+			    WM8940_COMPANDINGCTL, 1, wm8940_companding);
+static SOC_ENUM_SINGLE_DECL(wm8940_dac_companding_enum,
+			    WM8940_COMPANDINGCTL, 3, wm8940_companding);
 
 static const char *wm8940_alc_mode_text[] = {"ALC", "Limiter"};
-static const struct soc_enum wm8940_alc_mode_enum
-= SOC_ENUM_SINGLE(WM8940_ALC3, 8, 2, wm8940_alc_mode_text);
+static SOC_ENUM_SINGLE_DECL(wm8940_alc_mode_enum,
+			    WM8940_ALC3, 8, wm8940_alc_mode_text);
 
 static const char *wm8940_mic_bias_level_text[] = {"0.9", "0.65"};
-static const struct soc_enum wm8940_mic_bias_level_enum
-= SOC_ENUM_SINGLE(WM8940_INPUTCTL, 8, 2, wm8940_mic_bias_level_text);
+static SOC_ENUM_SINGLE_DECL(wm8940_mic_bias_level_enum,
+			    WM8940_INPUTCTL, 8, wm8940_mic_bias_level_text);
 
 static const char *wm8940_filter_mode_text[] = {"Audio", "Application"};
-static const struct soc_enum wm8940_filter_mode_enum
-= SOC_ENUM_SINGLE(WM8940_ADC, 7, 2, wm8940_filter_mode_text);
+static SOC_ENUM_SINGLE_DECL(wm8940_filter_mode_enum,
+			    WM8940_ADC, 7, wm8940_filter_mode_text);
 
 static DECLARE_TLV_DB_SCALE(wm8940_spk_vol_tlv, -5700, 100, 1);
 static DECLARE_TLV_DB_SCALE(wm8940_att_tlv, -1000, 1000, 0);
-- 
1.8.5.2
