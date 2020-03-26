Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08432C43331
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:11:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87262206E6
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bUR99/w/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87262206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5B13166D;
	Thu, 26 Mar 2020 20:10:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5B13166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585249881;
	bh=H2fMiIf+vEY03q8n3Ah8TTcE3Mgg0pQ1xRhngVrFRmk=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=bUR99/w/KrCVQ64nwUblbZAowsXa74SufHtuP5skI+ma3lHJYhBBcU8Su2bz7vMGG
	 6cuPqfH9zwbfsU2XPqRlxS7Hms6YL1OJf9IayQNHl01GIO8D4j9bVbflZs4ypFDmEx
	 o8bsx8LvPQymCglf2tcFdqs0zeSY6AgC3OocQHG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79D24F802E8;
	Thu, 26 Mar 2020 20:05:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DA20F802E9; Thu, 26 Mar 2020 20:05:28 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 850EAF802E7
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 20:05:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 850EAF802E7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B2AE7FA;
 Thu, 26 Mar 2020 12:05:24 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2F713F71F;
 Thu, 26 Mar 2020 12:05:23 -0700 (PDT)
Date: Thu, 26 Mar 2020 19:05:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Subject: Applied "ASoC: Intel: common: Add mach table for tgl-max98373-rt5682"
 to the asoc tree
In-Reply-To: <20200325213245.28247-5-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200325213245.28247-5-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Jairaj Arava <jairaj.arava@intel.com>,
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

The patch

   ASoC: Intel: common: Add mach table for tgl-max98373-rt5682

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

From eb1006c6ecf931e7f63d551e38569fbe4ebd5c1e Mon Sep 17 00:00:00 2001
From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Date: Wed, 25 Mar 2020 16:32:45 -0500
Subject: [PATCH] ASoC: Intel: common: Add mach table for tgl-max98373-rt5682

Update tgl mach table with: Maxim98373 Amp and ALC5682 hp codec.
Both of the codecs are on I2S bus.

Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200325213245.28247-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index 5984dd151f3e..c15eae402b18 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -46,6 +46,11 @@ static const struct snd_soc_acpi_link_adr tgl_rvp[] = {
 	{}
 };
 
+static struct snd_soc_acpi_codecs tgl_max98373_amp = {
+	.num_codecs = 1,
+	.codecs = {"MX98373"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	{
 		.id = "10EC1308",
@@ -63,6 +68,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 		.sof_fw_filename = "sof-tgl.ri",
 		.sof_tplg_filename = "sof-tgl-max98357a-rt5682.tplg",
 	},
+	{
+		.id = "10EC5682",
+		.drv_name = "tgl_max98373_rt5682",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &tgl_max98373_amp,
+		.sof_fw_filename = "sof-tgl.ri",
+		.sof_tplg_filename = "sof-tgl-max98373-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_machines);
-- 
2.20.1

