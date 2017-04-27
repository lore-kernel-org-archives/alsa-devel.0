From: John Hsu <supercraig0719@gmail.com>
Subject: [PATCH] ASoC: nau8824: rename controls to match DAPM
	controls
Date: Thu, 27 Apr 2017 11:15:37 +0800
Message-ID: <1493262937-22813-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 6074526690B
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 05:16:24 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id g23so5208160pfj.1
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 20:16:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, John Hsu <supercraig0719@gmail.com>
List-Id: alsa-devel@alsa-project.org

Rename the name of kcontrols to match up the DAPM
widget controls.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
---
 sound/soc/codecs/nau8824.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 18552ed..cd358be0 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -362,27 +362,27 @@ static const struct snd_kcontrol_new nau8824_snd_controls[] = {
 	SOC_ENUM("ADC Decimation Rate", nau8824_adc_decimation_enum),
 	SOC_ENUM("DAC Oversampling Rate", nau8824_dac_oversampl_enum),
 
-	SOC_SINGLE_TLV("Speaker Right from DACR Volume",
+	SOC_SINGLE_TLV("Speaker Right DACR Volume",
 		NAU8824_REG_CLASSD_GAIN_1, 8, 0x1f, 0, spk_vol_tlv),
-	SOC_SINGLE_TLV("Speaker Left from DACL Volume",
+	SOC_SINGLE_TLV("Speaker Left DACL Volume",
 		NAU8824_REG_CLASSD_GAIN_2, 0, 0x1f, 0, spk_vol_tlv),
-	SOC_SINGLE_TLV("Speaker Left from DACR Volume",
+	SOC_SINGLE_TLV("Speaker Left DACR Volume",
 		NAU8824_REG_CLASSD_GAIN_1, 0, 0x1f, 0, spk_vol_tlv),
-	SOC_SINGLE_TLV("Speaker Right from DACL Volume",
+	SOC_SINGLE_TLV("Speaker Right DACL Volume",
 		NAU8824_REG_CLASSD_GAIN_2, 8, 0x1f, 0, spk_vol_tlv),
 
-	SOC_SINGLE_TLV("Headphone Right from DACR Volume",
+	SOC_SINGLE_TLV("Headphone Right DACR Volume",
 		NAU8824_REG_ATT_PORT0, 8, 0x1f, 0, hp_vol_tlv),
-	SOC_SINGLE_TLV("Headphone Left from DACL Volume",
+	SOC_SINGLE_TLV("Headphone Left DACL Volume",
 		NAU8824_REG_ATT_PORT0, 0, 0x1f, 0, hp_vol_tlv),
-	SOC_SINGLE_TLV("Headphone Right from DACL Volume",
+	SOC_SINGLE_TLV("Headphone Right DACL Volume",
 		NAU8824_REG_ATT_PORT1, 8, 0x1f, 0, hp_vol_tlv),
-	SOC_SINGLE_TLV("Headphone Left from DACR Volume",
+	SOC_SINGLE_TLV("Headphone Left DACR Volume",
 		NAU8824_REG_ATT_PORT1, 0, 0x1f, 0, hp_vol_tlv),
 
-	SOC_SINGLE_TLV("Mic1 Volume", NAU8824_REG_FEPGA_II,
+	SOC_SINGLE_TLV("MIC1 Volume", NAU8824_REG_FEPGA_II,
 		NAU8824_FEPGA_GAINL_SFT, 0x12, 0, mic_vol_tlv),
-	SOC_SINGLE_TLV("Mic2 Volume", NAU8824_REG_FEPGA_II,
+	SOC_SINGLE_TLV("MIC2 Volume", NAU8824_REG_FEPGA_II,
 		NAU8824_FEPGA_GAINR_SFT, 0x12, 0, mic_vol_tlv),
 
 	SOC_SINGLE_TLV("DMIC1 Volume", NAU8824_REG_ADC_CH0_DGAIN_CTRL,
-- 
2.6.4
