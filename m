Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDBEC43463
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:42:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B15A207D3
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iSdVMbdy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=axis.com header.i=@axis.com header.b="m+b7uQrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B15A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B55016E9;
	Fri, 18 Sep 2020 13:41:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B55016E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600429341;
	bh=epEkUMlrR/rPoINSjSkduvQq8Pufu608nljokz0EXvg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSdVMbdyg1FRGf74mySbhCLpe/xe/s9V8twLokfGKN6HbGQZS6XoEecNZz4AIxIKx
	 SJGezlbw/56tzB+LTNeopXgT6KcAw6Vt0XCDx0NqFRh2X/m/msrbe6uON5Pe1hTN5W
	 kerj7FSTkMJf4zI8jNQOR7B+T+ei8rgkVbO13+0A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB755F8015C;
	Fri, 18 Sep 2020 13:40:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7AF05F8012D; Fri, 18 Sep 2020 13:40:37 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A562F8012D
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 13:40:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A562F8012D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="m+b7uQrA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=2756; q=dns/txt; s=axis-central1;
 t=1600429232; x=1631965232;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ew//nIO5dKXvaZr2/EGqobhhCsQ55JTGE+weINnJVVs=;
 b=m+b7uQrAGCRyYAXI0QInatFVm23DnQ5FEerqFr74ZBNiqpuIkZXNIcQ3
 dPBezFWPkQw4dt4N+G3LvI8ZVEVRcsGSkfiJLZhZWYoN2DITlO0o7XUcB
 UML06SiUnBJXsP2j6QjRbQ/rPuWwIlYQm8lpex9SpvMKEa+rubco2fT3y
 IgNQxv3k+tADcAwSNGgGBnBpbkJzCcoo0mx3t8SD+QuIVtX0Oxz849lq9
 AfVdZ/SKYl4BBr074uNUY9jcwpx/AgHEgz3sCaBJZvu1FdoJ61MGU9uB3
 4VishjxzwvnbegzTpbdatMpUXl6UC1Npb+Qv5xDBXj99UMtW9QTvhdtCx Q==;
IronPort-SDR: DKC8VO5L1SMacHypEV5JHzAI747iaewCGeQgHSpCHCveVnZOS/TzSoR4GEWOZVWPkTKXVU1aSm
 Y4uwYAocMzwzDhLcUZOBifmWda1/ttxrtZDLB2Clm8PzVztFAPeY4ahX4EqOaWPUrqUapk+U0q
 Mv4zE7BZF6lxLd3SbREJvC8r0KzysFZfKSwM9RyU+GU615LnrArMje3VZQ7UWU6jMo2JE0l/WO
 EfWoE46wX/B7VW5LIMCE1ukk0o8fohIW82hYgBQLkfW9aQRmNjaC+e0aN3dM4bEbx+QjnWsVDt
 jl4=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; d="scan'208";a="12637620"
From: Camel Guo <camel.guo@axis.com>
To: <robh+dt@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <tiwai@suse.com>, <dmurphy@ti.com>
Subject: [PATCH v5 2/2] ASoC: tlv320adcx140: Add support for configuring GPIO
 pin
Date: Fri, 18 Sep 2020 13:40:25 +0200
Message-ID: <20200918114025.18205-2-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918114025.18205-1-camel.guo@axis.com>
References: <20200918114025.18205-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@axis.com,
 linux-kernel@vger.kernel.org, Camel Guo <camelg@axis.com>
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

From: Camel Guo <camelg@axis.com>

Add support to configure the GPIO pin to the specific configuration.
The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
drive can be configured with various configuration.

Signed-off-by: Camel Guo <camelg@axis.com>
---
 v4:
  - Rebase and fix merge conflict
  - Add Acked-by from Dan
 v3:
  - Add ADCX140_NUM_GPIO_CFGS avoiding using magic number
  - Remove unneeded check on ret in adcx140_configure_gpio

 sound/soc/codecs/tlv320adcx140.c | 40 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h |  5 ++++
 2 files changed, 45 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 28dbd7d5e149..53a80246aee1 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -861,6 +861,42 @@ static int adcx140_configure_gpo(struct adcx140_priv *adcx140)
 
 }
 
+static int adcx140_configure_gpio(struct adcx140_priv *adcx140)
+{
+	int gpio_count = 0;
+	u32 gpio_outputs[ADCX140_NUM_GPIO_CFGS];
+	u32 gpio_output_val = 0;
+	int ret;
+
+	gpio_count = device_property_count_u32(adcx140->dev,
+			"ti,gpio-config");
+	if (gpio_count == 0)
+		return 0;
+
+	if (gpio_count != ADCX140_NUM_GPIO_CFGS)
+		return -EINVAL;
+
+	ret = device_property_read_u32_array(adcx140->dev, "ti,gpio-config",
+			gpio_outputs, gpio_count);
+	if (ret)
+		return ret;
+
+	if (gpio_outputs[0] > ADCX140_GPIO_CFG_MAX) {
+		dev_err(adcx140->dev, "GPIO config out of range\n");
+		return -EINVAL;
+	}
+
+	if (gpio_outputs[1] > ADCX140_GPIO_DRV_MAX) {
+		dev_err(adcx140->dev, "GPIO drive out of range\n");
+		return -EINVAL;
+	}
+
+	gpio_output_val = gpio_outputs[0] << ADCX140_GPIO_SHIFT
+		| gpio_outputs[1];
+
+	return regmap_write(adcx140->regmap, ADCX140_GPIO_CFG0, gpio_output_val);
+}
+
 static int adcx140_codec_probe(struct snd_soc_component *component)
 {
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
@@ -958,6 +994,10 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	ret = adcx140_configure_gpio(adcx140);
+	if (ret)
+		return ret;
+
 	ret = adcx140_configure_gpo(adcx140);
 	if (ret)
 		goto out;
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 107bd7927d9c..d7d4e3a88b5c 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -148,4 +148,9 @@
 
 #define ADCX140_TX_FILL    BIT(0)
 
+#define ADCX140_NUM_GPIO_CFGS		2
+#define ADCX140_GPIO_SHIFT		4
+#define ADCX140_GPIO_CFG_MAX		15
+#define ADCX140_GPIO_DRV_MAX		5
+
 #endif /* _TLV320ADCX140_ */
-- 
2.20.1

