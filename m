Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73893C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:09:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA5320675
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XPBsRY+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA5320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 865821698;
	Thu, 13 Aug 2020 22:09:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 865821698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597349391;
	bh=TjPJGtvSUTkoyT736y66D07BVOBpXvL3p1LL7vDUyJU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XPBsRY+e/tULfC5LHE0lkP/nHVljcGiRzPmJyo6xOJM6dKm2y7v8iVqZQt7uMrG/o
	 L4R1rszUxy8gKJErrGyIq7jDI1xoRpLO/uMiS09AlVGzax+rxxv8vvUK7A0sbdw057
	 tj/Rjpu8pQrmenmbQD7EBjFwxP7DXsOwYsegfD30=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BEFAF8033D;
	Thu, 13 Aug 2020 22:02:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45F90F80305; Thu, 13 Aug 2020 22:02:29 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62C77F802C4
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 22:02:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62C77F802C4
IronPort-SDR: VCEVAWJlGpqtGnbkWEGpmpukGYq9K3Afxi7Qkxzltrl2/HbI0E4ut93CaRD4z2bbyHb3lFTgau
 TV3CpcE1LwiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="134374670"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="134374670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:09 -0700
IronPort-SDR: U2gripvQW6tGsJ9oeWaDsD6Y2Em7XobbX7modP59hqYPWZgS+/ohkW/Fyc76ploImWmfzns+CS
 nAged58S9hRQ==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="495506321"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:07 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 15/21] ASoC: Intel: haswell-ipc: remove redundant assignments
Date: Thu, 13 Aug 2020 15:01:41 -0500
Message-Id: <20200813200147.61990-16-pierre-louis.bossart@linux.intel.com>
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

Fix cppcheck warnings:

sound/soc/intel/haswell/sst-haswell-ipc.c:430:8: style: Variable 'i'
is assigned a value that is never used. [unreadVariable]

sound/soc/intel/haswell/sst-haswell-ipc.c:1792:8: style: Variable 'id'
is assigned a value that is never used. [unreadVariable]

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 0ff89ea96ccf..345fd7c1b1d7 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -427,7 +427,7 @@ static void hsw_fw_ready(struct sst_hsw *hsw, u32 header)
 	u32 offset;
 	u8 fw_info[IPC_MAX_MAILBOX_BYTES - 5 * sizeof(u32)];
 	char *tmp[5], *pinfo;
-	int i = 0;
+	int i;
 
 	offset = (header & 0x1FFFFFFF) << 3;
 
@@ -1789,7 +1789,7 @@ int sst_hsw_store_param_line(struct sst_hsw *hsw, u8 *buf)
 
 int sst_hsw_load_param_line(struct sst_hsw *hsw, u8 *buf)
 {
-	u8 id = 0;
+	u8 id;
 
 	/* read the first matching line from param buffer */
 	while (hsw->param_idx_r < WAVES_PARAM_LINES) {
-- 
2.25.1

