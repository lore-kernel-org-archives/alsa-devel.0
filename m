Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0651C432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:35:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F3020722
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vjc8FjUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F3020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C64B1754;
	Tue, 26 Nov 2019 15:34:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C64B1754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574778923;
	bh=QVxPsyax75/VAN1MgPHXcgRStPiSN9nQzGRdcTAv838=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vjc8FjUMN1mvpaeFD+cZ8vBM7aEbXncDcKs3GUUOx9yPgPPS6SQc/wTUm9aavuwxo
	 Z9A+6s1bBSjRl/lWlu/8cM9g/niG8YKiGyDMDYKbbGMssHWRC/89D15B3yfYpJxJ4C
	 gm2LAJtUj8ab0siK5Km4ThPCcPsJ/3fVTmjZSBq8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5568F80266;
	Tue, 26 Nov 2019 15:28:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABEF2F8022B; Tue, 26 Nov 2019 15:28:48 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AE13F801ED
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2019 15:28:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AE13F801ED
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 06:28:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; d="scan'208";a="206473490"
Received: from vramali2-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.155.193])
 by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2019 06:28:35 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 26 Nov 2019 08:28:15 -0600
Message-Id: <20191126142815.21856-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126142815.21856-1-pierre-louis.bossart@linux.intel.com>
References: <20191126142815.21856-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 10/10] ASoC: SOF: nocodec: Amend arguments for
	sof_nocodec_setup()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Set the drv_name and tplg_filename for nocodec
machine driver in sof_machine_check().
This means the sof_nocodec_setup() does not
need the mach, plat_data or desc arguments any longer.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof.h       | 3 ---
 sound/soc/sof/nocodec.c   | 9 ---------
 sound/soc/sof/sof-audio.c | 5 ++++-
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 96625355aa94..6ea74f1a9ec2 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -97,8 +97,5 @@ struct sof_dev_desc {
 };
 
 int sof_nocodec_setup(struct device *dev,
-		      struct snd_sof_pdata *sof_pdata,
-		      struct snd_soc_acpi_mach *mach,
-		      const struct sof_dev_desc *desc,
 		      const struct snd_sof_dsp_ops *ops);
 #endif
diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
index 56d887545da3..2233146386cc 100644
--- a/sound/soc/sof/nocodec.c
+++ b/sound/soc/sof/nocodec.c
@@ -63,20 +63,11 @@ static int sof_nocodec_bes_setup(struct device *dev,
 }
 
 int sof_nocodec_setup(struct device *dev,
-		      struct snd_sof_pdata *sof_pdata,
-		      struct snd_soc_acpi_mach *mach,
-		      const struct sof_dev_desc *desc,
 		      const struct snd_sof_dsp_ops *ops)
 {
 	struct snd_soc_dai_link *links;
 	int ret;
 
-	if (!mach)
-		return -EINVAL;
-
-	mach->drv_name = "sof-nocodec";
-	sof_pdata->tplg_filename = desc->nocodec_tplg_filename;
-
 	/* create dummy BE dai_links */
 	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
 			     ops->num_drv, GFP_KERNEL);
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 9c3851bfe788..0d8f65b9ae25 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -396,7 +396,10 @@ int sof_machine_check(struct snd_sof_dev *sdev)
 	if (!mach)
 		return -ENOMEM;
 
-	ret = sof_nocodec_setup(sdev->dev, sof_pdata, mach, desc, desc->ops);
+	mach->drv_name = "sof-nocodec";
+	sof_pdata->tplg_filename = desc->nocodec_tplg_filename;
+
+	ret = sof_nocodec_setup(sdev->dev, desc->ops);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
