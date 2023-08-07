Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D11C001DB
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Aug 2023 21:51:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3865829;
	Mon,  7 Aug 2023 23:50:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3865829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691445099;
	bh=L921PL8UiYU7hxjC0q1tgy4ObbIjMwjaeLQEnYT/oEE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Yh0VUqBXZUQJaBbK9phYIlWDiMIAkgZjvcsP+RJteuPKmuWx3FKHdMTQ6B8f9Rvgu
	 LD2F59Qw6POulwQAaDKiDQOPqlyaN03qvBDrIo+xYZbdeKECJ3cj2/4YpBMIPneg6X
	 5Z0kF3TCXS6kSEdpMcqqpC4OvOF95DEAMg/Tnzwc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0A98F8051E; Mon,  7 Aug 2023 23:50:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10CD6F80534;
	Mon,  7 Aug 2023 23:50:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77766F80087; Mon,  7 Aug 2023 23:50:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CC66DF80087
	for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2023 23:50:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC66DF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IzbCvxvA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691445014; x=1722981014;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L921PL8UiYU7hxjC0q1tgy4ObbIjMwjaeLQEnYT/oEE=;
  b=IzbCvxvA23YLCncZb+h2rlkp1tGdF6HZyByfKFXUKuRpGCfNMAp/u6Nr
   lEMRgbHDfOZRCnOmG6MSx7AqcCPmb0ekTeRtznOqC3CSVBzs6SRqULXRI
   xMgbI2UX+O+Uqsfw+eeO8g6NAqR+ZCdteAvtFbMNABwO7MJiOAokB96Eo
   hGLC+5rdyEN7Tb9FtIeCaVISXtpqAsfjIrxHiC7/EOQ03XbbrjnGyjqjq
   e9sTkO0B5fcM+GPpBXmNrvqrOG2QEkGkAgONeP/4mcqOzzaHy3DXkJZoc
   xr4dedMJW8wQCagRa/7MJlyj2SJiJwY6nhNo7VsMPdxkpn89bX5dclcn5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434505559"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200";
   d="scan'208";a="434505559"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 14:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200";
   d="scan'208";a="874470755"
Received: from mkabani-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.55.216])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 14:50:13 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] ASoC: Intel: sof_sdw: fix two settings
Date: Mon,  7 Aug 2023 16:49:58 -0500
Message-Id: <20230807215000.515846-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MYSUYWN3SBCXWWLDBC4HDQKT62GX2BH2
X-Message-ID-Hash: MYSUYWN3SBCXWWLDBC4HDQKT62GX2BH2
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

Fix button mapping for CS42L42 and jack detection for LunarLake RVP.

Pierre-Louis Bossart (1):
  ASoC: Intel: sof-sdw: update jack detection quirk for LunarLake RVP

jairaj-arava (1):
  ASoC: Intel: sof-sdw-cs42142: fix for codec button mapping

 sound/soc/intel/boards/sof_sdw.c         | 2 +-
 sound/soc/intel/boards/sof_sdw_cs42l42.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.39.2

