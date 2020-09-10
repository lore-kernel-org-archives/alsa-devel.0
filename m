Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A6BC43461
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:20:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0802078E
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GTYjwXIe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKyzkPao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0802078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3000E1684;
	Thu, 10 Sep 2020 12:19:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3000E1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599733230;
	bh=2dBzjjuCmT+y7CLpxdvvy/p4y0cThP2sHps9Zv7jiJg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GTYjwXIe6aX4Wk3c12X7JUojidXoVpzhbCIVhXmQgjH/JptHoqLlSu4VcJDhKbDuP
	 EQAh2cKTcZprNpCPZdvFmp66w+RAR6AWQeIPCGmG64SVUb9lFTbCVbNkKsoZr2Tl3S
	 a3iTsEVkdP1GS+/Z5Jmo2ovS62C57xujfx4rop6c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07506F802DC;
	Thu, 10 Sep 2020 12:18:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 611FAF802DF; Thu, 10 Sep 2020 12:18:04 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6942DF80264
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 12:17:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6942DF80264
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="xKyzkPao"
Received: by mail-wr1-x442.google.com with SMTP id t10so6095334wrv.1
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=22LyqQo6HEx0we5PVT6YvtjB0CtK+JfHvXfl6GB7W6M=;
 b=xKyzkPaoXGrnZ90y19H11Ynf+0/C89moDoqMnGvpgHj1SIoacvU3QQzuR018Oq9sh+
 JW8mnCIYkOd05NpgBvxxNqLIV4J9ewS5fXUKw8KUPuJ3G66f5qHg72Dho7OkPaSbIRIe
 TEE81/brWsk8O34vpIQzVyUaPecx5PqvcUTxdkSiKkFkHIAZYRoRmMz9CPdr0ctL49V+
 FIcC9cJzdn8tzzSAKe3Hd43vkqOYBA2zlKMg2/m1u4OEBri2Rs7JEnjwgJ609tonp/g0
 D/rc5eN+jzOBbKgHzr1HLaXLq1K1vKrOWyjjx84EY/5QVMqRTawwO4JFhCZlqcU6/jzA
 USzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=22LyqQo6HEx0we5PVT6YvtjB0CtK+JfHvXfl6GB7W6M=;
 b=Xv5nQc+hi7mk+kaEmFqLo41kDN0X2Xq86wYw+Z1s6z6e3t3VJgwFpE0Wx6EYphmd8B
 CZMefKvj41e7WDGddW6bjhMvSxCJZiTMln/TuBZoytGP9dcp272QmtxYOmeCMQvRNlrv
 ZUFAtQgWiooPVS/YM3qriMWu0DGurtRb6NzWliIKEWTuHDXdQNilGk9B5MNJ7hUvcB0w
 GTchf8u4ZRXKwineqxk9tzxTtAVhB2iZmtadGzgBJAiM7BuFg9ObniZjh1V2CGa8MwvP
 WTtibmSSyE/UxZEtC7FAtvOH5cz9yahvuV5ZIoU7M61e3KjAr4983NgJxRbQz/F0y7X2
 TPpQ==
X-Gm-Message-State: AOAM530iTFmFPjPbqNXU0o2qnczMCSp3Zuz8NA4XlQjBMU+7MXhD1jyh
 YP2JSfGUUKUp/PCcl06AH8+VMw==
X-Google-Smtp-Source: ABdhPJwJd5K3H3/eTtoVAVk6dGbaBDWu6Tr9yeLt4UaYVwe22Yc/Xp4m5H4bZhJNjBA3GfkgR2Rgwg==
X-Received: by 2002:adf:81c6:: with SMTP id 64mr8024531wra.176.1599733073707; 
 Thu, 10 Sep 2020 03:17:53 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id m4sm8851731wro.18.2020.09.10.03.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:17:53 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 5/8] ASoC: q6dsp: q6afe: add lpass hw voting support
Date: Thu, 10 Sep 2020 11:17:29 +0100
Message-Id: <20200910101732.23484-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
References: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 99 ++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h |  8 +++
 2 files changed, 107 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 2a8e3c3acb10..51c94dd9998d 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -43,6 +43,9 @@
 #define AFE_PARAM_ID_TDM_CONFIG	0x0001029D
 #define AFE_PARAM_ID_PORT_SLOT_MAPPING_CONFIG	0x00010297
 #define AFE_PARAM_ID_CODEC_DMA_CONFIG	0x000102B8
+#define AFE_CMD_REMOTE_LPASS_CORE_HW_VOTE_REQUEST	0x000100f4
+#define AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST   0x000100f5
+#define AFE_CMD_REMOTE_LPASS_CORE_HW_DEVOTE_REQUEST	0x000100f6
 
 /* I2S config specific */
 #define AFE_API_VERSION_I2S_CONFIG	0x1
@@ -545,6 +548,18 @@ struct q6afe_port {
 	struct list_head node;
 };
 
+struct afe_cmd_remote_lpass_core_hw_vote_request {
+        uint32_t  hw_block_id;
+        char client_name[8];
+} __packed;
+
+struct afe_cmd_remote_lpass_core_hw_devote_request {
+        uint32_t  hw_block_id;
+        uint32_t client_handle;
+} __packed;
+
+
+
 struct afe_port_map {
 	int port_id;
 	int token;
@@ -880,6 +895,11 @@ static int q6afe_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 		}
 	}
 		break;
+	case AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST:
+		afe->result.opcode = hdr->opcode;
+		afe->result.status = res->status;
+		wake_up(&afe->wait);
+		break;
 	default:
 		break;
 	}
@@ -1593,6 +1613,85 @@ void q6afe_port_put(struct q6afe_port *port)
 }
 EXPORT_SYMBOL_GPL(q6afe_port_put);
 
+int q6afe_unvote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
+			       uint32_t client_handle)
+{
+	struct q6afe *afe = dev_get_drvdata(dev->parent);
+	struct afe_cmd_remote_lpass_core_hw_devote_request *vote_cfg;
+	struct apr_pkt *pkt;
+	int ret = 0;
+	int pkt_size;
+	void *p;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*vote_cfg);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	vote_cfg = p + APR_HDR_SIZE;
+
+	pkt->hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					   APR_HDR_LEN(APR_HDR_SIZE),
+					   APR_PKT_VER);
+	pkt->hdr.pkt_size = pkt_size;
+	pkt->hdr.src_port = 0;
+	pkt->hdr.dest_port = 0;
+	pkt->hdr.token = hw_block_id;
+	pkt->hdr.opcode = AFE_CMD_REMOTE_LPASS_CORE_HW_DEVOTE_REQUEST;
+	vote_cfg->hw_block_id = hw_block_id;
+	vote_cfg->client_handle = client_handle;
+
+	ret = apr_send_pkt(afe->apr, pkt);
+	if (ret < 0)
+		dev_err(afe->dev, "AFE failed to unvote (%d)\n", hw_block_id);
+
+	kfree(pkt);
+	return ret;
+}
+EXPORT_SYMBOL(q6afe_unvote_lpass_core_hw);
+
+int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
+			     char *client_name, uint32_t *client_handle)
+{
+	struct q6afe *afe = dev_get_drvdata(dev->parent);
+	struct afe_cmd_remote_lpass_core_hw_vote_request *vote_cfg;
+	struct apr_pkt *pkt;
+	int ret = 0;
+	int pkt_size;
+	void *p;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*vote_cfg);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	vote_cfg = p + APR_HDR_SIZE;
+
+	pkt->hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					   APR_HDR_LEN(APR_HDR_SIZE),
+					   APR_PKT_VER);
+	pkt->hdr.pkt_size = pkt_size;
+	pkt->hdr.src_port = 0;
+	pkt->hdr.dest_port = 0;
+	pkt->hdr.token = hw_block_id;
+	pkt->hdr.opcode = AFE_CMD_REMOTE_LPASS_CORE_HW_VOTE_REQUEST;
+	vote_cfg->hw_block_id = hw_block_id;
+	strlcpy(vote_cfg->client_name, client_name,
+			sizeof(vote_cfg->client_name));
+
+	ret = afe_apr_send_pkt(afe, pkt, NULL,
+			       AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST);
+	if (ret)
+		dev_err(afe->dev, "AFE failed to vote (%d)\n", hw_block_id);
+
+
+	kfree(pkt);
+	return ret;
+}
+EXPORT_SYMBOL(q6afe_vote_lpass_core_hw);
+
 static int q6afe_probe(struct apr_device *adev)
 {
 	struct q6afe *afe;
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 1f7cbed9335d..93592670ef0b 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -133,6 +133,10 @@
 /* Clock ID for INT MCLK1 */
 #define Q6AFE_LPASS_CLK_ID_INT_MCLK_1                             0x306
 
+#define Q6AFE_LPASS_CORE_AVTIMER_BLOCK			0x2
+#define Q6AFE_LPASS_CORE_HW_MACRO_BLOCK			0x3
+#define Q6AFE_LPASS_CORE_HW_DCODEC_BLOCK		0x4
+
 /* Clock attribute for invalid use (reserved for internal usage) */
 #define Q6AFE_LPASS_CLK_ATTRIBUTE_INVALID		0x0
 /* Clock attribute for no couple case */
@@ -220,4 +224,8 @@ void q6afe_cdc_dma_port_prepare(struct q6afe_port *port,
 int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 			  int clk_src, int clk_root,
 			  unsigned int freq, int dir);
+int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
+			     char *client_name, uint32_t *client_handle);
+int q6afe_unvote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
+			       uint32_t client_handle);
 #endif /* __Q6AFE_H__ */
-- 
2.21.0

