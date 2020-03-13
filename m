Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2225CC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:25:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2618206FA
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b8XsMPSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2618206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ECF2184D;
	Fri, 13 Mar 2020 17:24:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ECF2184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584116709;
	bh=J/jvDFzmt6PSXZQTC4oiNmWN+KE/MCKKvyLDJ15r6ZI=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=b8XsMPSNYS4qADlVvkmYw2s2bPdgSMPG+6X7DdLgDx32qiCVWGFgty2WfROPGDzfQ
	 2M8b7VwffDVn9iyuP6vXBjQ5846ojemPQEitCigirGXcwC6HhDlq+uqstD+L0x1gZG
	 3gJrIPvGhkp7MsYyxG6AxqyW37tStNceu5bg/3eI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2F54F80307;
	Fri, 13 Mar 2020 17:18:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 179CBF802F9; Fri, 13 Mar 2020 17:18:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id A47B9F802E8
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 17:18:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A47B9F802E8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D39B31B;
 Fri, 13 Mar 2020 09:18:01 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5D653F6CF;
 Fri, 13 Mar 2020 09:18:00 -0700 (PDT)
Date: Fri, 13 Mar 2020 16:17:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Applied "ASoC: Intel: sof_pcm512x: drop reverse deps for
 SND_HDA_CODEC_HDMI" to the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
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
Message-ID: <20200313161759.8d4lV1HqTGGEP-FT4GuFqLrm2IbJ4kJNlxnmiXJ2nhQ@z>

The patch

   ASoC: Intel: sof_pcm512x: drop reverse deps for SND_HDA_CODEC_HDMI

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

From 4399afd21a0169a125a16c2dbba68f7d9a2cffdb Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Thu, 12 Mar 2020 14:48:51 -0500
Subject: [PATCH] ASoC: Intel: sof_pcm512x: drop reverse deps for
 SND_HDA_CODEC_HDMI

Having a reverse dependency to a config that has its own additional
dependencies, is generally not recommended. And this applies to
select statements for SND_HDA_CODEC_HDMI, e.g. the case where SND_HDA
and SND_SOC_SOF_HDA are built as modules, but the machine driver is
built-in, leading to compile errors (reported as
i386-randconfig-e003-20200206).

Give up on trying to define different dependencies based on SOF/SST
selection, and simply add a "depends on" for SND_HDA_CODEC_HDMI. This
fixes the issue with randconfigs. Only downside is that SND_HDA_CODEC_HDMI
may be built unnecessarily in some cases, but this seems like the lesser
evil.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200312194859.4051-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 67d85a7be559..6833ef548710 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -464,8 +464,8 @@ config SND_SOC_INTEL_SOF_PCM512x_MACH
 	depends on I2C && ACPI
 	depends on (SND_SOC_SOF_HDA_AUDIO_CODEC && (MFD_INTEL_LPSS || COMPILE_TEST)) ||\
 		   (SND_SOC_SOF_BAYTRAIL && (X86_INTEL_LPSS || COMPILE_TEST))
+	depends on SND_HDA_CODEC_HDMI
 	select SND_SOC_PCM512x_I2C
-	select SND_HDA_CODEC_HDMI if SND_SOC_SOF_HDA_AUDIO_CODEC
 	help
 	  This adds support for ASoC machine driver for SOF platforms
 	  with TI PCM512x I2S audio codec.
-- 
2.20.1

