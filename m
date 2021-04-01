Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0E5C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 09:16:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DDB6108F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 09:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DDB6108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0E1C1687;
	Thu,  1 Apr 2021 11:15:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0E1C1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617268576;
	bh=8xzGYhCFzDcvbUelWUitDTo/C1YVVkEUNrF0+uZgD6w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nzTD+GEbMT2afHTC+NUWDIOrDxemZk6aBZgGhfd0rBfXxj7QuTA/Y5/j7uFHiqNUE
	 r6x+mhj820S5CkHIfRedGCjDT1SHD23xLpn4B+JHR3qzZDsESXl30bBNZK36qzx48z
	 IZ4zJnENCMMYEfYuRu0+xqwMzC6Oi24CChXmGL7w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E42DF8013F;
	Thu,  1 Apr 2021 11:15:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E065F8026B; Thu,  1 Apr 2021 11:15:23 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16FC0F8013F
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 11:15:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16FC0F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="WlIUaIoc"
Received: by mail-ed1-x535.google.com with SMTP id l18so1121589edc.9
 for <alsa-devel@alsa-project.org>; Thu, 01 Apr 2021 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pFG46RZYS5/Er5IhYN0FXoPQG4BJ55RdCsAsKwMxydU=;
 b=WlIUaIocYVvnh0DL8RSf6KBIjvTv7HVcs95o9YIu6r52SNIk/q5QYyzo6GDWE7LpHl
 lR+440cF3MLZmzmFSaH3P9x4WQwFDS6ENhwfuXULlj5hybDGIP+dlB7jQei4ezvaeyd3
 yDhoytWciC4lLk0eIVlHubjybZDxMHTt8JZ2yEM/vp1kfdLTC8yXJ+Oc2m9MYkTXuKTP
 iCMKopCKSg472suxVqhLV27KQrJwZO70iCfBNK0w6fivTHp4O7/7EFKJory3jbuTdADf
 MuETethhOuwgJ/Ks0xr03ATL+oTF3xU+mzUimorr0vLA+vke1rCsqUHZAhKHoySgwSQz
 iKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pFG46RZYS5/Er5IhYN0FXoPQG4BJ55RdCsAsKwMxydU=;
 b=HH+GNHiVZsLQncsEfdKzp+A3bpf71gj0rjcRslb+gpnCM6Nzdp0eWGl2lT8DhNp7Uu
 HV2Gf4tjZdIJHQ2xM7xaPpElLxoNYhPViOfjNV6ihLPSEufNExPMkgOd9Dx1qpGXgETW
 r7BbY4rFTi+z5WXn2mQUULKg6VdDNRLmCwFNaqMk/+5Bz7INOXcvVSVrf9K6VknE8pD9
 CM+yeTiBEMUNBVcaMdNIzvn+qEcGHcFgTygb79efBpnXDiI8I3es3j5IWbgVpaf7QeFt
 2Axx/UNF2cA4ewpU/uD11Kik8ZJwe+vukbb96jww0KCxlBLKspE81b/BFVZ+G6tEzpNw
 vXMw==
X-Gm-Message-State: AOAM531HMCRe1QpQwDUoiGly+iovz7z89ik/U15wbHcSixARqBpAVsFK
 l73L+zBkSmgw/J+z0c020MuqKQ==
X-Google-Smtp-Source: ABdhPJxq9SvkUxPvdCl1mrkfMUE3n7OpohFqbLJ25k6jtzcdjAn8gW60BZeAuXxTc2WbWKY0s+B/4w==
X-Received: by 2002:aa7:da14:: with SMTP id r20mr8590863eds.181.1617268505387; 
 Thu, 01 Apr 2021 02:15:05 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id gb4sm2426802ejc.122.2021.04.01.02.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 02:15:04 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH] soundwire: qcom: handle return correctly in
 qcom_swrm_transport_params
Date: Thu,  1 Apr 2021 10:15:02 +0100
Message-Id: <20210401091502.15825-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com,
 coverity-bot <keescook+coverity-bot@chromium.org>,
 linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
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

Looks like return from reg_write is set but not checked.
Fix this by adding error return path.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1503591 ("UNUSED_VALUE")
Fixes: 128eaf937adb ("soundwire: qcom: add support to missing transport params")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 5fd4a99cc8ac..348d9a46f850 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -731,17 +731,23 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 	value |= pcfg->si;
 
 	ret = ctrl->reg_write(ctrl, reg, value);
+	if (ret)
+		goto err;
 
 	if (pcfg->lane_control != SWR_INVALID_PARAM) {
 		reg = SWRM_DP_PORT_CTRL_2_BANK(params->port_num, bank);
 		value = pcfg->lane_control;
 		ret = ctrl->reg_write(ctrl, reg, value);
+		if (ret)
+			goto err;
 	}
 
 	if (pcfg->blk_group_count != SWR_INVALID_PARAM) {
 		reg = SWRM_DP_BLOCK_CTRL2_BANK(params->port_num, bank);
 		value = pcfg->blk_group_count;
 		ret = ctrl->reg_write(ctrl, reg, value);
+		if (ret)
+			goto err;
 	}
 
 	if (pcfg->hstart != SWR_INVALID_PARAM
@@ -755,11 +761,15 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 		ret = ctrl->reg_write(ctrl, reg, value);
 	}
 
+	if (ret)
+		goto err;
+
 	if (pcfg->bp_mode != SWR_INVALID_PARAM) {
 		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
 		ret = ctrl->reg_write(ctrl, reg, pcfg->bp_mode);
 	}
 
+err:
 	return ret;
 }
 
-- 
2.21.0

