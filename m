Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC08DC3E8AC
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:26:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377B124656
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iyoJy+C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377B124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E7AB16DA;
	Mon,  9 Dec 2019 20:17:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E7AB16DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575919078;
	bh=Kyf3QNCzq3/yCbznBdLwS8y+wkrDHsGChRXu/WY61BM=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=iyoJy+C/uoi2INXCGqODRR0VaZY0XHt22L7iK3gjHfjB+Au7q4ZiPeSl5MsLUJqzN
	 iFpIwl90rQkglgUNHnSZJqAw2fLOf/KsqVXY45Kskxf0gwQIh+66Ptv6V6z1Nxs+mj
	 /e2xg/ulwnkHR8UHz1TNCkZoh8kHVZTzHbseZ1bg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6574DF803BD;
	Mon,  9 Dec 2019 19:59:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBE06F8034A; Mon,  9 Dec 2019 19:59:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1ABC2F801F4
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 19:59:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1ABC2F801F4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E1131396;
 Mon,  9 Dec 2019 10:59:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1C853F6CF;
 Mon,  9 Dec 2019 10:59:40 -0800 (PST)
Date: Mon, 09 Dec 2019 18:59:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
In-Reply-To: <20191126145304.24204-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191126145304.24204-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: Intel: boards: make common HDMI driver
	the default for SOF" to the asoc tree
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

   ASoC: Intel: boards: make common HDMI driver the default for SOF

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

From e3d8f8ae5b1ef0d470b70f65174bbf670bc74130 Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Tue, 26 Nov 2019 08:53:03 -0600
Subject: [PATCH] ASoC: Intel: boards: make common HDMI driver the default for
 SOF

Modify Kconfig rules for machine drivers used by SOF to pick
SND_HDA_CODEC_HDMI by default if other conditions are met. For
shared machine drivers used also by older SST driver, keep using
HDAC_HDMI.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191126145304.24204-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index ef20316e83d1..575064b315ef 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -261,6 +261,7 @@ config SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
+	select SND_HDA_CODEC_HDMI if SND_SOC_SOF_HDA_CODEC
 	select SND_SOC_HDAC_HDMI
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON
@@ -387,6 +388,7 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	select SND_SOC_RT5682
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
+	select SND_HDA_CODEC_HDMI if SND_SOC_SOF_HDA_CODEC
 	select SND_SOC_HDAC_HDMI
 	help
 	   This adds support for ASoC machine driver for Geminilake platforms
@@ -400,6 +402,7 @@ if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC || SND_SOC_SOF_HDA_AUDIO_CODEC
 
 config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
 	tristate "SKL/KBL/BXT/APL with HDA Codecs"
+	select SND_HDA_CODEC_HDMI if SND_SOC_SOF_HDA_CODEC
 	select SND_SOC_HDAC_HDMI
 	select SND_SOC_DMIC
 	# SND_SOC_HDAC_HDA is already selected
@@ -419,6 +422,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
 		   (SND_SOC_SOF_BAYTRAIL && (X86_INTEL_LPSS || COMPILE_TEST))
 	select SND_SOC_RT5682
 	select SND_SOC_DMIC
+	select SND_HDA_CODEC_HDMI if SND_SOC_SOF_HDA_CODEC
 	select SND_SOC_HDAC_HDMI
 	help
 	   This adds support for ASoC machine driver for SOF platforms
@@ -448,6 +452,7 @@ config SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH
 	select SND_SOC_RT5682
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
+	select SND_HDA_CODEC_HDMI if SND_SOC_SOF_HDA_CODEC
 	help
 	  This adds support for ASoC machine driver for SOF platform with
 	  RT1011 + RT5682 I2S codec.
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
