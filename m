Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192EFC43461
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:10:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3FD20768
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="epcT4cHM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddcl7tEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3FD20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E81E91729;
	Wed,  9 Sep 2020 18:09:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E81E91729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599667826;
	bh=qQyP2lf9DYJ/bt4Q8ojs8Nn3DIco9f0t1XwtXS0awjg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=epcT4cHMEnGKG+gGpSFdKBK56PFzfdqoEmYXJpX5QU3BiZl+A/4mKJVWr7Ok1liUH
	 QHIHdVXFHwk4c6phch12vX+0bDfOQ464X4PPbFT6BP7xi45s0NqheU9FInjqb2YU06
	 PIv4JoYfAGGC4YYgfwVfpHsdf2YoMTQs6ctoBlyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55FA5F8021C;
	Wed,  9 Sep 2020 18:09:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9630BF80240; Wed,  9 Sep 2020 18:09:31 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61C67F800FD
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 18:09:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61C67F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ddcl7tEh"
Received: by mail-wm1-x344.google.com with SMTP id e17so2841093wme.0
 for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2020 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e9TiY5/bRVaXFVk1XIFOpSl5QkIq5j2T93HOt+CCPbQ=;
 b=ddcl7tEhnPfNtD0kQtjIW4AO4O9gqEadXfWVNAeO5xFb006m2m113HocUiwSP256uS
 oKZ6y6oMKI70IFBfi5WeBJqjONblrJCyY4FQucEgtNJc+6oI8VDcbvEdvr8MhjvMyPx+
 GjimWAegdexG2jth71ZMNjjw1dMu1EX7K2b/3qEWd5vZ60I64N1TUY8U22tCGsPc2ldr
 scwawNcgK83Omt9Z9u5IpVgsuJ3PtcWEFeMRZybOQjTEf9mj9sQZH88cY7adGKXRYMY5
 nFgqDLVNgGhVEmxtfWhSQKx8CKBEE9uCs4EtuZNj0mA8Aq9IEg8cnfL4afRiqTo3olFU
 Qh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e9TiY5/bRVaXFVk1XIFOpSl5QkIq5j2T93HOt+CCPbQ=;
 b=ncwHiaBj4hXUdqUyzXzHQ0rSqt6Ux8HORgKepUaNAKL3N0D1Qr8pwBx04wYdeoq+GC
 bYcmiVQ9f0w/wmtDH/1zW6buJdy5F8TdOhQjYVWGEGxtd0GKZbYxwcpk5+cp30PwZtiQ
 uXm0KiSQTNZjn4cupcCWmB/LCLnpdjLXqjfxxzKCMHJqhyzg2urY4V6ziR4vswAb3Dfa
 RxH6wfxIcsm2BDzt9SxvDmG7OnKwhzZiu0EwuCnM35OPcQ623ZMANiyfxAGJf0GwFz0y
 79Zocv5ayHJ8hVVOu+GKlP2cxeT/Tgq4dPCMsHQ/sA8OAcat5r0yQ7rrnbg5FQ1+yp7g
 sfhg==
X-Gm-Message-State: AOAM530PoHLN18GE6XsnbdQBwgD7ZdPDxvHcAczqEIDgb/X9ljpPvM19
 twaNE0D1gQbFi0dIhlyqN4d5DEqvPJBvvw==
X-Google-Smtp-Source: ABdhPJzNDImkocSgTlMk5wUA2B5Z+RFEl3n/ikeyBHhrp4Cu+ZM10SKJtoSscc/73DqUc7yGYvE/VA==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr4311608wmd.95.1599667764481; 
 Wed, 09 Sep 2020 09:09:24 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id k22sm4900824wrd.29.2020.09.09.09.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:09:23 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH 1/2] soundwire: qcom: add support to block packing mode
Date: Wed,  9 Sep 2020 17:09:11 +0100
Message-Id: <20200909160912.3656-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200909160912.3656-1-srinivas.kandagatla@linaro.org>
References: <20200909160912.3656-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: sanyog.r.kale@intel.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
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

This patch adds support to block pack mode, which is required
on Qcom soundwire controllers v1.5.x on few ports!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 4b3ef7559e6a..1ec0ee931f5b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -57,6 +57,7 @@
 #define SWRM_MCP_SLV_STATUS					0x1090
 #define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
 #define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
+#define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
 #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
 #define SWRM_DP_PORT_CTRL_OFFSET1_SHFT				0x08
@@ -85,6 +86,7 @@ struct qcom_swrm_port_config {
 	u8 si;
 	u8 off1;
 	u8 off2;
+	u8 bp_mode;
 };
 
 struct qcom_swrm_ctrl {
@@ -400,14 +402,22 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 {
 	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
 	u32 value;
+	int reg = SWRM_DP_PORT_CTRL_BANK((params->port_num), bank);
+	int ret;
 
 	value = params->offset1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
 	value |= params->offset2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
 	value |= params->sample_interval - 1;
 
-	return ctrl->reg_write(ctrl,
-			       SWRM_DP_PORT_CTRL_BANK((params->port_num), bank),
-			       value);
+	ret = ctrl->reg_write(ctrl, reg, value);
+
+	if (!ret && params->blk_pkg_mode) {
+		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
+
+		ret = ctrl->reg_write(ctrl, reg, 1);
+	}
+
+	return ret;
 }
 
 static int qcom_swrm_port_enable(struct sdw_bus *bus,
@@ -455,6 +465,7 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 			p_rt->transport_params.sample_interval = pcfg->si + 1;
 			p_rt->transport_params.offset1 = pcfg->off1;
 			p_rt->transport_params.offset2 = pcfg->off2;
+			p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
@@ -465,6 +476,7 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 					pcfg->si + 1;
 				p_rt->transport_params.offset1 = pcfg->off1;
 				p_rt->transport_params.offset2 = pcfg->off2;
+				p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
 				i++;
 			}
 		}
@@ -711,6 +723,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	u8 off1[QCOM_SDW_MAX_PORTS];
 	u8 off2[QCOM_SDW_MAX_PORTS];
 	u8 si[QCOM_SDW_MAX_PORTS];
+	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
 	int i, ret, nports, val;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
@@ -753,10 +766,13 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
+					bp_mode, nports);
 	for (i = 0; i < nports; i++) {
 		ctrl->pconfig[i].si = si[i];
 		ctrl->pconfig[i].off1 = off1[i];
 		ctrl->pconfig[i].off2 = off2[i];
+		ctrl->pconfig[i].bp_mode = bp_mode[i];
 	}
 
 	return 0;
-- 
2.21.0

