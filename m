From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 046/102] ASoC: uda1380: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:02 +0100
Message-ID: <1392723517-12772-19-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 868882655C8
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

Just replace with the helper macro.
Also, use ARRAY_SIZE() in some ASOC_ENUM_SINGLE() lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/uda1380.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 726df6d43c2b..72ee8e1838e5 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -237,25 +237,27 @@ static const char *uda1380_os_setting[] = {
 };
 
 static const struct soc_enum uda1380_deemp_enum[] = {
-	SOC_ENUM_SINGLE(UDA1380_DEEMP, 8, 5, uda1380_deemp),
-	SOC_ENUM_SINGLE(UDA1380_DEEMP, 0, 5, uda1380_deemp),
+	SOC_ENUM_SINGLE(UDA1380_DEEMP, 8, ARRAY_SIZE(uda1380_deemp),
+			uda1380_deemp),
+	SOC_ENUM_SINGLE(UDA1380_DEEMP, 0, ARRAY_SIZE(uda1380_deemp),
+			uda1380_deemp),
 };
-static const struct soc_enum uda1380_input_sel_enum =
-	SOC_ENUM_SINGLE(UDA1380_ADC, 2, 4, uda1380_input_sel);		/* SEL_MIC, SEL_LNA */
-static const struct soc_enum uda1380_output_sel_enum =
-	SOC_ENUM_SINGLE(UDA1380_PM, 7, 2, uda1380_output_sel);		/* R02_EN_AVC */
-static const struct soc_enum uda1380_spf_enum =
-	SOC_ENUM_SINGLE(UDA1380_MODE, 14, 4, uda1380_spf_mode);		/* M */
-static const struct soc_enum uda1380_capture_sel_enum =
-	SOC_ENUM_SINGLE(UDA1380_IFACE, 6, 2, uda1380_capture_sel);	/* SEL_SOURCE */
-static const struct soc_enum uda1380_sel_ns_enum =
-	SOC_ENUM_SINGLE(UDA1380_MIXER, 14, 2, uda1380_sel_ns);		/* SEL_NS */
-static const struct soc_enum uda1380_mix_enum =
-	SOC_ENUM_SINGLE(UDA1380_MIXER, 12, 4, uda1380_mix_control);	/* MIX, MIX_POS */
-static const struct soc_enum uda1380_sdet_enum =
-	SOC_ENUM_SINGLE(UDA1380_MIXER, 4, 4, uda1380_sdet_setting);	/* SD_VALUE */
-static const struct soc_enum uda1380_os_enum =
-	SOC_ENUM_SINGLE(UDA1380_MIXER, 0, 3, uda1380_os_setting);	/* OS */
+static SOC_ENUM_SINGLE_DECL(uda1380_input_sel_enum,
+			    UDA1380_ADC, 2, uda1380_input_sel);		/* SEL_MIC, SEL_LNA */
+static SOC_ENUM_SINGLE_DECL(uda1380_output_sel_enum,
+			    UDA1380_PM, 7, uda1380_output_sel);		/* R02_EN_AVC */
+static SOC_ENUM_SINGLE_DECL(uda1380_spf_enum,
+			    UDA1380_MODE, 14, uda1380_spf_mode);		/* M */
+static SOC_ENUM_SINGLE_DECL(uda1380_capture_sel_enum,
+			    UDA1380_IFACE, 6, uda1380_capture_sel);	/* SEL_SOURCE */
+static SOC_ENUM_SINGLE_DECL(uda1380_sel_ns_enum,
+			    UDA1380_MIXER, 14, uda1380_sel_ns);		/* SEL_NS */
+static SOC_ENUM_SINGLE_DECL(uda1380_mix_enum,
+			    UDA1380_MIXER, 12, uda1380_mix_control);	/* MIX, MIX_POS */
+static SOC_ENUM_SINGLE_DECL(uda1380_sdet_enum,
+			    UDA1380_MIXER, 4, uda1380_sdet_setting);	/* SD_VALUE */
+static SOC_ENUM_SINGLE_DECL(uda1380_os_enum,
+			    UDA1380_MIXER, 0, uda1380_os_setting);	/* OS */
 
 /*
  * from -48 dB in 1.5 dB steps (mute instead of -49.5 dB)
-- 
1.8.5.2
