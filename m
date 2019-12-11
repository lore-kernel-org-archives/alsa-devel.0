Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635B5C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:15:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84C12054F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Bj++0wzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84C12054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28A04169D;
	Wed, 11 Dec 2019 18:14:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28A04169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576084529;
	bh=iph3HRw7q+ltQ2t7GlI1LGkSjf9zVMKSrdwMui/mLYU=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Bj++0wzWZq+aQp+wy46F1tNN7COEu8FXVEG0Q60A7FgthRyVM/6ipM8OkbvlNtGpg
	 50svOXm33ZdApFKNbJc6FqXZrYIucDvu1fAQcf26X5sElL5NrmOtUBGJaalaC/eqwB
	 uFB16wBp4amHlLOm/PhuLR7RaO4h6HD7OnYGK8AI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0082F8023E;
	Wed, 11 Dec 2019 17:54:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAA1BF803B1; Wed, 11 Dec 2019 17:54:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 6CAFAF8038C
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:54:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CAFAF8038C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97D130E;
 Wed, 11 Dec 2019 08:54:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38B9E3F52E;
 Wed, 11 Dec 2019 08:54:23 -0800 (PST)
Date: Wed, 11 Dec 2019 16:54:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191210145406.21419-16-tiwai@suse.de>
Message-Id: <applied-20191210145406.21419-16-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: generic-dmaengine: Drop superfluous
	ioctl PCM ops" to the asoc tree
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

   ASoC: generic-dmaengine: Drop superfluous ioctl PCM ops

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

From 2680c3127c3995c7cbd920c87fbc3411685e7717 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Dec 2019 15:53:58 +0100
Subject: [PATCH] ASoC: generic-dmaengine: Drop superfluous ioctl PCM ops

ASoC PCM core deals the empty ioctl field now as default.
Let's kill the redundant lines.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191210145406.21419-16-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index a428ff393ea2..4616cab2117c 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -329,7 +329,6 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 	.open		= dmaengine_pcm_open,
 	.close		= dmaengine_pcm_close,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= dmaengine_pcm_hw_params,
 	.hw_free	= dmaengine_pcm_hw_free,
 	.trigger	= dmaengine_pcm_trigger,
@@ -342,7 +341,6 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 	.open		= dmaengine_pcm_open,
 	.close		= dmaengine_pcm_close,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= dmaengine_pcm_hw_params,
 	.hw_free	= dmaengine_pcm_hw_free,
 	.trigger	= dmaengine_pcm_trigger,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
