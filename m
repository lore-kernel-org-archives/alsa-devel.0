Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB870C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 23:53:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F11206E3
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 23:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zbv4udg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F11206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DACD616DA;
	Wed, 26 Aug 2020 01:52:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DACD616DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598399616;
	bh=uoKt9DEHWC5H72WbSd08aEXdDrzGQ4GVn2vOC+0CfCA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zbv4udg4kjh5rdX6yHAUgXN+++dO7Wlo1l0ONOIk6hUZICoJna9JY+lAFUYlksw1f
	 05K1jTBGDYm9rCRMaLucKzRVgOIgF1xnx9EQ+b1CqIDgxY8100Sr2Pxyzv3vkfm+TW
	 YlFIYKbenCiIZFScSItlsbJBlkwUzyNxyhZdrS4M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0F4FF80299;
	Wed, 26 Aug 2020 01:51:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8148FF802C3; Wed, 26 Aug 2020 01:51:07 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCD9FF8026A
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 01:51:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCD9FF8026A
IronPort-SDR: iQIkeBaXzSzI5rherLYqTpi25ZPFv36upR4zqK6EFtB844vNUS0zJZ/xC91WOqiBc+Ko10nCXn
 m0HUsbKuHtsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="157253466"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="157253466"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 16:50:59 -0700
IronPort-SDR: iugddknJ4fuK6keOfBEuVS35ESuhPD5M6ekH1EdzmX7+RCZBTxjcKIxFnmrrkw59XlFCO+dpMk
 +ytyJfFQfEFw==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="443819004"
Received: from cdurvasu-mobl2.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.42.42])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 16:50:59 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/7] ASoC: SOF: Intel: hda: add extended rom status dump to
 error log
Date: Tue, 25 Aug 2020 16:50:38 -0700
Message-Id: <20200825235040.1586478-6-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825235040.1586478-1-ranjani.sridharan@linux.intel.com>
References: <20200825235040.1586478-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Jaska Uimonen <jaska.uimonen@intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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

Dump the extended ROM status information to the error logs
to aid with remote support. The analysis of these logs requires
access to non-public technical information.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Jaska Uimonen <jaska.uimonen@intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 0e8285b34a7d..de8e85920402 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -37,6 +37,7 @@
 #include "shim.h"
 
 #define EXCEPT_MAX_HDR_SIZE	0x400
+#define HDA_EXT_ROM_STATUS_SIZE 8
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
 
@@ -414,6 +415,22 @@ void hda_dsp_dump_skl(struct snd_sof_dev *sdev, u32 flags)
 	}
 }
 
+/* dump the first 8 dwords representing the extended ROM status */
+static void hda_dsp_dump_ext_rom_status(struct snd_sof_dev *sdev)
+{
+	char msg[128];
+	int len = 0;
+	u32 value;
+	int i;
+
+	for (i = 0; i < HDA_EXT_ROM_STATUS_SIZE; i++) {
+		value = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_SRAM_REG_ROM_STATUS + i * 0x4);
+		len += snprintf(msg + len, sizeof(msg) - len, " 0x%x", value);
+	}
+
+	dev_err(sdev->dev, "error: extended rom status:%s", msg);
+}
+
 void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags)
 {
 	struct sof_ipc_dsp_oops_xtensa xoops;
@@ -437,6 +454,7 @@ void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags)
 	} else {
 		dev_err(sdev->dev, "error: status = 0x%8.8x panic = 0x%8.8x\n",
 			status, panic);
+		hda_dsp_dump_ext_rom_status(sdev);
 		hda_dsp_get_status(sdev);
 	}
 }
-- 
2.25.1

