Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41841C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 17:45:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8591161A2B
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 17:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8591161A2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B77E1655;
	Thu, 25 Mar 2021 18:44:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B77E1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616694298;
	bh=9Jhc4+tC+6MRcDCjwR+w7/5m3X+JZZKmTUuwHRCRHmE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qwlFTMj+/6Tbfwurra1RIgzxtZ+ONOp9mD15pM7phSXW02qB1YEzcRNufotIqu7sH
	 OVIiwHOkMvDSdyPFGWlekLJMwVUf38/D9HYkKfyvU3PMVR8t1gcRFTFYFsATJXyLxV
	 yb3KLNcUfG6Lh/q2XDAVkqdqLGe/yx0nkfY5Cpm8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 125F5F80103;
	Thu, 25 Mar 2021 18:44:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D93DFF80268; Thu, 25 Mar 2021 18:44:04 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 585FBF80103
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 18:43:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 585FBF80103
IronPort-SDR: khKFtwVi29oG4DjARigfiZ13lsXCkL3Foqe9V66ccXAw4rOypevzT2pTyDPy4SUCaxoNN6v0l4
 VCMfF85ufg9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="178107057"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; d="scan'208";a="178107057"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2021 10:43:56 -0700
IronPort-SDR: GDEemX4PUUOdcLYqFcHgAxGKc35LzD7G9bxt9SwgZSbbGlXlQ2ogyinc3DGWKT63R678wfM458
 Z0VidOETrEog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; d="scan'208";a="443481805"
Received: from snappy-s2600wt2r.iind.intel.com ([10.223.163.26])
 by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2021 10:43:53 -0700
From: vamshi.krishna.gopal@intel.com
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/2] kbl_da7219_max9357a machine changes for wov and MST
Date: Thu, 25 Mar 2021 23:13:23 +0530
Message-Id: <20210325174325.31802-1-vamshi.krishna.gopal@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: harshapriya.n@intel.com, mac.chiang@intel.com, broonie@kernel.org,
 sathya.prakash.m.r@intel.com, biernacki@google.com,
 vamshi.krishna.gopal@intel.com, pierre-louis.bossart@intel.com
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

From: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.corp-partner.google.com>

Hi all,

This patch series about creating dailink for Wake on voice functionality
and also adding MST route changes.

changes in v2
- Add MST route changes to kbl_da7219_max98927.c and
  kabl_rt5663_max98927.c
- typo corrected in struct skylaye_refcap_ops to skylake_refcap_ops
- Declare constraints_1600 struct and ch_mono variable

v1 is here:

https://patchwork.kernel.org/project/alsa-devel/cover/20210324175200.44922-1-vamshi.krishna.gopal@intel.com/

Mac Chiang (1):
  ASoc: Intel: board: add BE DAI link for WoV

Vamshi Krishna Gopal (1):
  ASoC: Intel: kbl: Add MST route change to kbl machine drivers

 sound/soc/intel/boards/kbl_da7219_max98357a.c | 57 ++++++++++++++++++-
 sound/soc/intel/boards/kbl_da7219_max98927.c  |  9 ++-
 sound/soc/intel/boards/kbl_rt5663_max98927.c  |  4 ++
 3 files changed, 64 insertions(+), 6 deletions(-)

-- 
2.17.1

