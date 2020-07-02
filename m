Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86802C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:44:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0217D206E2
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lrvR6rMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0217D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90B1216CE;
	Thu,  2 Jul 2020 21:43:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90B1216CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593719074;
	bh=NUvo4pZDnta0T5jIADdwEdkBFlxfcECNkeXDZEX7QpY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lrvR6rMqZJwn0G/+atNWZPqc7TqpBIwaARq+DtC3jKkzA7i0bySiQP1docG7hsbxI
	 wdYHwk5HA22PQ6lnuoC7KKA+lU5BJvWw/rWymlYD82C++1iW36Xt2ytcJUGE3wT/TF
	 kBUTxGNNXIMnhbV1lDwNyVBeOqRHieQaHO3luWtA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77DB0F80332;
	Thu,  2 Jul 2020 21:37:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 905F2F80305; Thu,  2 Jul 2020 21:36:53 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7637F802DC
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 21:36:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7637F802DC
IronPort-SDR: jxxKXpAksTAXZjWUgryX9nniMK5AdrZQ419DkYp0Cspdygq3rf5l6qk0OSf03bagF3rgsNK1Pd
 VeRGml0pWeLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148549353"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="148549353"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:25 -0700
IronPort-SDR: Zc5a2KqLDweOhTA8anBGu6HDJpMITL2A2aL1Q+KQo+4d5iIm6vmh8dPuum987DK0K+hvTtXgQs
 pIwYptTRJv7Q==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="482116380"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:24 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 12/23] ALSA: firewire: fix kernel-doc
Date: Thu,  2 Jul 2020 14:35:53 -0500
Message-Id: <20200702193604.169059-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
References: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix W=1 warning. Remove excess function parameter from description

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/firewire/cmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index 14abbe7175b6..b596bec19774 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -293,7 +293,6 @@ static int pcr_set_check(struct cmp_connection *c, __be32 pcr)
 /**
  * cmp_connection_establish - establish a connection to the target
  * @c: the connection manager
- * @max_payload_bytes: the amount of data (including CIP headers) per packet
  *
  * This function establishes a point-to-point connection from the local
  * computer to the target by allocating isochronous resources (channel and
-- 
2.25.1

