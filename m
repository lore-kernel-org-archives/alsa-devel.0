Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC42C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:04:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9523220774
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lgbDDAEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9523220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 272841675;
	Thu, 13 Aug 2020 22:03:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 272841675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597349045;
	bh=3Qhe2M9lfH85E334wuUgFC8jK+2an8EgunjuFzkpjI4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lgbDDAEwLbYmcopxvm0katq2wN8RERpVYvrWlO6KC7PNcaqh/N+uw9pG2d/eamvTI
	 XravHJGxuTOzWaBo1EO3qJSg7CjuMirucgPBhb0F5Cxke+1j206wFKOMosrJ2/p4MK
	 kwV3WExZ+t5hLcs0QQwDjtG9rbUeFps2mCDrXois=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4529AF80161;
	Thu, 13 Aug 2020 22:02:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71193F802C4; Thu, 13 Aug 2020 22:02:15 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9757F800F4
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 22:02:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9757F800F4
IronPort-SDR: cfxCigORiRA3kH7pQwoxBCF/XYt64hbuCBrbPFOpPvR4sjtw04Q77Ft9XW+wKcFltY2cJRX0Qf
 WzYEhBEz0ziw==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="172360707"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="172360707"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:02 -0700
IronPort-SDR: 8GvgRRQ+uhae5IJbHB3Rpch2XXhuiQ6+Ed3dj5AkYKnGqu+5l+bzWeq0goW37yNLv3N/7B01Gu
 19AuvERAdVUA==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="495506266"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:00 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 02/21] ASoC: Intel: Atom: compress: remove redundant assignment
Date: Thu, 13 Aug 2020 15:01:28 -0500
Message-Id: <20200813200147.61990-3-pierre-louis.bossart@linux.intel.com>
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

sound/soc/intel/atom/sst-mfld-platform-compress.c:46:14: style:
Variable 'ret_val' is assigned a value that is never
used. [unreadVariable]
 int ret_val = 0;
             ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst-mfld-platform-compress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-compress.c b/sound/soc/intel/atom/sst-mfld-platform-compress.c
index 1595e01a7e12..89c9c5ad6b21 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-compress.c
@@ -42,8 +42,7 @@ static void sst_drain_notify(void *arg)
 static int sst_platform_compr_open(struct snd_soc_component *component,
 				   struct snd_compr_stream *cstream)
 {
-
-	int ret_val = 0;
+	int ret_val;
 	struct snd_compr_runtime *runtime = cstream->runtime;
 	struct sst_runtime_stream *stream;
 
-- 
2.25.1

