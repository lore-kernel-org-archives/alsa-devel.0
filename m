Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E57C433C1
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 09:19:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A9261A32
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 09:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A9261A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26C7B1616;
	Fri, 26 Mar 2021 10:19:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26C7B1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616750395;
	bh=1H4nQ1C+KCgx/pzrCZ1uGEwjzPO3fBrvNbkPIhcZyh0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XpZz+uk2gbl7//iwc1aYCSqM2DHqB2QgINk4xaVAEfNp2CPpFIGItXDa2G2K9JOHY
	 KTLk3hzVnFW8QRcjUonGtyHzNnY8YqDwpjViNWQWzRb6DCrJmAPafNEJkVAcx1U0dY
	 eRV3cFbGKBFPCSwEqdSCmqeJfXqayDUeg7xbM9Lc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21C54F804D9;
	Fri, 26 Mar 2021 10:16:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4876FF804B0; Fri, 26 Mar 2021 10:16:09 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 031F8F80482
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 10:15:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 031F8F80482
IronPort-SDR: NIPzA9cUnRA/WFnsw1jpcjF23dhln5NCIRzKcQHsp6jOCGwZIjKoUHm6ZM5z1Wd9pzvf1O4sAw
 SKHWRjkq+o3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="276249473"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; d="scan'208";a="276249473"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 02:15:58 -0700
IronPort-SDR: iInWLugpd8TQiJ71CewLQCbDFkO1T67b7+A16hZnVk871kk0gbDt09hxFqFgOlj9ZBBQPZK2Qi
 QDQTPI55bTRw==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; d="scan'208";a="416463239"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 02:15:55 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [RESEND PATCH 10/11] soundwire: stream: remove useless initialization
Date: Fri, 26 Mar 2021 17:15:13 +0800
Message-Id: <20210326091514.20751-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Cppcheck complains about possible null pointer dereferences, but it's
more like there are unnecessary initializations before walking
through a list.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 4915676c4ac2..6a682179cd05 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -261,7 +261,7 @@ static int sdw_program_master_port_params(struct sdw_bus *bus,
  */
 static int sdw_program_port_params(struct sdw_master_runtime *m_rt)
 {
-	struct sdw_slave_runtime *s_rt = NULL;
+	struct sdw_slave_runtime *s_rt;
 	struct sdw_bus *bus = m_rt->bus;
 	struct sdw_port_runtime *p_rt;
 	int ret = 0;
@@ -1470,7 +1470,7 @@ static void sdw_acquire_bus_lock(struct sdw_stream_runtime *stream)
  */
 static void sdw_release_bus_lock(struct sdw_stream_runtime *stream)
 {
-	struct sdw_master_runtime *m_rt = NULL;
+	struct sdw_master_runtime *m_rt;
 	struct sdw_bus *bus = NULL;
 
 	/* Iterate for all Master(s) in Master list */
-- 
2.17.1

