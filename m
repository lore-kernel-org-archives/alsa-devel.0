Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A114BC001DB
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Aug 2023 21:52:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F399845;
	Mon,  7 Aug 2023 23:51:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F399845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691445122;
	bh=SCbd4gzEtA0QmN7CUNPAY/z2LKhm20XUhaFWuFOlVHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fB6bntO+97rFjm1xsoGtO7tVOP5zd5gj+SBcsORdYyVL9eSlBiN+XOs0752XTniC7
	 HVb1KMFKAIH2kvs5+DXcLpmemyB0SjVnKQVlmDivBRkPLYGKmuQ5r3n/lRt9H8YYrO
	 G3DVW2NRfY0lRXhwaLun0NDEV+pk/B8zuLbpfP8U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5C53F80534; Mon,  7 Aug 2023 23:50:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24213F80551;
	Mon,  7 Aug 2023 23:50:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CCEACF8016D; Mon,  7 Aug 2023 23:50:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C7C5EF80116
	for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2023 23:50:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7C5EF80116
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Nr5yqmbh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691445016; x=1722981016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCbd4gzEtA0QmN7CUNPAY/z2LKhm20XUhaFWuFOlVHg=;
  b=Nr5yqmbh/ew+qNo6A/ajUrUPnCmbwcodbfDtBQNYFwt85RyD3L0ivUVm
   yQet4vYDrjSnM42NFgtp/3Uwy8f9m3Hgv0mpxleXHjXGSsADvPyxHLu08
   gVrumghA6AaEj+lGd5b3t9cJDyI+3oE8o6xkTgkprimTwHDG+Dpp74MwP
   4KhEEDuW4f/yXVOQOyFPwbIAepJr5d1IjNBcI5F3392Vu/6k3px24ZzIU
   //d2mSiKJ5jI+19FNshAqTZdHGiWYgNPvrQ7e7voyH9Hka7UkvDcHjxOu
   f2Gaf3oYlEcufD0J99Ns8nTqwaKDMzrGIG+s+ZwOT6pAqJ8C8uw8sobme
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434505567"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200";
   d="scan'208";a="434505567"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 14:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200";
   d="scan'208";a="874470770"
Received: from mkabani-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.55.216])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 14:50:14 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: sof-sdw: update jack detection quirk for
 LunarLake RVP
Date: Mon,  7 Aug 2023 16:50:00 -0500
Message-Id: <20230807215000.515846-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807215000.515846-1-pierre-louis.bossart@linux.intel.com>
References: <20230807215000.515846-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Z2JZPLM57HYJXRAG33ZSIWLOPCTH4HDK
X-Message-ID-Hash: Z2JZPLM57HYJXRAG33ZSIWLOPCTH4HDK
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Experimental results show that the headset is only detected with the
JD2 quirk.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index f283c0d528df..5a1c750e6ae6 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -488,7 +488,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lunar Lake Client Platform"),
 		},
-		.driver_data = (void *)(RT711_JD2_100K),
+		.driver_data = (void *)(RT711_JD2),
 	},
 	{}
 };
-- 
2.39.2

