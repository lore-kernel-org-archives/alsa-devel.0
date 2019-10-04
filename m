Return-Path: <SRS0=/e/v=X5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC1C4360C
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:44:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D7920830
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KRl9cN7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D7920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3841D167A;
	Fri,  4 Oct 2019 17:43:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3841D167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570203851;
	bh=SHgM1JT9KUuL5T9ZeyfAsnUPCxhryE6GKi3obN2imrw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KRl9cN7TLExK5r9OUggyLJHw6tD+OYvG31IK2RCZdJM02GlX38VF0EvV/zDIyiGpC
	 NlXu8kWzcJ8fmUQqVtiEZlVk2rNawN4U537re+HGv6KRCk7mJjz8kjvCUZe7GH5hv6
	 +Rw6r8xT0K5QjTe7iSeCyFqO4f2gER08p2MtT/NY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B5DEF80377;
	Fri,  4 Oct 2019 17:41:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CCEFF805FA; Fri,  4 Oct 2019 17:41:40 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75996F800C2
 for <alsa-devel@alsa-project.org>; Fri,  4 Oct 2019 17:41:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75996F800C2
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Oct 2019 08:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; d="scan'208";a="192463296"
Received: from rmadapoo-mobl.amr.corp.intel.com (HELO
 ranjani-desktop.hsd1.ca.comcast.net) ([10.255.92.146])
 by fmsmga007.fm.intel.com with ESMTP; 04 Oct 2019 08:41:29 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri,  4 Oct 2019 08:41:27 -0700
Message-Id: <20191004154127.28459-3-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004154127.28459-1-ranjani.sridharan@linux.intel.com>
References: <20191004154127.28459-1-ranjani.sridharan@linux.intel.com>
Cc: broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
Subject: [alsa-devel] [RFC PATCH 2/2] ASoC: SOF: topology: set trigger order
	for FE DAI link
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Set trigger order for FE DAI links to SND_SOC_DPCM_TRIGGER_POST
to trigger the BE DAI's before the FE DAI's. This prevents the
xruns seen on playback pipelines using the link DMA.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 0aabb3190ddc..f00ecbc38c6c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2827,6 +2827,10 @@ static int sof_link_load(struct snd_soc_component *scomp, int index,
 	if (!link->no_pcm) {
 		link->nonatomic = true;
 
+		/* set trigger order */
+		link->trigger[0] = SND_SOC_DPCM_TRIGGER_POST;
+		link->trigger[1] = SND_SOC_DPCM_TRIGGER_POST;
+
 		/* nothing more to do for FE dai links */
 		return 0;
 	}
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
