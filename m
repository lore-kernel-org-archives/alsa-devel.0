Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45493C43461
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:08:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7173B20756
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oOZVIrPQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DZmw5M9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7173B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D926D1663;
	Tue, 15 Sep 2020 21:07:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D926D1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600196917;
	bh=oS4D//hyf71ysZQMO1QisiVTl1TUMq3VTNlpWnOXZKQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oOZVIrPQ6fWfQhdsJdvwEDpEm0r9dgeFQjLMlWHdKkOvgX48Scu1N6n031j2VnfWJ
	 VOUUafAVK0hjUwuzqbawU8uEZJ2aRJDdinA+8zFJXytams2JdIKJPFGM3wDWWXXXot
	 YGNsfzJRsRrencJZAVWej/t1F0uDpiBwYMYaq7LA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6161F802C3;
	Tue, 15 Sep 2020 21:06:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38BCFF80146; Tue, 15 Sep 2020 21:06:25 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EADBF80146
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 21:06:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EADBF80146
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DZmw5M9R"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6COP013395;
 Tue, 15 Sep 2020 14:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1600196772;
 bh=EAXQSylEvOtZPY7n6DOnauI/m1zyOC+7tLJj6RWm6wE=;
 h=From:To:CC:Subject:Date;
 b=DZmw5M9R5+Yt4l3T8wjwVFBtFLlLpA/o/5ILZWGQY9kKgeOtiOOXdOCeaHR7bQdvW
 JujFy96Q0B9SBmpHOTyMH1TpYW6W8fxproNal+NKFkBFpRxg1kGlbKmS/nW+99cZJU
 Fw36sZ23yGRxrghMWgKFDbtoMgBrx4i8xjRoFpuo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FJ6CoV073700
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Sep 2020 14:06:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 14:06:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 14:06:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6Bkp085621;
 Tue, 15 Sep 2020 14:06:11 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
Subject: [PATCH 1/6] ASoC: tlv320adcx140: Idle the device while writing
 registers
Date: Tue, 15 Sep 2020 14:06:01 -0500
Message-ID: <20200915190606.1744-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>, camel.guo@axis.com
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

It was observed that if the device was active and register writes were
performed there were some unwanted behaviors particularly when writing
the word length and some filter options. So when writing to the device
the device should be placed in sleep mode and then exit sleep mode once
the register update is complete.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 43 ++++++++++++++++++++++++--------
 sound/soc/codecs/tlv320adcx140.h |  2 ++
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 8efe20605f9b..3909c1cf52be 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -30,7 +30,7 @@ struct adcx140_priv {
 	struct regmap *regmap;
 	struct device *dev;
 
-	int micbias_vg;
+	bool micbias_vg;
 
 	unsigned int dai_fmt;
 	unsigned int tdm_delay;
@@ -614,11 +614,26 @@ static int adcx140_reset(struct adcx140_priv *adcx140)
 	return ret;
 }
 
+static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
+{
+	int pwr_ctrl = 0;
+
+	if (power_state)
+		pwr_ctrl = ADCX140_PWR_CFG_ADC_PDZ | ADCX140_PWR_CFG_PLL_PDZ;
+
+	if (adcx140->micbias_vg && power_state)
+		pwr_ctrl |= ADCX140_PWR_CFG_BIAS_PDZ;
+
+	regmap_update_bits(adcx140->regmap, ADCX140_PWR_CFG,
+			   ADCX140_PWR_CTRL_MSK, pwr_ctrl);
+}
+
 static int adcx140_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
 	u8 data = 0;
 
 	switch (params_width(params)) {
@@ -640,9 +655,13 @@ static int adcx140_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	adcx140_pwr_ctrl(adcx140, false);
+
 	snd_soc_component_update_bits(component, ADCX140_ASI_CFG0,
 			    ADCX140_WORD_LEN_MSK, data);
 
+	adcx140_pwr_ctrl(adcx140, true);
+
 	return 0;
 }
 
@@ -709,6 +728,8 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 	adcx140->dai_fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
+	adcx140_pwr_ctrl(adcx140, false);
+
 	snd_soc_component_update_bits(component, ADCX140_ASI_CFG0,
 				      ADCX140_FSYNCINV_BIT |
 				      ADCX140_BCLKINV_BIT |
@@ -721,6 +742,7 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	snd_soc_component_update_bits(component, ADCX140_ASI_CFG1,
 				      ADCX140_TX_OFFSET_MASK, offset);
 
+	adcx140_pwr_ctrl(adcx140, true);
 
 	return 0;
 }
@@ -818,12 +840,11 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 
 	ret = device_property_read_u32(adcx140->dev, "ti,mic-bias-source",
 				      &bias_source);
-	if (ret)
+	if (ret || bias_source > ADCX140_MIC_BIAS_VAL_AVDD) {
 		bias_source = ADCX140_MIC_BIAS_VAL_VREF;
-
-	if (bias_source > ADCX140_MIC_BIAS_VAL_AVDD) {
-		dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
-		return -EINVAL;
+		adcx140->micbias_vg = false;
+	} else {
+		adcx140->micbias_vg = true;
 	}
 
 	ret = device_property_read_u32(adcx140->dev, "ti,vref-source",
@@ -906,6 +927,8 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 				ADCX140_MIC_BIAS_VREF_MSK, bias_cfg);
 	if (ret)
 		dev_err(adcx140->dev, "setting MIC bias failed %d\n", ret);
+
+	adcx140_pwr_ctrl(adcx140, true);
 out:
 	return ret;
 }
@@ -914,21 +937,19 @@ static int adcx140_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
-	int pwr_cfg = 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
-		pwr_cfg = ADCX140_PWR_CFG_BIAS_PDZ | ADCX140_PWR_CFG_PLL_PDZ |
-			  ADCX140_PWR_CFG_ADC_PDZ;
+		adcx140_pwr_ctrl(adcx140, true);
 		break;
 	case SND_SOC_BIAS_OFF:
-		pwr_cfg = 0x0;
+		adcx140_pwr_ctrl(adcx140, false);
 		break;
 	}
 
-	return regmap_write(adcx140->regmap, ADCX140_PWR_CFG, pwr_cfg);
+	return 0;
 }
 
 static const struct snd_soc_component_driver soc_codec_driver_adcx140 = {
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index eedbc1d7221f..94c6d1fd2977 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -123,6 +123,7 @@
 #define ADCX140_MIC_BIAS_VREF_1375V	2
 #define ADCX140_MIC_BIAS_VREF_MSK GENMASK(1, 0)
 
+#define ADCX140_PWR_CTRL_MSK    GENMASK(7, 5)
 #define ADCX140_PWR_CFG_BIAS_PDZ	BIT(7)
 #define ADCX140_PWR_CFG_ADC_PDZ		BIT(6)
 #define ADCX140_PWR_CFG_PLL_PDZ		BIT(5)
@@ -145,4 +146,5 @@
 #define ADCX140_GPO_CFG_MAX		4
 #define ADCX140_GPO_DRV_MAX		5
 
+
 #endif /* _TLV320ADCX140_ */
-- 
2.28.0

