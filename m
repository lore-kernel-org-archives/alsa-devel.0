From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8960: add DAC mono mix kcontrol" to
	the asoc tree
Date: Fri, 08 Jan 2016 13:44:41 +0000
Message-ID: <E1aHXLN-0003Du-Hy@debutante>
References: <3d52a0f560ed565ca81da1d041744e1814d7b561.1452243300.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA626260421
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 14:44:52 +0100 (CET)
In-Reply-To: <3d52a0f560ed565ca81da1d041744e1814d7b561.1452243300.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8960: add DAC mono mix kcontrol

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

>From defbf708baf2a4cc4421699d02b57d7c3bb728b0 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 8 Jan 2016 16:57:01 +0800
Subject: [PATCH] ASoC: wm8960: add DAC mono mix kcontrol

In normal operation, the left and right channel digital audio data is
converted to analogue in two separate DACs. There is a mono-mix mode
where the two audio channels are mixed together digitally and then
converted to analogue using only one DAC, while the other DAC is
switched off. The mono-mix signal can be selected to appear on both
analogue output channels. The mono mix is automatically attenuated by
6dB to prevent clipping.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 328bde09d5bf..9e90b8e2b86e 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -153,6 +153,7 @@ static const char *wm8960_adc_data_output_sel[] = {
 	"Left Data = Right ADC; Right Data = Right ADC",
 	"Left Data = Right ADC; Right Data = Left ADC",
 };
+static const char *wm8960_dmonomix[] = {"Stereo", "Mono"};
 
 static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
@@ -162,6 +163,7 @@ static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_ALC1, 7, 4, wm8960_alcfunc),
 	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
 	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 2, 4, wm8960_adc_data_output_sel),
+	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 4, 2, wm8960_dmonomix),
 };
 
 static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
@@ -304,6 +306,7 @@ SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
 	       WM8960_ROUTMIX, 4, 7, 1, bypass_tlv),
 
 SOC_ENUM("ADC Data Output Select", wm8960_enum[6]),
+SOC_ENUM("DAC Mono Mix", wm8960_enum[7]),
 };
 
 static const struct snd_kcontrol_new wm8960_lin_boost[] = {
-- 
2.7.0.rc3
