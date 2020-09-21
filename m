Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55065C43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:50:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5395B20719
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Rpy/4TmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5395B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B642C16F8;
	Mon, 21 Sep 2020 12:49:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B642C16F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600685420;
	bh=5SIA/HiJGrwJLI4bwpLAHnpA2Qi5GTuRwDs+OFe3aDM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rpy/4TmJADOt9yh3I1z57TCzDlIlWosg0R0z5NsaJ0Sesa73kG2Nfp0AYdABWqz+x
	 0Tfo1fpkpVOUrxLk5T27+xiQ2ue7P1q4/xlTCn2/a+IsH2tdhmhSWmab5fdCj+1XQC
	 vsXsiC+jILzQt0UX9qfmzt2JPrqlrLuNvkgFS7VU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 576D6F80161;
	Mon, 21 Sep 2020 12:49:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DEEFF8015F; Mon, 21 Sep 2020 12:49:29 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4878F8015F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 12:49:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4878F8015F
IronPort-SDR: oItLsAgaiNCztrnq3A8wWrzLmoeRFZUbUacpx39e7jaabAGBm5ymMKM20C59AIkeJA0oU/bfhD
 mxqZuqkRd/RA==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="178425109"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="178425109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 03:49:18 -0700
IronPort-SDR: yCFW5uQlMo5ZvPTtjLqjD4sTnQGRSED6Kl6kefdLU5lTEDXc/tqVJVrWDtdXv7CCjMDhCVoJec
 MK4TJ4XNMKqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="289873314"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga007.fm.intel.com with ESMTP; 21 Sep 2020 03:49:16 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: imx: add missing MODULE_LICENSE() for imx-common
Date: Mon, 21 Sep 2020 13:47:46 +0300
Message-Id: <20200921104746.2903507-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Baluta <daniel.baluta@gmail.com>, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

Fix build warning:
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/sof/imx/imx-common.o

Fixes: 18ebffe4d043 ("ASoC: SOF: imx: Add debug support for imx platforms")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/imx/imx-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 63d8a5d7bc44..5fee637834c2 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -4,6 +4,7 @@
 //
 // Common helpers for the audio DSP on i.MX8
 
+#include <linux/module.h>
 #include <sound/sof/xtensa.h>
 #include "../ops.h"
 
@@ -70,3 +71,5 @@ void imx8_dump(struct snd_sof_dev *sdev, u32 flags)
 			   IMX8_STACK_DUMP_SIZE);
 }
 EXPORT_SYMBOL(imx8_dump);
+
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.27.0

