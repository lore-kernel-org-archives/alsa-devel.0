Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A60C433E9
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:49:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56CC206EB
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y272UmYi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3jA+yBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56CC206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 651531925;
	Thu,  3 Sep 2020 13:48:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 651531925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599133777;
	bh=SCBinwwUvcRl1ivI2Bf/Ks6zxur2RllsD2sIxoMrICE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y272UmYisvdgd1zmaLSI0aT44qV+9ie/SNwMa5rIshTfLD81FRGkEmxEjHTpH1FRN
	 0HYOflXUB33kAylKQN62Hx748Nfsm+MNW1IvW5q0nOUbUYuNf55hzSR1kMdMObIlKP
	 2ApFQ/w5jgCwLCJ3LNyq3APtZRifWqevwS93B/3E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6A56F802F8;
	Thu,  3 Sep 2020 13:45:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A73CF802F8; Thu,  3 Sep 2020 13:45:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 768ACF802E2
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 13:45:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 768ACF802E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="G3jA+yBr"
Received: from localhost.localdomain (unknown [122.171.179.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76A462083B;
 Thu,  3 Sep 2020 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599133533;
 bh=SCBinwwUvcRl1ivI2Bf/Ks6zxur2RllsD2sIxoMrICE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G3jA+yBrg7Y6EwjnfHnC6ypnROJQz/FBmacd8AL6kN6EAp6HhMp8tBCb8AjmebdJC
 npOe+zr2Qy1bAMEL2nQT38z+WGueRZc2NKC7JjHgWEIG94jH67tVjAe9+/jM41HKH7
 rFqxJexL5xdycZ/wzyyMdgKm3jvVcNFtr43zbnws=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 5/9] soundwire: qcom : use FIELD_{GET|PREP}
Date: Thu,  3 Sep 2020 17:15:00 +0530
Message-Id: <20200903114504.1202143-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903114504.1202143-1-vkoul@kernel.org>
References: <20200903114504.1202143-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>
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

use FIELD_{GET|PREP} in qcom driver to get/set field values instead of
open coding masks and shift operations.
Also, remove now unused register shift defines

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/qcom.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 915c2cf0c274..dafa3f3dd1ab 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -43,13 +43,10 @@
 #define SWRM_CMD_FIFO_RD_FIFO_ADDR				0x318
 #define SWRM_ENUMERATOR_CFG_ADDR				0x500
 #define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)		(0x101C + 0x40 * (m))
-#define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT			3
 #define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK			GENMASK(2, 0)
 #define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK			GENMASK(7, 3)
-#define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT			0
 #define SWRM_MCP_CFG_ADDR					0x1048
 #define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK		GENMASK(21, 17)
-#define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_SHFT		0x11
 #define SWRM_DEF_CMD_NO_PINGS					0x1f
 #define SWRM_MCP_STATUS						0x104C
 #define SWRM_MCP_STATUS_BANK_NUM_MASK				BIT(0)
@@ -284,8 +281,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	u32 val;
 
 	/* Clear Rows and Cols */
-	val = (SWRM_MAX_ROW_VAL << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
-	       SWRM_MIN_COL_VAL << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT);
+	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
+	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MIN_COL_VAL);
 
 	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
 
@@ -298,9 +295,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 
 	/* Configure No pings */
 	ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
-	val &= ~SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK;
-	val |= (SWRM_DEF_CMD_NO_PINGS <<
-		SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_SHFT);
+	val |= FIELD_PREP(SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK, SWRM_DEF_CMD_NO_PINGS);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
 	/* Configure number of retries of a read/write cmd */
@@ -355,11 +350,8 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
 
 	ctrl->reg_read(ctrl, reg, &val);
 
-	val &= ~SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK;
-	val &= ~SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK;
-
-	val |= (SWRM_MAX_ROW_VAL << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
-		SWRM_MAX_COL_VAL << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT);
+	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MAX_COL_VAL);
+	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
 
 	return ctrl->reg_write(ctrl, reg, val);
 }
@@ -693,8 +685,8 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 
 	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
 
-	ctrl->num_dout_ports = val & SWRM_COMP_PARAMS_DOUT_PORTS_MASK;
-	ctrl->num_din_ports = (val & SWRM_COMP_PARAMS_DIN_PORTS_MASK) >> 5;
+	ctrl->num_dout_ports = FIELD_GET(SWRM_COMP_PARAMS_DOUT_PORTS_MASK, val);
+	ctrl->num_din_ports = FIELD_GET(SWRM_COMP_PARAMS_DIN_PORTS_MASK, val);
 
 	ret = of_property_read_u32(np, "qcom,din-ports", &val);
 	if (ret)
-- 
2.26.2

