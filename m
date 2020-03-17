Return-Path: <SRS0=KQif=5C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D7C10F29
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:42:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6269720663
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PGYPCcRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6269720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1C8917BE;
	Tue, 17 Mar 2020 17:42:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1C8917BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584463373;
	bh=y5f4nqtRFxwgWGMCr9FWtoB8NiBbdChnlN0H5eMshPg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PGYPCcRukpUwesHF2ZTRdn0i7qA2muQTUsph8ADdonTaftdUffWjFqvU7ynzPDgYp
	 sibdC025NOPo+Uv7AEwnhGyGJlKxS4Yuxa0wZtv2RyH2YcjdVunKzf1Q8mff3mIbGu
	 UUVM8DUAG9rHfZRvIUGYh78qKnsTZko5bMAJyUZM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6165DF802E3;
	Tue, 17 Mar 2020 17:36:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DA75F80256; Tue, 17 Mar 2020 17:34:44 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8B78F80217
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2020 17:34:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8B78F80217
IronPort-SDR: zBR+4wef257d1A+pBeJJW9Cu4/4RcuUtJfb5JrYjpdxmN8/Vk58THlGVM8v/nOdWciWzGKSrfi
 xLzO/4r3v4UQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 09:34:37 -0700
IronPort-SDR: HMVawEQNbBT8kacidLvo6qJzq9uhT5CITFLmPpD471IAH6Mfy74IQMhHTsZ3yTO0HxX8W0/iQV
 wfP2Xj7qSMew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; d="scan'208";a="244533251"
Received: from aavila-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
 by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:34 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 12/17] soundwire: cadence: enable NORMAL operation in
 cdns_init()
Date: Tue, 17 Mar 2020 11:33:24 -0500
Message-Id: <20200317163329.25501-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

Follow recommended programming sequences, this needs to be enabled
before the reset sequence.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 9afce1f32076..6adf41e3fdcf 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -842,11 +842,6 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 		     CDNS_MCP_CONTROL_HW_RST,
 		     CDNS_MCP_CONTROL_HW_RST);
 
-	/* enable bus operations with clock and data */
-	cdns_updatel(cdns, CDNS_MCP_CONFIG,
-		     CDNS_MCP_CONFIG_OP,
-		     CDNS_MCP_CONFIG_OP_NORMAL);
-
 	/* commit changes */
 	return cdns_config_update(cdns);
 }
@@ -1097,6 +1092,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	/* Configure mcp config */
 	val = cdns_readl(cdns, CDNS_MCP_CONFIG);
 
+	/* enable bus operations with clock and data */
+	val &= ~CDNS_MCP_CONFIG_OP;
+	val |= CDNS_MCP_CONFIG_OP_NORMAL;
+
 	/* Set cmd mode for Tx and Rx cmds */
 	val &= ~CDNS_MCP_CONFIG_CMD;
 
-- 
2.20.1

