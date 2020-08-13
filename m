Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40203C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:02:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B1A20774
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TVUJUq2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B1A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4ACA41673;
	Thu, 13 Aug 2020 20:01:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4ACA41673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597341754;
	bh=MfB0ue6g7IsL2RLcb2TLI84RlhiD0rfc50HBWVOvSHE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TVUJUq2wut+5C2GeZ9/qT3Izs6/gR4SaKqhxvfRnyD0GmSaaQGAtARe4BxxQ54mY2
	 izAS1F99kKpmRhYK54imjgl7LuXd5BYxgca8h3EM1u1oJB4nifAaSIMGvDpq+pyLGJ
	 Ce96VnylblHxMh865++qiX6S6yZ95jNPKP3Mu0cY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B0C9F802E7;
	Thu, 13 Aug 2020 19:59:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 179EEF801A3; Thu, 13 Aug 2020 19:59:03 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD438F80161
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 19:58:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD438F80161
IronPort-SDR: YF30IjQUDguM18VGKgawof1sZ3ZawsVMsHhr5IpxSweoSuc7SOaOSpHEMj3nllaS1Ych/m0u2M
 KocbOtt2uuqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="239124825"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="239124825"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 10:58:56 -0700
IronPort-SDR: C0/DugQ9UMuqR2yg0UJ7JD48RxeVQ3/y2nndTjAG3FAIP9+xjg8ZXLo/VN9RZ6yfDJcGAA7YPb
 Pyn9ZqKEes0w==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="295510756"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 10:58:55 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/5] ASoC: Intel: bytcht_cx2072x: simplify return handling
Date: Thu, 13 Aug 2020 12:58:38 -0500
Message-Id: <20200813175839.59422-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813175839.59422-1-pierre-louis.bossart@linux.intel.com>
References: <20200813175839.59422-1-pierre-louis.bossart@linux.intel.com>
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

sound/soc/intel/boards/bytcht_cx2072x.c:102:9: warning: Identical
condition and return expression 'ret', return value is always 0
[identicalConditionAfterEarlyExit]

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index 9cb42ba40c07..0b50b3646d55 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -99,7 +99,7 @@ static int byt_cht_cx2072x_init(struct snd_soc_pcm_runtime *rtd)
 
 	snd_soc_dai_set_bclk_ratio(asoc_rtd_to_codec(rtd, 0), 50);
 
-	return ret;
+	return 0;
 }
 
 static int byt_cht_cx2072x_fixup(struct snd_soc_pcm_runtime *rtd,
-- 
2.25.1

