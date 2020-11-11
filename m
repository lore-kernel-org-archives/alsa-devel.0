Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D24C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 21:45:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2227520825
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 21:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rVGvVCxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2227520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 850D2178F;
	Wed, 11 Nov 2020 22:44:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 850D2178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605131144;
	bh=/fah4MreZydpVobV0t/Q9ymIZiJW/HDpEPxYsL2284s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rVGvVCxfzsB0nTVXlVHPBUFedKycyO0Poy/DpLX8gbstu7r3p5rc8Ar5AjXf5UR31
	 X3o6d4z9hqT19dgcunu2+J4GuG1bnqlFkwjb2xv6GB4gHcN9tuedJRQsFX5ET8/Pnr
	 mHTPmmSpEnt3WPiUqch+Dp2wVhX307Xiw7Qnn5hI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1A97F804CB;
	Wed, 11 Nov 2020 22:43:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91398F8025E; Wed, 11 Nov 2020 22:43:47 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57FEAF801F5
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 22:43:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57FEAF801F5
IronPort-SDR: C1DHJnBs0cjspMQf2/HBT80RZlC29OUKeOnWMG+xp5EPjhvGRYLnQXVMPDh/0dj3FvAv7AwEow
 JPY5QJgFZg9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="149495733"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; d="scan'208";a="149495733"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2020 13:43:34 -0800
IronPort-SDR: pBX9ZLo/Gkfao9G71OczxuFZeai1hDtt6U3EXumM5oQphEgh4clj4KDUHdoVJHVMTKyjYqiLoz
 q+8jvybor7Fw==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; d="scan'208";a="356808086"
Received: from cmurill1-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.130.147])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2020 13:43:34 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ASoC: codecs: max98373-sdw: align regmap use with other
 codecs
Date: Wed, 11 Nov 2020 15:43:18 -0600
Message-Id: <20201111214318.150529-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111214318.150529-1-pierre-louis.bossart@linux.intel.com>
References: <20201111214318.150529-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
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

It's not clear why this driver has an additional call to
regmap_mark_dirty(), remove to align with others.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/codecs/max98373-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index fa589d834f9a..ec2e79c57357 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -247,7 +247,7 @@ static __maybe_unused int max98373_suspend(struct device *dev)
 	struct max98373_priv *max98373 = dev_get_drvdata(dev);
 
 	regcache_cache_only(max98373->regmap, true);
-	regcache_mark_dirty(max98373->regmap);
+
 	return 0;
 }
 
-- 
2.25.1

