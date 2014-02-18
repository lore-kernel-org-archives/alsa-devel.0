From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 042/102] ASoC: stac9766: Use
	SOC_ENUM_{SINGLE|DOUBLE}_DECL()
Date: Tue, 18 Feb 2014 12:37:58 +0100
Message-ID: <1392723517-12772-15-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 75C0B2655C3
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
 sound/soc/codecs/stac9766.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index a5455c1aea42..53b810d23fea 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -62,25 +62,25 @@ static const char *stac9766_boost1[] = {"0dB", "10dB"};
 static const char *stac9766_boost2[] = {"0dB", "20dB"};
 static const char *stac9766_stereo_mic[] = {"Off", "On"};
 
-static const struct soc_enum stac9766_record_enum =
-	SOC_ENUM_DOUBLE(AC97_REC_SEL, 8, 0, 8, stac9766_record_mux);
-static const struct soc_enum stac9766_mono_enum =
-	SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 9, 2, stac9766_mono_mux);
-static const struct soc_enum stac9766_mic_enum =
-	SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 8, 2, stac9766_mic_mux);
-static const struct soc_enum stac9766_SPDIF_enum =
-	SOC_ENUM_SINGLE(AC97_STAC_DA_CONTROL, 1, 2, stac9766_SPDIF_mux);
-static const struct soc_enum stac9766_popbypass_enum =
-	SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 15, 2, stac9766_popbypass_mux);
-static const struct soc_enum stac9766_record_all_enum =
-	SOC_ENUM_SINGLE(AC97_STAC_ANALOG_SPECIAL, 12, 2,
-			stac9766_record_all_mux);
-static const struct soc_enum stac9766_boost1_enum =
-	SOC_ENUM_SINGLE(AC97_MIC, 6, 2, stac9766_boost1); /* 0/10dB */
-static const struct soc_enum stac9766_boost2_enum =
-	SOC_ENUM_SINGLE(AC97_STAC_ANALOG_SPECIAL, 2, 2, stac9766_boost2); /* 0/20dB */
-static const struct soc_enum stac9766_stereo_mic_enum =
-	SOC_ENUM_SINGLE(AC97_STAC_STEREO_MIC, 2, 1, stac9766_stereo_mic);
+static SOC_ENUM_DOUBLE_DECL(stac9766_record_enum,
+			    AC97_REC_SEL, 8, 0, stac9766_record_mux);
+static SOC_ENUM_SINGLE_DECL(stac9766_mono_enum,
+			    AC97_GENERAL_PURPOSE, 9, stac9766_mono_mux);
+static SOC_ENUM_SINGLE_DECL(stac9766_mic_enum,
+			    AC97_GENERAL_PURPOSE, 8, stac9766_mic_mux);
+static SOC_ENUM_SINGLE_DECL(stac9766_SPDIF_enum,
+			    AC97_STAC_DA_CONTROL, 1, stac9766_SPDIF_mux);
+static SOC_ENUM_SINGLE_DECL(stac9766_popbypass_enum,
+			    AC97_GENERAL_PURPOSE, 15, stac9766_popbypass_mux);
+static SOC_ENUM_SINGLE_DECL(stac9766_record_all_enum,
+			    AC97_STAC_ANALOG_SPECIAL, 12,
+			    stac9766_record_all_mux);
+static SOC_ENUM_SINGLE_DECL(stac9766_boost1_enum,
+			    AC97_MIC, 6, stac9766_boost1); /* 0/10dB */
+static SOC_ENUM_SINGLE_DECL(stac9766_boost2_enum,
+			    AC97_STAC_ANALOG_SPECIAL, 2, stac9766_boost2); /* 0/20dB */
+static SOC_ENUM_SINGLE_DECL(stac9766_stereo_mic_enum,
+			    AC97_STAC_STEREO_MIC, 2, stac9766_stereo_mic);
 
 static const DECLARE_TLV_DB_LINEAR(master_tlv, -4600, 0);
 static const DECLARE_TLV_DB_LINEAR(record_tlv, 0, 2250);
-- 
1.8.5.2
