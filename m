Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177ABC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:48:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C83864F16
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C83864F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 173C8166C;
	Mon,  1 Mar 2021 18:47:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 173C8166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614620929;
	bh=DV/0smjUkzK8zfhix0PtG/TWcgXpG5v/I/DgL483XjY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a6/yJeTrT2Us2uzpIqhcsKyN/DiNpnFeXuAqvdvakP509a3IFPkwcSZFgVk3Xflmt
	 H3XBZ7aqdtH/vjzvRQJAfy5fGVLdhN3UJ2fbIPueaC0QZWEDz+WRfCTlBsz4Cm6RUa
	 VTTBqI88QrXRMAx4CnUtyIYS9RkGHwlxFbUASCbY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B81E1F8032D;
	Mon,  1 Mar 2021 18:47:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6C09F80423; Mon,  1 Mar 2021 18:47:10 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3472F8032C
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 18:47:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3472F8032C
IronPort-SDR: a+PhyIj2ew9FhVXAyBYRFQpSqcCiToE4jZ4pGSvGM6Qu5DPHqJ3irppt48wqr9OuV8Xz/ZVCX7
 435KXDhfJn2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="165781660"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="165781660"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 09:46:59 -0800
IronPort-SDR: BNUomEEcwauz0ZoybzT13VbL7mhE7xwaKvStpZXUsTCo5yV9iujs7MmGxxlTmLOFyQ5zE6+M/p
 UwpstO2cewNA==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="434363180"
Received: from mhuang8-mobl3.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.25.220])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 09:46:58 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: Intel: atom: fix kernel-doc
Date: Mon,  1 Mar 2021 11:46:49 -0600
Message-Id: <20210301174649.117069-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
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

v5.12-rc1 flags new warnings with make W=1, fix missing or broken
function descriptors.

sound/soc/intel/atom/sst/sst_loader.c:85: warning: expecting prototype
for sst_start_merrifield(). Prototype was for sst_start_mrfld()
instead

sound/soc/intel/atom/sst/sst_acpi.c:339: warning: expecting prototype
for intel_sst_remove(). Prototype was for sst_acpi_remove() instead

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c   | 2 +-
 sound/soc/intel/atom/sst/sst_loader.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 2c1b8a2e3506..3be64430c256 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -328,7 +328,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 }
 
 /**
-* intel_sst_remove - remove function
+* sst_acpi_remove - remove function
 *
 * @pdev:	platform device structure
 *
diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index 1c9b0c9ec483..eea889001c24 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -76,7 +76,7 @@ int intel_sst_reset_dsp_mrfld(struct intel_sst_drv *sst_drv_ctx)
 }
 
 /**
- * sst_start_merrifield - Start the SST DSP processor
+ * sst_start_mrfld - Start the SST DSP processor
  * @sst_drv_ctx: intel_sst_drv context pointer
  *
  * This starts the DSP in MERRIFIELD platfroms
-- 
2.25.1

