From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 078/102] ASoC: lm49453: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:34 +0100
Message-ID: <1392723517-12772-51-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BAAF42655E9
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
 sound/soc/codecs/lm49453.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 6b7fe5e54881..e533594905be 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -213,15 +213,13 @@ static const char *lm49453_adcl_mux_text[] = { "MIC1", "Aux_L" };
 
 static const char *lm49453_adcr_mux_text[] = { "MIC2", "Aux_R" };
 
-static const struct soc_enum lm49453_adcl_enum =
-	SOC_ENUM_SINGLE(LM49453_P0_ANALOG_MIXER_ADC_REG, 0,
-			ARRAY_SIZE(lm49453_adcl_mux_text),
-			lm49453_adcl_mux_text);
-
-static const struct soc_enum lm49453_adcr_enum =
-	SOC_ENUM_SINGLE(LM49453_P0_ANALOG_MIXER_ADC_REG, 1,
-			ARRAY_SIZE(lm49453_adcr_mux_text),
-			lm49453_adcr_mux_text);
+static SOC_ENUM_SINGLE_DECL(lm49453_adcl_enum,
+			    LM49453_P0_ANALOG_MIXER_ADC_REG, 0,
+			    lm49453_adcl_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(lm49453_adcr_enum,
+			    LM49453_P0_ANALOG_MIXER_ADC_REG, 1,
+			    lm49453_adcr_mux_text);
 
 static const struct snd_kcontrol_new lm49453_adcl_mux_control =
 	SOC_DAPM_ENUM("ADC Left Mux", lm49453_adcl_enum);
-- 
1.8.5.2
