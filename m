From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/5] ASoC: max98090: Fix checkpatch errors
	related to spacing
Date: Mon, 18 Feb 2013 17:02:14 +0530
Message-ID: <1361187134-7525-5-git-send-email-sachin.kamat@linaro.org>
References: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f48.google.com (mail-pb0-f48.google.com
 [209.85.160.48])
 by alsa0.perex.cz (Postfix) with ESMTP id CD80726508D
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 12:42:21 +0100 (CET)
Received: by mail-pb0-f48.google.com with SMTP id wy12so1628325pbc.35
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 03:42:20 -0800 (PST)
In-Reply-To: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Fixes the following type of checkpatch errors:
ERROR: "foo * bar" should be "foo *bar"
ERROR: space required before the open brace '{'

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/max98090.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 4e8f88e..baebe2e 100755
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -507,16 +507,16 @@ static int max98090_put_enab_tlv(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const char * max98090_perf_pwr_text[] =
+static const char *max98090_perf_pwr_text[] =
 	{ "High Performance", "Low Power" };
-static const char * max98090_pwr_perf_text[] =
+static const char *max98090_pwr_perf_text[] =
 	{ "Low Power", "High Performance" };
 
 static const struct soc_enum max98090_vcmbandgap_enum =
 	SOC_ENUM_SINGLE(M98090_REG_BIAS_CONTROL, M98090_VCM_MODE_SHIFT,
 		ARRAY_SIZE(max98090_pwr_perf_text), max98090_pwr_perf_text);
 
-static const char * max98090_osr128_text[] = { "64*fs", "128*fs" };
+static const char *max98090_osr128_text[] = { "64*fs", "128*fs" };
 
 static const struct soc_enum max98090_osr128_enum =
 	SOC_ENUM_SINGLE(M98090_REG_ADC_CONTROL, M98090_OSR128_SHIFT,
@@ -533,28 +533,28 @@ static const struct soc_enum max98090_filter_dmic34mode_enum =
 		M98090_FLT_DMIC34MODE_SHIFT,
 		ARRAY_SIZE(max98090_mode_text), max98090_mode_text);
 
-static const char * max98090_drcatk_text[] =
+static const char *max98090_drcatk_text[] =
 	{ "0.5ms", "1ms", "5ms", "10ms", "25ms", "50ms", "100ms", "200ms" };
 
 static const struct soc_enum max98090_drcatk_enum =
 	SOC_ENUM_SINGLE(M98090_REG_DRC_TIMING, M98090_DRCATK_SHIFT,
 		ARRAY_SIZE(max98090_drcatk_text), max98090_drcatk_text);
 
-static const char * max98090_drcrls_text[] =
+static const char *max98090_drcrls_text[] =
 	{ "8s", "4s", "2s", "1s", "0.5s", "0.25s", "0.125s", "0.0625s" };
 
 static const struct soc_enum max98090_drcrls_enum =
 	SOC_ENUM_SINGLE(M98090_REG_DRC_TIMING, M98090_DRCRLS_SHIFT,
 		ARRAY_SIZE(max98090_drcrls_text), max98090_drcrls_text);
 
-static const char * max98090_alccmp_text[] =
+static const char *max98090_alccmp_text[] =
 	{ "1:1", "1:1.5", "1:2", "1:4", "1:INF" };
 
 static const struct soc_enum max98090_alccmp_enum =
 	SOC_ENUM_SINGLE(M98090_REG_DRC_COMPRESSOR, M98090_DRCCMP_SHIFT,
 		ARRAY_SIZE(max98090_alccmp_text), max98090_alccmp_text);
 
-static const char * max98090_drcexp_text[] = { "1:1", "2:1", "3:1" };
+static const char *max98090_drcexp_text[] = { "1:1", "2:1", "3:1" };
 
 static const struct soc_enum max98090_drcexp_enum =
 	SOC_ENUM_SINGLE(M98090_REG_DRC_EXPANDER, M98090_DRCEXP_SHIFT,
@@ -805,7 +805,7 @@ static int max98090_micinput_event(struct snd_soc_dapm_widget *w,
 		val = (val & M98090_MIC_PA2EN_MASK) >> M98090_MIC_PA2EN_SHIFT;
 
 
-	if (val >= 1){
+	if (val >= 1) {
 		if (w->reg == M98090_REG_MIC1_INPUT_LEVEL)
 			max98090->pa1en = val - 1; /* Update for volatile */
 		else
@@ -856,7 +856,7 @@ static const struct soc_enum mic2_mux_enum =
 static const struct snd_kcontrol_new max98090_mic2_mux =
 	SOC_DAPM_ENUM("MIC2 Mux", mic2_mux_enum);
 
-static const char * max98090_micpre_text[] = { "Off", "On" };
+static const char *max98090_micpre_text[] = { "Off", "On" };
 
 static const struct soc_enum max98090_pa1en_enum =
 	SOC_ENUM_SINGLE(M98090_REG_MIC1_INPUT_LEVEL, M98090_MIC_PA1EN_SHIFT,
-- 
1.7.4.1
