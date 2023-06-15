Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E28EB64D9
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jun 2023 12:01:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDEBF823;
	Thu, 15 Jun 2023 14:00:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDEBF823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686830477;
	bh=07Py/88uXuGrTPXE0ldtD2Dd7kBvzbKeAovLhM0xYIE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=iU4ITLZ+6MvKT7UrLoZYz+TRMAllcCpIfGi03CQESI/a7Hl60dT0Lbw/4/oaqEyYc
	 hBTACkWpiIPpB+/rhUhiSRJlTWAwP1ukk0ZTvS6aFfkLaDtQeWGEwzI7m7YCDdSCnM
	 uwDupAXPQCpFded3+L1tnAc7Nfw2oqT5HpQ3H1Nk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D698F80544; Thu, 15 Jun 2023 14:00:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70828F80533;
	Thu, 15 Jun 2023 14:00:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C556F80155; Thu, 15 Jun 2023 13:59:56 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A7D20F80093
	for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2023 13:59:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7D20F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LxAtJZW+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686830389; x=1718366389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=07Py/88uXuGrTPXE0ldtD2Dd7kBvzbKeAovLhM0xYIE=;
  b=LxAtJZW+aRy8c/VS+3VnpI4JBcgTHKkdUbteqmQCfk7s3CtMh1EqxaVc
   2dR6yPEkMTDEJAhI9ZO2N4Ui8OEhZpC0WB8vIFPQuUjMAQ9Z9+EcuHYQ2
   i3xcR7GC75h0pzIv27IAWRG9kx7mmLvrDFFR8FlTJvDBDcVcOzj4NlNX7
   GyJHjRd3osKVZCiu3W3GsVqenzjpHWW258jW4f6WWtx/E70+4Zzdv3K5B
   lJt118v2BpMwdVEOE926L7lKNZbrU3vy7LX2ZjVgxERcVE1X7T6AudX0f
   q8zI7HgcpX49G8OKyaKfOULu5a/5yGhdgZznKGKbjLMbVesKODpehUx2F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338517459"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400";
   d="scan'208";a="338517459"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 04:59:45 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="745505352"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400";
   d="scan'208";a="745505352"
Received: from macchian-builder.itwn.intel.com ([10.5.253.188])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 04:59:44 -0700
From: Mac Chiang <mac.chiang@intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	mac.chiang@intel.com
Subject: [PATCH] ASoC: Intel: sof_rt5682: reorder quirk table
Date: Thu, 15 Jun 2023 07:53:48 -0400
Message-Id: <20230615115349.21993-1-mac.chiang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PZMM5MWQTUPAXUQ3MYPLWABORPRREOJV
X-Message-ID-Hash: PZMM5MWQTUPAXUQ3MYPLWABORPRREOJV
X-MailFrom: mac.chiang@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PZMM5MWQTUPAXUQ3MYPLWABORPRREOJV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Terry Cheong <htcheong@chromium.org>

Reorder the entries in quirk table to group entries with same platform.

Signed-off-by: Terry Cheong <htcheong@chromium.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 52 ++++++++++++++---------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 86bbc1fea6ff..be34d7595537 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -981,14 +981,13 @@ static const struct platform_device_id board_ids[] = {
 		.name = "sof_rt5682",
 	},
 	{
-		.name = "tgl_mx98357_rt5682",
+		.name = "cml_rt1015_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_MCLK_24MHZ |
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
+					SOF_RT1015_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(1)),
 	},
 	{
 		.name = "jsl_rt5682_rt1015",
@@ -1000,33 +999,38 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(1)),
 	},
 	{
-		.name = "tgl_mx98373_rt5682",
+		.name = "jsl_rt5682_mx98360",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_MCLK_24MHZ |
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
-					SOF_MAX98373_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
+					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(1)),
 	},
 	{
-		.name = "jsl_rt5682_mx98360",
+		.name = "jsl_rt5682_rt1015p",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_MCLK_24MHZ |
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
-					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
+					SOF_RT1015P_SPEAKER_AMP_PRESENT |
 					SOF_RT5682_SSP_AMP(1)),
 	},
 	{
-		.name = "cml_rt1015_rt5682",
+		.name = "jsl_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_MCLK_24MHZ |
+					SOF_RT5682_SSP_CODEC(0)),
+	},
+	{
+		.name = "tgl_mx98357_rt5682",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT1015_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1)),
+					SOF_RT5682_SSP_AMP(1) |
+					SOF_RT5682_NUM_HDMIDEV(4) |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	{
 		.name = "tgl_rt1011_rt5682",
@@ -1040,13 +1044,15 @@ static const struct platform_device_id board_ids[] = {
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	{
-		.name = "jsl_rt5682_rt1015p",
+		.name = "tgl_mx98373_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_MCLK_24MHZ |
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT1015P_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1)),
+					SOF_MAX98373_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(1) |
+					SOF_RT5682_NUM_HDMIDEV(4) |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	{
 		.name = "adl_mx98373_rt5682",
@@ -1149,12 +1155,6 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(1) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
-	{
-		.name = "jsl_rt5682",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_MCLK_24MHZ |
-					SOF_RT5682_SSP_CODEC(0)),
-	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
-- 
2.20.1

