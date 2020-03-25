Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD1CC43331
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:48:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6BC2076A
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oAtA9Vb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6BC2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF07615F8;
	Wed, 25 Mar 2020 22:47:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF07615F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585172907;
	bh=S9xrvrgph4mBR8seDRmIPm/fDcfQMs0MSpo8Z4RgwUM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oAtA9Vb/wzdLGiObXBGBWd/uT5YvOTuoHj2uQeMlxggg3D8uM0u8vPokAT+zT/xLW
	 GFd66Rszh4wXi3rHonodgSjiYBZny86wHJGka67HRERHO2J1xoKb0XGjS0l96Ntzhc
	 9b6lcT0hFVDCKVlj6qO1NAhSsDwgjfJlC4P60+Co=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B29CF80218;
	Wed, 25 Mar 2020 22:47:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF251F80292; Wed, 25 Mar 2020 22:42:43 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12BEDF8015A
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 22:33:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12BEDF8015A
IronPort-SDR: /dV5YeI6d6APxrL8kSlb1HjfmNflMM//Rv1GwA5ogs6sl3IfpmNpeO89+19sDUuSpYsDNAqDfg
 XHQTI1rdEbsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 14:32:50 -0700
IronPort-SDR: 8J/14FeLVRIPGOR4kHkClsnMpW7VDgS8HCz4TB28Jq+K2Ad1Cdtd6GzYAHE4y1aWOim6DqSx9H
 HV1MMLq2q6cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; d="scan'208";a="420455873"
Received: from abeljans.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.233.195])
 by orsmga005.jf.intel.com with ESMTP; 25 Mar 2020 14:32:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: Intel: Make glk+rt5682 echo ref dynamic
Date: Wed, 25 Mar 2020 16:32:42 -0500
Message-Id: <20200325213245.28247-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325213245.28247-1-pierre-louis.bossart@linux.intel.com>
References: <20200325213245.28247-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Curtis Malainey <cujomalainey@chromium.org>,
 broonie@kernel.org,
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

From: Curtis Malainey <cujomalainey@chromium.org>

Without the dynamic flag to allow runtime routing, the card cannot
probe on chromebooks because SOF is constantly waiting for the link.
Adding flag back to allow upstream kernels to work on rt5682 based
chromebooks since SOF can now ignore the hard coded front end.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index ea1de8b3f3cd..3c576b33b9c6 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -409,6 +409,7 @@ static struct snd_soc_dai_link geminilake_dais[] = {
 		.init = NULL,
 		.capture_only = 1,
 		.nonatomic = 1,
+		.dynamic = 1,
 		SND_SOC_DAILINK_REG(echoref, dummy, platform),
 	},
 	[GLK_DPCM_AUDIO_REF_CP] = {
-- 
2.20.1

