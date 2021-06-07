Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE76CC47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 22:50:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8D560200
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 22:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8D560200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B200016B9;
	Tue,  8 Jun 2021 00:49:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B200016B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623106207;
	bh=is6R8nzw1suy8bqhxCLmnrRSQ9afoM1kzyjsrgqhQwI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j24h/KNGY6zl1B3kZe/hkGqIcZaJ8rGt36fr4/ie2BWudKdVGXkfwNQV4AiLVcPjo
	 J+Bujq/NPDcdbSbjoyjR3tttQhmIagebw/MblUsnlGuBoU9duIwhSlJpZ0s3ppB8RK
	 47pNcfRinAlmAP8Bt8gWmm6vGnYVXqTY05SeEjcM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33CA1F804E1;
	Tue,  8 Jun 2021 00:47:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7BE0EF8026C; Tue,  8 Jun 2021 00:47:09 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B989EF8027C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 00:46:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B989EF8027C
IronPort-SDR: J3bY6EQFvSXzuyouhqutUHmdr84hy3epWkYwuQuaA58bYiazyN4Xl8Y5pEgeOw2y+4gZaQ8Byz
 E9AVFNhMnCAA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185102181"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="185102181"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 15:46:50 -0700
IronPort-SDR: u/bKXVFm5p3p8/Jr9q4eojPwX366m9/H1D1OisYHTtVmkIjsfpdSt2bN5Gw8O7yf4pWwurTszf
 DDKwjU0KuyHQ==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="637437105"
Received: from marocham-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.108.70])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 15:46:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/10] ASoC: Intel: kbl_da7219_max98357a: shrink platform_id
 below 20 characters
Date: Mon,  7 Jun 2021 17:46:33 -0500
Message-Id: <20210607224638.585486-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607224638.585486-1-pierre-louis.bossart@linux.intel.com>
References: <20210607224638.585486-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, Paul Olaru <paul.olaru@oss.nxp.com>
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

Sparse throws the following warnings:

sound/soc/intel/boards/kbl_da7219_max98357a.c:647:25: error: too long
initializer-string for array of char(no space for nul char)

Fix by using the 'mx' acronym for Maxim.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c     | 4 ++--
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index c0d8a73c6d21..7ca3347dbd2e 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -644,7 +644,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 
 static const struct platform_device_id kbl_board_ids[] = {
 	{
-		.name = "kbl_da7219_max98357a",
+		.name = "kbl_da7219_mx98357a",
 		.driver_data =
 			(kernel_ulong_t)&kabylake_audio_card_da7219_m98357a,
 	},
@@ -666,4 +666,4 @@ module_platform_driver(kabylake_audio)
 MODULE_DESCRIPTION("Audio Machine driver-DA7219 & MAX98357A in I2S mode");
 MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:kbl_da7219_max98357a");
+MODULE_ALIAS("platform:kbl_da7219_mx98357a");
diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
index 47dadc9d5d2a..ba5ff468c265 100644
--- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
@@ -113,7 +113,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "kbl_da7219_max98373",
+		.drv_name = "kbl_da7219_mx98373",
 		.fw_filename = "intel/dsp_fw_kbl.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &kbl_7219_98373_codecs,
-- 
2.25.1

