Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C1BC433C1
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 06:45:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B824619F9
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 06:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B824619F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 168C7166A;
	Fri, 26 Mar 2021 07:44:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 168C7166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616741098;
	bh=sWk9mM0/YY3y42/OAFbo9tEX7ut2YsPJu1Qzf68gH6k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dem+nERCuvUm/O7CvmObNJSZk9kImZa/G9p2sQZHYoXC7AgDwSB17eQG94C92JG5e
	 nNLBOxaKRZyl5p0WdtQwJOyt7OdN2mU56SnnLNBa/G6rmIzhB/GVqce5iPY8KEPEzP
	 AgzmKopZY7+Q6V1A8dvaEyB146WhqQzdaoCj8JkY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1878FF804BD;
	Fri, 26 Mar 2021 07:42:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E93EF804AA; Fri, 26 Mar 2021 07:41:52 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA585F80156
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 07:41:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA585F80156
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="CKI6N9Bx"
Received: by mail-ej1-x630.google.com with SMTP id l4so6735047ejc.10
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JLx96J3P/z7SpklWGlSLOqViHHl5WXETT/eud7VOrQ4=;
 b=CKI6N9BxqTu7oc5cHbfAFTArbxQlLX407WNFxN/5fyZPddgwYnH+Lx7G6s8WXLxhnV
 /CNczXVcxGg3nppzl86S9e6pUrpRmZ9fX8fR4rxZy7HK+JKvzreZCCziTSNHQJJLBZso
 2Es5mqKlyhjOn8n9XSMcjkn/EvAidELHMetKLpURwr+s2PLg89DiRmh8UVaO/9u0/qfD
 NejsgeU4GDFCpDT0Y4yxy28zAx3WAo+Y1QH3nXCtbmxC46USX8s6l1KZd+QjRk3Zh9eI
 f4VVIyuu1LQI9714F09FCQbzSa474qAF1YTILTtc0s3qv2bHhBYI7qxUljqXSBGnC6kp
 ZMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JLx96J3P/z7SpklWGlSLOqViHHl5WXETT/eud7VOrQ4=;
 b=kFgFrf28WWxA48X2KvYDNN8yp16cZr5n2jmUyfeoTqmun3/3j9V0kbMwsFLr6L8gxd
 oomJOEAiLKmV5zy0DUzqahifNtlsZMuNNH/CcpH1dLNFuVVSbhzcQrp2DBL4Dy/e2Et6
 QJKzd6OfFJkYOfHKxRM+KFRt67WkSXccd10rZUIaHWD3PithaS6Sz2LuyWaPJPML5Ls6
 AycAUrgYvb4NdNcodjcUy7RZrg3VfqRNS9tn0YoJQwp6yWjOR2sCY5Qra4tMR1bJwZJ/
 em25teVk9Ls56w59h2cYAh1WSiyu5T+V7CBU0MUCU+GDN+oFL25QRg1qqWzlU+ckpEu5
 pcnA==
X-Gm-Message-State: AOAM532fC43uwqQgSyOGq1gGl6o5NubG0KCZUIvY4uEBJSfV3lfBX3rf
 AJdxe9hZ4CF2T3zEVLIVk4+jJg==
X-Google-Smtp-Source: ABdhPJwArwbmYX2WVpvAdXSWymAKUlKCWbcQVbY6eaqoujoHbsmPNTo3r6OZ7jXq/ljDTeTdhvlCLg==
X-Received: by 2002:a17:906:a44f:: with SMTP id
 cb15mr13350392ejb.420.1616740885771; 
 Thu, 25 Mar 2021 23:41:25 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id ci22sm125325ejc.54.2021.03.25.23.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 23:41:25 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH v5 9/9] soundwire: qcom: wait for enumeration to be complete
 in probe
Date: Fri, 26 Mar 2021 06:39:44 +0000
Message-Id: <20210326063944.31683-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
References: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index c6c923329b15..706d44200a36 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -123,6 +123,7 @@ struct qcom_swrm_ctrl {
 	struct regmap *regmap;
 	void __iomem *mmio;
 	struct completion broadcast;
+	struct completion enumeration;
 	struct work_struct slave_work;
 	/* Port alloc/free lock */
 	struct mutex port_lock;
@@ -417,6 +418,7 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
 		}
 	}
 
+	complete(&ctrl->enumeration);
 	return 0;
 }
 
@@ -1155,6 +1157,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, ctrl);
 	mutex_init(&ctrl->port_lock);
 	init_completion(&ctrl->broadcast);
+	init_completion(&ctrl->enumeration);
 
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
@@ -1201,6 +1204,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	}
 
 	qcom_swrm_init(ctrl);
+	wait_for_completion_timeout(&ctrl->enumeration,
+				    msecs_to_jiffies(TIMEOUT_MS));
 	ret = qcom_swrm_register_dais(ctrl);
 	if (ret)
 		goto err_master_add;
-- 
2.21.0

