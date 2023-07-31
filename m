Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAD0C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:45:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56C4CAE8;
	Mon, 31 Jul 2023 23:44:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56C4CAE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690839915;
	bh=gtdv4nHdaOR2QJJXm5cXuuEj0CAvYWedkMd0SvGyKHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UbDDX7oHqMUBm5fqO+BBf2nxWG/hGPOPlvLiOR6Pans02XHWopv5s5GIZp6Pr8q2d
	 h+JybTc3lNZM/p5rLLQWdfvGR+1hWvU+g0I5K79siJPOs2/1DpWsi2PhaUiVI+kucd
	 5akidMPgTspdWTRD7Pk/QVqy5upS5sFuEPYjbQyU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13F05F8058C; Mon, 31 Jul 2023 23:43:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 09AA9F8057E;
	Mon, 31 Jul 2023 23:43:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4F69F80535; Mon, 31 Jul 2023 23:43:17 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 44D08F80153
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:43:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44D08F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lY0e/EXY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839795; x=1722375795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gtdv4nHdaOR2QJJXm5cXuuEj0CAvYWedkMd0SvGyKHw=;
  b=lY0e/EXYPAqJ+QCkjbCGlUlD+DBJmeZx/PVupvz5GjlhcDt/bgUKlviB
   vE5g0IAgXaCyumfg4eW45wvG8d4dp/sqYnCJTvQANQJWYj8UphSqbOo04
   m2isRcDPig3MxUlUBU1TnfCAV2zNt3kQ9sN4rNoC8FOu3W+rA73JNuAIx
   uGZ1py2GOmS5UvlgcpnaZOnc07tVplooER3wbyDBAChfkHdzJKJHWSaj4
   NNR1kJ7XU6wBGJLH7SF8dCJU1UGOTX2/0Zg7R3n9v3HH7Ij39BcQqCuOR
   pPQHN4ITkHOxgZSpQdF9sOlq/x/TZi7iWqqwmcSUTVcNOm7RM/xzkiJie
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435449740"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="435449740"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="763523528"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="763523528"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:09 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Uday M Bhat <uday.m.bhat@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Jairaj Arava <jairaj.arava@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 04/23] ASoC: Intel: sof_sdw: Update BT offload config for
 soundwire config
Date: Mon, 31 Jul 2023 16:42:38 -0500
Message-Id: <20230731214257.444605-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
References: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OI76WFOTPEGHIHJ3CJB33JFUUXTNDGN4
X-Message-ID-Hash: OI76WFOTPEGHIHJ3CJB33JFUUXTNDGN4
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OI76WFOTPEGHIHJ3CJB33JFUUXTNDGN4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Uday M Bhat <uday.m.bhat@intel.com>

For soundwire config, SSP1 is used for BT offload. This is enabled
in sof_sdw_quirk_table

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index dbee8c98ff01..b811446be4cd 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -467,7 +467,9 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Rex"),
 		},
-		.driver_data = (void *)(SOF_SDW_PCH_DMIC),
+		.driver_data = (void *)(SOF_SDW_PCH_DMIC |
+					SOF_BT_OFFLOAD_SSP(1) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	/* LunarLake devices */
 	{
-- 
2.39.2

