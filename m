Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652FC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:36:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1007864E76
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1007864E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 451A916A9;
	Tue,  9 Feb 2021 00:35:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 451A916A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827395;
	bh=wIOXeH1sfPSl4mI1RiB/FlcyJC6Nslyn3MFxYHBVKqc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p+Lc9qYdLsV070h0x1nN2fRHrjIxGPKjCZLJxGEodPphiTTy5Bg0G0PqHdzOz0GDC
	 aKbQGdLizIQRLp1WcDr1bjseTJzu6+eFVu8X8STv/MUkytAHScf+ZZPgUF3dprtIc5
	 kw6KduBMgHcNBJZcenJD91hwmDnB/tkqibb620tc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C19ABF802E2;
	Tue,  9 Feb 2021 00:34:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 837A4F802DB; Tue,  9 Feb 2021 00:34:07 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EEACF8022B
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:33:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EEACF8022B
IronPort-SDR: 0AbS6A48YiGdFuZ5atg4VX+XtxnB48pkQUmIun82kjHaCxChbYqzK4aiy1/SzsiWlgU58tw+CT
 4IU/LPoe3tWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168923500"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="168923500"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:53 -0800
IronPort-SDR: Qa27yUuvgtp4jrbm4UPuvEiptvOEHSmaiUCZ8asBJeeyY6shTEAjzdNNxtvMtwvRv7WKahUgbl
 NyOiHTHGIWLQ==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="374741335"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:52 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 04/11] ASoC: Intel: sof_sdw: add mic:dmic and cfg-mics
 component strings
Date: Mon,  8 Feb 2021 17:33:29 -0600
Message-Id: <20210208233336.59449-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
References: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

UCM needs to know which microphone is used (dmic or RT715-based),
let's add the information in the component string.

Note the slight change from HDAudio platforms where 'cfg-dmics' was
used. 'cfg-mics' is used here with the intent that this component
string describes either the number of PCH-attached microphones or the
number of RT715-attached ones (the assumption is that the two
configurations are mutually exclusive).

Suggested-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 0e83db947a57..d1251a6ac3af 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1222,6 +1222,15 @@ static int mc_probe(struct platform_device *pdev)
 	if (!card->components)
 		return -ENOMEM;
 
+	if (mach->mach_params.dmic_num) {
+		card->components = devm_kasprintf(card->dev, GFP_KERNEL,
+						  "%s mic:dmic cfg-mics:%d",
+						  card->components,
+						  mach->mach_params.dmic_num);
+		if (!card->components)
+			return -ENOMEM;
+	}
+
 	card->long_name = sdw_card_long_name;
 
 	/* Register the card */
-- 
2.25.1

