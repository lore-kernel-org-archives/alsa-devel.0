From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8960: add kcontrol to select ADC data
	output" to the asoc tree
Date: Thu, 24 Dec 2015 19:43:55 +0000
Message-ID: <E1aCBnn-0000nz-Fn@finisterre>
References: <72b882412e24df59de1a6fe63568ac5ee5d998ca.1450940174.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E54092606B8
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 20:44:08 +0100 (CET)
In-Reply-To: <72b882412e24df59de1a6fe63568ac5ee5d998ca.1450940174.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8960: add kcontrol to select ADC data output

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

>From 4a5893cf67062be4f70196c3fe45cfda950ea308 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Thu, 24 Dec 2015 14:58:03 +0800
Subject: [PATCH] ASoC: wm8960: add kcontrol to select ADC data output

add kcontrol to select ADC data output.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 0563753..328bde0 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -147,6 +147,12 @@ static const char *wm8960_3d_upper_cutoff[] = {"High", "Low"};
 static const char *wm8960_3d_lower_cutoff[] = {"Low", "High"};
 static const char *wm8960_alcfunc[] = {"Off", "Right", "Left", "Stereo"};
 static const char *wm8960_alcmode[] = {"ALC", "Limiter"};
+static const char *wm8960_adc_data_output_sel[] = {
+	"Left Data = Left ADC;  Right Data = Right ADC",
+	"Left Data = Left ADC;  Right Data = Left ADC",
+	"Left Data = Right ADC; Right Data = Right ADC",
+	"Left Data = Right ADC; Right Data = Left ADC",
+};
 
 static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
@@ -155,6 +161,7 @@ static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_3D, 5, 2, wm8960_3d_lower_cutoff),
 	SOC_ENUM_SINGLE(WM8960_ALC1, 7, 4, wm8960_alcfunc),
 	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
+	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 2, 4, wm8960_adc_data_output_sel),
 };
 
 static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
@@ -295,6 +302,8 @@ SOC_SINGLE_TLV("Right Output Mixer Boost Bypass Volume",
 	       WM8960_BYPASS2, 4, 7, 1, bypass_tlv),
 SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
 	       WM8960_ROUTMIX, 4, 7, 1, bypass_tlv),
+
+SOC_ENUM("ADC Data Output Select", wm8960_enum[6]),
 };
 
 static const struct snd_kcontrol_new wm8960_lin_boost[] = {
-- 
2.6.4
