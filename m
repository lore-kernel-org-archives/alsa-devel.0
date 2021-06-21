Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4189DC4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 19:44:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA78A610EA
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 19:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA78A610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2740416AB;
	Mon, 21 Jun 2021 21:43:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2740416AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624304677;
	bh=2ZnRoc0njd+yEfkPSsN2EFJyfPBfETtMwzqlxrOG5Es=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s08GaXo/ITpGGSVcMag7o1Tf34hhR1+FttSriSFM5VZ2NZvbOvzKGQ+Uil5CuxKQA
	 c5dV4Si/gRyH22y72FpaEp4S488qyvFbCv/Ucf8f4Rw2fFEKeDc2296uUwAnCf9Oev
	 q+BcY5Zi0Eh8X4Lbq+zJpk+4botGxdaUiLxHt280=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E07C0F804E5;
	Mon, 21 Jun 2021 21:41:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80932F80111; Mon, 21 Jun 2021 21:41:34 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7EED1F8016B
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 21:41:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EED1F8016B
IronPort-SDR: TEdx2Lmb6RtdqmCqaesCz4xt8z4w7nM4ZtKels/MsRyKghXOjOQjmc1pM/KupsOFYWBnnK8WrK
 UJlp6LbcZGmg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203903334"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="203903334"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 12:41:20 -0700
IronPort-SDR: e1YMF1mk7oYCLOwzwoLjEvZSThrr8CBZwkiPdnRfSmoNs85NrC8bWlh/2swnSTS9aKk4fCXn3j
 AGj5n+IwldWA==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="486619051"
Received: from gwhaugh-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.175.53])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 12:41:19 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 04/10] ASoC: Intel: glk_rt5682_max98357a: shrink
 platform_id below 20 characters
Date: Mon, 21 Jun 2021 14:40:51 -0500
Message-Id: <20210621194057.21711-5-pierre-louis.bossart@linux.intel.com>
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

Sparse throws the following warning:

sound/soc/intel/boards/glk_rt5682_max98357a.c:622:25: error: too long
initializer-string for array of char(no space for nul char)

Fix by using the 'mx' acronym for Maxim

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/intel/boards/glk_rt5682_max98357a.c     | 4 ++--
 sound/soc/intel/common/soc-acpi-intel-glk-match.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index 19e2ff90886a..9b92625288cb 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -619,7 +619,7 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 
 static const struct platform_device_id glk_board_ids[] = {
 	{
-		.name = "glk_rt5682_max98357a",
+		.name = "glk_rt5682_mx98357a",
 		.driver_data =
 			(kernel_ulong_t)&glk_audio_card_rt5682_m98357a,
 	},
@@ -641,5 +641,5 @@ MODULE_DESCRIPTION("Geminilake Audio Machine driver-RT5682 & MAX98357A in I2S mo
 MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
 MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:glk_rt5682_max98357a");
+MODULE_ALIAS("platform:glk_rt5682_mx98357a");
 MODULE_IMPORT_NS(SND_SOC_INTEL_HDA_DSP_COMMON);
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 8c6264622da9..da1e151190b4 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -33,7 +33,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 	},
 	{
 		.id = "10EC5682",
-		.drv_name = "glk_rt5682_max98357a",
+		.drv_name = "glk_rt5682_mx98357a",
 		.fw_filename = "intel/dsp_fw_glk.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &glk_codecs,
-- 
2.25.1

