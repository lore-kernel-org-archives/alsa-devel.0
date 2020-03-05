Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097AC3F2CD
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:57:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7583E20732
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F5yBUXa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7583E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D750F1674;
	Thu,  5 Mar 2020 15:56:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D750F1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583420225;
	bh=LpkuANsQn6dx8yJ/bF6HC7JcjVFAqkxWkiQINkQPBL0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F5yBUXa+Scb6qR9zX64q9hWfYP5l3lUdRkCi8zeTleCqNGS8aObtzNrmqL7bUTWw7
	 GHq8uR5Ul9+brcThiKjOPJLY9t1s/gtIn5y4YBq0lRr3gcbr7+Dg19OKU2wZQLn3CO
	 mXw3lvktlUWCRLd/OZwu+BZdktw+xYcQ7OK2ULc8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F9BCF802A1;
	Thu,  5 Mar 2020 15:53:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF8F1F8028F; Thu,  5 Mar 2020 15:53:50 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15997F80245
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 15:53:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15997F80245
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 06:53:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; d="scan'208";a="352372611"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2020 06:53:44 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/7] ASoC: Intel: skl_hda_dsp: Enable Dmic configuration
Date: Thu,  5 Mar 2020 15:53:12 +0100
Message-Id: <20200305145314.32579-6-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200305145314.32579-1-cezary.rojewski@intel.com>
References: <20200305145314.32579-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, lgirdwood@gmail.com,
 tiwai@suse.com, vkoul@kernel.org, broonie@kernel.org,
 Mateusz Gorski <mateusz.gorski@linux.intel.com>
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

From: Mateusz Gorski <mateusz.gorski@linux.intel.com>

Address missing Dmic configuration for Intel DSP platforms with HDAudio
codecs by updating DAPM route map with adequate connections.

Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index fe2d3a23a4ef..0126dfc7ac24 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -59,6 +59,9 @@ static const struct snd_soc_dapm_route skl_hda_map[] = {
 	{ "Digital CPU Capture", NULL, "Digital Codec Capture" },
 	{ "codec2_in", NULL, "Alt Analog CPU Capture" },
 	{ "Alt Analog CPU Capture", NULL, "Alt Analog Codec Capture" },
+
+	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
+	{ "DMIC01 Rx", NULL, "DMIC AIF" },
 };
 
 SND_SOC_DAILINK_DEF(dummy_codec,
-- 
2.17.1

