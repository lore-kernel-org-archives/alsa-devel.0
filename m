Return-Path: <SRS0=lXbg=XL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791BDC49ED7
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 19:27:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C702067B
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 19:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FJlHXcTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C702067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C0F2166E;
	Mon, 16 Sep 2019 21:26:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C0F2166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568662042;
	bh=e6cfXh3iH38hECqW+Iy6mWTIm3iIpvKD8+BIbKziAjo=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FJlHXcTjURHRGx8kTf2Pt00jsguVVeK0iTSm3mW13Bq1xInhV03SNmsWUoZw0Y7by
	 aBeqyasKfPPeHWYBmAxtxAVk1xSxpyIYsD3XGt/gkiZOsRg3npncWcX12A5jT4206L
	 CXlwumfM1rOImG6kQTdd4Bu0RrWQm/XxI32Kzlgw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83706F805FE;
	Mon, 16 Sep 2019 21:24:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E64D3F805FB; Mon, 16 Sep 2019 21:24:02 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18CBAF80535
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 21:23:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18CBAF80535
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Sep 2019 12:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; d="scan'208";a="270291176"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.104.227])
 by orsmga001.jf.intel.com with ESMTP; 16 Sep 2019 12:23:55 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 16 Sep 2019 14:23:45 -0500
Message-Id: <20190916192348.467-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
References: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH 3/6] soundwire: intel: remove playback/capture
	stream_name
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

We will create dai widget in SOF.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c158a1d19a05..8aa513042a4e 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -843,14 +843,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 			return -ENOMEM;
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_OUT) {
-			dais[i].playback.stream_name =
-				kasprintf(GFP_KERNEL, "SDW%d Tx%d",
-					  cdns->instance, i);
-			if (!dais[i].playback.stream_name) {
-				kfree(dais[i].name);
-				return -ENOMEM;
-			}
-
 			dais[i].playback.channels_min = 1;
 			dais[i].playback.channels_max = max_ch;
 			dais[i].playback.rates = SNDRV_PCM_RATE_48000;
@@ -858,15 +850,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 		}
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_IN) {
-			dais[i].capture.stream_name =
-				kasprintf(GFP_KERNEL, "SDW%d Rx%d",
-					  cdns->instance, i);
-			if (!dais[i].capture.stream_name) {
-				kfree(dais[i].name);
-				kfree(dais[i].playback.stream_name);
-				return -ENOMEM;
-			}
-
 			dais[i].capture.channels_min = 1;
 			dais[i].capture.channels_max = max_ch;
 			dais[i].capture.rates = SNDRV_PCM_RATE_48000;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
