Return-Path: <SRS0=rOcL=HY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A9CC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 21:35:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBBA64EEC
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 21:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBBA64EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 715AC15E0;
	Mon, 22 Feb 2021 22:34:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 715AC15E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614029732;
	bh=Gz0BwCntzF6vNvO4TbpGkVfgNRPEr4+LN9e1iSF6W0M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bxV+PL7ssK4ApMsm3oKFmdLbQwmnmBX8vhgwLaqYJT7sXTDpZmhozCe2eOSSb8/SF
	 7xzVeWx/ffRE7y6u2hsvxF6Zcgq5y/IldJnFhgY+VfW+jhGVH/y0J2B8JWl9f//UYp
	 MSvifGT2yRzXZ1Yib7hinVbCotyigso3k48rxpIs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5DB0F802E0;
	Mon, 22 Feb 2021 22:33:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27591F802A9; Mon, 22 Feb 2021 22:33:37 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 783DFF8016C
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 22:33:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 783DFF8016C
IronPort-SDR: OP6hW2+fhTqBjCd2LYm9i9Rmnrr4uY1a7uS2flUI2QY1SK7AYM//ITQMRctbtsotBhF6LFq0+l
 Wb7LQeIGdPeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="171739983"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; d="scan'208";a="171739983"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 13:33:18 -0800
IronPort-SDR: enMOzcIk7TGJyQpdW91auGX7AIqsFlX59uA1h8I/BqB5NnFoeQP3sXFk4ZyVLyfNzM0kAAL/6j
 sQTAjPaVWsZA==
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; d="scan'208";a="423270693"
Received: from sspurohi-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.54.136])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 13:33:15 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/6] ASoC: samsung: remove cppcheck warnings
Date: Mon, 22 Feb 2021 15:33:00 -0600
Message-Id: <20210222213306.22654-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

No functional changes except for patch 3 and 4 where missing error
checks were added for consistency.

v2:
added Krzysztof Kozlowski's tags
added fix for first patch already merged as suggested by Krzysztof Kozlowski
moved variable to lower scope in patch6

Pierre-Louis Bossart (6):
  ASoC: samsung: tm2_wm5510: fix check of of_parse return value
  ASoC: samsung: i2s: remove unassigned variable
  ASoC: samsung: s3c24xx_simtec: add missing error check
  ASoC: samsung: smdk_wm8994: add missing return
  ASoC: samsung: snow: remove useless test
  ASoC: samsung: tm2_wm5510: remove shadowed variable

 sound/soc/samsung/i2s.c            | 3 +--
 sound/soc/samsung/s3c24xx_simtec.c | 5 +++++
 sound/soc/samsung/smdk_wm8994.c    | 1 +
 sound/soc/samsung/snow.c           | 5 +----
 sound/soc/samsung/tm2_wm5110.c     | 5 +++--
 5 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.25.1

