Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C31C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 14:03:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A19320759
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 14:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KOJOJK7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A19320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F1D91663;
	Fri, 15 May 2020 16:02:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F1D91663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589551407;
	bh=CR1mbUST0xnzRSEtk9BjrCTNnNZ0Etz2f5v6MjpYWAk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KOJOJK7W2zAWT2TyB0ZHC41Xb6FgKSmVTOMMpp+0OVIb33Ti1rjRQeSvejDlC+uiq
	 UHmIVvgh0gxSoE3ONs5A+qOcShIX9PJhKIIFu+RPtha0Y1BaZ7NuZ1DpKGkZdeHk+w
	 E/uEHWTDWAoQQcIOacv1e1mqLUqs0y7krzLnR9m8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9D42F80291;
	Fri, 15 May 2020 16:00:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1F64F80254; Fri, 15 May 2020 16:00:45 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC2E1F8022D
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 16:00:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC2E1F8022D
IronPort-SDR: 7o/giA17gbBlw6HNZKART0sOtETztodFrxlNS3Gc6yzhjQIZCNnPth2c7sLMHLEstec1jaOVzU
 1JiQ6gOri8AA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 07:00:35 -0700
IronPort-SDR: M0gDuCwr2lfFETuyCe3p+Or6GgyIL36GE4F0uWmoU76tdhvJrWvkf1FRFQt1SFBEYCZliVxWX0
 XMmtntiLzwQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; d="scan'208";a="266611095"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006.jf.intel.com with ESMTP; 15 May 2020 07:00:33 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 4/8] ASoC: SOF: topology: add support to smart amplifier
Date: Fri, 15 May 2020 16:59:54 +0300
Message-Id: <20200515135958.17511-5-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200515135958.17511-1-kai.vehmanen@linux.intel.com>
References: <20200515135958.17511-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Keyon Jie <yang.jie@linux.intel.com>, daniel.baluta@nxp.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

Add smart amplifier component support, which is designed as another new
type of process component and used for speaker protection algorithm
integration.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/sof/topology.h | 2 ++
 sound/soc/sof/topology.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
index 872de52b3144..f56e80d09b32 100644
--- a/include/sound/sof/topology.h
+++ b/include/sound/sof/topology.h
@@ -38,6 +38,7 @@ enum sof_comp_type {
 	SOF_COMP_DEMUX,
 	SOF_COMP_ASRC,		/**< Asynchronous sample rate converter */
 	SOF_COMP_DCBLOCK,
+	SOF_COMP_SMART_AMP,             /**< smart amplifier component */
 	/* keep FILEREAD/FILEWRITE as the last ones */
 	SOF_COMP_FILEREAD = 10000,	/**< host test based file IO */
 	SOF_COMP_FILEWRITE = 10001,	/**< host test based file IO */
@@ -220,6 +221,7 @@ enum sof_ipc_process_type {
 	SOF_PROCESS_MUX,
 	SOF_PROCESS_DEMUX,
 	SOF_PROCESS_DCBLOCK,
+	SOF_PROCESS_SMART_AMP,	/**< Smart Amplifier */
 };
 
 /* generic "effect", "codec" or proprietary processing component */
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 0259537d3740..6a9703e5ff60 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -431,6 +431,7 @@ static const struct sof_process_types sof_process[] = {
 	{"MUX", SOF_PROCESS_MUX, SOF_COMP_MUX},
 	{"DEMUX", SOF_PROCESS_DEMUX, SOF_COMP_DEMUX},
 	{"DCBLOCK", SOF_PROCESS_DCBLOCK, SOF_COMP_DCBLOCK},
+	{"SMART_AMP", SOF_PROCESS_SMART_AMP, SOF_COMP_SMART_AMP},
 };
 
 static enum sof_ipc_process_type find_process(const char *name)
-- 
2.26.0

