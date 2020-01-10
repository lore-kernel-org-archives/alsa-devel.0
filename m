Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54282C282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:42:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5B92077C
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="id5VyPTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5B92077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25537168F;
	Fri, 10 Jan 2020 14:41:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25537168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578663719;
	bh=fUptHjaDygVdwvJfU7UeoA9/bZ33oGxqghW/wAo5cdw=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=id5VyPTsuPnuyFM5+q/Vmj4D0K7mhlXMDMP0MWBKvHr/n+RRO+BoarjvXrfYHC+D2
	 THjdJhjQBHxPiuzPMSb00u+Kx7RwFJTwCi4TR2K9pm1rLZ2UTUK1HW/xvw7wTLzHui
	 4do4bGuRWMHmByTicutI2yKKtln8frznjajqLdQs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFDA0F80290;
	Fri, 10 Jan 2020 14:37:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED7F1F80214; Fri, 10 Jan 2020 14:37:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 450B7F8011C
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 14:37:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 450B7F8011C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7741C1FB;
 Fri, 10 Jan 2020 05:37:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F01613F534;
 Fri, 10 Jan 2020 05:37:47 -0800 (PST)
Date: Fri, 10 Jan 2020 13:37:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <875zhkt4vc.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-875zhkt4vc.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-core: remove duplicate pinctrl
	operation when suspend" to the asoc tree
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

   ASoC: soc-core: remove duplicate pinctrl operation when suspend

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

From d7a8cb4931652256a01383bb3ea10fab316e72a1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 10 Jan 2020 11:36:07 +0900
Subject: [PATCH] ASoC: soc-core: remove duplicate pinctrl operation when
 suspend

snd_soc_suspend() are doing below for pinctrl_pm_select_sleep_state()

	int snd_soc_suspend(struct device *dev)
	{
		...
		for_each_card_components(card, component) {
			...
(1)			pinctrl_pm_select_sleep_state(component->dev);
		}

		for_each_card_rtds(card, rtd) {
			...
(2)			pinctrl_pm_select_sleep_state(cpu_dai->dev);
		}
	}

(1) is called for all component (CPU/Codec/Platform), and
(2) is called for CPU DAIs.
Here, component->dev is same as dai->dev.
This means, it is called in duplicate on CPU case.
This patch removes (2).

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-By: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/875zhkt4vc.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8a1b4ffa6ca6..191b68732e56 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -619,9 +619,6 @@ int snd_soc_suspend(struct device *dev)
 
 		if (cpu_dai->driver->bus_control)
 			snd_soc_dai_suspend(cpu_dai);
-
-		/* deactivate pins to sleep state */
-		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 	}
 
 	if (card->suspend_post)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
