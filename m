Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB5DC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 20:35:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF81564E7B
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 20:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF81564E7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74C591666;
	Thu,  4 Feb 2021 21:34:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74C591666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612470932;
	bh=rAG/PEWQ/b1czMvkia2b/Vv+MMqU9K9g7pjgzjs+kKE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dEdJxP52agdNywoDAtmcCtV6rNJbYesatX6HKVgTrS45FQjvf/3Ea5raO3WBRc+3l
	 kl3qiVGqP0jsUGEYYaoYGlFqxkob/gZ8wX8JwIaRLjWQrO2EfhgEUZTbLcd8hr5z3D
	 w3Tk/osE7oRhapifDPPWM8Bp1ATJ1/sHbkPNM80w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FE65F8023E;
	Thu,  4 Feb 2021 21:33:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 514EAF8025C; Thu,  4 Feb 2021 21:33:51 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 152AAF80171
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 21:33:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 152AAF80171
IronPort-SDR: jna88Hqv/UrPj0gSBW9Wr8NdDH2ccMoTo0I+GI44FSr3H1MHqzqMpGjO9DPhNu/yxuy2ossBbP
 CAr8WxN5QiXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181472446"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="181472446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 12:33:41 -0800
IronPort-SDR: ALycqpE+OFeUntS0a7os18ZM9fD0QT95vlr0n6g1WETUViNZw9AS9b8NedOhBFZxF07iKpxcV8
 XPVQTfDN9VEg==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="483700293"
Received: from jdasilva-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.66.22])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 12:33:39 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 02/14] ASoC: Intel: sof_sdw: add missing TGL_HDMI quirk for
 Dell SKU 0A5E
Date: Thu,  4 Feb 2021 14:33:00 -0600
Message-Id: <20210204203312.27112-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204203312.27112-1-pierre-louis.bossart@linux.intel.com>
References: <20210204203312.27112-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>,
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

We missed adding the TGL_HDMI quirk which is very much needed to
expose the 4 display pipelines and will be required on TGL topologies.

Fixes: 9ad9bc59dde10 ('ASoC: Intel: sof_sdw: set proper flags for Dell TGL-H SKU 0A5E')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index aece6ba9a846..e79b0bad44f3 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -74,7 +74,8 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0A5E")
 		},
-		.driver_data = (void *)(SOF_RT711_JD_SRC_JD2 |
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					SOF_RT711_JD_SRC_JD2 |
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_FOUR_SPK),
 	},
-- 
2.25.1

