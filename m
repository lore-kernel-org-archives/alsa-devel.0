Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF72C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 23:53:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A1020707
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 23:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OcqZ0cL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A1020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4116416D5;
	Wed, 26 Aug 2020 01:53:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4116416D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598399636;
	bh=RgBP+SwZvow1vbbuRkxisJfGFhWxkbDcn0FOQU2+s+g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OcqZ0cL+0LCkPKsdtHjH2nT559QivLwvcyQjf3lzNu1ty6qdTFRSUJRGjV0+FbQaK
	 IUgd0Jz45LZOaGJKPxGdSsuY6jYr5xQsLXoQvT11q8BlkbFLHV6cAPgWifgk6opExe
	 xXPdVIZjzYP6lFb34LzbYUsJRwQOVQLHR04YdAqY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8E66F802C4;
	Wed, 26 Aug 2020 01:51:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DAEEF80269; Wed, 26 Aug 2020 01:51:07 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A429F80269
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 01:51:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A429F80269
IronPort-SDR: a8UvJixPOt/K4J8K32QcEoZVDegm8wKziA0mAFMsjpAZKRVJNZHtygj5zazISjQErBFCLtJY8o
 CMtQCYxzsxzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="157253465"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="157253465"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 16:50:58 -0700
IronPort-SDR: FjVCICnznrfIMKCGsCKv05+1L/B4wFO3EjJBEVzXaIYWQOsFrAV3hzZd7cwIyKzqibcM/LFtSH
 0yDhJ275nedA==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="443818998"
Received: from cdurvasu-mobl2.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.42.42])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 16:50:58 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/7] ASoC: SOF: topology: fix the ipc_size calculation for
 process component
Date: Tue, 25 Aug 2020 16:50:37 -0700
Message-Id: <20200825235040.1586478-5-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825235040.1586478-1-ranjani.sridharan@linux.intel.com>
References: <20200825235040.1586478-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Jaska Uimonen <jaska.uimonen@intel.com>, tiwai@suse.de,
 Keyon Jie <yang.jie@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org
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

From: Keyon Jie <yang.jie@linux.intel.com>

The topology private struct is used for token parsing and its size
should not be included to the ipc_size, fix it here though it didn't
cause any real issue as the Firmware won't use this wrong-added data.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Jaska Uimonen <jaska.uimonen@intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/topology.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 707fbac3e64f..95e63d138326 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2114,9 +2114,7 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
 			goto out;
 	}
 
-	ipc_size = sizeof(struct sof_ipc_comp_process) +
-		le32_to_cpu(private->size) +
-		ipc_data_size;
+	ipc_size = sizeof(struct sof_ipc_comp_process) + ipc_data_size;
 
 	/* we are exceeding max ipc size, config needs to be sent separately */
 	if (ipc_size > SOF_IPC_MSG_MAX_SIZE) {
-- 
2.25.1

