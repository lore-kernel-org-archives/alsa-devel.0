Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA97C2D0CE
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:38:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CAB21569
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N2HsQFO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CAB21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EE11169E;
	Tue, 21 Jan 2020 18:37:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EE11169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579628322;
	bh=7WT1nRGW1RQgVeHHXlmncD89u5ITUO/RTGMqgPrx7+E=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=N2HsQFO62jv1igPtceI/Y8C5QP4VP3AhbkQonl2kAKurloh98GhzBsHzSjg8/HXl4
	 8kU/SwdDaPpVKbp5u5qvAw5rDpxxLNFrwMYay1T3fVf9b/2phczYhjRg/Iy12un/Z+
	 fU4BtfidLLpRutKTGH10la3GpxOkaBdPOY8weCA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CA04F80322;
	Tue, 21 Jan 2020 18:29:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5F78F80332; Tue, 21 Jan 2020 18:28:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 31702F802FB
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 18:28:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31702F802FB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7149F30E;
 Tue, 21 Jan 2020 09:28:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49663F6C4;
 Tue, 21 Jan 2020 09:28:40 -0800 (PST)
Date: Tue, 21 Jan 2020 17:28:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874kwrym42.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-874kwrym42.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: samsung: spdif: move .suspend/.resume
	to component" to the asoc tree
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

   ASoC: samsung: spdif: move .suspend/.resume to component

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

From 79a5cf90f8719c3f69a0dc53efebb38da654512f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Jan 2020 10:04:13 +0900
Subject: [PATCH] ASoC: samsung: spdif: move .suspend/.resume to component

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
Link: https://lore.kernel.org/r/874kwrym42.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/spdif.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 805c57986e0b..1a9f08a50394 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -91,6 +91,12 @@ struct samsung_spdif_info {
 static struct snd_dmaengine_dai_dma_data spdif_stereo_out;
 static struct samsung_spdif_info spdif_info;
 
+static inline struct samsung_spdif_info
+*component_to_info(struct snd_soc_component *component)
+{
+	return snd_soc_component_get_drvdata(component);
+}
+
 static inline struct samsung_spdif_info *to_info(struct snd_soc_dai *cpu_dai)
 {
 	return snd_soc_dai_get_drvdata(cpu_dai);
@@ -290,9 +296,9 @@ static void spdif_shutdown(struct snd_pcm_substream *substream,
 }
 
 #ifdef CONFIG_PM
-static int spdif_suspend(struct snd_soc_dai *cpu_dai)
+static int spdif_suspend(struct snd_soc_component *component)
 {
-	struct samsung_spdif_info *spdif = to_info(cpu_dai);
+	struct samsung_spdif_info *spdif = component_to_info(component);
 	u32 con = spdif->saved_con;
 
 	dev_dbg(spdif->dev, "Entered %s\n", __func__);
@@ -307,9 +313,9 @@ static int spdif_suspend(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
-static int spdif_resume(struct snd_soc_dai *cpu_dai)
+static int spdif_resume(struct snd_soc_component *component)
 {
-	struct samsung_spdif_info *spdif = to_info(cpu_dai);
+	struct samsung_spdif_info *spdif = component_to_info(component);
 
 	dev_dbg(spdif->dev, "Entered %s\n", __func__);
 
@@ -343,12 +349,12 @@ static struct snd_soc_dai_driver samsung_spdif_dai = {
 				SNDRV_PCM_RATE_96000),
 		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
 	.ops = &spdif_dai_ops,
-	.suspend = spdif_suspend,
-	.resume = spdif_resume,
 };
 
 static const struct snd_soc_component_driver samsung_spdif_component = {
 	.name		= "samsung-spdif",
+	.suspend	= spdif_suspend,
+	.resume		= spdif_resume,
 };
 
 static int spdif_probe(struct platform_device *pdev)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
