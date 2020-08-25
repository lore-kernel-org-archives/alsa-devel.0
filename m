Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718F6C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:19:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F256F20706
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F6v9SBBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F256F20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B2EB1685;
	Tue, 25 Aug 2020 19:18:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B2EB1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598375966;
	bh=SeSlhNaCmHA3at3IcAizzM0ydyofnu+QkVTd/w7k+/w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F6v9SBBMduv6OKYpjfewfkbMNVWOXT+z0FqTcjBj6/Qdz7PTspXIVwvZVmQmnSDPl
	 retahyezabudbMNj/g6/b2jSm95oPOWI5RA59m/mup9/oydoOxt0VDULZMg6uKWVHn
	 /oXEbyZizRHZn5ZDa4neQHUbtJd74L1Okd40oWT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47556F80260;
	Tue, 25 Aug 2020 19:17:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5D16F80260; Tue, 25 Aug 2020 19:17:46 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD788F800EB
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 19:17:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD788F800EB
IronPort-SDR: J7e39gTxisAQDkBGDGjxtc6L5BA7F0Q5+pX5glyxabqTQi5+fxbkkmMhu5f7D9hKpb09BM+x0k
 /9jJg4TFsPew==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="135708957"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; d="scan'208";a="135708957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 10:17:13 -0700
IronPort-SDR: d3NZa9SV0Erea1YTulYBLN0sGbqCPfb1OHXJZ1polaNzEvInVIOYHnBaL3ccwUU0BvnRDoH1cA
 zd5liRfe9T7A==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; d="scan'208";a="331478421"
Received: from bgarring-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.4.243])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 10:17:12 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
Date: Tue, 25 Aug 2020 12:16:53 -0500
Message-Id: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
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

-ENOTSUPP is not a valid error code, use recommended value instead.

Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 50a66382d87d..89d3856f5890 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -40,14 +40,14 @@ static int regmap_sdw_config_check(const struct regmap_config *config)
 {
 	/* All register are 8-bits wide as per MIPI Soundwire 1.0 Spec */
 	if (config->val_bits != 8)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* Registers are 32 bits wide */
 	if (config->reg_bits != 32)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (config->pad_bits != 0)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	return 0;
 }
-- 
2.25.1

