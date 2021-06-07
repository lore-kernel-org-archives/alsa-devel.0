Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A113FC47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 22:49:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F9F610A1
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 22:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F9F610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 556C116A8;
	Tue,  8 Jun 2021 00:48:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 556C116A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623106142;
	bh=6b9EajoewNg5jNhU9r24F0QfwFtdldbRhMOadK4Ow7g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=InLrJXc1dt2bJ8ZAdnteOVNXq/yP9Ec1rTQJthKBoSuDaFUcQcDTTyeMwfcBbbvnq
	 4yJ87kHnZYYmJTNrPM1/Ow9y89TyB2qkSqVMGFGNUwE1B85fvxAoo95ZGTN54mioyn
	 kygXlISHE6RD0IUXzxLlK+Gtt2ObsD+ykvuPMRAY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9154EF800AF;
	Tue,  8 Jun 2021 00:47:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84118F804DA; Tue,  8 Jun 2021 00:47:08 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA64BF800AF
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 00:46:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA64BF800AF
IronPort-SDR: LUiRrpvP6G4N+03gNg3cw+EbkAoh8qS0QJXGfG+gFmQ8EID0828oJKo7RmbXNH/6wM2HeIh166
 gU3Q7cHQiuEg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185102171"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="185102171"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 15:46:47 -0700
IronPort-SDR: kqsnk66YiMeTaWxkJdzvpV/X/KwibLHczkykx1PpLrK/F/QY4HtAZXYwc/Q/n4VosLqxVMve6B
 gYsCGLTMlNEg==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="637437074"
Received: from marocham-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.108.70])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 15:46:47 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/10] ASoC: Intel: sof_sdw: use mach data for ADL RVP DMIC
 count
Date: Mon,  7 Jun 2021 17:46:29 -0500
Message-Id: <20210607224638.585486-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607224638.585486-1-pierre-louis.bossart@linux.intel.com>
References: <20210607224638.585486-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

On the reference boards, number of PCH dmics may vary and the number
should be taken from driver machine data. Remove the SOF_SDW_PCH_DMIC
quirk to make DMIC number configurable.

Fixes:d25bbe80485f8 ("ASoC: Intel: sof_sdw: add quirk for new ADL-P Rvp")
BugLink: https://github.com/thesofproject/sof/issues/4185
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index dd5d8e6af626..970d7892568a 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -199,7 +199,6 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.driver_data = (void *)(SOF_RT711_JD_SRC_JD1 |
 					SOF_SDW_TGL_HDMI |
 					SOF_RT715_DAI_ID_FIX |
-					SOF_SDW_PCH_DMIC |
 					SOF_BT_OFFLOAD_SSP(2) |
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
-- 
2.25.1

