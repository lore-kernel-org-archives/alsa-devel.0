Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1DBC433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:50:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FD461423
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FD461423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A194C1729;
	Wed,  5 May 2021 18:49:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A194C1729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620233415;
	bh=jNOzGzbmDYckzrfj/aidoKSY4WQTBCQegsncZ1cxYNQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cjgQHLuLVWDfSz5hTMb0vlbbtS/ND0XoBgT1rim6BNNbuF+0iJ6Ni0dv3ItiarO+R
	 9ylaCkxmrwwypVVa1DLne623+Y0e2keb12PpkgKITwIM5nJcgY3N6AW6lIakj90yYY
	 vT/cxKpZ6RcpY5c2Oq2cO69jbDZGg6O2W+mPUYUk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D374FF80516;
	Wed,  5 May 2021 18:37:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89644F805BB; Wed,  5 May 2021 18:37:39 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2532AF805B0
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:37:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2532AF805B0
IronPort-SDR: Jbh0qmnLS/NNjjW03Kiy2qJPmElW58+KjXHrG7TRviA/SS4+cbmdb1O6CqIvNCSsfKhvPiYEy9
 qe8Po0C5cGeQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="196219201"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="196219201"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 09:37:26 -0700
IronPort-SDR: 8UrTlVpU0lGUO8g+TK8JW60CukkKmOMpevVkAvEN2TM63ygznYkncuUKXyqhdojUzbL0bFT4J2
 CswMvR6VvxtA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="458800048"
Received: from rtsagpan-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.51.38])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 09:37:25 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 10/13] ASoC: Intel: sof_sdw: add SOF_RT715_DAI_ID_FIX for
 AlderLake
Date: Wed,  5 May 2021 11:37:02 -0500
Message-Id: <20210505163705.305616-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505163705.305616-1-pierre-louis.bossart@linux.intel.com>
References: <20210505163705.305616-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

From: Libin Yang <libin.yang@intel.com>

AlderLake needs the flag SOF_RT715_DAI_ID_FIX if it is using the
rt715 DMIC.

Reviewed-by: Bard Liao <bard.liao@intel.com>
Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 608ae3c93aae..0f1ad9e0a53b 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -198,6 +198,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOF_RT711_JD_SRC_JD1 |
 					SOF_SDW_TGL_HDMI |
+					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_PCH_DMIC),
 	},
 	{}
-- 
2.25.1

