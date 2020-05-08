Return-Path: <SRS0=uvJZ=6W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51C6C38A2A
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 09:44:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3029B208CA
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 09:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ti0nH6PS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3029B208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 825761846;
	Fri,  8 May 2020 11:44:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 825761846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588931094;
	bh=gmQzogdZd8scWd5ZrKYSQ27dgV1JWn275EeLUDdB0pQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ti0nH6PSg4UJYDpKTp6yUpPUGh5z7yQ3vY7GHeC0BkWiFrV+cWruDeHe82SF8GbDt
	 rPuqwxxN+R9FeUVC5ZjshH/mKuCmecg4OFMAVKCjA6+l/sSqUrxsTPqOeUXrQf3ipQ
	 YIrWoW6mTLGu3t4G4YmPJ7zus0iUq88qpBsPeQcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3AA4F802A2;
	Fri,  8 May 2020 11:42:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04672F8025F; Fri,  8 May 2020 11:42:28 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4356F8023E;
 Fri,  8 May 2020 11:42:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4356F8023E
IronPort-SDR: 4FRzu/c4X9Eu+O6R4wt49j04QKQ4rDtKLjdOpWYr5mpuVkmU2v4C+7oGMNWugtc4thF+TXkiep
 sh/AJ2ELrvdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2020 02:42:16 -0700
IronPort-SDR: Hu5VMuhblxlC0wVNQ4b50Iwr5ZfAUENs8992xhbcfP892QLd2PYeiCPoTuStkogKeZRfJ7yaWr
 kjhnuNZ8Lalw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; d="scan'208";a="435619142"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO
 ubuntu.ger.corp.intel.com) ([10.249.34.170])
 by orsmga005.jf.intel.com with ESMTP; 08 May 2020 02:42:15 -0700
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/2] soundwire: intel: (cosmetic) remove multiple
 superfluous "else" statements
Date: Fri,  8 May 2020 02:30:46 +0200
Message-Id: <20200508003046.23162-3-guennadi.liakhovetski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508003046.23162-1-guennadi.liakhovetski@linux.intel.com>
References: <20200508003046.23162-1-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Vinod Koul <vkoul@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

No need for an "else" after a "return" statement. Remove multiple such
occurrences in Intel-specific code.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 8 ++++++--
 drivers/soundwire/intel_init.c     | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index ecd357d1..9ea8753 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -407,7 +407,9 @@ void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
 	if (nack) {
 		dev_err_ratelimited(cdns->dev, "Msg NACKed for Slave %d\n", msg->dev_num);
 		return SDW_CMD_FAIL;
-	} else if (no_ack) {
+	}
+
+	if (no_ack) {
 		dev_dbg_ratelimited(cdns->dev, "Msg ignored for Slave %d\n", msg->dev_num);
 		return SDW_CMD_IGNORED;
 	}
@@ -520,7 +522,9 @@ void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
 		dev_err_ratelimited(cdns->dev,
 				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
 		return SDW_CMD_FAIL;
-	} else if (no_ack) {
+	}
+
+	if (no_ack) {
 		dev_dbg_ratelimited(cdns->dev,
 				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
 		return SDW_CMD_IGNORED;
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 4b76940..d5d4279 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -86,7 +86,9 @@ static int sdw_intel_cleanup_pdev(struct sdw_intel_ctx *ctx)
 		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
 			count, SDW_MAX_LINKS);
 		return NULL;
-	} else if (!count) {
+	}
+
+	if (!count) {
 		dev_warn(&adev->dev, "No SoundWire links detected\n");
 		return NULL;
 	}
-- 
1.9.3

