Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE0DC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 17:54:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E9C61992
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 17:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E9C61992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD7E21677;
	Wed, 24 Mar 2021 18:53:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD7E21677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616608436;
	bh=NnEWOf9qCKbcbowb8H8RKumWYw9+Lh2Tl+dPTDRfQVc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LITHlxOVJnJLcvRBvS+RlR6/XrmOnHtQ/K9QVESyoW0knwAmJFyU57KPr32O3wBnX
	 Low1dkvmp/VC+JqimWegJlZWoxAWo2uTtAtQ4gpFkM20eK0QFVftIq1YMDhmCFOo97
	 rROsFuYbCff/QOjpNdxBhuadYZfQ07duBCRT9hcU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FCE4F80156;
	Wed, 24 Mar 2021 18:52:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4181F80246; Wed, 24 Mar 2021 18:52:42 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73DCEF801EB
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 18:52:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73DCEF801EB
IronPort-SDR: 6ZsM3o8q8SurWIb/CdYNIncZPmNbrhlggMxo9fKwK43sJV2zA4nQnbp9Bqt5vNE0ZuH8OusGal
 wZMpghbD+8YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="187452407"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="187452407"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 10:52:30 -0700
IronPort-SDR: m40P9ZePExqvcf0euw5ghvx/n2IrVZZcrZx2i39+FzAAyZYmVNMKu17xd0HeUk8tqeOdP8aGsr
 d2UcdPrLIN1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="442344358"
Received: from snappy-s2600wt2r.iind.intel.com ([10.223.163.26])
 by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2021 10:52:28 -0700
From: vamshi.krishna.gopal@intel.com
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] kbl_da7219_max9357a machine changes for wov and MST
Date: Wed, 24 Mar 2021 23:21:58 +0530
Message-Id: <20210324175200.44922-1-vamshi.krishna.gopal@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: harshapriya.n@intel.com, broonie@kernel.org, sathya.prakash.m.r@intel.com,
 biernacki@google.com, vamshi.krishna.gopal@intel.com,
 pierre-louis.bossart@intel.com
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

From: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>

Hello,

This patch series about creating dailink for Wake on voice functionality
and also adding MST route changes

Mac Chiang (1):
  ASoc: Intel: board: add BE DAI link for WoV

Vamshi Krishna Gopal (1):
  ASoC: Intel: kbl: Add MST route change to kbl machine drivers

 sound/soc/intel/boards/kbl_da7219_max98357a.c | 42 +++++++++++++++++--
 1 file changed, 38 insertions(+), 4 deletions(-)

-- 
2.17.1

