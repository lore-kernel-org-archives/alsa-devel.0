Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FC8C43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:31:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006062072F
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gYKHi0xb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006062072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A87A91671;
	Fri, 27 Mar 2020 18:30:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A87A91671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585330296;
	bh=1bKdvCh07zdum/lhr/u0v/71fqv/2WEzavzsmAoGFuk=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=gYKHi0xbcbVOKo0qoxsp6ndvkwKcs0JM46SCAOl5WViBwyXBUSi/lWx+qhJv0ceSS
	 v51V9z2zk7oTglSN2mQxIU6cUGeI4Gv1QWNEFqHJhGF6xKbeyT2E+r75SpTTsAZ79X
	 Zwk6xvgzIaCfqLwK9b4M34CCG2ZYXLjnj7igHqxE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50C05F8028B;
	Fri, 27 Mar 2020 18:29:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9C0BF80274; Fri, 27 Mar 2020 18:29:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id C2692F8015A
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 18:29:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2692F8015A
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86A4D101E;
 Fri, 27 Mar 2020 10:29:00 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0104B3F85E;
 Fri, 27 Mar 2020 10:28:59 -0700 (PDT)
Date: Fri, 27 Mar 2020 17:28:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Naveen Manohar <naveen.m@intel.com>
Subject: Applied "ASoC: Intel: common: add match table for TGL RT5682
 SoundWire driver" to the asoc tree
In-Reply-To: <20200325220746.29601-4-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200325220746.29601-4-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
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

   ASoC: Intel: common: add match table for TGL RT5682 SoundWire driver

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

From 095ee71907ea02702f5fd84184d2656572e2c81c Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Wed, 25 Mar 2020 17:07:45 -0500
Subject: [PATCH] ASoC: Intel: common: add match table for TGL RT5682 SoundWire
 driver

RT5682 is in SoundWire mode on link0.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Link: https://lore.kernel.org/r/20200325220746.29601-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../intel/common/soc-acpi-intel-tgl-match.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index db360c9a8e5b..449d9d2286ae 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -56,6 +56,14 @@ static const struct snd_soc_acpi_adr_device rt1308_1_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt5682_0_adr[] = {
+	{
+		.adr = 0x000021025D568200,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+	}
+};
+
 static const struct snd_soc_acpi_link_adr tgl_i2s_rt1308[] = {
 	{
 		.mask = BIT(0),
@@ -79,6 +87,15 @@ static const struct snd_soc_acpi_link_adr tgl_rvp[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr tgl_chromebook_base[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt5682_0_adr),
+		.adr_d = rt5682_0_adr,
+	},
+	{}
+};
+
 static struct snd_soc_acpi_codecs tgl_max98373_amp = {
 	.num_codecs = 1,
 	.codecs = {"MX98373"}
@@ -122,6 +139,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
 		.sof_fw_filename = "sof-tgl.ri",
 		.sof_tplg_filename = "sof-tgl-rt711-rt1308.tplg",
 	},
+	{
+		.link_mask = 0x1, /* this will only enable rt5682 for now */
+		.links = tgl_chromebook_base,
+		.drv_name = "sof_sdw",
+		.sof_fw_filename = "sof-tgl.ri",
+		.sof_tplg_filename = "sof-tgl-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_sdw_machines);
-- 
2.20.1

