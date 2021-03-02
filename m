Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75063C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 09:17:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD43B64EDC
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 09:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD43B64EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B91B16F9;
	Tue,  2 Mar 2021 10:16:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B91B16F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614676656;
	bh=qy7P0OkoBjaW3fZTzKuC2rNuTauOSJIsqOmc8Cb1qD8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NUzkqwKHymOq27jpz/bnAWr285ayr/H/2K2xn3UnGW6Q05eKlEFnMugE9ZXmg92rk
	 mwWRFpLbWI5TxVkr5Oqmd21R5caNheQhTNzhd4eQazxS0ETH6Ga5WAiIR/ZYSwpP1o
	 gF3MmKTZe9idqcIO+yxyfviohRGQlFBxJ81cqqAs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AA8EF804FC;
	Tue,  2 Mar 2021 10:12:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80E43F804E4; Tue,  2 Mar 2021 10:12:06 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7738AF804A9
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 10:11:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7738AF804A9
IronPort-SDR: brk3AI15X91n7e/8AbRbUSzeBn8pJjOV6FW5FkKQnwNXA46mkxqKImmxpRLR1Xagbxfgt/hTyq
 MOAeVLvZt/6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="248158778"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="248158778"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 01:11:56 -0800
IronPort-SDR: oDirdZU3EahyWGLqbqxPVosY94AhfErhawu+/+n/TR9Tic2lGXLLsU2PLjHCIQoMgw73oE8/1v
 s+0oxkWNujcA==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="506262337"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 01:11:55 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH 11/11] soundwire: stream: remove useless bus initializations
Date: Tue,  2 Mar 2021 17:11:22 +0800
Message-Id: <20210302091122.13952-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302091122.13952-1-yung-chuan.liao@linux.intel.com>
References: <20210302091122.13952-1-yung-chuan.liao@linux.intel.com>
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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

There is no need to assign a pointer to NULL if it's only used in a
loop and assigned within that loop.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 71af14ae9c30..edad016c79e0 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1449,7 +1449,7 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 static void sdw_acquire_bus_lock(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
-	struct sdw_bus *bus = NULL;
+	struct sdw_bus *bus;
 
 	/* Iterate for all Master(s) in Master list */
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
@@ -1471,7 +1471,7 @@ static void sdw_acquire_bus_lock(struct sdw_stream_runtime *stream)
 static void sdw_release_bus_lock(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
-	struct sdw_bus *bus = NULL;
+	struct sdw_bus *bus;
 
 	/* Iterate for all Master(s) in Master list */
 	list_for_each_entry_reverse(m_rt, &stream->master_list, stream_node) {
-- 
2.17.1

