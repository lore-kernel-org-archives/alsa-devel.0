Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574CAC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 21:18:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C2F205CB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 21:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tIZ7UeJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C2F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C0231662;
	Fri, 15 May 2020 23:17:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C0231662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589577529;
	bh=Sos/JW/LvIAXJ5kLbN+8sdMq/9iDcR+trkVJ4BiwfEY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tIZ7UeJMJh95YMAWbFcoms1gMNA40SHS8cbb8YKqzNjDkNZIxzJ6qUxkSwmauew+E
	 L1rBatXaf77T6FBCoFwDPhAXYPdWigKKrFvykxw1ab77n16Kivie5EsvH78vfDcE63
	 /jN7JUJDNpc9am2nX5OSxu1f04l3vp1xGW8Xk/Sc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECD13F80291;
	Fri, 15 May 2020 23:16:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C37EF8027D; Fri, 15 May 2020 23:16:06 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF051F80255
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 23:15:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF051F80255
IronPort-SDR: 7zOoI8asPtOW1bHWarHfWR8LVcXDcSerVT/bk3z3W2Dabq+msONUGgePpyQeUfViSdnIaiKFaC
 A4bgFawApwTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 14:15:50 -0700
IronPort-SDR: KXCsgGR7HdDHAMPlDIm+PFrXk7jbiPyt7gBWASzbg+DpKM4nxrHvUaROdx6EUAgNK3VnD7t7s5
 fzN7aQvM3ODw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; d="scan'208";a="438454507"
Received: from btchambe-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.66.225])
 by orsmga005.jf.intel.com with ESMTP; 15 May 2020 14:15:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: codecs: rt1308-sdw: remove duplicate allocation
Date: Fri, 15 May 2020 16:15:31 -0500
Message-Id: <20200515211531.11416-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515211531.11416-1-pierre-louis.bossart@linux.intel.com>
References: <20200515211531.11416-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Shuming Fan <shumingf@realtek.com>
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

The .read_prop callback is supposed to be called by the SoundWire core
only. Calling it again from this driver results in an additional
memory allocation for no good reason.

Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Shuming Fan <shumingf@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/codecs/rt1308-sdw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index 91cc5a15c211..b0ba0d2acbdd 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -178,10 +178,6 @@ static int rt1308_io_init(struct device *dev, struct sdw_slave *slave)
 	if (rt1308->hw_init)
 		return 0;
 
-	ret = rt1308_read_prop(slave);
-	if (ret < 0)
-		goto _io_init_err_;
-
 	if (rt1308->first_hw_init) {
 		regcache_cache_only(rt1308->regmap, false);
 		regcache_cache_bypass(rt1308->regmap, true);
@@ -282,7 +278,6 @@ static int rt1308_io_init(struct device *dev, struct sdw_slave *slave)
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
 
-_io_init_err_:
 	return ret;
 }
 
-- 
2.20.1

