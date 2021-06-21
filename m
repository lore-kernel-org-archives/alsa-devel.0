Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E402C4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 19:44:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A53C6102A
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 19:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A53C6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAAED1690;
	Mon, 21 Jun 2021 21:43:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAAED1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624304643;
	bh=is6R8nzw1suy8bqhxCLmnrRSQ9afoM1kzyjsrgqhQwI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QnNsHQ8JYQzdWX0MheQp4CKF5kt2pp4JZGsamqEcO4V4HBUs6askD+jaQwEZXAqUM
	 idqVJoC8ej4VdkF0zwmcRLgdJu9ddSYgWUInUZYqg4mpKkLtAkI9XOr4822igx/ith
	 gZPtNRcJ56WTEnQlcD6/RczsQ4taXxISgHSouNqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 404C5F804DA;
	Mon, 21 Jun 2021 21:41:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78995F804DF; Mon, 21 Jun 2021 21:41:34 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EF71F804B0
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 21:41:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EF71F804B0
IronPort-SDR: 836yyhUWjIwzlA7yd/z2usZeRAmAHeJUAIo4lp3/XMzTiFCQsMSXeH0Lo1u5ebZK8hIOg+TSo7
 S3+wcydtAtBQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203903336"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="203903336"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 12:41:21 -0700
IronPort-SDR: NbsB7ZtJxxRx/+BwK495S/kn8CXZlbYYDRQrg1/58eVv2wBDwOI71N2saarHm7UfJt6ZnaQa9s
 RExaCFcgVW7g==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="486619061"
Received: from gwhaugh-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.175.53])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 12:41:20 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 05/10] ASoC: Intel: kbl_da7219_max98357a: shrink
 platform_id below 20 characters
Date: Mon, 21 Jun 2021 14:40:52 -0500
Message-Id: <20210621194057.21711-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621194057.21711-1-pierre-louis.bossart@linux.intel.com>
References: <20210621194057.21711-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Paul Olaru <paul.olaru@oss.nxp.com>
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

