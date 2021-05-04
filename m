Return-Path: <SRS0=dtPj=J7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886CCC433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 13:00:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8D5613BC
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 13:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8D5613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C143D1694;
	Tue,  4 May 2021 14:59:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C143D1694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620133220;
	bh=SSA16k+sanDJco4eWgP1XKZF9PZtZqD+LT53zUsdlVk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RILbHTEUPJRmkMZ4os/b3Oz6clMK/dgN1acEV1HQ3ydyYIVyZ2rLwKrdfE9i1rtZJ
	 OGnJy7MboRCEjwWcoyMNt+2SHbA1tRjKdVduP84SgDbvPIjVMWQGBxYFET5HQPppfl
	 5uUEl8suLwB3+bKxCxcuYdJ3vQ7f2TjeKYtzvjq8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CD98F80162;
	Tue,  4 May 2021 14:59:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C054F80234; Tue,  4 May 2021 14:59:28 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C9DAF80108
 for <alsa-devel@alsa-project.org>; Tue,  4 May 2021 14:59:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C9DAF80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="mSZKtm0q"
Received: by mail-wm1-x32b.google.com with SMTP id
 t11-20020a05600c198bb02901476e13296aso1300909wmq.0
 for <alsa-devel@alsa-project.org>; Tue, 04 May 2021 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8wApOpJhCU9tfgd/Dj9rvLGUlH1ua1FJRVoJ9b+ybUY=;
 b=mSZKtm0qtHgXPjNZf3T0OZd79W0shIJ+8mLIAsRgiJy5fOBwwTgG+2TSjTTD8uC3pS
 /NpdjVstmh8JBPVlnHnyUMBWn+7rC2MibquiBJeYaP/tnSol66mn/xw5jTSs1rUwWLWq
 pKORykqgkqocPNnoZ/qcke2nsEo6rBzf4C6S8ETfAEVfN50eSuKQvM1yDHNYRWewbr8V
 4sy4+qOVCs5qW3/c1Uw78dgzKdavwi3Vlzge+uRdfloyl7hdimORq7CNylSv4vXWpRTm
 H4IVPyu6cXgQINNdE2nEPLuSR4VzQJSdrygVJCfM2yLyvy09ImmU2Z5QV3Ch1JgSpiv3
 MHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8wApOpJhCU9tfgd/Dj9rvLGUlH1ua1FJRVoJ9b+ybUY=;
 b=a5ZPOy/c84dyx+VK/txsSnOQxRuRj9WIzTPai5XrAILzzFMDSHZYDPW2T5MmaAcCcU
 49CMijOw3g2B+d9gNxC5+rXjyw94Bq8Dmv5ugqI7NyN4UwBAOXV9fAX9UA206t1lWyIC
 c9+L7i6BejpGVXN/ipeg05snq0uknHtQ2SSzuoiyywZ36y+asOBDgfgb9P6Y2lXaj0dm
 19cr7CZw8VrI/3ETx4O+A6/WdWKadP8hez0PmDAZ1w03Lab8BnHI12zodvXJ7HW7UNxK
 s8BCMK/p3U45ShXvIOju2MV6HWJPbNQWr5iLkhqqeSEnN1Fw4Q+EiBBz1k2TLII97pTy
 MhpA==
X-Gm-Message-State: AOAM530CFtczzmnyDmQInebKYcc2Im4+ZELUEKH9k4/mDCOBn8hUXreC
 PBtKOB93JXgSCSZKMkWuCmWuWA==
X-Google-Smtp-Source: ABdhPJxYrJ5SvegT6/GQLBTJhJ+E6KkApAj5p70zLOSyZs9P4mRlQIFu8+K2HzTCbfng9oSHJJu4Qw==
X-Received: by 2002:a1c:cc0e:: with SMTP id h14mr27637427wmb.4.1620133161053; 
 Tue, 04 May 2021 05:59:21 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id a21sm2483055wmj.34.2021.05.04.05.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 05:59:20 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH] soundwire: qcom: fix handling of qcom,ports-block-pack-mode
Date: Tue,  4 May 2021 13:59:09 +0100
Message-Id: <20210504125909.16108-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: amit.pundir@linaro.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 bjorn.andersson@linaro.org, sanyog.r.kale@intel.com,
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

Support to "qcom,ports-block-pack-mode" was added at later stages
to support a variant of Qualcomm SoundWire controllers available
on Apps processor. However the older versions of the SoundWire
controller which are embedded in WCD Codecs do not need this property.

So returning on error for those cases will break boards like DragonBoard
DB845c and Lenovo Yoga C630.

This patch fixes error handling on this property considering older usecases.

Fixes: 5943e4fb14e3 ("soundwire: qcom: check of_property_read status")
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 2827085a323b..0ef79d60e88e 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1150,8 +1150,16 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 
 	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
 					bp_mode, nports);
-	if (ret)
-		return ret;
+	if (ret) {
+		u32 version;
+
+		ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &version);
+
+		if (version <= 0x01030000)
+			memset(bp_mode, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+		else
+			return ret;
+	}
 
 	memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
 	of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
-- 
2.21.0

