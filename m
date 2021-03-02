Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BAFC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:04:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3996764F23
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3996764F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B444418F0;
	Tue,  2 Mar 2021 22:03:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B444418F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614719070;
	bh=1QOksM4ruys0RqomN5NP/zBGCRo34MetCabmabbaZwg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lXcGAo8pVZuIwfHtCKPtAzxTpCmLF7id57tZN+qyeosywRB5rbOUam9sLb2FOg7/A
	 UyI+ZyvUa67D/v/rVpmRnBwT4zi6DKDEwperoDbhrcTa/ESTilyYWf9QhBsGO4r89d
	 TWBX4lsp3gruE5cxuOf444LuHRChicuU4Q5cJL0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4224F804AD;
	Tue,  2 Mar 2021 22:00:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93312F80424; Tue,  2 Mar 2021 22:00:44 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7EBDCF8032B
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:00:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EBDCF8032B
IronPort-SDR: G/wUvIU/SJsQV6GLf8zupidXqnDFGOwU0iK6jcBmUCE/uEr9xYedMvGtqznMF/F4xfuWy1LsAn
 NxvaQoA3nZRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174623753"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="174623753"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:00:31 -0800
IronPort-SDR: v/G/IR0vx5uFLtyZmHDtKCCVL6SBdPiSnYRMIR7BcuPVWmWYUcdAhJ470X2bPI+I1681u9RvP9
 qb8Ipl2iL36A==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="373727806"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:00:30 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 7/9] ASoC: fsl: fsl_easrc: fix kernel-doc warning
Date: Tue,  2 Mar 2021 14:59:24 -0600
Message-Id: <20210302205926.49063-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302205926.49063-1-pierre-louis.bossart@linux.intel.com>
References: <20210302205926.49063-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

make W=1 warning:

sound/soc/fsl/fsl_easrc.c:383: warning: wrong kernel-doc identifier on
line:
 *  Scale filter coefficients (64 bits float)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_easrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 725a5d3aaa02..60f9c0bad3e8 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -380,7 +380,7 @@ static int fsl_easrc_resampler_config(struct fsl_asrc *easrc)
 }
 
 /**
- *  Scale filter coefficients (64 bits float)
+ *  fsl_easrc_normalize_filter - Scale filter coefficients (64 bits float)
  *  For input float32 normalized range (1.0,-1.0) -> output int[16,24,32]:
  *      scale it by multiplying filter coefficients by 2^31
  *  For input int[16, 24, 32] -> output float32
-- 
2.25.1

