Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E6EC433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 13:52:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F3B6124A
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 13:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F3B6124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38D2D16A3;
	Thu,  1 Apr 2021 15:51:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38D2D16A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617285117;
	bh=vIWsoGc/7kO3mT6qBLpMoH1pK4iQTV9HksBAUWhvzug=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S8LsJb1nTMOBbB18PT08tNWOIa7MgrSRGL+HCGuxZ5TgIxOhNheWUXhG6e7VCnrQn
	 61jwDL1yMbnrc6lLuo5mOtTyD3/qhHy2dyOe209mUbNgbS/Z1SqUs7NQfra/8T+NW7
	 xh/FlsBdNsTrLkMeAT+pAm0UdoNJOqkXjFe4td2A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8F0AF80240;
	Thu,  1 Apr 2021 15:51:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A61BF8026B; Thu,  1 Apr 2021 15:51:05 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F264BF8013C
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 15:50:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F264BF8013C
IronPort-SDR: Ewf1oKjAyXTXFdI1iVbKXBr4AJgtWmEPMGWl4VUFNrFSJu8MehOHJ/qHAE6CxWhhdJmw/3HaxB
 Dp8UMNeA6rnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190012990"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="190012990"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 06:50:51 -0700
IronPort-SDR: GvgRgX9wXWHCBDmx/8nuUa19/NhDFzAFMx7GMhb3HcOE/ghAl28B4c6XIu8uoMLUHpZ9UF48ZV
 O2Fh1wY+PRVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="412688994"
Received: from cooperch-pc1.itwn.intel.com ([10.5.215.29])
 by fmsmga008.fm.intel.com with ESMTP; 01 Apr 2021 06:50:50 -0700
From: mac.chiang@intel.com
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: Boards: cml_da7219_max98390: add capture stream
 for echo reference
Date: Thu,  1 Apr 2021 22:00:13 +0800
Message-Id: <1617285613-29457-1-git-send-email-mac.chiang@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: mac.chiang@intel.com, broonie@kernel.org, yang.jie@linux.intel.com,
 pierre-louis.bossart@linux.intel.com
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

From: Mac Chiang <mac.chiang@intel.com>

enable speaker capture dai link for feedback path

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 0c0a7178..9ffef39 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -813,6 +813,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
 				if (ctx->spkamp == SPKAMP_MAX98390) {
 					broxton_dais[i].codecs = max98390_codec;
 					broxton_dais[i].num_codecs = ARRAY_SIZE(max98390_codec);
+					broxton_dais[i].dpcm_capture = 1;
 				}
 			}
 			/* DIALOG_CODEC is connected to SSP0 */
-- 
2.7.4

