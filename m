Return-Path: <SRS0=k679=GR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6FBC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 14:22:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E7223A69
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 14:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E7223A69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5552016B9;
	Thu, 14 Jan 2021 15:21:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5552016B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610634136;
	bh=HShoehtCTBiiZ6qTviYVn2Zmjj59U0YuJpMMgRngDo8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G8oTN2FKDbNBWDBaxO6+aVk8APEw0zMUf9vRK86CteyfnPvpxirB3LyusYyLGsVf2
	 YFJ1YCdcXDtKqkEs8WM7+CGIUrHE3nsHNa3S9lkWt1Zk0mH9yMyO6e5oO0B0mtRzHB
	 I838Nz3w/EHFULyV0VWKGmxtkEtx7Z9q51UGQhlc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB311F8026F;
	Thu, 14 Jan 2021 15:21:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E4C9F80113; Thu, 14 Jan 2021 15:21:23 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74C25F80113
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2021 15:21:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74C25F80113
IronPort-SDR: ME0dZtZcop2uVgkW392Dv6pYtlBme60H8E8hZdBRDPpi8AtBHG0Jp8SQC6/cuUxAkSs2AhyRxe
 O1uvSsFf7m3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="175792507"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="175792507"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 06:21:16 -0800
IronPort-SDR: wDqvSWqzX19vCWjxB/Gy4sCkxhL1zXi584PNq+3AS90TLbNyaAqWaDWugJIMTqh8K05ePFRin6
 ALreW3yplpEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="400912782"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by fmsmga002.fm.intel.com with ESMTP; 14 Jan 2021 06:21:14 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/2] Add sanity checks for topology API calls
Date: Thu, 14 Jan 2021 11:36:00 -0500
Message-Id: <20210114163602.911205-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
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

Topology API exposes just 2 function calls, to load and unload topology.
This adds sanity checks to make sure that it behaves well when some of
parameters are set incoorectly or not needed.

This makes developer live easier by failing early instead of proceeding
on and then failing in unexpected ways.

As loading and unloading topology usually happens one the overhead of
additional checks should be negligible.

Amadeusz Sławiński (2):
  ASoC: topology: Ensure that needed parameters are set
  ASoC: topology: Check if ops is set before dereference

 sound/soc/soc-topology.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.25.1

