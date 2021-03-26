Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC7C433C1
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 06:43:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B259561A33
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 06:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B259561A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52D3311C;
	Fri, 26 Mar 2021 07:42:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52D3311C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616740997;
	bh=YCP8WkWr44GjDP9iVcTb5GWXDSSKqtkjpFq8cYb8UhQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OGKqBjHCi51uh1PVr3JR26Z7Gr032cxrrgil6XfH93JMTUn6VnNgAUMbHCa1b3ZSJ
	 Tp+6FpiXekMXgmdCd0XksO+6laAcTlnFvM2SWWP0KODEEpJ4O1psZS37POa18yzmAJ
	 Cn4QE0q1wyZm1L4ktnY6/9x21B9+HOn9RHjn8omE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B3CFF80423;
	Fri, 26 Mar 2021 07:41:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C2AEF8032D; Fri, 26 Mar 2021 07:41:31 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 960F0F8016B
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 07:41:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 960F0F8016B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="TtM2fa7P"
Received: by mail-ej1-x636.google.com with SMTP id r12so6773677ejr.5
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pBsk7JwZ/LZ6cSzAnPDMM/93PskvajNpLm1bjDKAXDA=;
 b=TtM2fa7PbzOgQLB4fpw6IimpLrH2OIlw5m0waALp7JmZ+C3gb5XD8n3yBIREwNonVa
 eiYQVl4WckcL3VU5o6QVL9+Gt21DvsXfwX83rwmtT0IvG/p2VEz3u5m9IjoEA+B004RT
 g+GbAD9CBQbkk/Yaa2PmOIEq1C8DIPunDBpI2xttCSBMJG8BG7nj+xtBxiJp07agBWdY
 2SYEGcnSUiOqGU0hsvdaYPL4c1pQ81TDFomf619Eo6/we+hcPB44KSSX92+wxneFaQi/
 3YulS9egaP/f79BP6NJ3BF/VuYgahZqoyMrzJYyfntol5uOV1EzXjFSdErmobMSOeNpM
 bAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pBsk7JwZ/LZ6cSzAnPDMM/93PskvajNpLm1bjDKAXDA=;
 b=bHdQLKMN/UOejgK1j3SQrcABBmK43vn49XytbrBr6CxrIhpD7ajpS57pMIlLIfgXaA
 LTsp20mie0mkUUxK61CGUeTL/JTeD0qad0kU9NA3ixjDOPInCb9aq+z5OiPNgdmfIt6y
 nXci/rIgX6DFuHmGsDq4ZH1vNkSPWS8BIpAY2XJUdCmZ7YNM0BRY+5IXcHWMoJGPad0Q
 cLecZuJp9YWLBM2frSwRJu7xinTlwLhdgSPjy7H3j1itA3IAcnZN6LMaktwiX0ATu/sw
 /PKQ6M0xPzKR7udReC0bS12+zwWR+psht6fVgrxP+XoWRJ0mQMrTteomFOxysQS1OPU9
 DsAQ==
X-Gm-Message-State: AOAM531UDrLd2j0abZrFxOa5lxFRJlke7/5+Xf7ibR7mI+NKfHbUyHEs
 4OnAcUwbMmjv823xDK9OWvcmGw==
X-Google-Smtp-Source: ABdhPJxM2pWHo5EX4fBrgBkHiE+kpNUhbDi/gLNPEs47hwEYC7Gt7x5YLuJrgOtzXhNHd3tDFabfDA==
X-Received: by 2002:a17:906:72d1:: with SMTP id
 m17mr13391086ejl.118.1616740879057; 
 Thu, 25 Mar 2021 23:41:19 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id ci22sm125325ejc.54.2021.03.25.23.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 23:41:18 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH v5 3/9] soundwire: qcom: set continue execution flag for
 ignored commands
Date: Fri, 26 Mar 2021 06:39:38 +0000
Message-Id: <20210326063944.31683-4-srinivas.kandagatla@linaro.org>
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

version 1.5.1 and higher IPs of this controller required to set
continue execution on ignored command flag. This patch sets this flag.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/qcom.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index d05e41f68658..43ec22a5e332 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -40,6 +40,7 @@
 #define SWRM_CMD_FIFO_CMD					0x308
 #define SWRM_CMD_FIFO_STATUS					0x30C
 #define SWRM_CMD_FIFO_CFG_ADDR					0x314
+#define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
 #define SWRM_RD_WR_CMD_RETRIES					0x7
 #define SWRM_CMD_FIFO_RD_FIFO_ADDR				0x318
 #define SWRM_ENUMERATOR_CFG_ADDR				0x500
@@ -343,7 +344,15 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
 	/* Configure number of retries of a read/write cmd */
-	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR, SWRM_RD_WR_CMD_RETRIES);
+	if (ctrl->version > 0x01050001) {
+		/* Only for versions >= 1.5.1 */
+		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
+				SWRM_RD_WR_CMD_RETRIES |
+				SWRM_CONTINUE_EXEC_ON_CMD_IGNORE);
+	} else {
+		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
+				SWRM_RD_WR_CMD_RETRIES);
+	}
 
 	/* Set IRQ to PULSE */
 	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
-- 
2.21.0

