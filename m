Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89595C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1211D20781
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XGGN2Xwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1211D20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89FA91AB1;
	Thu, 25 Jun 2020 21:16:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89FA91AB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593112632;
	bh=Qc32TZBMXazm92GRoVNRgpopIFHLtUYgGpvV6fLFjzY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGGN2Xwt+z6PntNUoexVrKQBJY3EXX8F1sSd5tCzPH0NoLhd/FWGBGObhHINssBFJ
	 LBHOOPNI9/jLj431rlsLEetIhjnGfmAeyszmY2SUycfAyL0Nb5fxpH2/A+zhRUsSdW
	 IfrK2ksb+mwpKl0fhGrGixFhKBAKWz6PLvNqGtsM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9283BF802D2;
	Thu, 25 Jun 2020 21:14:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8FD0F802A1; Thu, 25 Jun 2020 21:13:51 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79DAEF80218
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 21:13:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79DAEF80218
IronPort-SDR: IybRL7CBIKwlfSy+8q/IxT2dbTdaNDkIHIDg+HuZDRu5+LDKw1yXO3BmV360Cw1Wzi60ZFc7Yp
 ttFLpOJzrP0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144120822"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="144120822"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 12:13:36 -0700
IronPort-SDR: VnOXuiU6u1ZHvL9352bPjbGU5JlYfoas76JPpdBaZP/4733xIqiRMhhkxS/dodYoQuv66C3qwe
 wzM4yAXkXQUQ==
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="354559496"
Received: from zeqimao-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.109.39])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 12:13:36 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/17] ASoC: Intel: boards: byt*.c: remove cast in dev_info
 quirk log
Date: Thu, 25 Jun 2020 14:12:57 -0500
Message-Id: <20200625191308.3322-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625191308.3322-1-pierre-louis.bossart@linux.intel.com>
References: <20200625191308.3322-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>
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

We don't need an explicit cast, using the right format is simple
enough.

Suggested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 5 ++---
 sound/soc/intel/boards/bytcr_rt5640.c  | 4 ++--
 sound/soc/intel/boards/bytcr_rt5651.c  | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 98e47a5d3a65..71b39e579af9 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -525,9 +525,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 			BYT_CHT_ES8316_MONO_SPEAKER;
 	}
 	if (quirk_override != -1) {
-		dev_info(dev, "Overriding quirk 0x%x => 0x%x\n",
-			 (unsigned int)quirk,
-			 quirk_override);
+		dev_info(dev, "Overriding quirk 0x%lx => 0x%x\n",
+			 quirk, quirk_override);
 		quirk = quirk_override;
 	}
 	log_quirks(dev);
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 1851aea983c7..a46777b80485 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1265,8 +1265,8 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	if (dmi_id)
 		byt_rt5640_quirk = (unsigned long)dmi_id->driver_data;
 	if (quirk_override != -1) {
-		dev_info(&pdev->dev, "Overriding quirk 0x%x => 0x%x\n",
-			 (unsigned int)byt_rt5640_quirk, quirk_override);
+		dev_info(&pdev->dev, "Overriding quirk 0x%lx => 0x%x\n",
+			 byt_rt5640_quirk, quirk_override);
 		byt_rt5640_quirk = quirk_override;
 	}
 
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 3e5cd3a87c3d..57bec0554ba8 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -977,8 +977,8 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	dmi_check_system(byt_rt5651_quirk_table);
 
 	if (quirk_override != -1) {
-		dev_info(&pdev->dev, "Overriding quirk 0x%x => 0x%x\n",
-			 (unsigned int)byt_rt5651_quirk, quirk_override);
+		dev_info(&pdev->dev, "Overriding quirk 0x%lx => 0x%x\n",
+			 byt_rt5651_quirk, quirk_override);
 		byt_rt5651_quirk = quirk_override;
 	}
 
-- 
2.20.1

