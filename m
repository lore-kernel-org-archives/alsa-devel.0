Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8435AC352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:02:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B552082F
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f8+UTWsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B552082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4681115E2;
	Tue, 11 Feb 2020 17:01:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4681115E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581436919;
	bh=KG6hXBdiB+XPr4Az6jQFqSvPLXeh8Mrtrbb7in0cRpE=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=f8+UTWsFVCy/tyqKKU2gwdjrPQtKgUqByBJTKoGzdv1QIVhal43RaWejAqGvLm+6S
	 7Zf2hOgIryGDPAnw/jdg9AKaFFLA3gFI9J/1SKjIy7DgucOWA/bWVOyK+YCN5Es07U
	 rjcI7vOs4EHGee9aJGe/NCivgh31VsHqV2BSLo5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2213F80350;
	Tue, 11 Feb 2020 16:49:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DF83F80344; Tue, 11 Feb 2020 16:49:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 121D9F80341
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 16:49:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 121D9F80341
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82E6AFEC;
 Tue, 11 Feb 2020 07:49:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 086E83F68E;
 Tue, 11 Feb 2020 07:49:09 -0800 (PST)
Date: Tue, 11 Feb 2020 15:49:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
In-Reply-To: <20200210140950.11090-3-peter.ujfalusi@ti.com>
Message-Id: <applied-20200210140950.11090-3-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com
Subject: [alsa-devel] Applied "ASoC: ti: davinci-mcasp: Add support for
	platforms using UDMA" to the asoc tree
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

   ASoC: ti: davinci-mcasp: Add support for platforms using UDMA

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From fb0c3c6e2007da156d023e91da42c173ea33b102 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 10 Feb 2020 16:09:50 +0200
Subject: [PATCH] ASoC: ti: davinci-mcasp: Add support for platforms using UDMA

k3 devices including am654 and j721e are using UDMA

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20200210140950.11090-3-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/Kconfig         | 4 +++-
 sound/soc/ti/davinci-mcasp.c | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index bf85a160a523..c5408c129f34 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Audio support for Texas Instruments SoCs"
-depends on DMA_OMAP || TI_EDMA || COMPILE_TEST
+depends on DMA_OMAP || TI_EDMA || TI_K3_UDMA || COMPILE_TEST
 
 config SND_SOC_TI_EDMA_PCM
 	tristate
@@ -28,6 +28,7 @@ config SND_SOC_DAVINCI_MCASP
 	tristate "Multichannel Audio Serial Port (McASP) support"
 	select SND_SOC_TI_EDMA_PCM
 	select SND_SOC_TI_SDMA_PCM
+	select SND_SOC_TI_UDMA_PCM
 	help
 	  Say Y or M here if you want to have support for McASP IP found in
 	  various Texas Instruments SoCs like:
@@ -35,6 +36,7 @@ config SND_SOC_DAVINCI_MCASP
 	  - Sitara line of SoCs (AM335x, AM438x, etc)
 	  - DRA7x devices
 	  - Keystone devices
+	  - K3 devices (am654, j721e)
 
 config SND_SOC_DAVINCI_VCIF
 	tristate "daVinci Voice Interface (VCIF) support"
diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index e1e937eb1dc1..d9c3a3210a24 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -38,6 +38,7 @@
 
 #include "edma-pcm.h"
 #include "sdma-pcm.h"
+#include "udma-pcm.h"
 #include "davinci-mcasp.h"
 
 #define MCASP_MAX_AFIFO_DEPTH	64
@@ -1875,6 +1876,7 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 enum {
 	PCM_EDMA,
 	PCM_SDMA,
+	PCM_UDMA,
 };
 static const char *sdma_prefix = "ti,omap";
 
@@ -1912,6 +1914,8 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 	dev_dbg(mcasp->dev, "DMA controller compatible = \"%s\"\n", tmp);
 	if (!strncmp(tmp, sdma_prefix, strlen(sdma_prefix)))
 		return PCM_SDMA;
+	else if (strstr(tmp, "udmap"))
+		return PCM_UDMA;
 
 	return PCM_EDMA;
 }
@@ -2371,6 +2375,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	case PCM_SDMA:
 		ret = sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
 		break;
+	case PCM_UDMA:
+		ret = udma_pcm_platform_register(&pdev->dev);
+		break;
 	default:
 		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
 	case -EPROBE_DEFER:
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
