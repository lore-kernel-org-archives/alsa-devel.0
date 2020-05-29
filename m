Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92FC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 12:31:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA082077D
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 12:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I9U/8gVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA082077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B4C716E7;
	Fri, 29 May 2020 14:30:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B4C716E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590755468;
	bh=vXKgcKQ3VbOwPAiItOzLM2wwZpavU6Lj2xH1O7qNplY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I9U/8gVv4lfMlFK/1v7y91yAQqA7MHRyta9If7nLzFmqHjP/8caNb4ek5Dvi8iErG
	 s+CWUWYTm9/N37yzQ1tkAF5ZNr/hxKGomJXsCFjeJvzjSg1UVvU4yTYDAmC4RwHdSh
	 NZlggk4/emkEv695n533nlYdRIUMjoNEQOraF2ug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A6E6F800FF;
	Fri, 29 May 2020 14:28:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4842F80227; Fri, 29 May 2020 14:28:37 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8297F80107
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 14:28:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8297F80107
IronPort-SDR: sw6bmpwyIN2IVAIzp8fiqOThEBAmGLj73NptzkWZ8YDplXnsOC43F7FMXFP+cq7Bh4cuu/j2PT
 RvCKDACWaKYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 05:28:25 -0700
IronPort-SDR: KbxoTM9RwstSf7PN/RfQ0ujhgeAIpproeH86Vz/uo9vODa6vAvAvPzQiAA7GMYxtinyPPdY3CN
 nZGz2kx+a0JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; d="scan'208";a="469491468"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga006.fm.intel.com with ESMTP; 29 May 2020 05:28:24 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	perex@perex.cz
Subject: [PATCH 2/2] pcm: fix spelling in documentation for -EBADFD
Date: Fri, 29 May 2020 15:28:17 +0300
Message-Id: <20200529122817.1198-3-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529122817.1198-1-kai.vehmanen@linux.intel.com>
References: <20200529122817.1198-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com
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

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 src/pcm/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 488a8dd0493d..79322b4eab0d 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -284,7 +284,7 @@ supports resume and the snd_pcm_prepare() call can be ommited.
 \par -EBADFD
 
 This error means that the device is in a bad state. It means that
-the handskahe between application and alsa-lib is corrupted.
+the handshake between application and alsa-lib is corrupted.
 
 \par -ENOTTY, -ENODEV
 
-- 
2.26.2

