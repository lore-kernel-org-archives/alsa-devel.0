Return-Path: <SRS0=nXTK=HZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14370C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 18:22:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4457664E6B
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 18:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4457664E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDC87169D;
	Tue, 23 Feb 2021 19:21:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDC87169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614104563;
	bh=WlBdW8OkU8Utbs2mLu/IxW8JRhVqazuXQqNYXkntaGY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bKwWmQJQ3/RZam+/cBSmGUqeUfhus/FzMBSdbfkILIEcZmhXJjBObTdlhNdUJ3zLy
	 X1fsJePEwn1Pn1V7YHvbHtSqU38FEmyeDEPu+dXgqrUiLmULMzny9SrZ50cvZ6HpCm
	 2WurOMkL18OFkk5C4GYJQP3id8/isjiSdWm4Iul0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 269BDF8032C;
	Tue, 23 Feb 2021 19:20:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAB72F802D2; Tue, 23 Feb 2021 19:20:15 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8471F802D2
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 19:20:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8471F802D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="mywD4Tca"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1614104413; x=1645640413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WlBdW8OkU8Utbs2mLu/IxW8JRhVqazuXQqNYXkntaGY=;
 b=mywD4TcanpMhzqrf22/iV9u3O0SJHGF8Ww/ztJaGI25MJXYzkuERxnj5
 sbyfpD+i/Pa7mD/Bqpw8TZkJ9uzRK59pLwjEGTF8MsSDB7Zt3L+CXkIBP
 NEuqE7IcuVCjzEWlgxPgX0ABwavAbhQ722WSsntBNDcjonZrgYUienfEK
 6efvqRDpKzXcPqXTImI/9RmJs3TFZRxzZ9BpbT6SgRi1Ank6SvBn5s8Gk
 mOMBs8zh9zM9C/IwBrBHGpj94owymBaz9KsRLgbKTvC3vbPaw+EcC9pow
 ap9k8ja0jdOBlb1Wymss4qNp4vmjsRTCs0hU3R3Y539mtADQKUwlhblgw w==;
IronPort-SDR: 8O1ZYUc+JQjPeK3aOdhFfc75OIfeAA5i5qFIfe/ODKq0Wvgn0q9tFlHIXjPlS7VrRlQS4fV5fx
 yFIVpsUlduDl7wyKyqiQgEh/J3sutE0Qh7c87LDtLeEJGTZtfhcCf9OnWH/NeWmSpib8q5rBhk
 b6a/P02BVengUaDdavee9drTrWabK6Svo4gfy/H1HV0ry9/azsI8up7UuTAs6HrlSTsBtZpO6j
 MOkuofglmUZov3e4DIj+Odzng0oDDf4pREroQ0rnKvUFMjo2s71Vx0wX1sKLuyE0aPAoSvnlkO
 1zA=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; d="scan'208";a="107691077"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 23 Feb 2021 11:20:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:20:11 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:20:08 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/7] ASoC: mchp-i2s-mcc: Add multi-channel support for I2S and
 LEFT_J formats
Date: Tue, 23 Feb 2021 20:19:26 +0200
Message-ID: <20210223181929.444640-5-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
 nicolas.ferre@microchip.com, robh+dt@kernel.org, tiwai@suse.com,
 ludovic.desroches@microchip.com, broonie@kernel.org, Codrin
 Ciubotariu <codrin.ciubotariu@microchip.com>
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

The latest I2S-MCC available in SAMA7G5 supports multi-channel for I2S and
Left-Justified formats. For this, the new version uses 8 (4 * 2) input and
output pins, with each pin being responsible for 2 channels. This sums up
to a total of 8 channels for synchronous capture and playback.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 0ee01383e307..52d3f43148dc 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
 #include <linux/lcm.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -225,6 +226,10 @@ static const struct regmap_config mchp_i2s_mcc_regmap_config = {
 	.max_register = MCHP_I2SMCC_VERSION,
 };
 
+struct mchp_i2s_mcc_soc_data {
+	unsigned int	data_pin_pair_num;
+};
+
 struct mchp_i2s_mcc_dev {
 	struct wait_queue_head			wq_txrdy;
 	struct wait_queue_head			wq_rxrdy;
@@ -232,6 +237,7 @@ struct mchp_i2s_mcc_dev {
 	struct regmap				*regmap;
 	struct clk				*pclk;
 	struct clk				*gclk;
+	const struct mchp_i2s_mcc_soc_data	*soc;
 	struct snd_dmaengine_dai_dma_data	playback;
 	struct snd_dmaengine_dai_dma_data	capture;
 	unsigned int				fmt;
@@ -549,6 +555,17 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (dev->fmt & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
+		/* for I2S and LEFT_J one pin is needed for every 2 channels */
+		if (channels > dev->soc->data_pin_pair_num * 2) {
+			dev_err(dev->dev,
+				"unsupported number of audio channels: %d\n",
+				channels);
+			return -EINVAL;
+		}
+
+		/* enable for interleaved format */
+		mrb |= MCHP_I2SMCC_MRB_CRAMODE_REGULAR;
+
 		switch (channels) {
 		case 1:
 			if (is_playback)
@@ -558,6 +575,12 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 			break;
 		case 2:
 			break;
+		case 4:
+			mra |= MCHP_I2SMCC_MRA_WIRECFG_I2S_2_TDM_1;
+			break;
+		case 8:
+			mra |= MCHP_I2SMCC_MRA_WIRECFG_I2S_4_TDM_2;
+			break;
 		default:
 			dev_err(dev->dev, "unsupported number of audio channels\n");
 			return -EINVAL;
@@ -869,12 +892,22 @@ static const struct snd_soc_component_driver mchp_i2s_mcc_component = {
 };
 
 #ifdef CONFIG_OF
+static struct mchp_i2s_mcc_soc_data mchp_i2s_mcc_sam9x60 = {
+	.data_pin_pair_num = 1,
+};
+
+static struct mchp_i2s_mcc_soc_data mchp_i2s_mcc_sama7g5 = {
+	.data_pin_pair_num = 4,
+};
+
 static const struct of_device_id mchp_i2s_mcc_dt_ids[] = {
 	{
 		.compatible = "microchip,sam9x60-i2smcc",
+		.data = &mchp_i2s_mcc_sam9x60,
 	},
 	{
 		.compatible = "microchip,sama7g5-i2smcc",
+		.data = &mchp_i2s_mcc_sama7g5,
 	},
 	{ /* sentinel */ }
 };
@@ -932,6 +965,11 @@ static int mchp_i2s_mcc_probe(struct platform_device *pdev)
 		dev->gclk = NULL;
 	}
 
+	dev->soc = of_device_get_match_data(&pdev->dev);
+	if (!dev->soc) {
+		dev_err(&pdev->dev, "failed to get soc data\n");
+		return -ENODEV;
+	}
 	dev->dev = &pdev->dev;
 	dev->regmap = regmap;
 	platform_set_drvdata(pdev, dev);
-- 
2.27.0

