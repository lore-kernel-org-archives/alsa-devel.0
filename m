Return-Path: <SRS0=j9WI=Y4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816E2CA9EB5
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:29:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039D32184C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fHunaJE4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="f0yrBQbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039D32184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF21D175C;
	Mon,  4 Nov 2019 14:28:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF21D175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572874143;
	bh=TLAvOsvNMKzLax0jOZFoVZL4VVl7vcNEeb2pKX15SqU=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=fHunaJE4Rx8p52+NFlpYpM+yK5BAx32U1aUCADfXSb/01S3A1Qy4qiShVHXuHqLJh
	 roYGBAbCyfCwoCBsjMPOSdCcasnxzElrgqlriZd1os8ywB9LHkt8kawiGCMsVr0hN3
	 vgyufv5cy01CdXR1UcycsTKB3ucKYhBzgo0CNl7k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D27DF80635;
	Mon,  4 Nov 2019 14:27:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10E05F8060D; Mon,  4 Nov 2019 14:27:16 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 557A9F80321
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2019 14:27:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 557A9F80321
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="f0yrBQbP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=3uWYvkVAp/Gz+aHYfP6VJJDXIKFHytpoxHVLXfULA0o=; b=f0yrBQbP/s2U
 b9ETNVvtxIappu5Nou/B7rwZwRdiYTkMVdcgA9ApIKWd3phS7ZcdYRAQ8RyZa0WxrgnOWvqCFAKDa
 FJpVb+d3EXjf1f3KtApdj6F7qUoFzqd1Vrgw3AGPiXBvgeVovNsEm2CadImyYdr1hc6tbpZ2MYp5B
 NaBEk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iRcO0-0002e0-MK; Mon, 04 Nov 2019 13:27:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 2BC26274319C; Mon,  4 Nov 2019 13:27:12 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20191101173045.27099-8-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191104132712.2BC26274319C@ypsilon.sirena.org.uk>
Date: Mon,  4 Nov 2019 13:27:12 +0000 (GMT)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [alsa-devel] Applied "ASoC: Intel: Skylake: mark HDAudio codec
	support as deprecated." to the asoc tree
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

   ASoC: Intel: Skylake: mark HDAudio codec support as deprecated.

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 02701b909c2fab4b49f9c9545ab921c9b2c7a768 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 1 Nov 2019 12:30:41 -0500
Subject: [PATCH] ASoC: Intel: Skylake: mark HDAudio codec support as
 deprecated.

This option famously broke audio on Linus' laptop and the problem have
not been fixed.

Mark as DEPRECATED to avoid any ambiguity with distros.

Use SOF if you need HDaudio support w/ the DSP enabled, e.g. for DMIC
capture.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191101173045.27099-8-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 086fc60b2a14..79b227613108 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -209,9 +209,12 @@ config SND_SOC_INTEL_SKYLAKE_SSP_CLK
 config SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
 	bool "HDAudio codec support"
 	help
-	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
-	  GeminiLake or CannonLake platform with an HDaudio codec
-	  then enable this option by saying Y
+	  This option broke audio on Linus' Skylake laptop in December 2018
+	  and the race conditions during the probe were not fixed since.
+	  This option is DEPRECATED, all HDaudio codec support needs
+	  to be handled by the SOF driver.
+	  Distributions should not enable this option and there are no known
+	  users of this capability.
 
 config SND_SOC_INTEL_SKYLAKE_COMMON
 	tristate
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
