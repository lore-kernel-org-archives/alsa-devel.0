Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAB6C6FD1C
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Mar 2023 07:53:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAECAA4E;
	Wed, 22 Mar 2023 08:52:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAECAA4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679471612;
	bh=2Yt6LYXoDWi3uimSjNziXW0ZWf4Ke0+iOU4eFCk/5M4=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NnNXU9K59jG1b7yKiGRyj9qNwYa3Pn59Gs8fWaZC//GE8wF2AWHnjTTmuklPf5hIk
	 OJZv8XA+UnOfpiRfJkLqIcQvVEJRoANcmxTqFm7kJIzHNLuRY0c2HsyTFQmv6FJl0Q
	 4SEO9mJShlcnaBWVfRhzIAA9i863vPIfsge1NGZk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8709FF8052D;
	Wed, 22 Mar 2023 08:51:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5F29F802E8; Wed, 22 Mar 2023 08:50:34 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2F98EF8024E
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2023 08:50:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F98EF8024E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OO5+WN2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679471417; x=1711007417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Yt6LYXoDWi3uimSjNziXW0ZWf4Ke0+iOU4eFCk/5M4=;
  b=OO5+WN2BIvFbG+jCCL4c3kkqpLU8krYGZuvh+WJ5D/tGJV7AzkRgI0MC
   1+x+ifK3PMTGfJz1YE9rRMZQzWiKF48Ca7QYIrZnaZLL/ihDplVclVYdd
   VJHZDNZ7hXtvKQ2QoLwHHItK+4Wea5PdrhS35NgRfjHBR5UwhPf85EO1U
   y/V2lDSsjmVAW4Ke+WZjZdVqZpV9InmpzjomVNATps5Tk1PSBrcigCOUb
   ZsTA6uMyLXTTqsxUON8b4IvvbwPzoBPfirtuoWjDREQFM8Sl6IU7ajYVW
   ZEafDiJxzFyHTtPc3okJo1/sR5csmEGQw0UnkfJqffif8zj2Dfv5faeyE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="341507402"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400";
   d="scan'208";a="341507402"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 00:48:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="631893478"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400";
   d="scan'208";a="631893478"
Received: from gjantea-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.222.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 00:48:52 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 2/2] ASoC: Intel: sof_rt5682: Update BT offload config for MTL
 RVP
Date: Wed, 22 Mar 2023 09:49:16 +0200
Message-Id: <20230322074916.23225-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230322074916.23225-1-peter.ujfalusi@linux.intel.com>
References: <20230322074916.23225-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RF2XRMF6IQF45NKFWYOKOZLFLFPAVBPG
X-Message-ID-Hash: RF2XRMF6IQF45NKFWYOKOZLFLFPAVBPG
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 uday.m.bhat@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RF2XRMF6IQF45NKFWYOKOZLFLFPAVBPG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Uday M Bhat <uday.m.bhat@intel.com>

For MTL RVP, SSP2 is used for BT offload. This is enabled
in the sof_rt5682_quirk_table

Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index c1891ff00d65..8735519cf4ed 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -1122,7 +1122,9 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
 					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4)),
+					SOF_RT5682_NUM_HDMIDEV(4) |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	{
 		.name = "mtl_mx98360_rt5682",
-- 
2.40.0

