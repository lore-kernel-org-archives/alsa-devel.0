Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC79FC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:51:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23AF92088E
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W984Cn4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AF92088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD4441707;
	Thu,  2 Jul 2020 21:50:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD4441707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593719482;
	bh=nZN8yIFog0DHyZats7wntaWNQLFBun+1s7+xAoYDPhg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W984Cn4B+urtuHrRj6m1kav3xIE7W03sCPEM9WPXO4Ji2DQ9miZHbSBABiLY3ixIB
	 vuYDDAMXWOtLML14OhTZvZQRC0aEsETtfaWQBO2/vxjPgNSbuuFzjCVl3P9LFuR+LV
	 W83FuUaC9Gfqody4rz+CgGrJCIyS7c8fEO2MDvZs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08ADDF80252;
	Thu,  2 Jul 2020 21:39:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59A57F80252; Thu,  2 Jul 2020 21:39:02 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2BACF80134
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 21:38:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2BACF80134
IronPort-SDR: pnVQTBsC2iS+vOQMD8lU22BbC4KBWK3nqN7GcX+lIpvqWf28NNiaBMfA0UBHrqL5LmEnlH55ro
 8qP4ISuTGSKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146098129"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="146098129"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:38:50 -0700
IronPort-SDR: Gw/4+QZAT9dQVP+X7kE56J9oHPWJ9h1j4WgkNVPz7B56MiPx/oFn05FvTmXtahzTgOLXWCu5pp
 2c26FsFFoZOw==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="267158440"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:38:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: core: pcm_iec958: fix kernel-doc
Date: Thu,  2 Jul 2020 14:38:42 -0500
Message-Id: <20200702193842.169215-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix W=1 warning. The kernel doc uses the hwparams type instead of the
argument name.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/pcm_iec958.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
index 073540f73b2f..f9a211cc1f2c 100644
--- a/sound/core/pcm_iec958.c
+++ b/sound/core/pcm_iec958.c
@@ -103,7 +103,7 @@ EXPORT_SYMBOL(snd_pcm_create_iec958_consumer);
 
 /**
  * snd_pcm_create_iec958_consumer_hw_params - create IEC958 channel status
- * @hw_params: the hw_params instance for extracting rate and sample format
+ * @params: the hw_params instance for extracting rate and sample format
  * @cs: channel status buffer, at least four bytes
  * @len: length of channel status buffer
  *
-- 
2.25.1

