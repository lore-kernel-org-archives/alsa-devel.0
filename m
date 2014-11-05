From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5677: Minor coding style and typo
	fix
Date: Wed, 5 Nov 2014 13:42:52 +0800
Message-ID: <1415166173-7504-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 86D4C261734
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 06:43:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Minor coding style and typo fix

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677-spi.h |  4 ++--
 sound/soc/codecs/rt5677.c     | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5677-spi.h b/sound/soc/codecs/rt5677-spi.h
index 7528bfd..ec41b2b 100644
--- a/sound/soc/codecs/rt5677-spi.h
+++ b/sound/soc/codecs/rt5677-spi.h
@@ -9,8 +9,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __RT5671_SPI_H__
-#define __RT5671_SPI_H__
+#ifndef __RT5677_SPI_H__
+#define __RT5677_SPI_H__
 
 #define RT5677_SPI_BUF_LEN 240
 #define RT5677_SPI_CMD_BURST_WRITE 0x05
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index ca264f8..0d24dc4 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1353,7 +1353,7 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5677_ib45_bypass_src_mux =
 	SOC_DAPM_ENUM("IB45 Bypass Source", rt5677_ib45_bypass_src_enum);
 
-/* Stereo ADC Source 2 */ /* MX-27 MX26  MX25 [11:10] */
+/* Stereo ADC Source 2 */ /* MX-27 MX26 MX25 [11:10] */
 static const char * const rt5677_stereo_adc2_src[] = {
 	"DD MIX1", "DMIC", "Stereo DAC MIX"
 };
@@ -1438,7 +1438,7 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5677_sto2_adc_lr_mux =
 	SOC_DAPM_ENUM("Stereo2 ADC LR Source", rt5677_stereo2_adc_lr_enum);
 
-/* Stereo1 ADC Source 1 */ /* MX-27 MX26  MX25 [13:12] */
+/* Stereo1 ADC Source 1 */ /* MX-27 MX26 MX25 [13:12] */
 static const char * const rt5677_stereo_adc1_src[] = {
 	"DD MIX1", "ADC1/2", "Stereo DAC MIX"
 };
@@ -1710,7 +1710,7 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5677_pdm2_r_mux =
 	SOC_DAPM_ENUM("PDM2 Source", rt5677_pdm2_r_enum);
 
-/* TDM IF1/2 SLB ADC1 Data Selection */ /* MX-3C MX-41 [5:4] MX-08 [1:0]*/
+/* TDM IF1/2 SLB ADC1 Data Selection */ /* MX-3C MX-41 [5:4] MX-08 [1:0] */
 static const char * const rt5677_if12_adc1_src[] = {
 	"STO1 ADC MIX", "OB01", "VAD ADC"
 };
@@ -1788,7 +1788,7 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5677_slb_adc3_mux =
 	SOC_DAPM_ENUM("SLB ADC3 Source", rt5677_slb_adc3_enum);
 
-/* TDM IF1/2 SLB ADC4 Data Selection */ /* MX-3C MX-41 [11:10]  MX-08 [7:6] */
+/* TDM IF1/2 SLB ADC4 Data Selection */ /* MX-3C MX-41 [11:10] MX-08 [7:6] */
 static const char * const rt5677_if12_adc4_src[] = {
 	"STO4 ADC MIX", "OB67", "OB01"
 };
@@ -1814,7 +1814,7 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5677_slb_adc4_mux =
 	SOC_DAPM_ENUM("SLB ADC4 Source", rt5677_slb_adc4_enum);
 
-/* Interface3/4 ADC Data Input */ /* MX-2F [3:0] MX-30 [7:4]*/
+/* Interface3/4 ADC Data Input */ /* MX-2F [3:0] MX-30 [7:4] */
 static const char * const rt5677_if34_adc_src[] = {
 	"STO1 ADC MIX", "STO2 ADC MIX", "STO3 ADC MIX", "STO4 ADC MIX",
 	"MONO ADC MIX", "OB01", "OB23", "VAD ADC"
@@ -1895,7 +1895,7 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5677_if2_adc4_swap_mux =
 	SOC_DAPM_ENUM("IF2 ADC4 Swap Source", rt5677_if2_adc4_swap_enum);
 
-/* TDM IF1 ADC Data Selection */ /* MX-3C  [2:0] */
+/* TDM IF1 ADC Data Selection */ /* MX-3C [2:0] */
 static const char * const rt5677_if1_adc_tdm_swap_src[] = {
 	"1/2/3/4", "2/1/3/4", "2/3/1/4", "4/1/2/3", "1/3/2/4", "1/4/2/3",
 	"3/1/2/4", "3/4/1/2"
@@ -2442,7 +2442,7 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 		rt5677_ob_7_mix, ARRAY_SIZE(rt5677_ob_7_mix)),
 
 	/* Output Side */
-	/* DAC mixer before sound effect  */
+	/* DAC mixer before sound effect */
 	SND_SOC_DAPM_MIXER("DAC1 MIXL", SND_SOC_NOPM, 0, 0,
 		rt5677_dac_l_mix, ARRAY_SIZE(rt5677_dac_l_mix)),
 	SND_SOC_DAPM_MIXER("DAC1 MIXR", SND_SOC_NOPM, 0, 0,
-- 
1.8.1.1.439.g50a6b54
