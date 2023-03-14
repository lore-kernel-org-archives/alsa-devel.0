Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E523C61DA4
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Mar 2023 01:45:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED6C91419;
	Tue, 14 Mar 2023 02:44:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED6C91419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678758342;
	bh=az/KB86lRG095DZZ6RuZwSVMJqq3LS8MNxe03npvozo=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WsMy52xNMND8yEVkn+oJyomcsjYF2Kd0164Vl722JMOL2zSgs7p31UJYkypiyI5WU
	 MczfY4AhzFQ7zaZ4v4ZC+6m3O2DdDjIvOOjK/yve7e17XPnfER95WjrwxYf4S5OWft
	 Q/f9nrtEOb8FRu2He/niMdABJ1oz5oaIH87a+eLg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3612CF805B5;
	Tue, 14 Mar 2023 02:41:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D355BF80578; Tue, 14 Mar 2023 02:41:37 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 886FCF80557
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2023 02:41:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 886FCF80557
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ky69POpo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758091; x=1710294091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=az/KB86lRG095DZZ6RuZwSVMJqq3LS8MNxe03npvozo=;
  b=Ky69POpocCeqpGOryAqq9LJNYAbY8XE/10qhYvCQRsvyE3Sb6AX/rl9h
   DG29eswhHI7x7fScHMgDD+yFoC8zEzmPS9J2lnZTzozWuWjAXo6Xu7Iim
   2fmdy1MtHoj2IdnDPK7i6+Yfo5r9aR1Y7d3iau2VGfDmabu8v/Lfs+l3L
   LNYh2RhB7UqN2sPJqbFwKWsxdxblpXgukwjhMFJ5B+XJZXzRZ0hU3DTbX
   8gPZFZ4Oqb+/uSJgt/Bm9kvRx3fZL4x9Dr4nK9Z2Btjwsg0wUJdRXV9PA
   mHR8iUSxn5V+2NEc7+XCDT+ZlOdGFKNZn0yo9fx26UuQcyvyCC/gXzisv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949286"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400";
   d="scan'208";a="316949286"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 18:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327495"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400";
   d="scan'208";a="711327495"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 18:41:26 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 11/16] soundwire: cadence: remove CDNS_MCP_CONFIG_SSPMOD
Date: Tue, 14 Mar 2023 09:54:05 +0800
Message-Id: <20230314015410.487311-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SK7EUWNEXL4GSISAKK23RTNHEA4T5MWX
X-Message-ID-Hash: SK7EUWNEXL4GSISAKK23RTNHEA4T5MWX
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SK7EUWNEXL4GSISAKK23RTNHEA4T5MWX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This field is not used, and its definition is not aligned with the
hardware specification.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index e835dabb516c..4f34fc72dbd5 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -33,7 +33,6 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_MCP_CONFIG_MMASTER			BIT(7)
 #define CDNS_MCP_CONFIG_BUS_REL			BIT(6)
 #define CDNS_MCP_CONFIG_SNIFFER			BIT(5)
-#define CDNS_MCP_CONFIG_SSPMOD			BIT(4)
 #define CDNS_MCP_CONFIG_CMD			BIT(3)
 #define CDNS_MCP_CONFIG_OP			GENMASK(2, 0)
 #define CDNS_MCP_CONFIG_OP_NORMAL		0
-- 
2.25.1

