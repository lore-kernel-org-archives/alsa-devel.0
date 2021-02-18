Return-Path: <SRS0=3Kie=HU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1385C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 22:33:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BC764EB9
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 22:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BC764EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE99B1664;
	Thu, 18 Feb 2021 23:32:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE99B1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613687594;
	bh=6Db/0RdXKSj9Z+sYc2K5yVd4xbWx9rAv6DRk+fvIp7E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LL6AyQ+9PQvwRe8oKMgDY9Sdbqolde5IBXAnkl55Phm/1Aqdx2yiRRTqv/aStL1mB
	 LVMkYZshc6amka+MSz0NpgbnMvGA+HOgOhfeUMvVLRir8TQ806rx0WwOoL0OU44+ig
	 9SsJv72JBkmb4aLO1nnVkOHeK2HMAlP/LJMYhz/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19E92F802E0;
	Thu, 18 Feb 2021 23:30:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FD9FF800D0; Thu, 18 Feb 2021 23:29:58 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13026F8016E
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2021 23:29:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13026F8016E
IronPort-SDR: Fq9YDUk3TTJEdBlPqUrfeAojS0Vi1Nq8GJWOV12BZifJ8Apj3SkvXelF/rXGM+rau9ricpZMRQ
 TczeWAXRfHRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="182875623"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="182875623"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 14:29:38 -0800
IronPort-SDR: CtYywkyx0CCoT5fWDfXq4w4I+OYnGKRzzSBuLY4HKWXHl3qpxqLTT4SVSK7y3xMIuWMPYfrEPB
 0qNWmJPD65tA==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="364990836"
Received: from tphilli1-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.64.38])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 14:29:37 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/10] ASoC: qcom: q6afe: remove useless assignments
Date: Thu, 18 Feb 2021 16:29:10 -0600
Message-Id: <20210218222916.89809-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218222916.89809-1-pierre-louis.bossart@linux.intel.com>
References: <20210218222916.89809-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

cppcheck warnings:

sound/soc/qcom/qdsp6/q6afe.c:848:25: note: Assignment 'p=NULL',
assigned value is 0
 struct q6afe_port *p = NULL;
                        ^
sound/soc/qcom/qdsp6/q6afe.c:854:7: note: Null pointer dereference
  if (p->token == token) {
      ^
sound/soc/qcom/qdsp6/q6afe.c:939:8: style: Redundant initialization
for 'wait'. The initialized value is overwritten before it is
read. [redundantInitialization]
  wait = &port->wait;
       ^
sound/soc/qcom/qdsp6/q6afe.c:933:26: note: wait is initialized
 wait_queue_head_t *wait = &port->wait;
                         ^
sound/soc/qcom/qdsp6/q6afe.c:939:8: note: wait is overwritten
  wait = &port->wait;
       ^
sound/soc/qcom/qdsp6/q6afe.c:1191:10: style: Redundant initialization
for 'port_id'. The initialized value is overwritten before it is
read. [redundantInitialization]
 port_id = port->id;
         ^
sound/soc/qcom/qdsp6/q6afe.c:1186:14: note: port_id is initialized
 int port_id = port->id;
             ^
sound/soc/qcom/qdsp6/q6afe.c:1191:10: note: port_id is overwritten
 port_id = port->id;
         ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/qcom/qdsp6/q6afe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index daa58b5f941e..60061d654946 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -845,7 +845,7 @@ static void q6afe_port_free(struct kref *ref)
 
 static struct q6afe_port *q6afe_find_port(struct q6afe *afe, int token)
 {
-	struct q6afe_port *p = NULL;
+	struct q6afe_port *p;
 	struct q6afe_port *ret = NULL;
 	unsigned long flags;
 
@@ -930,7 +930,7 @@ EXPORT_SYMBOL_GPL(q6afe_get_port_id);
 static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 			    struct q6afe_port *port, uint32_t rsp_opcode)
 {
-	wait_queue_head_t *wait = &port->wait;
+	wait_queue_head_t *wait;
 	struct aprv2_ibasic_rsp_result_t *result;
 	int ret;
 
@@ -1188,7 +1188,6 @@ int q6afe_port_stop(struct q6afe_port *port)
 	int index, pkt_size;
 	void *p;
 
-	port_id = port->id;
 	index = port->token;
 	if (index < 0 || index >= AFE_PORT_MAX) {
 		dev_err(afe->dev, "AFE port index[%d] invalid!\n", index);
-- 
2.25.1

