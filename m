Return-Path: <SRS0=UYyO=JC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1760C433ED
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Apr 2021 12:50:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFEF61396
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Apr 2021 12:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFEF61396
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8AB816DC;
	Mon,  5 Apr 2021 14:49:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8AB816DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617627007;
	bh=Es7AiRWUC358x2UBP900e+IroLJIgKKKlkIv0F9xLB0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FZxF0vJgcHPNklZi7oMjB/xlBZds51YPqi43FywQmklRoIGP5b/bA/gW2pyEhZi41
	 MEclO/qVF1cGl776vCgtg5dgH4zDLP+mCnNOEKhZmZfmUhbQiKxYoZyB1p4q/aUkbA
	 ZOE4ye57ILZblKN/mqRa0WHplsT2w4b2BcyBTpdM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EC58F8016D;
	Mon,  5 Apr 2021 14:49:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C380F8003A; Mon,  5 Apr 2021 14:49:16 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81EB0F8003A
 for <alsa-devel@alsa-project.org>; Mon,  5 Apr 2021 14:49:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81EB0F8003A
IronPort-SDR: PSjJ1luKiYhz6MQzG50ov/6tEIjvfnOelvSpqov37Y1sPRtqFUFSSPj+MxnwFyCFYjWahD4alp
 EBgqmoAxPTvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9944"; a="278081137"
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; d="scan'208";a="278081137"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 05:49:08 -0700
IronPort-SDR: 70hCiO8PwFRfX/MTWGeOw/L7cGvOb5FB/qQqENcR5mhrfilNlvq7xETuI/I0l8utJb+q+kPczn
 3aw3fCmhlZ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; d="scan'208";a="414280072"
Received: from snappy-s2600wt2r.iind.intel.com ([10.223.163.26])
 by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2021 05:49:06 -0700
From: vamshi.krishna.gopal@intel.com
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 0/2] kbl_da7219_max9357a machine changes for wov and MST
Date: Mon,  5 Apr 2021 18:18:33 +0530
Message-Id: <20210405124835.71247-1-vamshi.krishna.gopal@intel.com>
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

changes in v3:

-Remove DP from widgets
-Add MST support in other routing table for kbl_rt5663_max98927.c 

v2 is here:

https://patchwork.kernel.org/project/alsa-devel/cover/20210325174325.31802-1-vamshi.krishna.gopal@intel.com/

v1 is here:

https://patchwork.kernel.org/project/alsa-devel/cover/20210324175200.44922-1-vamshi.krishna.gopal@intel.com/


Mac Chiang (1):
  ASoc: Intel: board: add BE DAI link for WoV

Vamshi Krishna Gopal (1):
  ASoC: Intel: kbl: Add MST route change to kbl machine drivers

 sound/soc/intel/boards/kbl_da7219_max98357a.c | 58 +++++++++++++++++--
 sound/soc/intel/boards/kbl_da7219_max98927.c  | 10 ++--
 sound/soc/intel/boards/kbl_rt5663_max98927.c  | 14 +++--
 3 files changed, 70 insertions(+), 12 deletions(-)

-- 
2.17.1

