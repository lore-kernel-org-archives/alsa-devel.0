Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E289C43461
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:43:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AA922272
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TzZB9oIn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phjXwZxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AA922272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 334F81685;
	Wed, 16 Sep 2020 17:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 334F81685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600270980;
	bh=tzsZSTYKILufozIcYioy6+qV6vAnvB8uhe4VIfgY1k0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TzZB9oInSazFLWph9wR765l6NeQ44jWeYMdkugXgYFKD3ps1p+1wSVjn6KWR168V7
	 m0bygVGhsd+mjCiVKoL85saaP40YAdZ+x5ZDBkZfzQJTeFl+9SbAiEYFOjAOkvYMDl
	 ouXfKlHp/xaPus2A/l0WUo/tYZ8YJvpb3UFun8cQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 074DBF8020B;
	Wed, 16 Sep 2020 17:41:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E562CF801F7; Wed, 16 Sep 2020 17:41:16 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22F57F800BB
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 17:41:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22F57F800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="phjXwZxj"
Received: by mail-wr1-x442.google.com with SMTP id w5so7404865wrp.8
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CvLpIi+7meUnlK1+vtXiFiibYQd8qHIihBysDb2CEOI=;
 b=phjXwZxjSF985V8NctZC3S01geF6oSlbFp0KQIK9XIro3P4aafdYhA3MPyE4uSYwqU
 5W9QliowsOkOTeluqflrXFlaEf2yuBnG/uZT93TCMxR++ILSGZWngGUV93rALz24Klrq
 A+AZOLUXCLYQcsiGSGV0+AiYab8QhUCw2C0GL3sRUBuCcUGvvnIvo7fk7kkSGDSIHGaB
 qyqn9g+iFA2z+g9oVoiuD1Qjh2fEH3WcK/FJuU2swGmRg4ZKsgl5bnan1/r829mx5uKc
 IkCmcVf5vZnpoeJgk1/kVxjTkFFRMPuruDA5YaynKiwtlADUfd0aFJJhohvOoNdqAs3X
 g+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CvLpIi+7meUnlK1+vtXiFiibYQd8qHIihBysDb2CEOI=;
 b=BWJVIxyRUVjtE0/j9uoSS0/2jdum5ATVdjoRzZfZ8LnG4OHJbsrgOQce4aRyeNFNzY
 28do7d8VTdb9x/rlzIqsbU2U5fmXQChG1cTY9JjXohXVM+79ef0YUB7gIkfJEwyfZcYE
 VAKUb1i43XxS6UQ7UAgGJbJ3wysuJMQhzSSQM1QI9a7AWWcrOYN362NGapj5nkj+/o4R
 QT77jB0h3qdUufIlYpGNPdChs8wwTjfeTxNGjpgHFZWezMT0jFk/mh6PpSDVRtNoP0oF
 TDuobunSjw7gSYrV5Cmz7gNbOcQsnJHCABD6FmWn9eUy3kBGdcSFwpDOJsxspa0isCig
 QpZg==
X-Gm-Message-State: AOAM5319lxE92KytNKIRE9HGkrWX46R2EziC/EDkK38kxiJRCYQoGReP
 I7D9LWAPcBouvIR9j4oASowo5Q==
X-Google-Smtp-Source: ABdhPJy1a7uy0r37DEzgvgQ+aghbxG7NQxGXDCoJlcb4on0bvc5n0bt1eMftRJ6VHaFlhZWUtLLPpQ==
X-Received: by 2002:adf:f585:: with SMTP id f5mr28618511wro.64.1600270870245; 
 Wed, 16 Sep 2020 08:41:10 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id t22sm7223901wmt.1.2020.09.16.08.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 08:41:09 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH v3 2/3] soundwire: qcom: add support to block packing mode
Date: Wed, 16 Sep 2020 16:41:00 +0100
Message-Id: <20200916154101.2254-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
References: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
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
index 0036d3248fb4..5a61d82310fd 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -54,6 +54,7 @@
 #define SWRM_MCP_SLV_STATUS					0x1090
 #define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
 #define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
+#define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
 #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
 #define SWRM_DP_PORT_CTRL_OFFSET1_SHFT				0x08
@@ -82,6 +83,7 @@ struct qcom_swrm_port_config {
 	u8 si;
 	u8 off1;
 	u8 off2;
+	u8 bp_mode;
 };
 
 struct qcom_swrm_ctrl {
@@ -392,14 +394,22 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
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
@@ -447,6 +457,7 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 			p_rt->transport_params.sample_interval = pcfg->si + 1;
 			p_rt->transport_params.offset1 = pcfg->off1;
 			p_rt->transport_params.offset2 = pcfg->off2;
+			p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
@@ -457,6 +468,7 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 					pcfg->si + 1;
 				p_rt->transport_params.offset1 = pcfg->off1;
 				p_rt->transport_params.offset2 = pcfg->off2;
+				p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
 				i++;
 			}
 		}
@@ -703,6 +715,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	u8 off1[QCOM_SDW_MAX_PORTS];
 	u8 off2[QCOM_SDW_MAX_PORTS];
 	u8 si[QCOM_SDW_MAX_PORTS];
+	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
 	int i, ret, nports, val;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
@@ -745,10 +758,13 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
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

