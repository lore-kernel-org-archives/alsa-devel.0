Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD7CC352BE
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:38:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2605B208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e+1RqCd6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSz5h/7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2605B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78E901672;
	Fri, 17 Apr 2020 11:37:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78E901672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587116302;
	bh=9QUu4I4QXKnjgKyPl3WJjiPp1jfaBSx5JRxOipr0d5E=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e+1RqCd6DPfdQlJAEv0jYU70B8I04Ke1G8l2or/T7NiBLpM5ZT5Sm1ysC5DbBkqoV
	 xRHwk68kpj0igK6nPIqtCG8UqEGfDeAojyUvhJfbPmfdm2wye6WngxQhOINRsNJ2bB
	 1G74lk4SDCbENIOOL/lmYBBi+Cn7WGkpi1sSAMWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 893F6F80291;
	Fri, 17 Apr 2020 11:36:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B50FF80292; Fri, 17 Apr 2020 11:36:36 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78908F80290
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 11:36:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78908F80290
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="kSz5h/7b"
Received: by mail-wr1-x444.google.com with SMTP id u13so2293509wrp.3
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nr4vKvs2qrJShxFn1O+ztxZUZEQFA+yVojQ7rh1kCD0=;
 b=kSz5h/7bGrJkc/P34ntw8nXpZOrDvE3F342U/XFDDNM66DRjfnDbDvE1g3Xowe2Hyo
 0O3XJZHuZ0WPvz7I2nWs9vEste+IZSGrcbecg+Ngk5H2nY63ld/TuVvhujmGJ0CJIiXc
 CI0D/rzFPSEBMEuaX0ih2c4fpyuEQchuqwFN/58oaQHIRX1VNuwKNt5khMWCXhKjuEVS
 xPscU1/UGdx+r5816XnjgBxCMDaqEr2q4isXF9pkx0OqUOovm1aMlkMBFwxA8pqX561X
 3tI4ecUg/+lDdjbVBHo2urtXRQpJJzn2yRlqzVMJ1cWhD/AwoJF7/MMWBPOAO/7w/g2l
 4fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nr4vKvs2qrJShxFn1O+ztxZUZEQFA+yVojQ7rh1kCD0=;
 b=aQHjV2QkVMUtpR1aeyj3xxEihkE7YebOj0BEYwUZQxOnLcSkHIvmBdV+/Y5xalIts8
 EK4EDKe4Y0kAnbDv7OsEIQnWOJ79vAAFQsYX3dkuRTYefR8FENbnhJajfLq5i4GdHEMe
 FdbrQu97msPZPLoim3NPES69Vg+jn7Xrc7tEcMt3dlLp3Q8rVvY9tAWmSM1bQCfPhqZA
 aXr0mmvW3v5gRzrjBtvtzEiZNDNzXcO6okR1bzgMhrA9eqNYzJCDYK+HK8fb82qUelGp
 lWbOjOlFVeWFEs6wI1EM+PQdXgPCbi9CDlcG8/caUi5nLEPGflx2jiCO75gksc/6N6j0
 nyKQ==
X-Gm-Message-State: AGi0PuZU5EH//L2+edfK2I1IaSkHYZNlqmtJpmdGhR7msTI7BZlovVRZ
 gx+z8+TyTuEgf7nfF1kNhIiDTw==
X-Google-Smtp-Source: APiQypLxHOfwG1ryjC/TcH1jk7Fqcg15PZuF3rUQqrV6goNBMMG+OjJ2jRHeFEWG+XHD0e7kNPGDGA==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr3148130wru.326.1587116187648; 
 Fri, 17 Apr 2020 02:36:27 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id h137sm7819792wme.0.2020.04.17.02.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 02:36:26 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: srini@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH] slimbus: ngd: get drvdata from correct device
Date: Fri, 17 Apr 2020 10:36:18 +0100
Message-Id: <20200417093618.7929-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
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

Get drvdata directly from parent instead of ngd dev, as ngd
dev can probe defer and previously set drvdata will become null.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index fc2575fef51b..7426b5884218 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1361,7 +1361,6 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
-		platform_set_drvdata(ngd->pdev, ctrl);
 
 		platform_device_add(ngd->pdev);
 		ngd->base = ctrl->base + ngd->id * data->offset +
@@ -1376,12 +1375,13 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 
 static int qcom_slim_ngd_probe(struct platform_device *pdev)
 {
-	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev->parent);
 	int ret;
 
 	ctrl->ctrl.dev = dev;
 
+	platform_set_drvdata(pdev, ctrl);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, QCOM_SLIM_NGD_AUTOSUSPEND);
 	pm_runtime_set_suspended(dev);
-- 
2.21.0

