Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5047C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:33:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531A92073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lQ/7zZF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531A92073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B18CC1673;
	Tue, 10 Dec 2019 14:32:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B18CC1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575984800;
	bh=u3gEP4z7rYrmaYDK6fhnpii/Ec5KaejvTZIXmFQUbKA=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=lQ/7zZF3x+4YhEE7JSpY005EUs0UYx0V3Ssm2LsE0WIgfDMZeRY990m+XhrEuhAt5
	 9qRBkTIVjP5fDeDBg9in6Z5QewNFsJmNs0oO2BVJ9nX2TytGzkYek62YawcATkljkq
	 zNj6aOJPql+rMEDupsLaED9T2jbZLaaD87B7py34=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00CBCF80316;
	Tue, 10 Dec 2019 14:23:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 511CCF802FE; Tue, 10 Dec 2019 14:23:12 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1008CF802E8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:23:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1008CF802E8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26C23328;
 Tue, 10 Dec 2019 05:23:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B2173F52E;
 Tue, 10 Dec 2019 05:23:06 -0800 (PST)
Date: Tue, 10 Dec 2019 13:23:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eexdyq6p.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87eexdyq6p.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: soc-core: remove
	snd_soc_disconnect_sync()" to the asoc tree
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

   ASoC: soc-core: remove snd_soc_disconnect_sync()

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

From b553bd238da23041bf39110e58ee80f8efe034e0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Dec 2019 09:33:50 +0900
Subject: [PATCH] ASoC: soc-core: remove snd_soc_disconnect_sync()

Sound card disconnecting operation was needed when "sound driver" was
unbinded without unbinding "sound card".
In such case, sound driver should be stopped even though it was
playbacking/capturing. Otherwise clock open/close counter mismatch happen.

One headache was that we can't skip unbind in error case because unbind
operation doesn't check return value from each drivers.
snd_soc_disconnect_sync() was added for these purpose, and Renesas
sound card only is used it.

But now, ALSA SoC automatically disconnect sound card when sound driver
was unbinded. Thus, snd_soc_disconnect_sync() is no longer needed.
This patch removes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87eexdyq6p.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c |  2 --
 sound/soc/soc-core.c     | 12 ------------
 2 files changed, 14 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index d20f03dfdee6..6aac25095218 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1819,8 +1819,6 @@ static int rsnd_remove(struct platform_device *pdev)
 	};
 	int ret = 0, i;
 
-	snd_soc_disconnect_sync(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 
 	for_each_rsnd_dai(rdai, priv, i) {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9483bfe17260..0d436a2560e4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1444,18 +1444,6 @@ static int soc_probe_link_components(struct snd_soc_card *card)
 	return 0;
 }
 
-void snd_soc_disconnect_sync(struct device *dev)
-{
-	struct snd_soc_component *component =
-			snd_soc_lookup_component(dev, NULL);
-
-	if (!component || !component->card)
-		return;
-
-	snd_card_disconnect_sync(component->card->snd_card);
-}
-EXPORT_SYMBOL_GPL(snd_soc_disconnect_sync);
-
 static int soc_link_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
 				struct snd_soc_pcm_runtime *rtd)
 {
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
