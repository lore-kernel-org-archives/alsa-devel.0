Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD1C4742C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 06:26:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808E82222E
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 06:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g0RBpqUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808E82222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA9D917A4;
	Mon, 16 Nov 2020 07:25:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA9D917A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605507972;
	bh=NS9k3jWjpi4xGCcKkI+4l7RXuKJVFT6ZiTpQPV/Akqw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g0RBpqUZk4tEl6b2PAXVr1Udn3kQKG9EdVD0c4TdSB9SkPRvo7PFeTRK+vKmj5AlT
	 TVi36AFYSzHrASqoGSjedOoR2uZjxEkL4H5Bju+YW2HStAsQM9ycYlPXHzgfZLpJiF
	 GJSIJY7wG8PDBE04+U2FPkix0rhg9WzwsSmLtm2s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C87AF8014A;
	Mon, 16 Nov 2020 07:25:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C40A9F8016C; Mon, 16 Nov 2020 07:25:19 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0590F8014A
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 07:25:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0590F8014A
IronPort-SDR: J/xPn+1D0e1aYEEhPjoXuZewCWMjJLLB4AqwBQhw6mM0uDFUDGMVip82A65qmRjpayLwOcQgz4
 elvbDwGqT4UQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="150555403"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; d="scan'208";a="150555403"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2020 22:25:11 -0800
IronPort-SDR: 3PcZawxPwP0VIiF3FlNYvPmcp5DEdKE550gfCIFIoX15RnmkM0SwSlwcII0RUMK+stjhbjR2e3
 NUtvoWf8Hh5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; d="scan'208";a="310297893"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2020 22:25:08 -0800
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] This patch series enables DMA mode on Intel Keem Bay
 platform
Date: Mon, 16 Nov 2020 14:19:00 +0800
Message-Id: <20201116061905.32431-1-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, vinod.koul@linux.intel.com,
 andriy.shevchenko@intel.com, tiwai@suse.com, jee.heng.sia@intel.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org, lars@metafoo.de
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

v1: Initial patch version, which contains fix for S24_LE format and also enable
    DMA mode on Intel Keembay platform

Michael Sit Wei Hong (5):
  ASoC: Intel: KMB: Fix S24_LE configuration
  dt-bindings: sound: intel, keembay-i2s: Add info for device to use DMA
  ASoC: soc-generic-dmaengine-pcm: Add custom prepare and submit
    function
  ASoC: dmaengine_pcm: expose functions to header file for custom
    functions
  ASoC: Intel: KMB: Enable DMA transfer mode

 .../bindings/sound/intel,keembay-i2s.yaml     |  14 ++
 include/sound/dmaengine_pcm.h                 |  21 ++
 sound/core/pcm_dmaengine.c                    |  46 ++--
 sound/soc/intel/Kconfig                       |   2 +
 sound/soc/intel/keembay/kmb_platform.c        | 208 ++++++++++++++++--
 sound/soc/intel/keembay/kmb_platform.h        |   9 +
 sound/soc/soc-generic-dmaengine-pcm.c         |   8 +-
 7 files changed, 270 insertions(+), 38 deletions(-)

-- 
2.17.1

