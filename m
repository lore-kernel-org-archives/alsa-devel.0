From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Implement WM8962 ADC high pass filter
	configuration
Date: Tue, 26 Apr 2011 16:05:13 +0100
Message-ID: <1303830313-15847-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29F662451E
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 17:05:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 7949f89..f90ae42 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2039,6 +2039,13 @@ static int wm8962_put_spk_sw(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static const char *cap_hpf_mode_text[] = {
+	"Hi-fi", "Application"
+};
+
+static const struct soc_enum cap_hpf_mode =
+	SOC_ENUM_SINGLE(WM8962_ADC_DAC_CONTROL_2, 10, 2, cap_hpf_mode_text);
+
 static const struct snd_kcontrol_new wm8962_snd_controls[] = {
 SOC_DOUBLE("Input Mixer Switch", WM8962_INPUT_MIXER_CONTROL_1, 3, 2, 1, 1),
 
@@ -2064,6 +2071,9 @@ SOC_DOUBLE_R("Capture Switch", WM8962_LEFT_INPUT_VOLUME,
 	     WM8962_RIGHT_INPUT_VOLUME, 7, 1, 1),
 SOC_DOUBLE_R("Capture ZC Switch", WM8962_LEFT_INPUT_VOLUME,
 	     WM8962_RIGHT_INPUT_VOLUME, 6, 1, 1),
+SOC_SINGLE("Capture HPF Switch", WM8962_ADC_DAC_CONTROL_1, 0, 1, 1),
+SOC_ENUM("Capture HPF Mode", cap_hpf_mode),
+SOC_SINGLE("Capture HPF Cutoff", WM8962_ADC_DAC_CONTROL_2, 7, 7, 0),
 
 SOC_DOUBLE_R_TLV("Sidetone Volume", WM8962_DAC_DSP_MIXING_1,
 		 WM8962_DAC_DSP_MIXING_2, 4, 12, 0, st_tlv),
-- 
1.7.4.1
