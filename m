Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C65EC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:08:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D3720829
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OtG4H8XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D3720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C77C168C;
	Thu, 13 Aug 2020 22:07:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C77C168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597349281;
	bh=XhVuXPkCG8xxh48hF1hgagaTrnnZ0w2VSfyAeMQvzD4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OtG4H8XWaYcsBtV6wvCh3wSJpedjqrn4OaTDfKdIizdo61m/iTyHZTaz2enrSZlLV
	 woC1krW4gImJPacj6IL93ZEo6Ym6jE3QI85tZvlTblTXuKIJCFXQEZL6aFxwYDPEwe
	 Ptro5Oqr20/dOssms+hwHjnpPjzLF1RE7z64c4y0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8989FF802E0;
	Thu, 13 Aug 2020 22:02:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D259F80304; Thu, 13 Aug 2020 22:02:26 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6FE9F802DD
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 22:02:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6FE9F802DD
IronPort-SDR: u9aoUZ8AvkGbKVwQsmIAyhZU74N10rfj6aNYu0VIkmwtD1MHRxqPzhbInYQq5EvFT09tZ/6DR2
 ABbqeajYCDqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="141940386"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="141940386"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:06 -0700
IronPort-SDR: 8S8m/zNUaY0IXVDj0hOlR/8phjhNsYjY9Idl1Q50hLP3XKRtJWa91+n7QOAilL4782VRcV2TZO
 OOxgQ9XOjEtw==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="495506302"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:04 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 09/21] ASoC: Intel: Atom: sst_loader: remove always-true
 condition
Date: Thu, 13 Aug 2020 15:01:35 -0500
Message-Id: <20200813200147.61990-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
References: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
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

Fix cppcheck warning:

sound/soc/intel/atom/sst/sst_loader.c:401:43: style: Redundant
condition: If 'EXPR == 4', the comparison 'EXPR != 3' is always
true. [redundantCondition]

 if (sst_drv_ctx->sst_state !=  SST_RESET ||
                                          ^

In this case, if sst_state == SST_SHUTDOWN then the first test is
already true. 2014 bug, yay.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_loader.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index fc91a304256b..5c42cce90ce2 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -398,8 +398,7 @@ int sst_load_fw(struct intel_sst_drv *sst_drv_ctx)
 
 	dev_dbg(sst_drv_ctx->dev, "sst_load_fw\n");
 
-	if (sst_drv_ctx->sst_state !=  SST_RESET ||
-			sst_drv_ctx->sst_state == SST_SHUTDOWN)
+	if (sst_drv_ctx->sst_state !=  SST_RESET)
 		return -EAGAIN;
 
 	if (!sst_drv_ctx->fw_in_mem) {
-- 
2.25.1

