Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8735FC35671
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:45:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE5B20836
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="piokK4/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE5B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F050167E;
	Mon, 24 Feb 2020 14:44:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F050167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582551899;
	bh=j+2u9hHGXzcEWcBUKeiaHPEjdcul/NaSEKeLUgd9ntY=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=piokK4/EtBcYaiW/NKaS1T/q2pY9wmzUJcLP1UFBXElkRzeiJVaZpbIdPD4n2oqBS
	 sZWg6h8O8KMjHQL9FbBX/J7fOtvxPJZYwXWSZauJQ78/vxe85ogzxxPQbPNRSE6eZb
	 S7DduqS65XyKDbjwC5FXQpWWcB/Tc9T3VnOGStwE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67434F8028D;
	Mon, 24 Feb 2020 14:42:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 144F0F8028D; Mon, 24 Feb 2020 14:42:05 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 163F2F8027D
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 14:42:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 163F2F8027D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC7C30E;
 Mon, 24 Feb 2020 05:41:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 623473F534;
 Mon, 24 Feb 2020 05:41:59 -0800 (PST)
Date: Mon, 24 Feb 2020 13:41:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Applied "ASoC: tlv320adcx140: Add DRE and AGC support" to the asoc
 tree
In-Reply-To: <20200221181358.22526-1-dmurphy@ti.com>
Message-Id: <applied-20200221181358.22526-1-dmurphy@ti.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, Mark Brown <broonie@kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: tlv320adcx140: Add DRE and AGC support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 8a329dbd4a02dc4e4ff78b006c33676f867f2726 Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Fri, 21 Feb 2020 12:13:57 -0600
Subject: [PATCH] ASoC: tlv320adcx140: Add DRE and AGC support

The TLV320ADCx140 parts support Dynamic Range Enhancer (DRE) as defined
in Section 8.3.2 of the data sheets.

The DRE achieves a complete-channel dynamic range as high as 120 dB.
At a system level, the DRE scheme enables far-field, high-fidelity recording
of audio signals in very quiet environments and low-distortion recording in
loud environments.

There are 2 enables for DRE.  The first is a global setting that enables
the DRE engine in the device and the other enable is per channel.  If
the DRE is enabled globally then either DRE or AGC can be used per each
configured channel.  If global DRE is disabled then even setting the DRE
enable bit in the channel config register will have no effect.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: https://lore.kernel.org/r/20200221181358.22526-1-dmurphy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320adcx140.c | 55 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 8182c584de9c..105e51be6fe6 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -108,6 +108,7 @@ static const struct reg_default adcx140_reg_defaults[] = {
 	{ ADCX140_DSP_CFG0, 0x01 },
 	{ ADCX140_DSP_CFG1, 0x40 },
 	{ ADCX140_DRE_CFG0, 0x7b },
+	{ ADCX140_AGC_CFG0, 0xe7 },
 	{ ADCX140_IN_CH_EN, 0xf0 },
 	{ ADCX140_ASI_OUT_CH_EN, 0x00 },
 	{ ADCX140_PWR_CFG, 0x00 },
@@ -158,6 +159,16 @@ static DECLARE_TLV_DB_SCALE(dig_vol_tlv, -10000, 50, 0);
 /* ADC gain. From 0 to 42 dB in 1 dB steps */
 static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 100, 0);
 
+/* DRE Level. From -12 dB to -66 dB in 1 dB steps */
+static DECLARE_TLV_DB_SCALE(dre_thresh_tlv, -6600, 100, 0);
+/* DRE Max Gain. From 2 dB to 26 dB in 2 dB steps */
+static DECLARE_TLV_DB_SCALE(dre_gain_tlv, 200, 200, 0);
+
+/* AGC Level. From -6 dB to -36 dB in 2 dB steps */
+static DECLARE_TLV_DB_SCALE(agc_thresh_tlv, -3600, 200, 0);
+/* AGC Max Gain. From 3 dB to 42 dB in 3 dB steps */
+static DECLARE_TLV_DB_SCALE(agc_gain_tlv, 300, 300, 0);
+
 static const char * const resistor_text[] = {
 	"2.5 kOhm", "10 kOhm", "20 kOhm"
 };
@@ -281,6 +292,18 @@ static const struct snd_kcontrol_new adcx140_dapm_ch3_en_switch =
 static const struct snd_kcontrol_new adcx140_dapm_ch4_en_switch =
 	SOC_DAPM_SINGLE("Switch", ADCX140_ASI_OUT_CH_EN, 4, 1, 0);
 
+static const struct snd_kcontrol_new adcx140_dapm_ch1_dre_en_switch =
+	SOC_DAPM_SINGLE("Switch", ADCX140_CH1_CFG0, 0, 1, 0);
+static const struct snd_kcontrol_new adcx140_dapm_ch2_dre_en_switch =
+	SOC_DAPM_SINGLE("Switch", ADCX140_CH2_CFG0, 0, 1, 0);
+static const struct snd_kcontrol_new adcx140_dapm_ch3_dre_en_switch =
+	SOC_DAPM_SINGLE("Switch", ADCX140_CH3_CFG0, 0, 1, 0);
+static const struct snd_kcontrol_new adcx140_dapm_ch4_dre_en_switch =
+	SOC_DAPM_SINGLE("Switch", ADCX140_CH4_CFG0, 0, 1, 0);
+
+static const struct snd_kcontrol_new adcx140_dapm_dre_en_switch =
+	SOC_DAPM_SINGLE("Switch", ADCX140_DSP_CFG1, 3, 1, 0);
+
 /* Output Mixer */
 static const struct snd_kcontrol_new adcx140_output_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Digital CH1 Switch", 0, 0, 0, 0),
@@ -361,6 +384,18 @@ static const struct snd_soc_dapm_widget adcx140_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("CH4_ASI_EN", SND_SOC_NOPM, 0, 0,
 			    &adcx140_dapm_ch4_en_switch),
 
+	SND_SOC_DAPM_SWITCH("DRE_ENABLE", SND_SOC_NOPM, 0, 0,
+			    &adcx140_dapm_dre_en_switch),
+
+	SND_SOC_DAPM_SWITCH("CH1_DRE_EN", SND_SOC_NOPM, 0, 0,
+			    &adcx140_dapm_ch1_dre_en_switch),
+	SND_SOC_DAPM_SWITCH("CH2_DRE_EN", SND_SOC_NOPM, 0, 0,
+			    &adcx140_dapm_ch2_dre_en_switch),
+	SND_SOC_DAPM_SWITCH("CH3_DRE_EN", SND_SOC_NOPM, 0, 0,
+			    &adcx140_dapm_ch3_dre_en_switch),
+	SND_SOC_DAPM_SWITCH("CH4_DRE_EN", SND_SOC_NOPM, 0, 0,
+			    &adcx140_dapm_ch4_dre_en_switch),
+
 	SND_SOC_DAPM_MUX("IN1 Analog Mic Resistor", SND_SOC_NOPM, 0, 0,
 			in1_resistor_controls),
 	SND_SOC_DAPM_MUX("IN2 Analog Mic Resistor", SND_SOC_NOPM, 0, 0,
@@ -383,6 +418,16 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"CH3_ASI_EN", "Switch", "CH3_ADC"},
 	{"CH4_ASI_EN", "Switch", "CH4_ADC"},
 
+	{"DRE_ENABLE", "Switch", "CH1_DRE_EN"},
+	{"DRE_ENABLE", "Switch", "CH2_DRE_EN"},
+	{"DRE_ENABLE", "Switch", "CH3_DRE_EN"},
+	{"DRE_ENABLE", "Switch", "CH4_DRE_EN"},
+
+	{"CH1_DRE_EN", "Switch", "CH1_ADC"},
+	{"CH2_DRE_EN", "Switch", "CH2_ADC"},
+	{"CH3_DRE_EN", "Switch", "CH3_ADC"},
+	{"CH4_DRE_EN", "Switch", "CH4_ADC"},
+
 	/* Mic input */
 	{"CH1_ADC", NULL, "MIC_GAIN_CTL_CH1"},
 	{"CH2_ADC", NULL, "MIC_GAIN_CTL_CH2"},
@@ -455,6 +500,16 @@ static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 	SOC_SINGLE_TLV("Analog CH4 Mic Gain Volume", ADCX140_CH1_CFG4, 2, 42, 0,
 			adc_tlv),
 
+	SOC_SINGLE_TLV("DRE Threshold", ADCX140_DRE_CFG0, 4, 9, 0,
+		       dre_thresh_tlv),
+	SOC_SINGLE_TLV("DRE Max Gain", ADCX140_DRE_CFG0, 0, 12, 0,
+		       dre_gain_tlv),
+
+	SOC_SINGLE_TLV("AGC Threshold", ADCX140_AGC_CFG0, 4, 15, 0,
+		       agc_thresh_tlv),
+	SOC_SINGLE_TLV("AGC Max Gain", ADCX140_AGC_CFG0, 0, 13, 0,
+		       agc_gain_tlv),
+
 	SOC_SINGLE_TLV("Digital CH1 Out Volume", ADCX140_CH1_CFG2,
 			0, 0xff, 0, dig_vol_tlv),
 	SOC_SINGLE_TLV("Digital CH2 Out Volume", ADCX140_CH2_CFG2,
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 66b1c3b33f1e..6d055e55909e 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -84,6 +84,7 @@
 #define ADCX140_DSP_CFG0	0x6b
 #define ADCX140_DSP_CFG1	0x6c
 #define ADCX140_DRE_CFG0	0x6d
+#define ADCX140_AGC_CFG0	0x70
 #define ADCX140_IN_CH_EN	0x73
 #define ADCX140_ASI_OUT_CH_EN	0x74
 #define ADCX140_PWR_CFG		0x75
-- 
2.20.1

