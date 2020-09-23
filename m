Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D2C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:30:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D758206A5
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SLa0aj6n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xzGDQbEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D758206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D033173E;
	Wed, 23 Sep 2020 15:29:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D033173E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600867830;
	bh=s1UKRodZyEnb+YAQ2pjGZ0sWjCKqDhfuZytyjIwsRpM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SLa0aj6n8yJZEB/2EuMPBOOGe6j4XygWtqoEjVveLchB2EUUeRTjW6gF6047WwfJC
	 WIzmsObq6m9jC+d7IX9iC9y2tyizk5leKPL7LnUhpdCrYvv9yBC6A9fEnWfjTMQ+Pq
	 DRRlz7tJN2M1lqBVTXgE+5rNrgms/Oocvl4VBUp8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9AEFF802F7;
	Wed, 23 Sep 2020 15:26:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AFF7F802F8; Wed, 23 Sep 2020 15:26:40 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D1C2F802E3
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 15:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D1C2F802E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xzGDQbEY"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQX2q079582;
 Wed, 23 Sep 2020 08:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1600867593;
 bh=wgvDwMPsP55ywAoaHV74OL6ILlRcs/yPg/x9ic3T9kw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xzGDQbEYZUyurQ8EFkXvdh/l9AbtaaJLtIWWXY112oMt2CRrOFzI4W5DaxHtVsgiL
 zy1dSBr3ubR2vdZPmu4F1k9JRU9pGa3U8VmHwyRP442XxylXSSgwBkjEoTtX+ePmpl
 mmT34hb194UNtBJ3AWTmh5QNhKSGUAogTFBl5mZQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQWSM054060;
 Wed, 23 Sep 2020 08:26:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 08:26:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 08:26:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQW7u007810;
 Wed, 23 Sep 2020 08:26:32 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
Subject: [PATCH 6/6] ASoC: tas2770: Remove unused variables
Date: Wed, 23 Sep 2020 08:26:00 -0500
Message-ID: <20200923132600.10652-6-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923132600.10652-1-dmurphy@ti.com>
References: <20200923132600.10652-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
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

Remove unused variables in the private struct and the code as these
variables are initially set and then there is no additional code
utilizing these variables.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 11 -----------
 sound/soc/codecs/tas2770.h |  8 ++------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c7a6f7e8200c..a91a0a31e74d 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -249,8 +249,6 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 	if (ret < 0)
 		return ret;
 
-	tas2770->channel_size = bitwidth;
-
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG5,
 					    TAS2770_TDM_CFG_REG5_VSNS_MASK |
 					    TAS2770_TDM_CFG_REG5_50_MASK,
@@ -312,7 +310,6 @@ static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 	if (ret < 0)
 		return ret;
 
-	tas2770->sampling_rate = samplerate;
 	return 0;
 }
 
@@ -400,8 +397,6 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 				int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
-	struct tas2770_priv *tas2770 =
-			snd_soc_component_get_drvdata(component);
 	int left_slot, right_slot;
 	int ret;
 
@@ -466,7 +461,6 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		return ret;
 
-	tas2770->slot_width = slot_width;
 	return 0;
 }
 
@@ -688,8 +682,6 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, tas2770);
 	dev_set_drvdata(&client->dev, tas2770);
 
-	tas2770->power_state = TAS2770_POWER_SHUTDOWN;
-
 	tas2770->regmap = devm_regmap_init_i2c(client, &tas2770_i2c_regmap);
 	if (IS_ERR(tas2770->regmap)) {
 		result = PTR_ERR(tas2770->regmap);
@@ -716,9 +708,6 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 		}
 	}
 
-	tas2770->channel_size = 0;
-	tas2770->slot_width = 0;
-
 	result = tas2770_register_codec(tas2770);
 	if (result)
 		dev_err(tas2770->dev, "Register codec failed.\n");
diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index 856a7c5cff5a..d156666bcc55 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -128,15 +128,11 @@
 #define ERROR_CLASSD_PWR    BIT(5)
 
 struct tas2770_priv {
-	struct device *dev;
-	struct regmap *regmap;
 	struct snd_soc_component *component;
-	int power_state;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *sdz_gpio;
-	int sampling_rate;
-	int channel_size;
-	int slot_width;
+	struct regmap *regmap;
+	struct device *dev;
 	int v_sense_slot;
 	int i_sense_slot;
 };
-- 
2.28.0

