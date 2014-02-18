From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 017/102] ASoC: sta32x: Fix array access overflow
Date: Tue, 18 Feb 2014 12:36:52 +0100
Message-ID: <1392723422-12689-2-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FCF4265586
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:37:06 +0100 (CET)
In-Reply-To: <1392723422-12689-1-git-send-email-tiwai@suse.de>
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

Preset EQ enum of sta32x codec driver declares too many number of
items and it may lead to the access over the actual array size.

Use SOC_ENUM_SINGLE_DECL() helper and it's automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/sta32x.c | 72 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 06edb396e733..42c5b458b046 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -187,42 +187,42 @@ static const unsigned int sta32x_limiter_drc_release_tlv[] = {
 	13, 16, TLV_DB_SCALE_ITEM(-1500, 300, 0),
 };
 
-static const struct soc_enum sta32x_drc_ac_enum =
-	SOC_ENUM_SINGLE(STA32X_CONFD, STA32X_CONFD_DRC_SHIFT,
-			2, sta32x_drc_ac);
-static const struct soc_enum sta32x_auto_eq_enum =
-	SOC_ENUM_SINGLE(STA32X_AUTO1, STA32X_AUTO1_AMEQ_SHIFT,
-			3, sta32x_auto_eq_mode);
-static const struct soc_enum sta32x_auto_gc_enum =
-	SOC_ENUM_SINGLE(STA32X_AUTO1, STA32X_AUTO1_AMGC_SHIFT,
-			4, sta32x_auto_gc_mode);
-static const struct soc_enum sta32x_auto_xo_enum =
-	SOC_ENUM_SINGLE(STA32X_AUTO2, STA32X_AUTO2_XO_SHIFT,
-			16, sta32x_auto_xo_mode);
-static const struct soc_enum sta32x_preset_eq_enum =
-	SOC_ENUM_SINGLE(STA32X_AUTO3, STA32X_AUTO3_PEQ_SHIFT,
-			32, sta32x_preset_eq_mode);
-static const struct soc_enum sta32x_limiter_ch1_enum =
-	SOC_ENUM_SINGLE(STA32X_C1CFG, STA32X_CxCFG_LS_SHIFT,
-			3, sta32x_limiter_select);
-static const struct soc_enum sta32x_limiter_ch2_enum =
-	SOC_ENUM_SINGLE(STA32X_C2CFG, STA32X_CxCFG_LS_SHIFT,
-			3, sta32x_limiter_select);
-static const struct soc_enum sta32x_limiter_ch3_enum =
-	SOC_ENUM_SINGLE(STA32X_C3CFG, STA32X_CxCFG_LS_SHIFT,
-			3, sta32x_limiter_select);
-static const struct soc_enum sta32x_limiter1_attack_rate_enum =
-	SOC_ENUM_SINGLE(STA32X_L1AR, STA32X_LxA_SHIFT,
-			16, sta32x_limiter_attack_rate);
-static const struct soc_enum sta32x_limiter2_attack_rate_enum =
-	SOC_ENUM_SINGLE(STA32X_L2AR, STA32X_LxA_SHIFT,
-			16, sta32x_limiter_attack_rate);
-static const struct soc_enum sta32x_limiter1_release_rate_enum =
-	SOC_ENUM_SINGLE(STA32X_L1AR, STA32X_LxR_SHIFT,
-			16, sta32x_limiter_release_rate);
-static const struct soc_enum sta32x_limiter2_release_rate_enum =
-	SOC_ENUM_SINGLE(STA32X_L2AR, STA32X_LxR_SHIFT,
-			16, sta32x_limiter_release_rate);
+static SOC_ENUM_SINGLE_DECL(sta32x_drc_ac_enum,
+			    STA32X_CONFD, STA32X_CONFD_DRC_SHIFT,
+			    sta32x_drc_ac);
+static SOC_ENUM_SINGLE_DECL(sta32x_auto_eq_enum,
+			    STA32X_AUTO1, STA32X_AUTO1_AMEQ_SHIFT,
+			    sta32x_auto_eq_mode);
+static SOC_ENUM_SINGLE_DECL(sta32x_auto_gc_enum,
+			    STA32X_AUTO1, STA32X_AUTO1_AMGC_SHIFT,
+			    sta32x_auto_gc_mode);
+static SOC_ENUM_SINGLE_DECL(sta32x_auto_xo_enum,
+			    STA32X_AUTO2, STA32X_AUTO2_XO_SHIFT,
+			    sta32x_auto_xo_mode);
+static SOC_ENUM_SINGLE_DECL(sta32x_preset_eq_enum,
+			    STA32X_AUTO3, STA32X_AUTO3_PEQ_SHIFT,
+			    sta32x_preset_eq_mode);
+static SOC_ENUM_SINGLE_DECL(sta32x_limiter_ch1_enum,
+			    STA32X_C1CFG, STA32X_CxCFG_LS_SHIFT,
+			    sta32x_limiter_select);
+static SOC_ENUM_SINGLE_DECL(sta32x_limiter_ch2_enum,
+			    STA32X_C2CFG, STA32X_CxCFG_LS_SHIFT,
+			    sta32x_limiter_select);
+static SOC_ENUM_SINGLE_DECL(sta32x_limiter_ch3_enum,
+			    STA32X_C3CFG, STA32X_CxCFG_LS_SHIFT,
+			    sta32x_limiter_select);
+static SOC_ENUM_SINGLE_DECL(sta32x_limiter1_attack_rate_enum,
+			    STA32X_L1AR, STA32X_LxA_SHIFT,
+			    sta32x_limiter_attack_rate);
+static SOC_ENUM_SINGLE_DECL(sta32x_limiter2_attack_rate_enum,
+			    STA32X_L2AR, STA32X_LxA_SHIFT,
+			    sta32x_limiter_attack_rate);
+static SOC_ENUM_SINGLE_DECL(sta32x_limiter1_release_rate_enum,
+			    STA32X_L1AR, STA32X_LxR_SHIFT,
+			    sta32x_limiter_release_rate);
+static SOC_ENUM_SINGLE_DECL(sta32x_limiter2_release_rate_enum,
+			    STA32X_L2AR, STA32X_LxR_SHIFT,
+			    sta32x_limiter_release_rate);
 
 /* byte array controls for setting biquad, mixer, scaling coefficients;
  * for biquads all five coefficients need to be set in one go,
-- 
1.8.5.2
