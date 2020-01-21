Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60FEC2D0CE
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:41:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEE021569
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="esTGuj7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEE021569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7215169F;
	Tue, 21 Jan 2020 18:41:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7215169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579628514;
	bh=w3rwGbqQ9dmPYW9dy6nEqSrMCS0ziNZdu/y3XaR3Hl8=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=esTGuj7H/NVEgYrAXwe9+Uu1N8KJfvxCioL6Wi9P/l9OxylUPkDhaSNiTmFUXSNIB
	 U/RvI8RbirvzhZSDsQocVv5284RBiyuIrJcOmLaZShtSItvSxlfPPG+LG5VXt2tc74
	 eL2FHQnVLQYgUf9veHebxEssqG8hHVRBerr+ws/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C686F80363;
	Tue, 21 Jan 2020 18:29:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2818FF80346; Tue, 21 Jan 2020 18:29:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 70EF9F80322
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 18:28:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70EF9F80322
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3E7730E;
 Tue, 21 Jan 2020 09:28:53 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 528F43F6C4;
 Tue, 21 Jan 2020 09:28:53 -0800 (PST)
Date: Tue, 21 Jan 2020 17:28:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d0bfym53.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87d0bfym53.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: atmel: atmel_ssc_dai: move
	.suspend/.resume to component" to the asoc tree
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

   ASoC: atmel: atmel_ssc_dai: move .suspend/.resume to component

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

From e4f8bb37efae2b2be51f4d872fffcd09001c1f75 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Jan 2020 10:03:36 +0900
Subject: [PATCH] ASoC: atmel: atmel_ssc_dai: move .suspend/.resume to
 component

There is no big difference at implementation for .suspend/.resume
between DAI driver and Component driver.
But because some driver is using DAI version, thus ALSA SoC needs
to keep supporting it, hence, framework becoming verbose.
If we can switch all DAI driver .suspend/.resume to Component driver,
we can remove verbose code from ALSA SoC.

Driver is getting its private data via dai->dev.
But dai->dev and component->dev are same dev, thus, we can convert
these. For same reason, we can convert dai->active to
component->active if necessary.

This patch moves DAI driver .suspend/.resume to Component driver

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87d0bfym53.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index ca603397651c..1073f468f21f 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -760,12 +760,12 @@ static int atmel_ssc_trigger(struct snd_pcm_substream *substream,
 }
 
 #ifdef CONFIG_PM
-static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
+static int atmel_ssc_suspend(struct snd_soc_component *component)
 {
 	struct atmel_ssc_info *ssc_p;
-	struct platform_device *pdev = to_platform_device(cpu_dai->dev);
+	struct platform_device *pdev = to_platform_device(component->dev);
 
-	if (!cpu_dai->active)
+	if (!component->active)
 		return 0;
 
 	ssc_p = &ssc_info[pdev->id];
@@ -787,15 +787,13 @@ static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
-
-
-static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
+static int atmel_ssc_resume(struct snd_soc_component *component)
 {
 	struct atmel_ssc_info *ssc_p;
-	struct platform_device *pdev = to_platform_device(cpu_dai->dev);
+	struct platform_device *pdev = to_platform_device(component->dev);
 	u32 cr;
 
-	if (!cpu_dai->active)
+	if (!component->active)
 		return 0;
 
 	ssc_p = &ssc_info[pdev->id];
@@ -839,8 +837,6 @@ static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
 };
 
 static struct snd_soc_dai_driver atmel_ssc_dai = {
-		.suspend = atmel_ssc_suspend,
-		.resume = atmel_ssc_resume,
 		.playback = {
 			.channels_min = 1,
 			.channels_max = 2,
@@ -860,6 +856,8 @@ static struct snd_soc_dai_driver atmel_ssc_dai = {
 
 static const struct snd_soc_component_driver atmel_ssc_component = {
 	.name		= "atmel-ssc",
+	.suspend	= atmel_ssc_suspend,
+	.resume		= atmel_ssc_resume,
 };
 
 static int asoc_ssc_init(struct device *dev)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
