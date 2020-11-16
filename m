Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679DDC55ABD
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 06:23:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932792227F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 06:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Aa6TFugY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932792227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C70021741;
	Mon, 16 Nov 2020 07:22:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C70021741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605507784;
	bh=NS9k3jWjpi4xGCcKkI+4l7RXuKJVFT6ZiTpQPV/Akqw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Aa6TFugYsu5Ta1cipby6ULp6NdsUf7jzUra7DF1y2V8shy8vlubHogmKIFvlWcbvm
	 rldWZouh1M3jxsgnO1GWnhUBUt0MmbDKCXdzOH7wERYrkcov72L6nGsytqQQneXkVk
	 +OuP9msXVGIuxxOIZUTgj7lP3Ncd1QGHI0H397YQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25A1EF8016E;
	Mon, 16 Nov 2020 07:22:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84C28F8016C; Mon, 16 Nov 2020 07:22:11 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64353F8014A
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 07:22:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64353F8014A
IronPort-SDR: Cl1JfX+c5mZwQ5odVW/9fBfJXHYVeSoWp9oFhPdzD1DtUMDN6d1gkJwpdx2CO7QYJ7TniWtZWJ
 9Nk0rXxS0blQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158482321"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; d="scan'208";a="158482321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2020 22:21:57 -0800
IronPort-SDR: CVgIKhvbCaTlWk7aAIt6VDt6cbajJv7nHoyyAlMhXb0//naOloyMt+0QTkDiBoIQGtuwaNj1FO
 PNELADhiaNyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; d="scan'208";a="362020288"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2020 22:21:54 -0800
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] This patch series enables DMA mode on Intel Keem Bay
 platform
Date: Mon, 16 Nov 2020 14:14:47 +0800
Message-Id: <20201116061452.32347-1-michael.wei.hong.sit@intel.com>
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

