Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F33C00528
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 09:48:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB82DE0E;
	Fri,  4 Aug 2023 11:47:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB82DE0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691142489;
	bh=bRZp9Sm138v0puHOR94DyV2Lh7t900tW0FDrqn3j3Ok=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rQTKXqFe/iLnUyGgQu/aKCf1fSuz3nLZQOeMAKUQ0pPbS2Cvv4ymmS38/TBO/9H7M
	 nBG4ZWDK+atAtT+SwJl4CVOg9LaAO+XgdgNwHeixdkNh7vQWdVFvOa6RJaagTNScbx
	 Sdggh8UJ0BNoLbFz5sea65ZVohEzqJJFkspQhWjw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13296F805F7; Fri,  4 Aug 2023 11:44:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F1758F805FB;
	Fri,  4 Aug 2023 11:44:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B35DF8025A; Fri,  4 Aug 2023 10:54:31 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F0D0F8016D
	for <alsa-devel@alsa-project.org>; Fri,  4 Aug 2023 10:54:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F0D0F8016D
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RHKFh5RgszJrTY;
	Fri,  4 Aug 2023 16:51:36 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:54:21 +0800
From: GUO Zihua <guozihua@huawei.com>
To: <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>
CC: <alsa-devel@alsa-project.org>
Subject: [PATCH -next] ASoC: q6dsp: Make g_apm staic
Date: Fri, 4 Aug 2023 16:53:53 +0800
Message-ID: <20230804085353.1361-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-MailFrom: guozihua@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: KMLY5KEN436Q2BOCB4CE6I65QKQFZQ25
X-Message-ID-Hash: KMLY5KEN436Q2BOCB4CE6I65QKQFZQ25
X-Mailman-Approved-At: Fri, 04 Aug 2023 09:44:31 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KMLY5KEN436Q2BOCB4CE6I65QKQFZQ25/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

g_apm is not referred elsewhere, so make it static.

This resolves sparse warning:
  warning: symbol 'g_apm' was not declared. Should it be static?

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 5d44d07acd69..2a2a5bd98110 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -27,7 +27,7 @@ struct apm_graph_mgmt_cmd {
 
 #define APM_GRAPH_MGMT_PSIZE(p, n) ALIGN(struct_size(p, sub_graph_id_list, n), 8)
 
-struct q6apm *g_apm;
+static struct q6apm *g_apm;
 
 int q6apm_send_cmd_sync(struct q6apm *apm, struct gpr_pkt *pkt, uint32_t rsp_opcode)
 {
-- 
2.17.1

