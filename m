Return-Path: <SRS0=kaWB=7O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C47EC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:20:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166652074B
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ULBOT5ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166652074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9753E1707;
	Mon,  1 Jun 2020 08:19:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9753E1707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590992405;
	bh=6t3LgQbCg5z7w9LwiwK7oRmbPApSWrMEFhfi39sJpkM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ULBOT5iamEqaJgFdCaW3wJCrDnPTvnRM1tF51+oE/bM9FwqxLmTE/TVc3fuX0OL/k
	 qBr7CiTUJ0n6j7yL7E1FKgegcMaZZkZYQDBmYVe0ePMSS71EWizLOzRRGh1FdmMtUu
	 z2DvoThJnMOmgvkgOazDZc/l+oedKuurCUKWmQFs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AFDEF802DC;
	Mon,  1 Jun 2020 08:16:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89CAAF802DD; Mon,  1 Jun 2020 08:16:13 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0D87F802A7
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2020 08:16:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0D87F802A7
IronPort-SDR: m9Ky2KSs+5anfD/Mmurs7Dyr3JAc22YkgsQ5ajDGqiEMWokv49d8aSPzkSO9+ffd7FKf7216rV
 NmMN4dASekgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2020 23:16:03 -0700
IronPort-SDR: k+oWiXyC15/n5k4A3sqbzXGeEPXe/u+NhXVKNCbX1+TPpJq0Q3lJpkJVTuSTwgW04HiZ6uTfsT
 tBcSYzyuhDAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; d="scan'208";a="470208758"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga005.fm.intel.com with ESMTP; 31 May 2020 23:15:58 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 5/6] soundwire: intel_init: pass link information as
 platform data
Date: Mon,  1 Jun 2020 02:21:01 +0800
Message-Id: <20200531182102.27840-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
References: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

It's not clear how this code ever worked, the link information is used
in intel.c but never passed as platform_data.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index f9d190157c47..ff1017e64abd 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -128,6 +128,8 @@ static struct sdw_intel_ctx
 		pdevinfo.name = "int-sdw";
 		pdevinfo.id = i;
 		pdevinfo.fwnode = acpi_fwnode_handle(adev);
+		pdevinfo.data = link;
+		pdevinfo.size_data = sizeof(*link);
 
 		pdev = platform_device_register_full(&pdevinfo);
 		if (IS_ERR(pdev)) {
-- 
2.17.1

