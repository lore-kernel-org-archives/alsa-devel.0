Return-Path: <SRS0=d1MO=G5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA44C433E6
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 08:55:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6598A229C4
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 08:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6598A229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6DDA17B4;
	Tue, 26 Jan 2021 09:54:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6DDA17B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611651333;
	bh=TM53jacq8KMw7KIz9tfKrpynhcsYRlnuli9d3/ECyEQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fwnIK2uvcNDbeVB6lFv5m4xAonbeOf51exhYnCnfZZAuBfCpfDFiGDYCNfjm9ZUpg
	 aBbf4SMOnrvwTgsM65AGQM5Sw8WgoCClgm+AZJenkG4mDorrzZZliETxK2Y8M0epvs
	 vdrSzZRMTzGLERW54nLUErwrlg9/gEOxDoNl2VbQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52104F80158;
	Tue, 26 Jan 2021 09:54:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DE7DF8015B; Tue, 26 Jan 2021 09:54:42 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 509DEF80130
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2021 09:54:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 509DEF80130
IronPort-SDR: wCeN2u9M/VwWJ7j3qI3oK3cGJPFsVjCSrrv3V7Oc47Z3Az9gQ+fOC8CrbkRJ+kwadrw0Ed5pfg
 ZIw/d19pCmZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="241399310"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="241399310"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 00:54:11 -0800
IronPort-SDR: iseolxOeUPLakWJlrVGuxEJHpxgCumdhgxeuF7ZK04+CDl8E6w9Cyj96ZY0E490LzV98g/h599
 MsUePUuQOQxw==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="577736823"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 00:54:08 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire: bus: add better dev_dbg to track complete() calls
Date: Tue, 26 Jan 2021 16:54:02 +0800
Message-Id: <20210126085402.4264-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

Add a dev_dbg() log for both enumeration and initialization completion
to better track suspend-resume issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Chao Song <chao.song@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6e1c988f3845..82df088c9333 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -784,7 +784,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 
 	if (status == SDW_SLAVE_UNATTACHED) {
 		dev_dbg(&slave->dev,
-			"%s: initializing completion for Slave %d\n",
+			"%s: initializing enumeration and init completion for Slave %d\n",
 			__func__, slave->dev_num);
 
 		init_completion(&slave->enumeration_complete);
@@ -793,7 +793,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
 		dev_dbg(&slave->dev,
-			"%s: signaling completion for Slave %d\n",
+			"%s: signaling enumeration completion for Slave %d\n",
 			__func__, slave->dev_num);
 
 		complete(&slave->enumeration_complete);
@@ -1758,8 +1758,13 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (ret)
 			dev_err(slave->bus->dev,
 				"Update Slave status failed:%d\n", ret);
-		if (attached_initializing)
+		if (attached_initializing) {
+			dev_dbg(&slave->dev,
+				"%s: signaling initialization completion for Slave %d\n",
+				__func__, slave->dev_num);
+
 			complete(&slave->initialization_complete);
+		}
 	}
 
 	return ret;
-- 
2.17.1

