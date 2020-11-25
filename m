Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D4BC5519F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 05:42:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFE6208C3
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 05:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ozeFkWPE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUFNKhqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFE6208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7773E16F7;
	Wed, 25 Nov 2020 06:42:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7773E16F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606282970;
	bh=dOwCJJnQ3iQhKWe+kWuMfjyCHt4gC4PKnpJIFX6tijc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ozeFkWPE+8TOSJQFvCWdNX8uN6vHvbyq3mOOj9gFGoVjv9mjqnCyo+E1uw+x1pWCE
	 tnwR4/iag2JUrWg/WT2wguDiWnFZzpBtsaL2J81KIbfhmzoCUqBupXvNHgUJsV+rSc
	 tJuxbHv744/9FhbAxbCiL20wmb6Pcpl9WAvfKW2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE2A5F80128;
	Wed, 25 Nov 2020 06:41:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB7A6F8019D; Wed, 25 Nov 2020 06:41:57 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 170B0F80128
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 06:41:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 170B0F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="MUFNKhqQ"
Received: by mail-ot1-x343.google.com with SMTP id k3so1165461otp.12
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 21:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TrH5HMIZUxZ8p9ZVVV5Tv219hldD8kORSISX8v4WVrU=;
 b=MUFNKhqQDCHQpfptt+YYZBTPRfTVUTXDGFfpo2K3QohChRAmOyh+drOOkBLeNSIYEi
 /4Yl3ksYWaJFBB+6L8/ZFvFTL76G+Ufj6anX93pkeJBzRt8nlHPQRVcXXJOvGY+mf5+0
 FIWPGvw/1phHPgvOn6jKCgCM4seP+1OlfZgMJSnz8niVSQQppkEGaQba96Oy32AdPJFm
 Vs4+WGdCHlK1wwk2ECk3OsbV+2CyK4SDMB9Gs/DsC8CspVJKot8iJ1xYEGNYT1mIw6Ys
 DK2LYih469xzjMLL5Eb+fL/JPadnt8dwuHdCrzm5ujqMxXYs8q7LDxh08vXDkxna4MSY
 Il9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TrH5HMIZUxZ8p9ZVVV5Tv219hldD8kORSISX8v4WVrU=;
 b=JCGcgcFzpO0URdboVVDHDQWzak3F7QBXQPXs69O5ASmvzrJQVHW8VLWoXe2r4wwfua
 kG+PIW3dJE0wotbDgcqwGH1AexUNFvVaKDTZHnnmNA7IA+QIK6DQZ/fchzAmHYjHknLf
 gb4ysU3amamzR2rRSW6GqWtE6qcQkFQe9kIgRQWSKCmN+c1NG0au7lOG7IUFEAm/AZJB
 Wi4DPGhsoXmUaR8iEfMfh250FrU/bIqSPOPqwL2oz+BIwmKnRiLNF0l4w8BXMJo9KiqT
 XXrC2ehjwjPuZijUNyKQFbHcC3ruGZ/kXr0sdeDuU0gaUSvlJ8X2ohTJYpMc5QgihBIR
 WZ5A==
X-Gm-Message-State: AOAM530o4otCPgdpVy/VYJKKCYmd6ktRnsPg0ieSoxD+jnM5xlistmjZ
 9hMLNW+fIyMVVi4SpxgwfYt7bQ==
X-Google-Smtp-Source: ABdhPJzzp6dtkH49iCowittR7nB8DAE9MRULxL7pHYpMrTkXIyuxqg5YqkKrKoEV/UUUXBoNAR4/jA==
X-Received: by 2002:a9d:851:: with SMTP id 75mr1731327oty.102.1606282904926;
 Tue, 24 Nov 2020 21:41:44 -0800 (PST)
Received: from localhost.localdomain
 (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id l12sm806802ooe.27.2020.11.24.21.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 21:41:43 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Avoid sending power requests without
 QMI
Date: Tue, 24 Nov 2020 21:42:55 -0800
Message-Id: <20201125054255.137067-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
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

Attempting to send a power request during PM operations, when the QMI
handle isn't initialized results in a NULL pointer dereference. So check
if the QMI handle has been initialized before attempting to post the
power requests.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index d8decb345e9d..c502e9e93965 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1229,6 +1229,9 @@ static int qcom_slim_ngd_runtime_resume(struct device *dev)
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret = 0;
 
+	if (!ctrl->qmi.handle)
+		return 0;
+
 	if (ctrl->state >= QCOM_SLIM_NGD_CTRL_ASLEEP)
 		ret = qcom_slim_ngd_power_up(ctrl);
 	if (ret) {
@@ -1616,6 +1619,9 @@ static int __maybe_unused qcom_slim_ngd_runtime_suspend(struct device *dev)
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret = 0;
 
+	if (!ctrl->qmi.handle)
+		return 0;
+
 	ret = qcom_slim_qmi_power_request(ctrl, false);
 	if (ret && ret != -EBUSY)
 		dev_info(ctrl->dev, "slim resource not idle:%d\n", ret);
-- 
2.29.2

