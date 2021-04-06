Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38944C43460
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 10:52:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3C6613CB
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 10:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3C6613CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aksignal.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB3C31671;
	Tue,  6 Apr 2021 12:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB3C31671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617706335;
	bh=k4hGVIOOcQuqovKyW2uZ1QDcFpEJMiAgY/IO4UfDtNo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VV0mmY8KI7Ra/TbbtY6QUyQBqIFuMjBg22ihJPkki5q13SpJbor21owXLjHJcfV0p
	 ZE+H0OIMm4XyQAjaOE7T1Kf3kFlcJpSKGQPboRwhB79A3bRGky+oorA46n+m22XH9V
	 LiNZEP7/mVKHJfNBpWfQajun+o4thEajjjB7PmyQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28F1CF80246;
	Tue,  6 Apr 2021 12:50:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C3A4F80249; Tue,  6 Apr 2021 12:50:35 +0200 (CEST)
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13F2BF80249
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 12:50:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13F2BF80249
Received: from localhost (localhost [127.0.0.1])
 by router.aksignal.cz (Postfix) with ESMTP id AC52F3FA38;
 Tue,  6 Apr 2021 12:50:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
 by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id lfPPcqAUAOvi; Tue,  6 Apr 2021 12:50:23 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
 (Authenticated sender: jiri.prchal@aksignal.cz)
 by router.aksignal.cz (Postfix) with ESMTPSA id 0BD1C3FA37;
 Tue,  6 Apr 2021 12:50:23 +0200 (CEST)
From: Jiri Prchal <jiri.prchal@aksignal.cz>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/5] SOC Codecs: TLV320AIC3X add SPI: I2C code
Date: Tue,  6 Apr 2021 12:50:16 +0200
Message-Id: <20210406105018.59463-4-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406105018.59463-1-jiri.prchal@aksignal.cz>
References: <20210406105018.59463-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Jiri Prchal <jiri.prchal@aksignal.cz>, Liam Girdwood <lgirdwood@gmail.com>
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

Things related to I2C in separate file.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 sound/soc/codecs/tlv320aic3x-i2c.c | 72 ++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 sound/soc/codecs/tlv320aic3x-i2c.c

diff --git a/sound/soc/codecs/tlv320aic3x-i2c.c b/sound/soc/codecs/tlv320aic3x-i2c.c
new file mode 100644
index 000000000000..f77c76d25112
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic3x-i2c.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ALSA SoC TLV320AIC3x codec driver I2C interface
+ *
+ * Author:      Arun KS, <arunks@mistralsolutions.com>
+ * Copyright:   (C) 2008 Mistral Solutions Pvt Ltd.,
+ *
+ * Based on sound/soc/codecs/wm8731.c by Richard Purdie
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+
+#include "tlv320aic3x.h"
+
+static int aic3x_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	struct regmap_config config;
+
+	config = aic3x_regmap_config;
+	config.reg_bits = 8;
+	config.val_bits = 8;
+
+	regmap = devm_regmap_init_i2c(i2c, &config);
+	return aic3x_probe(&i2c->dev, regmap, id->driver_data);
+}
+
+static int aic3x_i2c_remove(struct i2c_client *i2c)
+{
+	return aic3x_remove(&i2c->dev);
+}
+
+static const struct i2c_device_id aic3x_i2c_id[] = {
+	{ "tlv320aic3x", AIC3X_MODEL_3X },
+	{ "tlv320aic33", AIC3X_MODEL_33 },
+	{ "tlv320aic3007", AIC3X_MODEL_3007 },
+	{ "tlv320aic3104", AIC3X_MODEL_3104 },
+	{ "tlv320aic3106", AIC3X_MODEL_3106 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
+
+static const struct of_device_id aic3x_of_id[] = {
+	{ .compatible = "ti,tlv320aic3x", },
+	{ .compatible = "ti,tlv320aic33" },
+	{ .compatible = "ti,tlv320aic3007" },
+	{ .compatible = "ti,tlv320aic3104" },
+	{ .compatible = "ti,tlv320aic3106" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, aic3x_of_id);
+
+static struct i2c_driver aic3x_i2c_driver = {
+	.driver = {
+		.name = "tlv320aic3x",
+		.of_match_table = aic3x_of_id),
+	},
+	.probe = aic3x_i2c_probe,
+	.remove = aic3x_i2c_remove,
+	.id_table = aic3x_i2c_id,
+};
+
+module_i2c_driver(aic3x_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC TLV320AIC3x codec driver I2C");
+MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

