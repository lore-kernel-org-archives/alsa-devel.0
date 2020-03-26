Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA95C43331
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:06:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EBD20658
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z/QShErC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EBD20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BB691673;
	Thu, 26 Mar 2020 20:05:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BB691673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585249597;
	bh=/4bDJSZwauyArdNAWxVVzqwAPgOHxk3DFXuXCgfOQ4g=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Z/QShErCoG/gnir/JzD0G0Ko50TsgtEeIEEQKMI6k15C9eWJG6qDM5PkMLljf39wZ
	 DpJ5UNy10U/MB9xTsbY31SNmv/HXOFM+W1ymEOxja8sRQ6gBTB2kmsle5lXiOrQ2Kd
	 9Ix0vG5zEkATbLl7cVQqXsU0PImC8cQPHJ/9a6n0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B39BF80234;
	Thu, 26 Mar 2020 20:04:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09C60F80274; Thu, 26 Mar 2020 20:04:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2DF89F8011E
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 20:04:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DF89F8011E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7E1E1045;
 Thu, 26 Mar 2020 12:04:48 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6504A3F71F;
 Thu, 26 Mar 2020 12:04:48 -0700 (PDT)
Date: Thu, 26 Mar 2020 19:04:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: Select regmap from AC'97 machines" to the asoc
 tree
In-Reply-To: <20200326151053.40806-1-broonie@kernel.org>
Message-Id: <applied-20200326151053.40806-1-broonie@kernel.org>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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

   ASoC: pxa: Select regmap from AC'97 machines

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

From 60a260169abd78a71d1fa3f0384fbe78aab3ffdb Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 26 Mar 2020 15:10:53 +0000
Subject: [PATCH] ASoC: pxa: Select regmap from AC'97 machines

regmap needs to be selected by users which for machine drivers that select
AC'97 CODEC drivers means that we need to also select regmap to ensure that
the CODEC driver will build if nothing else enables regmap as is likely for
such systems.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20200326151053.40806-1-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 295cfffa4646..1f0c08b06c1d 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -81,6 +81,7 @@ config SND_PXA2XX_SOC_TOSA
 	depends on SND_PXA2XX_SOC && MACH_TOSA
 	depends on MFD_TC6393XB
 	depends on AC97_BUS=n
+	select REGMAP
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -91,6 +92,7 @@ config SND_PXA2XX_SOC_E740
 	tristate "SoC AC97 Audio support for e740"
 	depends on SND_PXA2XX_SOC && MACH_E740
 	depends on AC97_BUS=n
+	select REGMAP
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -101,6 +103,7 @@ config SND_PXA2XX_SOC_E750
 	tristate "SoC AC97 Audio support for e750"
 	depends on SND_PXA2XX_SOC && MACH_E750
 	depends on AC97_BUS=n
+	select REGMAP
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -111,6 +114,7 @@ config SND_PXA2XX_SOC_E800
 	tristate "SoC AC97 Audio support for e800"
 	depends on SND_PXA2XX_SOC && MACH_E800
 	depends on AC97_BUS=n
+	select REGMAP
 	select SND_SOC_WM9712
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -122,6 +126,7 @@ config SND_PXA2XX_SOC_EM_X270
 	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
 			MACH_CM_X300)
 	depends on AC97_BUS=n
+	select REGMAP
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -133,6 +138,7 @@ config SND_PXA2XX_SOC_PALM27X
 	depends on SND_PXA2XX_SOC && (MACH_PALMLD || MACH_PALMTX || \
 			MACH_PALMT5 || MACH_PALMTE2)
 	depends on AC97_BUS=n
+	select REGMAP
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -164,6 +170,7 @@ config SND_SOC_ZYLONITE
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
 	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
+	select REGMAP
 	select SND_PXA_SOC_SSP
 	select SND_SOC_WM9713
 	help
@@ -193,6 +200,7 @@ config SND_PXA2XX_SOC_MIOA701
 	tristate "SoC Audio support for MIO A701"
 	depends on SND_PXA2XX_SOC && MACH_MIOA701
 	depends on AC97_BUS=n
+	select REGMAP
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9713
 	help
-- 
2.20.1

