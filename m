Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5BBC001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:47:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15FABE0F;
	Mon, 31 Jul 2023 23:46:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15FABE0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690840052;
	bh=Sl+JnvzvCZ2oRoZq5fmpGrYfOIUrPUnGbPnSvBgk4R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aYuxtRHlsk+/qZH2y8E8oHY27fqpOq+xb+u0V+ePdVg/WIXzobT4bLbHtKXu7xygI
	 tUtIQF1DvLXEpCElLGC0ShcKK4dh2v/goTBykNam+S8Pn2tVMSDlwFX2NHh7+8UFDO
	 bll4SgHct9IQusMOyv8K6HjJNGnJJ/+gCychhCfY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F02CF805F1; Mon, 31 Jul 2023 23:43:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F3C4F805FA;
	Mon, 31 Jul 2023 23:43:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D271CF80557; Mon, 31 Jul 2023 23:43:28 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F094F80567
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:43:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F094F80567
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XmXE2Dqj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839801; x=1722375801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sl+JnvzvCZ2oRoZq5fmpGrYfOIUrPUnGbPnSvBgk4R0=;
  b=XmXE2DqjqzyKaaho92d4aHZMSjK+9Z0K7CNhXPYtMRmeOqNfcb5+w6Ur
   LFUhbVuGEg8ytfeVH/V+S9NsT3hxt3Am/sWR2ND3FogvN659l9fB66wXK
   EvWZ0JSqQFBv/hIqsWbslv5paeoHUzQxae66LMHNXNm1EasRWNBjex8eX
   9kreWGRueYiYrsMK4raNJ8qiCjGWdj54t4E2Tkals1lFNUCpilbq9qX78
   5pFY2U14RN/z09cyhauGQaESa/31tNjMJSuNu81ZZKtziqz2dgij/lFgJ
   FBC9jLySEzJ7z3UwNeFJMXcK3ozdMrzg+ehInCI6JsG6diXqePDNWuKrz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435449784"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="435449784"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="763523555"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="763523555"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:16 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 14/23] ASoC: intel: sof_sdw: Constify parameter to
 find_codec_part_info
Date: Mon, 31 Jul 2023 16:42:48 -0500
Message-Id: <20230731214257.444605-15-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
References: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IUJMRV55TGEOBWCRMXZSBYT5YP4H5TE7
X-Message-ID-Hash: IUJMRV55TGEOBWCRMXZSBYT5YP4H5TE7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IUJMRV55TGEOBWCRMXZSBYT5YP4H5TE7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Charles Keepax <ckeepax@opensource.cirrus.com>

The address passed to find_codec_part_info should be const.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index d3222f40d798..fc67029b3a64 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -974,7 +974,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 	},
 };
 
-static inline int find_codec_info_part(u64 adr)
+static inline int find_codec_info_part(const u64 adr)
 {
 	unsigned int part_id, sdw_version;
 	int i;
-- 
2.39.2

