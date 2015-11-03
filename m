From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8998: Remove duplicated consts" to
	the asoc tree
Date: Tue, 03 Nov 2015 19:09:42 +0000
Message-ID: <E1Ztgxi-0007Oh-Iv@debutante>
References: <1446563150-28755-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B69AE2604D3
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 20:09:51 +0100 (CET)
In-Reply-To: <1446563150-28755-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8998: Remove duplicated consts

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 82d6717f675f4ce7764c1978d844c59b57ca1499 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 3 Nov 2015 15:05:50 +0000
Subject: [PATCH] ASoC: wm8998: Remove duplicated consts

The SOC_xxx_DECL() macros already include 'const' so there's
no need to put a const in the source where they are used.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8998.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 8782dfb628ab..7719bc509e50 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -199,20 +199,20 @@ static const char * const wm8998_inmux_texts[] = {
 	"B",
 };
 
-static const SOC_ENUM_SINGLE_DECL(wm8998_in1muxl_enum,
-				  ARIZONA_ADC_DIGITAL_VOLUME_1L,
-				  ARIZONA_IN1L_SRC_SHIFT,
-				  wm8998_inmux_texts);
+static SOC_ENUM_SINGLE_DECL(wm8998_in1muxl_enum,
+			    ARIZONA_ADC_DIGITAL_VOLUME_1L,
+			    ARIZONA_IN1L_SRC_SHIFT,
+			    wm8998_inmux_texts);
 
-static const SOC_ENUM_SINGLE_DECL(wm8998_in1muxr_enum,
-				  ARIZONA_ADC_DIGITAL_VOLUME_1R,
-				  ARIZONA_IN1R_SRC_SHIFT,
-				  wm8998_inmux_texts);
+static SOC_ENUM_SINGLE_DECL(wm8998_in1muxr_enum,
+			    ARIZONA_ADC_DIGITAL_VOLUME_1R,
+			    ARIZONA_IN1R_SRC_SHIFT,
+			    wm8998_inmux_texts);
 
-static const SOC_ENUM_SINGLE_DECL(wm8998_in2mux_enum,
-				  ARIZONA_ADC_DIGITAL_VOLUME_2L,
-				  ARIZONA_IN2L_SRC_SHIFT,
-				  wm8998_inmux_texts);
+static SOC_ENUM_SINGLE_DECL(wm8998_in2mux_enum,
+			    ARIZONA_ADC_DIGITAL_VOLUME_2L,
+			    ARIZONA_IN2L_SRC_SHIFT,
+			    wm8998_inmux_texts);
 
 static const struct snd_kcontrol_new wm8998_in1mux[2] = {
 	SOC_DAPM_ENUM_EXT("IN1L Mux", wm8998_in1muxl_enum,
@@ -522,17 +522,17 @@ static const unsigned int wm8998_aec_loopback_values[] = {
 	0, 1, 2, 3, 4, 6, 7, 8, 9,
 };
 
-static const SOC_VALUE_ENUM_SINGLE_DECL(wm8998_aec1_loopback,
-					ARIZONA_DAC_AEC_CONTROL_1,
-					ARIZONA_AEC_LOOPBACK_SRC_SHIFT, 0xf,
-					wm8998_aec_loopback_texts,
-					wm8998_aec_loopback_values);
-
-static const SOC_VALUE_ENUM_SINGLE_DECL(wm8998_aec2_loopback,
-					ARIZONA_DAC_AEC_CONTROL_2,
-					ARIZONA_AEC_LOOPBACK_SRC_SHIFT, 0xf,
-					wm8998_aec_loopback_texts,
-					wm8998_aec_loopback_values);
+static SOC_VALUE_ENUM_SINGLE_DECL(wm8998_aec1_loopback,
+				  ARIZONA_DAC_AEC_CONTROL_1,
+				  ARIZONA_AEC_LOOPBACK_SRC_SHIFT, 0xf,
+				  wm8998_aec_loopback_texts,
+				  wm8998_aec_loopback_values);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(wm8998_aec2_loopback,
+				  ARIZONA_DAC_AEC_CONTROL_2,
+				  ARIZONA_AEC_LOOPBACK_SRC_SHIFT, 0xf,
+				  wm8998_aec_loopback_texts,
+				  wm8998_aec_loopback_values);
 
 static const struct snd_kcontrol_new wm8998_aec_loopback_mux[] = {
 	SOC_DAPM_ENUM("AEC1 Loopback", wm8998_aec1_loopback),
-- 
2.6.2
