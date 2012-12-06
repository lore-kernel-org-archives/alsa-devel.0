From: <MR.Swami.Reddy@ti.com>
Subject: [PATCH] ASoC: lm49453: Fix adc,
	mic and sidetone volume ranges
Date: Thu, 6 Dec 2012 16:08:12 +0530
Message-ID: <1354790292-11968-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB0026030B
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 11:21:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: vishwas.a.deshpande@ti.com, alsa-devel@alsa-project.org, MR Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

From: MR Swami Reddy <MR.Swami.Reddy@ti.com>

[PATCH] ASoC: lm49453: Fix adc, mic and sidetone volume ranges

Signed-off-by: MR Swami Reddy <mr.swami.reddy@ti.com>

--
 sound/soc/codecs/lm49453.c |   43 ++++++++++++++++++++++++-------------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 808e50a..379fcdf 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -494,36 +494,41 @@ SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_PORT2_TX2_REG, 7, 1, 0),
 };
 
 /* TLV Declarations */
-static const DECLARE_TLV_DB_SCALE(digital_tlv, -7650, 150, 1);
-static const DECLARE_TLV_DB_SCALE(port_tlv, 0, 600, 0);
+static const DECLARE_TLV_DB_SCALE(adc_dac_tlv, -7650, 150, 1);
+static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 200, 1);
+static const DECLARE_TLV_DB_SCALE(port_tlv, -1800, 600, 0);
+static const DECLARE_TLV_DB_SCALE(stn_tlv, -7200, 150, 0);
 
 static const struct snd_kcontrol_new lm49453_sidetone_mixer_controls[] = {
 /* Sidetone supports mono only */
 SOC_DAPM_SINGLE_TLV("Sidetone ADCL Volume", LM49453_P0_STN_VOL_ADCL_REG,
-		     0, 0x3F, 0, digital_tlv),
+		     0, 0x3F, 0, stn_tlv),
 SOC_DAPM_SINGLE_TLV("Sidetone ADCR Volume", LM49453_P0_STN_VOL_ADCR_REG,
-		     0, 0x3F, 0, digital_tlv),
+		     0, 0x3F, 0, stn_tlv),
 SOC_DAPM_SINGLE_TLV("Sidetone DMIC1L Volume", LM49453_P0_STN_VOL_DMIC1L_REG,
-		     0, 0x3F, 0, digital_tlv),
+		     0, 0x3F, 0, stn_tlv),
 SOC_DAPM_SINGLE_TLV("Sidetone DMIC1R Volume", LM49453_P0_STN_VOL_DMIC1R_REG,
-		     0, 0x3F, 0, digital_tlv),
+		     0, 0x3F, 0, stn_tlv),
 SOC_DAPM_SINGLE_TLV("Sidetone DMIC2L Volume", LM49453_P0_STN_VOL_DMIC2L_REG,
-		     0, 0x3F, 0, digital_tlv),
+		     0, 0x3F, 0, stn_tlv),
 SOC_DAPM_SINGLE_TLV("Sidetone DMIC2R Volume", LM49453_P0_STN_VOL_DMIC2R_REG,
-		     0, 0x3F, 0, digital_tlv),
+		     0, 0x3F, 0, stn_tlv),
 };
 
 static const struct snd_kcontrol_new lm49453_snd_controls[] = {
 	/* mic1 and mic2 supports mono only */
-	SOC_SINGLE_TLV("Mic1 Volume", LM49453_P0_ADC_LEVELL_REG, 0, 6,
-			0, digital_tlv),
-	SOC_SINGLE_TLV("Mic2 Volume", LM49453_P0_ADC_LEVELR_REG, 0, 6,
-			0, digital_tlv),
+	SOC_SINGLE_TLV("Mic1 Volume", LM49453_P0_MICL_REG, 0, 15, 0, mic_tlv),
+	SOC_SINGLE_TLV("Mic2 Volume", LM49453_P0_MICR_REG, 0, 15, 0, mic_tlv),
+
+	SOC_SINGLE_TLV("ADCL Volume", LM49453_P0_ADC_LEVELL_REG, 0, 63,
+			0, adc_dac_tlv),
+	SOC_SINGLE_TLV("ADCR Volume", LM49453_P0_ADC_LEVELR_REG, 0, 63,
+			0, adc_dac_tlv),
 
 	SOC_DOUBLE_R_TLV("DMIC1 Volume", LM49453_P0_DMIC1_LEVELL_REG,
-			  LM49453_P0_DMIC1_LEVELR_REG, 0, 6, 0, digital_tlv),
+			  LM49453_P0_DMIC1_LEVELR_REG, 0, 63, 0, adc_dac_tlv),
 	SOC_DOUBLE_R_TLV("DMIC2 Volume", LM49453_P0_DMIC2_LEVELL_REG,
-			  LM49453_P0_DMIC2_LEVELR_REG, 0, 6, 0, digital_tlv),
+			  LM49453_P0_DMIC2_LEVELR_REG, 0, 63, 0, adc_dac_tlv),
 
 	SOC_DAPM_ENUM("Mic2Mode", lm49453_mic2mode_enum),
 	SOC_DAPM_ENUM("DMIC12 SRC", lm49453_dmic12_cfg_enum),
@@ -538,16 +543,16 @@ static const struct snd_kcontrol_new lm49453_snd_controls[] = {
 					  2, 1, 0),
 
 	SOC_DOUBLE_R_TLV("DAC HP Volume", LM49453_P0_DAC_HP_LEVELL_REG,
-			  LM49453_P0_DAC_HP_LEVELR_REG, 0, 6, 0, digital_tlv),
+			  LM49453_P0_DAC_HP_LEVELR_REG, 0, 63, 0, adc_dac_tlv),
 	SOC_DOUBLE_R_TLV("DAC LO Volume", LM49453_P0_DAC_LO_LEVELL_REG,
-			  LM49453_P0_DAC_LO_LEVELR_REG, 0, 6, 0, digital_tlv),
+			  LM49453_P0_DAC_LO_LEVELR_REG, 0, 63, 0, adc_dac_tlv),
 	SOC_DOUBLE_R_TLV("DAC LS Volume", LM49453_P0_DAC_LS_LEVELL_REG,
-			  LM49453_P0_DAC_LS_LEVELR_REG, 0, 6, 0, digital_tlv),
+			  LM49453_P0_DAC_LS_LEVELR_REG, 0, 63, 0, adc_dac_tlv),
 	SOC_DOUBLE_R_TLV("DAC HA Volume", LM49453_P0_DAC_HA_LEVELL_REG,
-			  LM49453_P0_DAC_HA_LEVELR_REG, 0, 6, 0, digital_tlv),
+			  LM49453_P0_DAC_HA_LEVELR_REG, 0, 63, 0, adc_dac_tlv),
 
 	SOC_SINGLE_TLV("EP Volume", LM49453_P0_DAC_LS_LEVELL_REG,
-			0, 6, 0, digital_tlv),
+			0, 63, 0, adc_dac_tlv),
 
 	SOC_SINGLE_TLV("PORT1_1_RX_LVL Volume", LM49453_P0_PORT1_RX_LVL1_REG,
 			0, 3, 0, port_tlv),
