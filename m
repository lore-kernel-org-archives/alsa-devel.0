Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDE0C2D0CE
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:37:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E4121569
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GhqapCXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E4121569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5154D1693;
	Tue, 21 Jan 2020 18:36:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5154D1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579628234;
	bh=6oxGSwZrISzIJupS1GTDU60sb88+K4G3M3BmaLyxQaU=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=GhqapCXQK9/iS1EbMHpBxduhvEFas0bDwyNgePjhIgDPzJa4kOiGC6dkQph3epDoI
	 bIx1i1ZGKIXhTE2tUY8cVbFbOe/3GyLFNpRyNqtPqgAvoKSg3Sdlq1NHiTsUQnUOMc
	 p4tLFUbtCATjbtgq/7RVq1J8/w6tRKodCGffsA4A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDA16F80304;
	Tue, 21 Jan 2020 18:28:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D7BEF802C2; Tue, 21 Jan 2020 18:28:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 0C840F802C2
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 18:28:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C840F802C2
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0132630E;
 Tue, 21 Jan 2020 09:28:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74F173F6C4;
 Tue, 21 Jan 2020 09:28:28 -0800 (PST)
Date: Tue, 21 Jan 2020 17:28:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wo9nx7it.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87wo9nx7it.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: samsung: i2s: move .suspend/.resume to
	component" to the asoc tree
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

   ASoC: samsung: i2s: move .suspend/.resume to component

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

From 21385a4faa8469b129af56a8c5a9405e3189c787 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Jan 2020 10:04:42 +0900
Subject: [PATCH] ASoC: samsung: i2s: move .suspend/.resume to component

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
Link: https://lore.kernel.org/r/87wo9nx7it.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9722940da6a4..a57bb989a0ef 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1024,14 +1024,14 @@ i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 }
 
 #ifdef CONFIG_PM
-static int i2s_suspend(struct snd_soc_dai *dai)
+static int i2s_suspend(struct snd_soc_component *component)
 {
-	return pm_runtime_force_suspend(dai->dev);
+	return pm_runtime_force_suspend(component->dev);
 }
 
-static int i2s_resume(struct snd_soc_dai *dai)
+static int i2s_resume(struct snd_soc_component *component)
 {
-	return pm_runtime_force_resume(dai->dev);
+	return pm_runtime_force_resume(component->dev);
 }
 #else
 #define i2s_suspend NULL
@@ -1140,6 +1140,9 @@ static const struct snd_soc_component_driver samsung_i2s_component = {
 
 	.dapm_routes = samsung_i2s_dapm_routes,
 	.num_dapm_routes = ARRAY_SIZE(samsung_i2s_dapm_routes),
+
+	.suspend = i2s_suspend,
+	.resume = i2s_resume,
 };
 
 #define SAMSUNG_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
@@ -1171,8 +1174,6 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 
 		dai_drv->probe = samsung_i2s_dai_probe;
 		dai_drv->remove = samsung_i2s_dai_remove;
-		dai_drv->suspend = i2s_suspend;
-		dai_drv->resume = i2s_resume;
 
 		dai_drv->symmetric_rates = 1;
 		dai_drv->ops = &samsung_i2s_dai_ops;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
