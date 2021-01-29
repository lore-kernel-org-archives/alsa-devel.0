Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48703C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 17:36:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09C164E09
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 17:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09C164E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5206316C7;
	Fri, 29 Jan 2021 18:35:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5206316C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611941788;
	bh=hXrjwHOB5+FbD/F2YvYexS3oIcYUC845RMpZdoW8AeM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JL3L/BRgk81r1YM0xhMpoepASYwnZQEu6Un3ugCKapxC2uwaEjqx9IwL25pJ/PDaF
	 AxQ1uBg91CkxBvWxz0wTD1WPr9YV8ot+KsCSibjdgzL2x6X6yCHb8foJHEIlHhkn0J
	 +XBi158PdCvQjvH1BBjnXHfzck4ooRag2YbXzlO0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0790F804EC;
	Fri, 29 Jan 2021 18:33:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 683BCF804CB; Fri, 29 Jan 2021 18:33:11 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1017FF804D2
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 18:33:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1017FF804D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="I3pg9tfL"
Received: by mail-wm1-x32b.google.com with SMTP id y187so7809832wmd.3
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 09:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eONmBCImMt12oRSP39RxbUr8Npi7ApzTyCqDK+i9RD4=;
 b=I3pg9tfLnTHfjB2H0AIKW/Sy2XzgCDvoebmNiJAxjzvE84bV+3IVDhFWh7xjv/BHwE
 a4N7DEV9M1285ElbyqbZZVo1nOaibXGfVJVKX1oJ29h600KK/VD6orbi8rKA/DVIXo8t
 /hTV/0LBmFWB+8vE4PM1D7YUBHvHgH0bOWKIxnlEbzlMl6M455aBBAUkZkp/UMRh1uuz
 tigaQ4VoODJ7Uvu96qi1JajZgStNH9buqm3A2C2PvwSLQGRI/lQjSCzvPrqepqfkSeBI
 QRA8OyqheqLFYa0j0N/erYU9g9q7Oeu8AL1TZt7qIj7GivpC9YyjHlLUI84+hmeoeLdm
 SaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eONmBCImMt12oRSP39RxbUr8Npi7ApzTyCqDK+i9RD4=;
 b=X9WTeLKq0WB7+MTFvuRdcTmqKi+GYnyE+LzabR0sneZByxeu6DJRBj32Uy+74jeLWK
 nYBqYZ6u/7s5EltKg2kP73PEK/HEH+ZMxQuyUSCnfrHczsY1LLghXuXPrANvSKffZd0l
 WC9CJwiUORyPaPjgwimRh8U+z3i158DB5ImHN81IXEbpPp36FcvTiCm3kNOFZ6p0EKb5
 loyUDzyMj57NHvOs0YSrufhCDjs5JOMJ1y63Znsm/Mci26bpUFlrpGbtldTuonPCX/0s
 s2sfH+7FOBGoKXvV9mQV0GymuRblSJ/ZKio5d+Bl2uev+1vx1l5hIJMOtbzzRpbjFT/3
 BSCA==
X-Gm-Message-State: AOAM531J4tBDofwkD5yfS/EOTt61rdkUirOB/qgbfF44wgyvpyOVK7Xn
 Klob18mkkpd7JIOtN5NaNF4Spw==
X-Google-Smtp-Source: ABdhPJxi3zNFX7lDhzWQF3xuka/mdUMJ2B/LfYFZGdOvLMOEwSnE4U5Xz/11texoMUiaiMkOYjSt6Q==
X-Received: by 2002:a05:600c:27d1:: with SMTP id
 l17mr4816004wmb.18.1611941579861; 
 Fri, 29 Jan 2021 09:32:59 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id h18sm13202294wru.65.2021.01.29.09.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 09:32:59 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH 4/6] soundwire: qcom: start the clock during initialization
Date: Fri, 29 Jan 2021 17:32:46 +0000
Message-Id: <20210129173248.5941-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 linux-kernel@vger.kernel.org,
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

Start the clock during initialization.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 3669bac11a32..83df15d83935 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -47,6 +47,8 @@
 #define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)		(0x101C + 0x40 * (m))
 #define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK			GENMASK(2, 0)
 #define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK			GENMASK(7, 3)
+#define SWRM_MCP_BUS_CTRL					0x1044
+#define SWRM_MCP_BUS_CLK_START					BIT(1)
 #define SWRM_MCP_CFG_ADDR					0x1048
 #define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK		GENMASK(21, 17)
 #define SWRM_DEF_CMD_NO_PINGS					0x1f
@@ -345,6 +347,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
+	ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
 	/* Configure number of retries of a read/write cmd */
 	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
 	    ctrl->version_step >= 1) {
-- 
2.21.0

