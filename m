Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BD9C61DA4
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Mar 2023 01:43:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAB63146F;
	Tue, 14 Mar 2023 02:42:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAB63146F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678758205;
	bh=PGk3sCWW4GKxrRnzP/5NGc1o5+9sx46cLfioCRVccX4=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WFgrm0g4fNBGKU9pYXTbM7TWdjXAaNJQZCZ7nuXfsx0rz9FFz6qyAUMkwgWqLFNuB
	 BLhK4P7MQA1ah0m77zi9PoNfzjuOlkz26IyJK/E3MJwSF4zvPM5hrsuT4olIoBg+1n
	 /mb4CZOPAYD1EanB7DcSLia+VBVh5DwjLQs5mQgs=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D624F80544;
	Tue, 14 Mar 2023 02:41:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA1F7F80520; Tue, 14 Mar 2023 02:41:19 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 98DFCF800C9
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2023 02:41:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98DFCF800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aZCmYPUF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758075; x=1710294075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PGk3sCWW4GKxrRnzP/5NGc1o5+9sx46cLfioCRVccX4=;
  b=aZCmYPUFj+TQjhCTIglVFH2LGeF37b+cY6CQfb7/gzumF7rEmG5s4A3Z
   4s2BHsP7JzIBCEAI+QYJAur+I4b+PYgQAo13HRwENuw7bwSMaFaoi7SvF
   MoYUfQA8pi5bIS4oMCJy7kFMMksZeRwb2jNM3JnaC/iuQZJLougeqMYtI
   p8p83wjPRrIBeTQvr2ISoGmBUrzji4Y4XPMZiTK05eujgQNIxIxr46J/4
   R0gspAr6gmeq0hbIyjFPg9rQOS7IvPtAHVHZ0ui5nIdcKZy28n5sKwgXi
   8Y2muSkVxTT5fsBFSdnhXwuT0zMqREQkS903NRLHcHIb2QeTJYfBNjFyZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949220"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400";
   d="scan'208";a="316949220"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 18:41:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327350"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400";
   d="scan'208";a="711327350"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 18:41:08 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 02/16] soundwire: intel: remove stale/misleading comment
Date: Tue, 14 Mar 2023 09:53:56 +0800
Message-Id: <20230314015410.487311-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5RGSVKJ6S5EVDD234OGOVRBVUFEK6OKD
X-Message-ID-Hash: 5RGSVKJ6S5EVDD234OGOVRBVUFEK6OKD
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5RGSVKJ6S5EVDD234OGOVRBVUFEK6OKD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The PDIs don't really have a notion of rates and formats, only
channels are relevant.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 20067f9cd128..924dff670170 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1056,7 +1056,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 	if (num == 0)
 		return 0;
 
-	 /* TODO: Read supported rates/formats from hardware */
 	for (i = off; i < (off + num); i++) {
 		dais[i].name = devm_kasprintf(cdns->dev, GFP_KERNEL,
 					      "SDW%d Pin%d",
-- 
2.25.1

