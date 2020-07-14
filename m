Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B71C433E5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:34:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602E8206E9
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cHa4teAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602E8206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D531E1676;
	Wed, 15 Jul 2020 11:33:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D531E1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594805686;
	bh=oeBMSoMG1meuq1o/isWHipsieJiZudJbzCX0qS6RLRs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cHa4teAtQRZb6pfhZIZ5uunnKIyrZoI4hTdVepFzw/Y4MR80xdhfjhldLP7yUrYVJ
	 t23tqjwQju2Th3OQBspcU16mUYp1LvFuR/JSywCrdz+n6oT4DNKW2Xe/z70shreOfL
	 sFcUovMnLfuuzlBvWZFaa4gYjo7NYctuu/x3Tq90=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CDE3F8027B;
	Wed, 15 Jul 2020 11:32:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF6D8F80217; Wed, 15 Jul 2020 11:32:18 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68C1EF8021D
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 11:32:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68C1EF8021D
IronPort-SDR: i0W17eW030w9nY2Rlk28HThGUecBdU73FOB5gba2q4jRj93IFbv6iXo7MK1YFK1CXlXfAk4BSg
 7ND4WnXr0rpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="137241507"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="137241507"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 02:32:08 -0700
IronPort-SDR: EtDtJlDPlYRIvJKIg68eUFrdOu7QMbSIatFBXmGn53ww/n7xu+OopTBBKPtm7jdA3AcPlsuqEC
 9qRoD13YJ1tA==
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="460006248"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 02:32:04 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/2] soundwire: sdw.h: fix indentation
Date: Wed, 15 Jul 2020 05:37:44 +0800
Message-Id: <20200714213744.24674-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
References: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
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

Not sure how this went undetected for years.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 6452bac957b3..76052f12c9f7 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -88,10 +88,10 @@ enum sdw_slave_status {
  * @SDW_CLK_POST_DEPREPARE: post clock stop de-prepare
  */
 enum sdw_clk_stop_type {
-	       SDW_CLK_PRE_PREPARE = 0,
-	       SDW_CLK_POST_PREPARE,
-	       SDW_CLK_PRE_DEPREPARE,
-	       SDW_CLK_POST_DEPREPARE,
+	SDW_CLK_PRE_PREPARE = 0,
+	SDW_CLK_POST_PREPARE,
+	SDW_CLK_PRE_DEPREPARE,
+	SDW_CLK_POST_DEPREPARE,
 };
 
 /**
-- 
2.17.1

