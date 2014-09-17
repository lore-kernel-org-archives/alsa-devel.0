From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv4 4/9] WM8971 uses TLV information
Date: Wed, 17 Sep 2014 16:41:10 +0800
Message-ID: <1410943275-4160-4-git-send-email-xavier.hsu@linaro.org>
References: <1410943275-4160-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id EB74D2652E9
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 10:41:29 +0200 (CEST)
In-Reply-To: <1410943275-4160-1-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch improves WM8971.
We use TLV information.

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
Any comments about improving the patch are welcome.
Thanks.

 sound/soc/codecs/wm8971.c |   57 +++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 22c8fcc..c2ebc77 100755
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -30,6 +30,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 
 #include "wm8971.h"
 
@@ -207,8 +208,19 @@ static const SOC_ENUM_SINGLE_DECL(capture_polarity, WM8971_ADCDAC,
 				  5, wm8971_adcpol);
 static const SOC_ENUM_SINGLE_DECL(monomux, WM8971_ADCIN, 6, wm8971_mono_mux);
 
+static const DECLARE_TLV_DB_SCALE(in_vol, -1725, 75, 0);
+static const DECLARE_TLV_DB_SCALE(out_vol, -6700, 91, 0);
+static const DECLARE_TLV_DB_SCALE(attenuate_6db, -600, 600, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol, -12700, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tone_vol, -600, 150, 0);
+static const DECLARE_TLV_DB_SCALE(alc_tar_vol, -2850, 150, 0);
+static const DECLARE_TLV_DB_SCALE(alc_max_vol, -1200, 600, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol, -9700, 50, 0);
+static const DECLARE_TLV_DB_SCALE(bypass_out_vol, -1500, 300, 0);
+
 static const struct snd_kcontrol_new wm8971_snd_controls[] = {
-	SOC_DOUBLE_R("Capture Volume", WM8971_LINVOL, WM8971_RINVOL, 0, 63, 0),
+	SOC_DOUBLE_R_TLV("Capture Volume", WM8971_LINVOL, WM8971_RINVOL,
+			 0, 63, 0, in_vol),
 	SOC_DOUBLE_R("Capture ZC Switch", WM8971_LINVOL, WM8971_RINVOL,
 		     6, 1, 0),
 	SOC_DOUBLE_R("Capture Switch", WM8971_LINVOL, WM8971_RINVOL, 7, 1, 1),
@@ -219,31 +231,35 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 		     WM8971_ROUT2V, 7, 1, 0),
 	SOC_SINGLE("Mono Playback ZC Switch", WM8971_MOUTV, 7, 1, 0),
 
-	SOC_DOUBLE_R("PCM Volume", WM8971_LDAC, WM8971_RDAC, 0, 255, 0),
+	SOC_DOUBLE_R_TLV("PCM Volume", WM8971_LDAC, WM8971_RDAC,
+			 0, 255, 0, dac_vol),
 
-	SOC_DOUBLE_R("Bypass Left Playback Volume", WM8971_LOUTM1,
-		     WM8971_LOUTM2, 4, 7, 1),
-	SOC_DOUBLE_R("Bypass Right Playback Volume", WM8971_ROUTM1,
-		     WM8971_ROUTM2, 4, 7, 1),
-	SOC_DOUBLE_R("Bypass Mono Playback Volume", WM8971_MOUTM1,
-		     WM8971_MOUTM2, 4, 7, 1),
+	SOC_DOUBLE_R_TLV("Bypass Left Playback Volume", WM8971_LOUTM1,
+			 WM8971_LOUTM2, 4, 7, 1, bypass_out_vol),
+	SOC_DOUBLE_R_TLV("Bypass Right Playback Volume", WM8971_ROUTM1,
+			 WM8971_ROUTM2, 4, 7, 1, bypass_out_vol),
+	SOC_DOUBLE_R_TLV("Bypass Mono Playback Volume", WM8971_MOUTM1,
+			 WM8971_MOUTM2, 4, 7, 1, bypass_out_vol),
 
-	SOC_DOUBLE_R("Headphone Playback Volume", WM8971_LOUT1V,
-		     WM8971_ROUT1V, 0, 127, 0),
-	SOC_DOUBLE_R("Speaker Playback Volume", WM8971_LOUT2V,
-		     WM8971_ROUT2V, 0, 127, 0),
+	SOC_DOUBLE_R_TLV("Headphone Playback Volume", WM8971_LOUT1V,
+			 WM8971_ROUT1V, 0, 127, 0, out_vol),
+	SOC_DOUBLE_R_TLV("Speaker Playback Volume", WM8971_LOUT2V,
+			 WM8971_ROUT2V, 0, 127, 0, out_vol),
+	SOC_SINGLE_TLV("Mono Playback Volume", WM8971_MOUTV,
+		       0, 127, 0, out_vol),
 
 	SOC_ENUM("Bass Boost", bass_boost),
 	SOC_ENUM("Bass Filter", bass_filter),
-	SOC_SINGLE("Bass Volume", WM8971_BASS, 0, 7, 1),
+	SOC_SINGLE_TLV("Bass Volume", WM8971_BASS, 0, 15, 1, tone_vol),
 
-	SOC_SINGLE("Treble Volume", WM8971_TREBLE, 0, 7, 0),
+	SOC_SINGLE_TLV("Treble Volume", WM8971_TREBLE, 0, 15, 0, tone_vol),
 	SOC_ENUM("Treble Cut-off", treble_cutoff),
 
 	SOC_SINGLE("Capture Filter Switch", WM8971_ADCDAC, 0, 1, 1),
 
-	SOC_SINGLE("ALC Target Volume", WM8971_ALC1, 0, 7, 0),
-	SOC_SINGLE("ALC Max Volume", WM8971_ALC1, 4, 7, 0),
+	SOC_SINGLE_TLV("ALC Target Volume", WM8971_ALC1,
+		       0, 15, 0, alc_tar_vol),
+	SOC_SINGLE_TLV("ALC Max Volume", WM8971_ALC1, 4, 7, 0, alc_max_vol),
 
 	SOC_SINGLE("ALC Capture Target Volume", WM8971_ALC1, 0, 7, 0),
 	SOC_SINGLE("ALC Capture Max Volume", WM8971_ALC1, 4, 7, 0),
@@ -256,8 +272,10 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 	SOC_ENUM("ALC Capture NG Type", alc_capture_ngtype),
 	SOC_SINGLE("ALC Capture NG Switch", WM8971_NGATE, 0, 1, 0),
 
-	SOC_SINGLE("Capture 6dB Attenuate", WM8971_ADCDAC, 8, 1, 0),
-	SOC_SINGLE("Playback 6dB Attenuate", WM8971_ADCDAC, 7, 1, 0),
+	SOC_SINGLE_TLV("Capture 6dB Attenuate", WM8971_ADCDAC,
+		       8, 1, 0, attenuate_6db),
+	SOC_SINGLE_TLV("Playback 6dB Attenuate", WM8971_ADCDAC,
+		       7, 1, 0, attenuate_6db),
 
 	SOC_SINGLE_BOOL_EXT("Playback De-emphasis Switch", 0,
 			    wm8971_get_deemph, wm8971_put_deemph),
@@ -265,6 +283,9 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 	SOC_ENUM("Playback Phase", dac_phase_inv),
 
 	SOC_DOUBLE_R("Mic Boost", WM8971_LADCIN, WM8971_RADCIN, 4, 3, 0),
+
+	SOC_DOUBLE_R_TLV("ADC Volume", WM8971_LADC, WM8971_RADC,
+			 0, 255, 0, adc_vol),
 };
 
 /*
-- 
1.7.9.5
