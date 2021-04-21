Return-Path: <SRS0=sv+a=JS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD8C433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Apr 2021 01:13:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1196141F
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Apr 2021 01:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1196141F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 424B81678;
	Wed, 21 Apr 2021 03:12:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 424B81678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618967628;
	bh=W5W8KOeU5cF+c783a0EUSmBWDW2m+RDUwh02kYFd7Kc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B67/oANUqrQZN/krdf5B0oksqRwqLUfDDcaLssWUfN07cfywwlVzeWFDcsbK8nuKR
	 PbC9VVtg8GnRu05kSjiI51VBecXgi9YBc/3bRyzo1NSyWwh4cdWbJy/OINxkIxyz4K
	 IGpCn+Y+a8lY1Dw2MBlWIa77m8EGBq13bL/ntqFg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A73A7F80164;
	Wed, 21 Apr 2021 03:12:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2A59F80253; Wed, 21 Apr 2021 03:12:55 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19598F80164
 for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2021 03:12:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19598F80164
IronPort-SDR: RWdQTJfn1e6lvZpUVALzDdJHrzvQDCLwmDiPi37St+uhcHTksB/BaBVP/j7Y0NhoaneOSrgYNA
 MQEsApGT+djA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="183112723"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; d="scan'208";a="183112723"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 18:12:38 -0700
IronPort-SDR: 6897KNHO0MOhdT1akAu31trtrof72UCZaH+P7XSiisMTWeQsJExKsZ54VkVjW2zkhitVkCTpU/
 ZvdXfI2Q7Lxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; d="scan'208";a="391333202"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
 by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2021 18:12:36 -0700
From: Sia Jee Heng <jee.heng.sia@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: KMB: Fix random noise at the HDMI output
Date: Wed, 21 Apr 2021 08:55:46 +0800
Message-Id: <20210421005546.7534-1-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
Cc: broonie@kernel.org, tiwai@suse.com, jee.heng.sia@intel.com,
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

Random noise could be heard when playing audio to the HDMI output.
This is due to the IEC conversion is invoked in the external loop.
As a result, this additional loop takes up a lot of the processing
cycle.

hdmi_reformat_iec958() process the conversion using an internal loop,
it is safe to move it out from the external loop to avoid unnecessary
processing cycle been spent. Furthermore, ALSA IEC958 plugin works in
32bit format only.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/keembay/kmb_platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/keembay/kmb_platform.c b/sound/soc/intel/keembay/kmb_platform.c
index 0fd1e8f62c89..96741c7c0fba 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -105,14 +105,15 @@ static unsigned int kmb_pcm_tx_fn(struct kmb_i2s_info *kmb_i2s,
 	void *buf = runtime->dma_area;
 	int i;
 
+	if (kmb_i2s->iec958_fmt)
+		hdmi_reformat_iec958(runtime, kmb_i2s, tx_ptr);
+
 	/* KMB i2s uses two separate L/R FIFO */
 	for (i = 0; i < kmb_i2s->fifo_th; i++) {
 		if (kmb_i2s->config.data_width == 16) {
 			writel(((u16(*)[2])buf)[tx_ptr][0], i2s_base + LRBR_LTHR(0));
 			writel(((u16(*)[2])buf)[tx_ptr][1], i2s_base + RRBR_RTHR(0));
 		} else {
-			if (kmb_i2s->iec958_fmt)
-				hdmi_reformat_iec958(runtime, kmb_i2s, tx_ptr);
 			writel(((u32(*)[2])buf)[tx_ptr][0], i2s_base + LRBR_LTHR(0));
 			writel(((u32(*)[2])buf)[tx_ptr][1], i2s_base + RRBR_RTHR(0));
 		}

base-commit: bf05bf16c76bb44ab5156223e1e58e26dfe30a88
-- 
2.18.0

