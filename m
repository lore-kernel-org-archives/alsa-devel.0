From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm5102: Add noise gate control
Date: Tue, 18 Dec 2012 14:13:05 +0000
Message-ID: <1355839986-17604-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1355839986-17604-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE7DA261624
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2012 15:13:09 +0100 (CET)
In-Reply-To: <1355839986-17604-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The references used for the noise gates and parameters for their triggering
are configurable, expose that to users.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 3831645..fad3684 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -45,6 +45,7 @@ static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
 static DECLARE_TLV_DB_SCALE(noise_tlv, 0, 600, 0);
+static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 
 static const struct wm_adsp_region wm5102_dsp1_regions[] = {
 	{ .type = WMFW_ADSP2_PM, .base = 0x100000 },
@@ -603,6 +604,17 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+#define WM5102_NG_SRC(name, base) \
+	SOC_SINGLE(name " NG HPOUT1L Switch",  base, 0, 1, 0), \
+	SOC_SINGLE(name " NG HPOUT1R Switch",  base, 1, 1, 0), \
+	SOC_SINGLE(name " NG HPOUT2L Switch",  base, 2, 1, 0), \
+	SOC_SINGLE(name " NG HPOUT2R Switch",  base, 3, 1, 0), \
+	SOC_SINGLE(name " NG EPOUT Switch",    base, 4, 1, 0), \
+	SOC_SINGLE(name " NG SPKOUTL Switch",  base, 6, 1, 0), \
+	SOC_SINGLE(name " NG SPKOUTR Switch",  base, 7, 1, 0), \
+	SOC_SINGLE(name " NG SPKDAT1L Switch", base, 8, 1, 0), \
+	SOC_SINGLE(name " NG SPKDAT1R Switch", base, 9, 1, 0)
+
 static const struct snd_kcontrol_new wm5102_snd_controls[] = {
 SOC_SINGLE("IN1 High Performance Switch", ARIZONA_IN1L_CONTROL,
 	   ARIZONA_IN1_OSR_SHIFT, 1, 0),
@@ -786,6 +798,22 @@ SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
 SOC_DOUBLE("SPKDAT1 Switch", ARIZONA_PDM_SPK1_CTRL_1, ARIZONA_SPK1L_MUTE_SHIFT,
 	   ARIZONA_SPK1R_MUTE_SHIFT, 1, 1),
 
+SOC_SINGLE("Noise Gate Switch", ARIZONA_NOISE_GATE_CONTROL,
+	   ARIZONA_NGATE_ENA_SHIFT, 1, 0),
+SOC_SINGLE_TLV("Noise Gate Threshold Volume", ARIZONA_NOISE_GATE_CONTROL,
+	       ARIZONA_NGATE_THR_SHIFT, 7, 1, ng_tlv),
+SOC_ENUM("Noise Gate Hold", arizona_ng_hold),
+
+WM5102_NG_SRC("HPOUT1L", ARIZONA_NOISE_GATE_SELECT_1L),
+WM5102_NG_SRC("HPOUT1R", ARIZONA_NOISE_GATE_SELECT_1R),
+WM5102_NG_SRC("HPOUT2L", ARIZONA_NOISE_GATE_SELECT_2L),
+WM5102_NG_SRC("HPOUT2R", ARIZONA_NOISE_GATE_SELECT_2R),
+WM5102_NG_SRC("EPOUT", ARIZONA_NOISE_GATE_SELECT_3L),
+WM5102_NG_SRC("SPKOUTL", ARIZONA_NOISE_GATE_SELECT_4L),
+WM5102_NG_SRC("SPKOUTR", ARIZONA_NOISE_GATE_SELECT_4R),
+WM5102_NG_SRC("SPKDAT1L", ARIZONA_NOISE_GATE_SELECT_5L),
+WM5102_NG_SRC("SPKDAT1R", ARIZONA_NOISE_GATE_SELECT_5R),
+
 ARIZONA_MIXER_CONTROLS("AIF1TX1", ARIZONA_AIF1TX1MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("AIF1TX2", ARIZONA_AIF1TX2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("AIF1TX3", ARIZONA_AIF1TX3MIX_INPUT_1_SOURCE),
-- 
1.7.10.4
