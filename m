Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AB9C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 05:41:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B07239EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 05:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B07239EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33F0717A9;
	Fri, 15 Jan 2021 06:40:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33F0717A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610689267;
	bh=1K8fmc0B78xEJfY23lI3eofNPiXrmfQ1MaedJhmgXD8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g1tqVpzSieeOoTYUG/qDVRjBvb3tUAked0qBdoK+0rREqVd3xv7og96QIHEfZ+IwD
	 fg6UxWAM3zlOk+cUVPZilNCKzh948KUl5cr6MFyTgyEcC8cHvaMYHsF5XhUX1cqlca
	 FtluMzxQDAEPNecd87+JY8HRpeuDtkpTKLWPIIkI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23884F804E2;
	Fri, 15 Jan 2021 06:38:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41C56F8025F; Fri, 15 Jan 2021 06:37:58 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A102F8016D
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 06:37:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A102F8016D
IronPort-SDR: UHA5umxGOICX4mAV0Zwr7fN4R5NlBE6gYJlHnThoL16zLukMM2v7Sz8YF7NCdOyscBnXWPww7H
 TEmu9sWLgmdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="240046301"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="240046301"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 21:37:53 -0800
IronPort-SDR: 184qEtKU3MGXr7ct/YeK4whfi7YNr0pETtiitEaWzRPRDWp9xRgfpf1kvEcnaeh4fW1MxFJBXe
 FmSbOr3QwYgg==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="382542488"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 21:37:50 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 5/5] soundwire: cadence: adjust verbosity in response handling
Date: Fri, 15 Jan 2021 13:37:38 +0800
Message-Id: <20210115053738.22630-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
References: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org, jank@cadence.com,
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

There are too many logs on startup, e.g.

[ 8811.851497] cdns_fill_msg_resp: 2 callbacks suppressed
[ 8811.851497] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851498] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851499] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851499] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851500] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851500] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851502] intel-sdw intel-sdw.0: Msg ignored for Slave 0
[ 8811.851503] soundwire sdw-master-0: No more devices to enumerate

We can skip the 'Msg Ack not received' since it's typical of the
enumeration end, and conversely add the information on which command
fails.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d3c9cf920cbd..8d7166ffd4ad 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -483,11 +483,11 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
 	for (i = 0; i < count; i++) {
 		if (!(cdns->response_buf[i] & CDNS_MCP_RESP_ACK)) {
 			no_ack = 1;
-			dev_dbg_ratelimited(cdns->dev, "Msg Ack not received\n");
+			dev_vdbg(cdns->dev, "Msg Ack not received, cmd %d\n", i);
 		}
 		if (cdns->response_buf[i] & CDNS_MCP_RESP_NACK) {
 			nack = 1;
-			dev_err_ratelimited(cdns->dev, "Msg NACK received\n");
+			dev_err_ratelimited(cdns->dev, "Msg NACK received, cmd %d\n", i);
 		}
 	}
 
-- 
2.17.1

