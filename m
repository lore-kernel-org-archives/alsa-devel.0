From: Jeremy McDermond <nh6z@nh6z.net>
Subject: [PATCH 2/2] ASoC: tlv320aic32x4: Add additional input
	pins
Date: Wed, 20 Apr 2016 11:39:12 -0700
Message-ID: <1461177552-31809-3-git-send-email-nh6z@nh6z.net>
References: <1461177552-31809-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BFE24265074
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 20:39:22 +0200 (CEST)
In-Reply-To: <1461177552-31809-1-git-send-email-nh6z@nh6z.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
Cc: Jeremy McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The input mixers support routing the IN1_R pin to the Left PGA and the
IN2_L pin to the Right PGA.  This patch allows for those routings.

Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 621f421..0eb8acc 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -193,11 +193,14 @@ static SOC_ENUM_SINGLE_DECL(in2l_lpga_p_enum, AIC32X4_LMICPGAPIN, 4,
 		resistor_text);
 static SOC_ENUM_SINGLE_DECL(in3l_lpga_p_enum, AIC32X4_LMICPGAPIN, 2,
 		resistor_text);
+static SOC_ENUM_SINGLE_DECL(in1r_lpga_p_enum, AIC32X4_LMICPGAPIN, 0,
+		resistor_text);
 
 static const struct snd_kcontrol_new left_input_mixer_controls[] = {
 	SOC_DAPM_ENUM("IN1_L P Switch", in1l_lpga_p_enum),
 	SOC_DAPM_ENUM("IN2_L P Switch", in2l_lpga_p_enum),
 	SOC_DAPM_ENUM("IN3_L P Switch", in3l_lpga_p_enum),
+	SOC_DAPM_ENUM("IN1_R P Switch", in1r_lpga_p_enum),
 };
 
 static SOC_ENUM_SINGLE_DECL(in1r_rpga_p_enum, AIC32X4_RMICPGAPIN, 6,
@@ -206,11 +209,14 @@ static SOC_ENUM_SINGLE_DECL(in2r_rpga_p_enum, AIC32X4_RMICPGAPIN, 4,
 		resistor_text);
 static SOC_ENUM_SINGLE_DECL(in3r_rpga_p_enum, AIC32X4_RMICPGAPIN, 2,
 		resistor_text);
+static SOC_ENUM_SINGLE_DECL(in2l_rpga_p_enum, AIC32X4_RMICPGAPIN, 0,
+		resistor_text);
 
 static const struct snd_kcontrol_new right_input_mixer_controls[] = {
 	SOC_DAPM_ENUM("IN1_R P Switch", in1r_rpga_p_enum),
 	SOC_DAPM_ENUM("IN2_R P Switch", in2r_rpga_p_enum),
 	SOC_DAPM_ENUM("IN3_R P Switch", in3r_rpga_p_enum),
+	SOC_DAPM_ENUM("IN2_L P Switch", in2l_rpga_p_enum),
 };
 
 static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
@@ -285,6 +291,7 @@ static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
 	{"Left Input Mixer", "IN1_L P Switch", "IN1_L"},
 	{"Left Input Mixer", "IN2_L P Switch", "IN2_L"},
 	{"Left Input Mixer", "IN3_L P Switch", "IN3_L"},
+	{"Left Input Mixer", "IN1_R P Switch", "IN1_R"},
 
 	{"Left ADC", NULL, "Left Input Mixer"},
 
@@ -292,6 +299,7 @@ static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
 	{"Right Input Mixer", "IN1_R P Switch", "IN1_R"},
 	{"Right Input Mixer", "IN2_R P Switch", "IN2_R"},
 	{"Right Input Mixer", "IN3_R P Switch", "IN3_R"},
+	{"Right Input Mixer", "IN2_L P Switch", "IN2_L"},
 
 	{"Right ADC", NULL, "Right Input Mixer"},
 };
-- 
2.5.0
