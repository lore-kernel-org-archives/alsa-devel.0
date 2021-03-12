Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE51C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 12:04:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C02064FCE
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 12:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C02064FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B845F1712;
	Fri, 12 Mar 2021 13:03:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B845F1712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615550687;
	bh=Wxn3xJzLpNfwNH20YdDt3wSi65HqNv3PH4P3im84C/A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZFGmDx7jDheRW7APM5KKfIlkuAKTGuFoYFANr2w9tRUnAm+rFj+pRHMXRn/7qlxxz
	 ZL8sl9BWU60Z0SSm55N0sVOVUlgJ0ecKrO3UYeZwO5m9fOZbPF9nJoFqEM5JHpTnts
	 JamDuex+dZy3DAmqATOx+fqrKFLOpdf3qAxQNp68=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A6A6F804E0;
	Fri, 12 Mar 2021 13:00:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0247F80217; Fri, 12 Mar 2021 13:00:54 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78FA6F8032D
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 13:00:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78FA6F8032D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="yXkq2KLA"
Received: by mail-wr1-x42d.google.com with SMTP id x16so1631392wrn.4
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 04:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yEstJ8fSJSpfc6e8Q0vMn1tWonCjZtnzF+5445SF5Qs=;
 b=yXkq2KLAbC7KzixcJj2Z96/TbUF5rxrVRAuXgmyNmPkUsbt00yQDUAtePfvJpDGkBq
 Q9AdySyXNnOdzKSxPbO/ssZolk7JeniO5InutNFtUM0ERNxCG3ID43kJuDgkbMgNovEY
 mZGbxSn+fGUz3jnIQC08dXvh3eoNP8Z6850z4rizDVZe6I1LBkISACd5EbB0ag9zxyhN
 dWGf8DDFmDsEr94j30r1q5+PwHX7k1qnCnWBDhSMQV/EK7Tl8wcw1lvW/KarPTytmy1e
 kfZUWS9r00Ewl1SYyRqwDW+oxCD3VvLvvKc+eeezMk0NxU2zuKNEVYgeCcowcJVFaCzK
 LEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yEstJ8fSJSpfc6e8Q0vMn1tWonCjZtnzF+5445SF5Qs=;
 b=S4kPps1XePGNX5JwIhYwufUyroFj4TA9vCN0qWYYs3eEcqcZLx1YJ0WuL0bydXKGXQ
 PfW0WFkPXmgLISBu2jDNWtJSv1q0ruZC4ZnsJwGr0b9BLcn8MjtiTm/+jA6X9LoOiOXE
 +euM5Clp3vfjHBOuka7QGp6cZ1VrBS4n4en8gG37jCUTEUeTJ0u3rJ+N/H0zPbHjzVjs
 eJpHU8RvDnz7mt3g7bS5UAsnKsnX9BJR1QfbnMWvB3nl+lv43CU12Vgb+VcQkGbxkD6y
 tfIhzXMQFr5xIaPmnjZFBvtZzQ9I6OzldjHXxNGJMTQIV+gD+8fRrA3RrtRigUcGrPEk
 uRmA==
X-Gm-Message-State: AOAM531HcM/mLXIs01mgi3HsbrXffADCnMKkQBA8Uqm3XZ+SNGRyGrvB
 CyXAuf3RJiO5eGvt3QWJN0V2Bw==
X-Google-Smtp-Source: ABdhPJyEuMGLdAxtqH4eoe5V0wW+agxN2/wXtSMXWHisBysHzetmWiXSxFO1vt99WenOLTrCyQ4FaA==
X-Received: by 2002:a5d:4564:: with SMTP id a4mr13642592wrc.3.1615550432808;
 Fri, 12 Mar 2021 04:00:32 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id h25sm2268315wml.32.2021.03.12.04.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 04:00:32 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH v4 9/9] soundwire: qcom: wait for enumeration to be complete
 in probe
Date: Fri, 12 Mar 2021 12:00:09 +0000
Message-Id: <20210312120009.22386-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
References: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
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

