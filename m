Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA9FC433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 21:06:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B294206E2
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 21:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="psaXxT8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B294206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBC3615F9;
	Tue,  7 Jul 2020 23:05:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBC3615F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594155958;
	bh=qsIV51d68tQN2da3LG9BBfQVd9qh0X+R6XyyewU8nW8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=psaXxT8IUmnct8aEOYl14OOs9zEMWgbleTOx6/h80cTA417kNumDqkI8HistvGr5y
	 2Kn5EMm9o4PBIgLZPxJdAt7AdvTOsCvU0QfaapLjKlJCRq+0jeRc7pEPfz1/i/LMbH
	 9OF0Fc1PbmrB3xRVEXWfCij6asjyJgNkkIp6GJWM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1169AF80264;
	Tue,  7 Jul 2020 23:05:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 882B1F80264; Tue,  7 Jul 2020 23:05:02 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC031F800D0
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 23:04:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC031F800D0
IronPort-SDR: +mjC+1PWXpzchka5SBl4/9sWrebEfF8klAQ1K/mh7ID1lItdFqJewMueJ48gmXOj1Ce0UfyuQN
 qFA3nLZDVt6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127777240"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="127777240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 14:04:55 -0700
IronPort-SDR: PFNU4KThsT7hvYTCkHiuPzTO62HDeAGp+tBNFqtWLLJzIKVXrtqLg8bk7mNtVfka/2+9tzRG0L
 dLVCuaLffqjw==
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="483648058"
Received: from colvinch-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.3])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 14:04:55 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: more fixes for dpcm checks
Date: Tue,  7 Jul 2020 16:04:36 -0500
Message-Id: <20200707210439.115300-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

This is hopefully the last set of fixes to avoid probe errors due to
stricter checks of DAI capabilities introduced late in the 5.8 cycle.

Daniel Baluta (1):
  ASoC: SOF: imx: add min/max channels for SAI/ESAI on i.MX8/i.MX8M

Pierre-Louis Bossart (2):
  ASoC: soc-dai: set dai_link dpcm_ flags with a helper
  ASoC: Intel: bdw-rt5677: fix non BE conversion

 include/sound/soc-dai.h              |  1 +
 sound/soc/generic/audio-graph-card.c |  4 +--
 sound/soc/generic/simple-card.c      |  4 +--
 sound/soc/intel/boards/bdw-rt5677.c  |  1 +
 sound/soc/soc-dai.c                  | 38 ++++++++++++++++++++++++++++
 sound/soc/sof/imx/imx8.c             |  8 ++++++
 sound/soc/sof/imx/imx8m.c            |  8 ++++++
 7 files changed, 60 insertions(+), 4 deletions(-)


base-commit: a5911ac5790acaf98c929b826b3f7b4a438f9759
-- 
2.25.1

