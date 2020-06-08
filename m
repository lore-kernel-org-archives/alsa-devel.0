Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF63C433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:45:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C2C2074B
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XcPUGFj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C2C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08EB315E4;
	Mon,  8 Jun 2020 21:44:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08EB315E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591645520;
	bh=oXPLta8h6ke+n8/Dkm39sD8M8iu5cVfFoJiUlHtjGzg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XcPUGFj/2mu/hB95FF2qLpIlxrOy43tbaen6xyRfJNiUnW2fWvo6E5FegvMEkLcZM
	 73YKimIQ8U/mdXn5qZ4s822ekR+o7/kJjXiTlq4VxSXVMS/tjDuMBuUzre6OZ/JAj8
	 0xGarz+JMZ7VWbvPSroJp/XAK20IIQIgWCFok8+g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45F5EF80252;
	Mon,  8 Jun 2020 21:44:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B726BF80252; Mon,  8 Jun 2020 21:44:27 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7911F801EB
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 21:44:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7911F801EB
IronPort-SDR: d6m9+RU88Ohi47CYqnylRQpdChLdJkd9rBk2Upm7+dJVRl4t8Io1ax1F5Z2XB2LlSI7QTRDpNV
 KKOTa46bq/rw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2020 12:44:20 -0700
IronPort-SDR: 3G+K0ioGlBTeYapc9jtn0+Y/ecuqAC1R98HF+NAI+TO7SoR05jMj0QQrC8cZBZZVMnlG7pUQIW
 w9dyTVfXjqlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="305939476"
Received: from skarmaka-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.104.56])
 by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2020 12:44:20 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ASoC: Fix dailink checks for DPCM
Date: Mon,  8 Jun 2020 14:44:11 -0500
Message-Id: <20200608194415.4663-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

We've had a couple of changes that introduce regressions with the
multi-cpu DAI solutions, and while trying to fix them we found
additional inconsistencies that should also go to stable branches.

Bard Liao (1):
  ASoC: core: only convert non DPCM link to DPCM link

Pierre-Louis Bossart (3):
  ASoC: soc-pcm: dpcm: fix playback/capture checks
  ASoC: Intel: boards: replace capture_only by dpcm_capture
  ASoC: SOF: nocodec: conditionally set dpcm_capture/dpcm_playback flags

 sound/soc/intel/boards/glk_rt5682_max98357a.c |  2 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c  |  4 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c  |  2 +-
 .../intel/boards/kbl_rt5663_rt5514_max98927.c |  2 +-
 sound/soc/soc-core.c                          | 22 ++++++++--
 sound/soc/soc-pcm.c                           | 44 ++++++++++++++-----
 sound/soc/sof/nocodec.c                       |  6 ++-
 7 files changed, 62 insertions(+), 20 deletions(-)


base-commit: 8a9144c1cf523221b37dd3393827253c91fcbf54
-- 
2.20.1

