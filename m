Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A42EC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 05:59:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0CB2083B
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 05:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WiKoOiEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0CB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 458901741;
	Thu, 30 Jul 2020 07:58:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 458901741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596088757;
	bh=PxuDE1rTfMoJFL9DI153wYthLCNr6R5bjDVEsxHtTT0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WiKoOiEi8Hcf+CfNJzHcxl63BPYZrbXmAKktmenznuP6F6ciAbxQIjpPvzVyxrRP4
	 5y3YEPKTvzLdzmvYPE0SJmhCqZORf3Jk3RAA2p9zKTcDTEZg2LaQOXbNCrB7eANUkY
	 naDNAr3KOCIuGz2t4VhuWipE8NvkHyBJLjvKCGKw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2261F8021C;
	Thu, 30 Jul 2020 07:58:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57C9BF8021E; Thu, 30 Jul 2020 07:58:25 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC946F8012F
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 07:58:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC946F8012F
IronPort-SDR: uiFQp+Gch5iw9yaTxaeec7tO+2Ans7zn7w964t1hjiKPqtEDhotp12f6yA6AvsXGKBFl8ebzD6
 PFLRQWpz9F1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="149375916"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="149375916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 22:58:18 -0700
IronPort-SDR: qYCfEKi8fp/ek75/fm4VqCgGtIk/CAf6PGmwpG3V9/pI+YbQ430Z+qyU6xQplQ60cK1S6is22H
 hsTvXVREuUsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="434923832"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 22:58:16 -0700
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ASoC: Intel: KMB: TDM Enablement patches
Date: Thu, 30 Jul 2020 13:53:15 +0800
Message-Id: <20200730055319.1522-1-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, andriy.shevchenko@intel.com, tiwai@suse.com,
 jee.heng.sia@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

This patch series is to enable multiple features on the Keembay Platform

Michael Sit Wei Hong (4):
  ASoC: Intel: KMB: Add 8kHz audio support
  ASoC: Intel: KMB: Rework disable channel function
  ASoC: Intel: KMB: Enable TDM audio capture
  dt-bindings: sound: intel,keembay-i2s: Add channel-max property

 .../bindings/sound/intel,keembay-i2s.yaml     |   8 +
 sound/soc/intel/keembay/kmb_platform.c        | 137 +++++++++++++-----
 sound/soc/intel/keembay/kmb_platform.h        |   1 +
 3 files changed, 112 insertions(+), 34 deletions(-)

-- 
2.17.1

