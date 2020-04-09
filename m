Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC0C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:47:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D702082D
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WbPVwNWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D702082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49EDA1696;
	Thu,  9 Apr 2020 20:46:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49EDA1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586458038;
	bh=f0yU0CuR/ZMjd39XKLnPTvknW9m4vwkLPdqnMig48Fo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WbPVwNWhXvZFq578i8xUomgX79eEqtJ+0SA0rAXkzLPsATlWOQ5PoX6vpqv+Q7ZZD
	 vrkyx+X7CIaRCHgUFywQv22B8HyBVYqIgrsp0r31Tgx7enFuj+C7Z8+0uzpLaxVKA2
	 ZtEjdyei3VBy92e12dMZR22mYA9omfArU2A64Gyo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0D2DF80273;
	Thu,  9 Apr 2020 20:44:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1243CF80213; Thu,  9 Apr 2020 20:44:46 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E836BF80107
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 20:44:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E836BF80107
IronPort-SDR: Y35IEx9wqOaaeaFrObhHvmRgWWMcJ6c9vXAxOaARTZU6DgYfGDUCFqxWiq4KXZgPfMl3x+Gz5e
 i/85LPIQ6y9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 11:44:32 -0700
IronPort-SDR: UaQIZ+qNSLSpJc/jGL/r5ptXRBQFT94RZ/NXwyIK0Tp8Whl4+ODhISjrXvmMuqhs7r9f2EdoQV
 PRPFTRhj8dXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="251981342"
Received: from davidadu-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.151.218])
 by orsmga003.jf.intel.com with ESMTP; 09 Apr 2020 11:44:31 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/4] ASoC: SOF: Intel: hda: reduce verbosity on SoundWire
 detection
Date: Thu,  9 Apr 2020 13:44:14 -0500
Message-Id: <20200409184416.15591-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409184416.15591-1-pierre-louis.bossart@linux.intel.com>
References: <20200409184416.15591-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org
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

No need to report an error when SoundWire is not detected (not present
in hardware or not exposed in ACPI). Move to dev_dbg to state that
SoundWire is skipped.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 211e91e79eae..6cbe2edc868c 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -135,10 +135,8 @@ static int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
 	hdev = sdev->pdata->hw_pdata;
 
 	ret = sdw_intel_acpi_scan(handle, &hdev->info);
-	if (ret < 0) {
-		dev_err(sdev->dev, "%s failed\n", __func__);
+	if (ret < 0)
 		return -EINVAL;
-	}
 
 	return 0;
 }
@@ -604,7 +602,7 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	/* scan SoundWire capabilities exposed by DSDT */
 	ret = hda_sdw_acpi_scan(sdev);
 	if (ret < 0) {
-		dev_dbg(sdev->dev, "skipping SoundWire, ACPI scan error\n");
+		dev_dbg(sdev->dev, "skipping SoundWire, not detected with ACPI scan\n");
 		goto skip_soundwire;
 	}
 
-- 
2.20.1

