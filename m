Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E61C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:22:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DB920738
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CwUUP0t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DB920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 768C81763;
	Tue, 23 Jun 2020 11:21:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 768C81763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592904130;
	bh=X4dclXMAyb+dH6vJPLnzrSIilrDXCfIOcinieyDVraU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CwUUP0t8B+2E7Rh143YSkD0Btq5A/aslGjq31lT7WhRBcySNGSqdQglSwqCVvnXqK
	 ne7W3oxDsr7R6T7DLLHHHw1SzRK1NOXv0HEimvdcssLW1ihLZwWeOYkHjq403VDyTT
	 nfVdj2AzmthSy5ErY+tLq4XzV9pefsSw60WEaGPM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC16DF802BD;
	Tue, 23 Jun 2020 11:18:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FBE8F802E3; Tue, 23 Jun 2020 11:18:13 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F9A6F802BD
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 11:18:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F9A6F802BD
IronPort-SDR: Z4Hjq2bHkH+1bGOr4quwJfnKeKyUA8BuFTEzMPTwYihIQSyg8G1ILKWxIc3znpWEAEj7Sh3OTL
 URJe6mz3ulRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="145508166"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; d="scan'208";a="145508166"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 02:18:06 -0700
IronPort-SDR: O1GX7+lUtQ9uG9PxF1OmJdMkxawUjPA9IeUigE2o74JaC9zUKlxB79Qw4l4Th8DCNXDGnQYkht
 4g9Sd1YAamrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; d="scan'208";a="293142017"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga002.jf.intel.com with ESMTP; 23 Jun 2020 02:18:02 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 5/5] soundwire: intel: don't free dma_data in DAI shutdown
Date: Tue, 23 Jun 2020 05:23:32 +0800
Message-Id: <20200622212332.16277-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
References: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Now that the DMA data is allocated/freed in set_sdw_stream(), remove
free operations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 72ba3d22daf9..98e98be6c0f8 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -985,14 +985,7 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 static void intel_shutdown(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
-	struct sdw_cdns_dma_data *dma;
 
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma)
-		return;
-
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
-	kfree(dma);
 }
 
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
-- 
2.17.1

