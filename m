Return-Path: <SRS0=jGB1=OZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76007C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 14:16:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D25611F2
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 14:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41D25611F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D6DE844;
	Tue,  5 Oct 2021 16:15:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D6DE844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633443373;
	bh=T0ApoH6bTOB1xPwWJq2JOHT/ap3L6MEeNTlW7Q3UToI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WCre+8M0zVYcyIifnTt3Pq/qH22IhD8peRHb2Ebsx4tvQm1fCKMXegwjrJik/yRXH
	 MUL63YWODRKUV3paYUE1btQ16BJV0Bg6Oez4gXjP7i5tcTckKPGYrjU2/wdXGQ44hr
	 eLbJaO7MvEyAvZ0usVGrBr5vFDc8j6YwXbI8Bg+M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1596DF8010B;
	Tue,  5 Oct 2021 16:15:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40A62F80259; Tue,  5 Oct 2021 16:15:21 +0200 (CEST)
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C956F8010B
 for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2021 16:15:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C956F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="S+2RnZjE"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1633443315; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=OwZI3V/T1OCP8rQzVHp5rAiN1T4/brwJdSaQX4lxQQA=;
 b=S+2RnZjEmqpyXHYK4/o9ee0HYfzfEhJ4v1fNhbNPml7PfBuhmLYsWQQYI7nFSeRLlxkZfrG6
 y/L3vXAd4ZLW3SmN0HNfMhWD+zddka0H2qfy3XenroLlA7ejcQbU7U2kx74q+BuBsziGxcL/
 HldgCUczXkGM9xOH4hPHEY8lhcs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 615c5df08ea00a941f66ae01 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 14:15:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id EECEDC4360D; Tue,  5 Oct 2021 14:15:11 +0000 (UTC)
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id AB993C4360D;
 Tue,  5 Oct 2021 14:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AB993C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=codeaurora.org
From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To: agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
Subject: [PATCH v2] ASoC: qcom: soundwire: Enable soundwire bus clock for
 version 1.6
Date: Tue,  5 Oct 2021 19:44:45 +0530
Message-Id: <1633443285-18685-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: Venkata Prasad Potturu <potturu@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
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

Add support for soundwire 1.6 version to gate RX/TX bus clock.

Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
Changes since v1:
    -- Add const name to mask value.

 drivers/soundwire/qcom.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 0ef79d6..491407f 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -109,6 +109,7 @@
 #define SWR_MAX_CMD_ID	14
 #define MAX_FIFO_RD_RETRY 3
 #define SWR_OVERFLOW_RETRY_COUNT 30
+#define SWRM_HCTL_REG_MASK 0xFFFFFFFD
 
 struct qcom_swrm_port_config {
 	u8 si;
@@ -127,6 +128,7 @@ struct qcom_swrm_ctrl {
 	struct device *dev;
 	struct regmap *regmap;
 	void __iomem *mmio;
+	char __iomem *swrm_hctl_reg;
 	struct completion broadcast;
 	struct completion enumeration;
 	struct work_struct slave_work;
@@ -610,6 +612,12 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, ctrl->rows_index);
 	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, ctrl->cols_index);
 
+	if (ctrl->swrm_hctl_reg) {
+		val = ioread32(ctrl->swrm_hctl_reg);
+		val &= SWRM_HCTL_REG_MASK;
+		iowrite32(val, ctrl->swrm_hctl_reg);
+	}
+
 	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
 
 	/* Enable Auto enumeration */
@@ -1200,7 +1208,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	struct qcom_swrm_ctrl *ctrl;
 	const struct qcom_swrm_data *data;
 	int ret;
-	u32 val;
+	int val, swrm_hctl_reg = 0;
 
 	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -1251,6 +1259,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
 	ctrl->bus.compute_params = &qcom_swrm_compute_params;
 
+	if (!of_property_read_u32(dev->of_node, "qcom,swrm-hctl-reg", &swrm_hctl_reg))
+		ctrl->swrm_hctl_reg = devm_ioremap(&pdev->dev, swrm_hctl_reg, 0x4);
+
 	ret = qcom_swrm_get_port_config(ctrl);
 	if (ret)
 		goto err_clk;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

