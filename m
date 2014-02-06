From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: pcm512x: More constification
Date: Thu,  6 Feb 2014 14:34:45 +0000
Message-ID: <1391697285-29913-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 818892651B8
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2014 16:03:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Since the core now takes const strings for enums we should be constifying
them (and the regulator supplies while we're at it).

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm512x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 5ad3e9aa3cb4..1150381fc373 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -30,7 +30,7 @@
 #include "pcm512x.h"
 
 #define PCM512x_NUM_SUPPLIES 3
-static const char *pcm512x_supply_names[PCM512x_NUM_SUPPLIES] = {
+static const char * const pcm512x_supply_names[PCM512x_NUM_SUPPLIES] = {
 	"AVDD",
 	"DVDD",
 	"CPVDD",
@@ -167,7 +167,7 @@ static bool pcm512x_volatile(struct device *dev, unsigned int reg)
 
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -10350, 50, 1);
 
-static const char *pcm512x_dsp_program_texts[] = {
+static const char * const pcm512x_dsp_program_texts[] = {
 	"FIR interpolation with de-emphasis",
 	"Low latency IIR with de-emphasis",
 	"Fixed process flow",
@@ -188,14 +188,14 @@ static const SOC_VALUE_ENUM_SINGLE_DECL(pcm512x_dsp_program,
 					pcm512x_dsp_program_texts,
 					pcm512x_dsp_program_values);
 
-static const char *pcm512x_clk_missing_text[] = {
+static const char * const pcm512x_clk_missing_text[] = {
 	"1s", "2s", "3s", "4s", "5s", "6s", "7s", "8s"
 };
 
 static const struct soc_enum pcm512x_clk_missing =
 	SOC_ENUM_SINGLE(PCM512x_CLKDET, 0,  8, pcm512x_clk_missing_text);
 
-static const char *pcm512x_autom_text[] = {
+static const char * const pcm512x_autom_text[] = {
 	"21ms", "106ms", "213ms", "533ms", "1.07s", "2.13s", "5.33s", "10.66s"
 };
 
@@ -207,7 +207,7 @@ static const struct soc_enum pcm512x_autom_r =
 	SOC_ENUM_SINGLE(PCM512x_AUTO_MUTE, PCM512x_ATMR_SHIFT, 8,
 			pcm512x_autom_text);
 
-static const char *pcm512x_ramp_rate_text[] = {
+static const char * const pcm512x_ramp_rate_text[] = {
 	"1 sample/update", "2 samples/update", "4 samples/update",
 	"Immediate"
 };
@@ -224,7 +224,7 @@ static const struct soc_enum pcm512x_vedf =
 	SOC_ENUM_SINGLE(PCM512x_DIGITAL_MUTE_2, PCM512x_VEDF_SHIFT, 4,
 			pcm512x_ramp_rate_text);
 
-static const char *pcm512x_ramp_step_text[] = {
+static const char * const pcm512x_ramp_step_text[] = {
 	"4dB/step", "2dB/step", "1dB/step", "0.5dB/step"
 };
 
-- 
1.9.rc1
