Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC682C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:20:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2962176D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f/wAEs4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2962176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A66961688;
	Wed, 18 Dec 2019 21:19:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A66961688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576700416;
	bh=McSbigfCjCNOf2bXHek66yTJLSeTBjYopQffGMxELXc=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=f/wAEs4DcbZ3C3YpB7k1MbRGUm15VmEdr6OfrNvshi72nS2gndFRkJQRLZpOLrr9U
	 CTPSPQDIfafyXRnDQYHjzfWqH8glpwp27xaT97mtbCZG60X2KTZqAEl9pSbzidmzHS
	 6q6VUvNWTeGOMDrQSg/VCXQpCXKidHt/6AHO1e7E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53883F80372;
	Wed, 18 Dec 2019 21:06:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BE90F8036C; Wed, 18 Dec 2019 21:06:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D9F28F8035F
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 21:06:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9F28F8035F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 348E731B;
 Wed, 18 Dec 2019 12:06:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A71CC3F67D;
 Wed, 18 Dec 2019 12:06:17 -0800 (PST)
Date: Wed, 18 Dec 2019 20:06:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20191217202231.18259-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191217202231.18259-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: SOF: Intel: add namespaces for BAYTRAIL
	and MERRIFIELD" to the asoc tree
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

   ASoC: SOF: Intel: add namespaces for BAYTRAIL and MERRIFIELD

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From e42b19450866fbd447e459d8935c208e3888705a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 17 Dec 2019 14:22:25 -0600
Subject: [PATCH] ASoC: SOF: Intel: add namespaces for BAYTRAIL and MERRIFIELD

Define separate namespaces and include them in ACPI and PCI top-level
modules.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191217202231.18259-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/byt.c    | 12 ++++++------
 sound/soc/sof/sof-acpi-dev.c |  1 +
 sound/soc/sof/sof-pci-dev.c  |  1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index b214b12fdcda..07634873deb6 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -619,13 +619,13 @@ const struct snd_sof_dsp_ops sof_tng_ops = {
 			SNDRV_PCM_INFO_PAUSE |
 			SNDRV_PCM_INFO_BATCH,
 };
-EXPORT_SYMBOL(sof_tng_ops);
+EXPORT_SYMBOL_NS(sof_tng_ops, SND_SOC_SOF_MERRIFIELD);
 
 const struct sof_intel_dsp_desc tng_chip_info = {
 	.cores_num = 1,
 	.cores_mask = 1,
 };
-EXPORT_SYMBOL(tng_chip_info);
+EXPORT_SYMBOL_NS(tng_chip_info, SND_SOC_SOF_MERRIFIELD);
 
 #endif /* CONFIG_SND_SOC_SOF_MERRIFIELD */
 
@@ -793,13 +793,13 @@ const struct snd_sof_dsp_ops sof_byt_ops = {
 			SNDRV_PCM_INFO_PAUSE |
 			SNDRV_PCM_INFO_BATCH,
 };
-EXPORT_SYMBOL(sof_byt_ops);
+EXPORT_SYMBOL_NS(sof_byt_ops, SND_SOC_SOF_BAYTRAIL);
 
 const struct sof_intel_dsp_desc byt_chip_info = {
 	.cores_num = 1,
 	.cores_mask = 1,
 };
-EXPORT_SYMBOL(byt_chip_info);
+EXPORT_SYMBOL_NS(byt_chip_info, SND_SOC_SOF_BAYTRAIL);
 
 /* cherrytrail and braswell ops */
 const struct snd_sof_dsp_ops sof_cht_ops = {
@@ -866,13 +866,13 @@ const struct snd_sof_dsp_ops sof_cht_ops = {
 			SNDRV_PCM_INFO_PAUSE |
 			SNDRV_PCM_INFO_BATCH,
 };
-EXPORT_SYMBOL(sof_cht_ops);
+EXPORT_SYMBOL_NS(sof_cht_ops, SND_SOC_SOF_BAYTRAIL);
 
 const struct sof_intel_dsp_desc cht_chip_info = {
 	.cores_num = 1,
 	.cores_mask = 1,
 };
-EXPORT_SYMBOL(cht_chip_info);
+EXPORT_SYMBOL_NS(cht_chip_info, SND_SOC_SOF_BAYTRAIL);
 
 #endif /* CONFIG_SND_SOC_SOF_BAYTRAIL */
 
diff --git a/sound/soc/sof/sof-acpi-dev.c b/sound/soc/sof/sof-acpi-dev.c
index 9c0a4eed5cc8..6d44d5802e29 100644
--- a/sound/soc/sof/sof-acpi-dev.c
+++ b/sound/soc/sof/sof-acpi-dev.c
@@ -240,3 +240,4 @@ static struct platform_driver snd_sof_acpi_driver = {
 module_platform_driver(snd_sof_acpi_driver);
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(SND_SOC_SOF_BAYTRAIL);
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 5f08a9ca6bf8..0c67e5d7dc33 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -415,3 +415,4 @@ static struct pci_driver snd_sof_pci_driver = {
 module_pci_driver(snd_sof_pci_driver);
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(SND_SOC_SOF_MERRIFIELD);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
