Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B245CC433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:49:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F4A20709
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DlH2VU1H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ztKaU6TC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F4A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A69EE16D0;
	Thu,  3 Sep 2020 13:49:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A69EE16D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599133795;
	bh=7/cHN+kgFiNZ+AzZMkhwaK+bXI6BTKY3TO+wp3pd76Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DlH2VU1HwV2TX5I7dEQHA9hntQhVL6mEp1QxqbL+mOQw2dLgQ+nd4bnwbcpaGuN/o
	 WskomeOlTiyYJsC7/lVxbPuce1YOOeJ6qhH+rOUNidZrlI0QQXG8bOEdrW1k7huLUJ
	 OlbQDy3VHec7WrTk/0VHWXqNivn9tdeE2wZ/jAtM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 303CAF802EB;
	Thu,  3 Sep 2020 13:45:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 676B5F802FE; Thu,  3 Sep 2020 13:45:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AEFBF802EB
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 13:45:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AEFBF802EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ztKaU6TC"
Received: from localhost.localdomain (unknown [122.171.179.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A17FC206EB;
 Thu,  3 Sep 2020 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599133537;
 bh=7/cHN+kgFiNZ+AzZMkhwaK+bXI6BTKY3TO+wp3pd76Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ztKaU6TCoLLyU0uj9eC7TLzqCdZKNWpCG6E9bsl9XOM2JnIyQuntIyb6myAiXOuB5
 i/QMftjnPwEOKC7duEmZbGyr0ANfpor0BgA0iyOkV5qqY0N1/eDyXk7OywWsLiBf7O
 WQxQ+VRr37IZqgnfYQSWgRkFStKNAdzae3ujJ97U=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 6/9] soundwire: cadence: use FIELD_{GET|PREP}
Date: Thu,  3 Sep 2020 17:15:01 +0530
Message-Id: <20200903114504.1202143-7-vkoul@kernel.org>
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

use FIELD_{GET|PREP} in cadence driver to get/set field values instead
of open coding masks and shift operations.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/cadence_master.c | 61 +++++++++++++-----------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 24eafe0aa1c3..ecf503fb23e1 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_MCP_FRAME_SHAPE			0x10
 #define CDNS_MCP_FRAME_SHAPE_INIT		0x14
 #define CDNS_MCP_FRAME_SHAPE_COL_MASK		GENMASK(2, 0)
-#define CDNS_MCP_FRAME_SHAPE_ROW_OFFSET		3
+#define CDNS_MCP_FRAME_SHAPE_ROW_MASK		GENMASK(7, 3)
 
 #define CDNS_MCP_CONFIG_UPDATE			0x18
 #define CDNS_MCP_CONFIG_UPDATE_BIT		BIT(0)
@@ -129,8 +129,7 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_MCP_CMD_SSP_TAG			BIT(31)
 #define CDNS_MCP_CMD_COMMAND			GENMASK(30, 28)
 #define CDNS_MCP_CMD_DEV_ADDR			GENMASK(27, 24)
-#define CDNS_MCP_CMD_REG_ADDR_H			GENMASK(23, 16)
-#define CDNS_MCP_CMD_REG_ADDR_L			GENMASK(15, 8)
+#define CDNS_MCP_CMD_REG_ADDR			GENMASK(23, 8)
 #define CDNS_MCP_CMD_REG_DATA			GENMASK(7, 0)
 
 #define CDNS_MCP_CMD_READ			2
@@ -417,8 +416,7 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
 
 	/* fill response */
 	for (i = 0; i < count; i++)
-		msg->buf[i + offset] = cdns->response_buf[i] >>
-				SDW_REG_SHIFT(CDNS_MCP_RESP_RDATA);
+		msg->buf[i + offset] = FIELD_GET(CDNS_MCP_RESP_RDATA, cdns->response_buf[i]);
 
 	return SDW_CMD_OK;
 }
@@ -441,14 +439,15 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 	addr = msg->addr;
 
 	for (i = 0; i < count; i++) {
-		data = msg->dev_num << SDW_REG_SHIFT(CDNS_MCP_CMD_DEV_ADDR);
-		data |= cmd << SDW_REG_SHIFT(CDNS_MCP_CMD_COMMAND);
-		data |= addr++  << SDW_REG_SHIFT(CDNS_MCP_CMD_REG_ADDR_L);
+		data = FIELD_PREP(CDNS_MCP_CMD_DEV_ADDR, msg->dev_num);
+		data |= FIELD_PREP(CDNS_MCP_CMD_COMMAND, cmd);
+		data |= FIELD_PREP(CDNS_MCP_CMD_REG_ADDR, addr);
+		addr++;
 
 		if (msg->flags == SDW_MSG_FLAG_WRITE)
 			data |= msg->buf[i + offset];
 
-		data |= msg->ssp_sync << SDW_REG_SHIFT(CDNS_MCP_CMD_SSP_TAG);
+		data |= FIELD_PREP(CDNS_MCP_CMD_SSP_TAG, msg->ssp_sync);
 		cdns_writel(cdns, base, data);
 		base += CDNS_MCP_CMD_WORD_LEN;
 	}
@@ -483,12 +482,12 @@ cdns_program_scp_addr(struct sdw_cdns *cdns, struct sdw_msg *msg)
 		cdns->msg_count = CDNS_SCP_RX_FIFOLEVEL;
 	}
 
-	data[0] = msg->dev_num << SDW_REG_SHIFT(CDNS_MCP_CMD_DEV_ADDR);
-	data[0] |= 0x3 << SDW_REG_SHIFT(CDNS_MCP_CMD_COMMAND);
+	data[0] = FIELD_PREP(CDNS_MCP_CMD_DEV_ADDR, msg->dev_num);
+	data[0] |= FIELD_PREP(CDNS_MCP_CMD_COMMAND, 0x3);
 	data[1] = data[0];
 
-	data[0] |= SDW_SCP_ADDRPAGE1 << SDW_REG_SHIFT(CDNS_MCP_CMD_REG_ADDR_L);
-	data[1] |= SDW_SCP_ADDRPAGE2 << SDW_REG_SHIFT(CDNS_MCP_CMD_REG_ADDR_L);
+	data[0] |= FIELD_PREP(CDNS_MCP_CMD_REG_ADDR, SDW_SCP_ADDRPAGE1);
+	data[1] |= FIELD_PREP(CDNS_MCP_CMD_REG_ADDR, SDW_SCP_ADDRPAGE2);
 
 	data[0] |= msg->addr_page1;
 	data[1] |= msg->addr_page2;
@@ -1041,9 +1040,10 @@ static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
 	int r;
 
 	r = sdw_find_row_index(n_rows);
-	c = sdw_find_col_index(n_cols) & CDNS_MCP_FRAME_SHAPE_COL_MASK;
+	c = sdw_find_col_index(n_cols);
 
-	val = (r << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | c;
+	val = FIELD_PREP(CDNS_MCP_FRAME_SHAPE_ROW_MASK, r);
+	val |= FIELD_PREP(CDNS_MCP_FRAME_SHAPE_COL_MASK, c);
 
 	return val;
 }
@@ -1170,12 +1170,9 @@ static int cdns_port_params(struct sdw_bus *bus,
 
 	dpn_config = cdns_readl(cdns, dpn_config_off);
 
-	dpn_config |= ((p_params->bps - 1) <<
-				SDW_REG_SHIFT(CDNS_DPN_CONFIG_WL));
-	dpn_config |= (p_params->flow_mode <<
-				SDW_REG_SHIFT(CDNS_DPN_CONFIG_PORT_FLOW));
-	dpn_config |= (p_params->data_mode <<
-				SDW_REG_SHIFT(CDNS_DPN_CONFIG_PORT_DAT));
+	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_WL, (p_params->bps - 1));
+	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_FLOW, p_params->flow_mode);
+	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_DAT, p_params->data_mode);
 
 	cdns_writel(cdns, dpn_config_off, dpn_config);
 
@@ -1212,23 +1209,17 @@ static int cdns_transport_params(struct sdw_bus *bus,
 
 	dpn_config = cdns_readl(cdns, dpn_config_off);
 
-	dpn_config |= (t_params->blk_grp_ctrl <<
-				SDW_REG_SHIFT(CDNS_DPN_CONFIG_BGC));
-	dpn_config |= (t_params->blk_pkg_mode <<
-				SDW_REG_SHIFT(CDNS_DPN_CONFIG_BPM));
+	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_BGC, t_params->blk_grp_ctrl);
+	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_BPM, t_params->blk_pkg_mode);
 	cdns_writel(cdns, dpn_config_off, dpn_config);
 
-	dpn_offsetctrl |= (t_params->offset1 <<
-				SDW_REG_SHIFT(CDNS_DPN_OFFSET_CTRL_1));
-	dpn_offsetctrl |= (t_params->offset2 <<
-				SDW_REG_SHIFT(CDNS_DPN_OFFSET_CTRL_2));
+	dpn_offsetctrl |= FIELD_PREP(CDNS_DPN_OFFSET_CTRL_1, t_params->offset1);
+	dpn_offsetctrl |= FIELD_PREP(CDNS_DPN_OFFSET_CTRL_2, t_params->offset2);
 	cdns_writel(cdns, dpn_offsetctrl_off,  dpn_offsetctrl);
 
-	dpn_hctrl |= (t_params->hstart <<
-				SDW_REG_SHIFT(CDNS_DPN_HCTRL_HSTART));
-	dpn_hctrl |= (t_params->hstop << SDW_REG_SHIFT(CDNS_DPN_HCTRL_HSTOP));
-	dpn_hctrl |= (t_params->lane_ctrl <<
-				SDW_REG_SHIFT(CDNS_DPN_HCTRL_LCTRL));
+	dpn_hctrl |= FIELD_PREP(CDNS_DPN_HCTRL_HSTART, t_params->hstart);
+	dpn_hctrl |= FIELD_PREP(CDNS_DPN_HCTRL_HSTOP, t_params->hstop);
+	dpn_hctrl |= FIELD_PREP(CDNS_DPN_HCTRL_LCTRL, t_params->lane_ctrl);
 
 	cdns_writel(cdns, dpn_hctrl_off, dpn_hctrl);
 	cdns_writel(cdns, dpn_samplectrl_off, (t_params->sample_interval - 1));
@@ -1534,7 +1525,7 @@ void sdw_cdns_config_stream(struct sdw_cdns *cdns,
 
 	val = pdi->num;
 	val |= CDNS_PDI_CONFIG_SOFT_RESET;
-	val |= ((1 << ch) - 1) << SDW_REG_SHIFT(CDNS_PDI_CONFIG_CHANNEL);
+	val |= FIELD_PREP(CDNS_PDI_CONFIG_CHANNEL, (1 << ch) - 1);
 	cdns_writel(cdns, CDNS_PDI_CONFIG(pdi->num), val);
 }
 EXPORT_SYMBOL(sdw_cdns_config_stream);
-- 
2.26.2

