Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75427C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:38:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD33464E77
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD33464E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F19816AD;
	Tue,  9 Feb 2021 00:37:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F19816AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827527;
	bh=xcNgneQIdKZdcaLKzyXrjvSyOTBYn11Es72zYbTHb1g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJMeytQuewJ/lmBS+bpiLYp5rG32Ft9kCFeo9dEpqEmp4qu4No5wwS+0RUzhbx8jG
	 TMiGJDFpyEj1azOe4meM5HUgPNEYfnzQzBCWZsW4fi3oU7uYL6sHVToVoV9KWgLw8U
	 DHTS8Na79PWIBNjfYfgIhrWCNJ7MdRZahA2m2GWU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8002BF804DA;
	Tue,  9 Feb 2021 00:34:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97430F8032D; Tue,  9 Feb 2021 00:34:16 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 256F5F80114
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:34:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 256F5F80114
IronPort-SDR: DGVAIUd+Nz3iKrcz42EKTEAiHkGeKdPlVR9Q98QQm8beMVbK1NrLCG8+PCUMZ5/tBYyXffIBrb
 90I5xJL/vD/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168923524"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="168923524"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:59 -0800
IronPort-SDR: i/6AHL8NIbg6WS/6N8hLteCcKSaVhRWwEzeIe2yd5ln2GHWyraTzUBBYQ1TeW7Fi/AehWaag4c
 ho0b58Ez9u2w==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="374741369"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:58 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 11/11] ASoC: SOF: Intel: hda: add dev_dbg() when DMIC
 number is overridden
Date: Mon,  8 Feb 2021 17:33:36 -0600
Message-Id: <20210208233336.59449-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
References: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

It's useful for debug and system integration to show cases where we
ignore the number of microphones reported by NHLT.

Suggested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e8094be6bfc6..0dc3a8c0f5e3 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -564,8 +564,12 @@ static int dmic_topology_fixup(struct snd_sof_dev *sdev,
 	dmic_num = check_nhlt_dmic(sdev);
 
 	/* allow for module parameter override */
-	if (hda_dmic_num != -1)
+	if (hda_dmic_num != -1) {
+		dev_dbg(sdev->dev,
+			"overriding DMICs detected in NHLT tables %d by kernel param %d\n",
+			dmic_num, hda_dmic_num);
 		dmic_num = hda_dmic_num;
+	}
 
 	switch (dmic_num) {
 	case 1:
-- 
2.25.1

