Return-Path: <SRS0=vuHx=ZK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB89EC432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:51:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A982192B
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l5MzlwaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A982192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B40D169E;
	Mon, 18 Nov 2019 18:50:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B40D169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574099487;
	bh=xoADsm24Otqpra0NoWUmPtayJ1X98GbFMYBDqXB9iI4=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=l5MzlwaRrnkWUZk9CbKYiazALJUdifFblaHIde3oIqqQHYdkoLyeW2Um396ozF1Yy
	 DlExvWAgkcptgMC7txxF4xV7RvWU/fnmik8ZU69Qha8Il/pzamtXwGvGUY0+IR/zBJ
	 +d5KhQ4goaFNQIxfIh5VOF7mP821d6HWyCsZmhcE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FFA7F80146;
	Mon, 18 Nov 2019 18:48:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3846F80150; Mon, 18 Nov 2019 18:48:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id EC415F80146
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 18:48:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC415F80146
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8702D1FB;
 Mon, 18 Nov 2019 09:48:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA34A3F703;
 Mon, 18 Nov 2019 09:48:49 -0800 (PST)
Date: Mon, 18 Nov 2019 17:48:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
In-Reply-To: <20191111222901.19892-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191111222901.19892-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: Intel: Fix CFL and CML FW nocodec
	binary names." to the asoc tree
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

The patch

   ASoC: SOF: Intel: Fix CFL and CML FW nocodec binary names.

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 653c28afa76b45c570370c3c3a89975c68c5fc8e Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Mon, 11 Nov 2019 16:29:00 -0600
Subject: [PATCH] ASoC: SOF: Intel: Fix CFL and CML FW nocodec binary names.

The manifest information is different between CNL, CML and CFL platforms
hence we need to load different files.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191111222901.19892-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/sof-pci-dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 4de90d04a91b..3252dbe277c8 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -119,7 +119,7 @@ static const struct sof_dev_desc cnl_desc = {
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_COFFEELAKE)
 static const struct sof_dev_desc cfl_desc = {
-	.machines		= snd_soc_acpi_intel_cnl_machines,
+	.machines		= snd_soc_acpi_intel_cfl_machines,
 	.resindex_lpe_base	= 0,
 	.resindex_pcicfg_base	= -1,
 	.resindex_imr_base	= -1,
@@ -128,7 +128,7 @@ static const struct sof_dev_desc cfl_desc = {
 	.chip_info = &cnl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
-	.nocodec_fw_filename = "sof-cnl.ri",
+	.nocodec_fw_filename = "sof-cfl.ri",
 	.nocodec_tplg_filename = "sof-cnl-nocodec.tplg",
 	.ops = &sof_cnl_ops,
 	.arch_ops = &sof_xtensa_arch_ops
@@ -139,7 +139,7 @@ static const struct sof_dev_desc cfl_desc = {
 	IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_H)
 
 static const struct sof_dev_desc cml_desc = {
-	.machines		= snd_soc_acpi_intel_cnl_machines,
+	.machines		= snd_soc_acpi_intel_cml_machines,
 	.resindex_lpe_base	= 0,
 	.resindex_pcicfg_base	= -1,
 	.resindex_imr_base	= -1,
@@ -148,7 +148,7 @@ static const struct sof_dev_desc cml_desc = {
 	.chip_info = &cnl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
-	.nocodec_fw_filename = "sof-cnl.ri",
+	.nocodec_fw_filename = "sof-cml.ri",
 	.nocodec_tplg_filename = "sof-cnl-nocodec.tplg",
 	.ops = &sof_cnl_ops,
 	.arch_ops = &sof_xtensa_arch_ops
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
