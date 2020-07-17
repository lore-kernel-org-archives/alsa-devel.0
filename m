Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6CEC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:03:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9317C20734
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tFf2LDpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9317C20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F5ED15F2;
	Fri, 17 Jul 2020 09:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F5ED15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594969424;
	bh=t+RVgycSVRZcql1dlR7Zkf1panfFk3hWd477JSo2JB0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tFf2LDpR5kWwpd61/+l7BnAsCddVnt2gqxa84NxZZLG8iXtdTl/rJm2KNVv6t6m0L
	 Rays0Lo1zjLE/Pid3uZSwTrL/rgtYlal3Aq7uil+2aggSPiUtYVJfJoPmt2Z9dg1gk
	 YOAB1HUGf5z9ERihtNA4FQ3gE43N8HguIzVFVQ0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78EF1F801D8;
	Fri, 17 Jul 2020 09:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7FFCF80217; Fri, 17 Jul 2020 09:02:51 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CF4BF8014E
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 09:02:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CF4BF8014E
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06H72dc56031978,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06H72dc56031978
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 17 Jul 2020 15:02:39 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 15:02:38 +0800
Received: from localhost.localdomain (172.22.102.1) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 17 Jul
 2020 15:02:38 +0800
From: <shumingf@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 1/2] ASoC: rt5682: optimize the power consumption
Date: Fri, 17 Jul 2020 15:02:28 +0800
Message-ID: <20200717070228.28660-1-shumingf@realtek.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, derek.fang@realtek.com,
 sathyanarayana.nujella@intel.com, Shuming Fan <shumingf@realtek.com>,
 flove@realtek.com
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

From: Shuming Fan <shumingf@realtek.com>

Some settings should set to default value after the calibration.
This patch also disables the 25MHz and 1MHz clock power when the jack unplugged.
The JD is triggered by JDH, therefore this patch removes JDL setting.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682-i2c.c |  2 +-
 sound/soc/codecs/rt5682-sdw.c |  2 +-
 sound/soc/codecs/rt5682.c     | 12 +++++++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index b24f93ff0e55..85aba311bdc8 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -232,7 +232,7 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt5682->regmap, RT5682_PWR_ANLG_1,
 		RT5682_LDO1_DVO_MASK | RT5682_HP_DRIVER_MASK,
 		RT5682_LDO1_DVO_12 | RT5682_HP_DRIVER_5X);
-	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0380);
+	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0080);
 	regmap_update_bits(rt5682->regmap, RT5682_GPIO_CTRL_1,
 		RT5682_GP4_PIN_MASK | RT5682_GP5_PIN_MASK,
 		RT5682_GP4_PIN_ADCDAT1 | RT5682_GP5_PIN_DACDAT1);
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 4cecc5ce545c..94bf6bee78e6 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -431,7 +431,7 @@ static int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 	regmap_update_bits(rt5682->regmap, RT5682_PWR_ANLG_1,
 		RT5682_LDO1_DVO_MASK | RT5682_HP_DRIVER_MASK,
 		RT5682_LDO1_DVO_12 | RT5682_HP_DRIVER_5X);
-	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0380);
+	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0080);
 	regmap_write(rt5682->regmap, RT5682_TEST_MODE_CTRL_1, 0x0000);
 	regmap_update_bits(rt5682->regmap, RT5682_BIAS_CUR_CTRL_8,
 		RT5682_HPA_CP_BIAS_CTRL_MASK, RT5682_HPA_CP_BIAS_3UA);
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index d7302f968a75..c06f5763573c 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -963,6 +963,9 @@ int rt5682_headset_detect(struct snd_soc_component *component, int jack_insert)
 			RT5682_HP_CHARGE_PUMP_1,
 			RT5682_OSW_L_MASK | RT5682_OSW_R_MASK,
 			RT5682_OSW_L_EN | RT5682_OSW_R_EN);
+		snd_soc_component_update_bits(component, RT5682_MICBIAS_2,
+			RT5682_PWR_CLK25M_MASK | RT5682_PWR_CLK1M_MASK,
+			RT5682_PWR_CLK25M_PU | RT5682_PWR_CLK1M_PU);
 	} else {
 		rt5682_enable_push_button_irq(component, false);
 		snd_soc_component_update_bits(component, RT5682_CBJ_CTRL_1,
@@ -975,6 +978,9 @@ int rt5682_headset_detect(struct snd_soc_component *component, int jack_insert)
 				RT5682_PWR_ANLG_1, RT5682_PWR_VREF2, 0);
 		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_3,
 			RT5682_PWR_CBJ, 0);
+		snd_soc_component_update_bits(component, RT5682_MICBIAS_2,
+			RT5682_PWR_CLK25M_MASK | RT5682_PWR_CLK1M_MASK,
+			RT5682_PWR_CLK25M_PD | RT5682_PWR_CLK1M_PD);
 
 		rt5682->jack_type = 0;
 	}
@@ -1022,8 +1028,7 @@ static int rt5682_set_jack_detect(struct snd_soc_component *component,
 				RT5682_POW_ANA, RT5682_POW_IRQ |
 				RT5682_POW_JDH | RT5682_POW_ANA);
 			regmap_update_bits(rt5682->regmap, RT5682_PWR_ANLG_2,
-				RT5682_PWR_JDH | RT5682_PWR_JDL,
-				RT5682_PWR_JDH | RT5682_PWR_JDL);
+				RT5682_PWR_JDH, RT5682_PWR_JDH);
 			regmap_update_bits(rt5682->regmap, RT5682_IRQ_CTRL_2,
 				RT5682_JD1_EN_MASK | RT5682_JD1_POL_MASK,
 				RT5682_JD1_EN | RT5682_JD1_POL_NOR);
@@ -3031,13 +3036,14 @@ void rt5682_calibrate(struct rt5682_priv *rt5682)
 		dev_err(rt5682->component->dev, "HP Calibration Failure\n");
 
 	/* restore settings */
-	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0x02af);
+	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0x002f);
 	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0080);
 	regmap_write(rt5682->regmap, RT5682_GLB_CLK, 0x0000);
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0000);
 	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x2000);
 	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x2005);
 	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0xc0c4);
+	regmap_write(rt5682->regmap, RT5682_CAL_REC, 0x0c0c);
 
 	mutex_unlock(&rt5682->calibrate_mutex);
 }
-- 
2.27.0

