Return-Path: <SRS0=mf6l=XU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED3C432C1
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:00:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7930521D7B
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Dtlae6CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7930521D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CC9C16BD;
	Wed, 25 Sep 2019 07:59:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CC9C16BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569391218;
	bh=gRgHxIAVwGYssoYEqGfulvI/CEfgy5duOnwn0zDdrFI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dtlae6CD8Nb7rbC4eZ/8epZQGBkYoAUWvUvmjh8k640AscKaKmCZT1C/wQ96Rk3gG
	 8weq4tGg/wu85XvT4O96+YFzoTfWiktZ21APJTgqlsclN2v+aOiIT/3iOv88eJgdL0
	 zgM4Pfen1medTBIGVYnNM5nfvapdOBAHGOpqlJeM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E712CF805F8;
	Wed, 25 Sep 2019 07:57:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 307E7F80508; Wed, 25 Sep 2019 07:57:47 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97050F8044C
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2019 07:57:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97050F8044C
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 22:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,546,1559545200"; d="scan'208";a="213935572"
Received: from unknown (HELO localhost.localdomain) ([10.223.165.177])
 by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2019 22:57:35 -0700
From: sathya.prakash.m.r@intel.com
To: alsa-devel@alsa-project.org
Date: Wed, 25 Sep 2019 11:33:10 +0530
Message-Id: <1569391390-15328-3-git-send-email-sathya.prakash.m.r@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569391390-15328-1-git-send-email-sathya.prakash.m.r@intel.com>
References: <1569391390-15328-1-git-send-email-sathya.prakash.m.r@intel.com>
Cc: sathya.prakash.m.r@intel.com, naveen.m@intel.com,
 pierre-louis.bossart@linux.intel.com
Subject: [alsa-devel] [PATCH v3 2/2] ASoC: Intel: Add acpi match for rt1011
	based m/c driver
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Naveen Manohar <naveen.m@intel.com>

Add match for CML m/c with RT1011 and RT5682

Changes from V2: re ordered match table
to ensure non i2c device matches are at the end

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
index 771b0ef21051..af7e85a4fc86 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -29,6 +29,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[] = {
 		.sof_tplg_filename = "sof-cnl-rt274.tplg",
 	},
 	{
+		.id = "10EC1011",
+		.drv_name = "cml_rt1011_rt5682",
+		.quirk_data = &cml_codecs,
+		.sof_fw_filename = "sof-cnl.ri",
+		.sof_tplg_filename = "sof-cml-rt1011-rt5682.tplg",
+	},
+	{
 		.id = "MX98357A",
 		.drv_name = "sof_rt5682",
 		.quirk_data = &cml_codecs,
-- 
1.9.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
