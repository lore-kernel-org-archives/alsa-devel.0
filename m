Return-Path: <SRS0=1DJj=5R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C9C43331
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:09:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF552078B
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y6uHEiq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF552078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3816F1686;
	Wed,  1 Apr 2020 13:08:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3816F1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585739364;
	bh=GHGY1APurHBlnnVO//VuwjjWVbw+Y2v3w0qwuWDFZUU=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Y6uHEiq8TTLk5xg8UCwlKSqyvB2jl3nPlj9KMYVAH2cCZBpdzNobZetQAK4yldrhc
	 FgeJyNw+JxacHjho8zd1kj+43FnLrIgdkzH+AvYCn6zKDonbMsvlXmrn7npjmxR5uG
	 Z/7BHNv2mKjdblFOuVCUNWUa89ZhaJOiLfF2/EnY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE5F0F8028C;
	Wed,  1 Apr 2020 13:06:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8358EF8028D; Wed,  1 Apr 2020 13:06:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 110A8F8015C
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2020 13:06:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 110A8F8015C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 948EE101E;
 Wed,  1 Apr 2020 04:06:52 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187463F68F;
 Wed,  1 Apr 2020 04:06:51 -0700 (PDT)
Date: Wed, 01 Apr 2020 12:06:50 +0100
From: Mark Brown <broonie@kernel.org>
To: 이경택 <gt82.lee@samsung.com>
Subject: Applied "ASoC: dpcm: allow start or stop during pause for backend" to
 the asoc tree
In-Reply-To: <004d01d607c1$7a3d5250$6eb7f6f0$@samsung.com>
Message-Id: <applied-004d01d607c1$7a3d5250$6eb7f6f0$@samsung.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 vkoul@kernel.org, Mark Brown <broonie@kernel.org>, hmseo@samsung.com,
 Gyeongtaek Lee <gt82.lee@samsung.com>, pilsun.jang@samsung.com,
 tkjung@samsung.com
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

   ASoC: dpcm: allow start or stop during pause for backend

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

From 21fca8bdbb64df1297e8c65a746c4c9f4a689751 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?=EC=9D=B4=EA=B2=BD=ED=83=9D?= <gt82.lee@samsung.com>
Date: Wed, 1 Apr 2020 10:04:21 +0900
Subject: [PATCH] ASoC: dpcm: allow start or stop during pause for backend

soc_compr_trigger_fe() allows start or stop after pause_push.
In dpcm_be_dai_trigger(), however, only pause_release is allowed
command after pause_push.
So, start or stop after pause in compress offload is always
returned as error if the compress offload is used with dpcm.
To fix the problem, SND_SOC_DPCM_STATE_PAUSED should be allowed
for start or stop command.

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/004d01d607c1$7a3d5250$6eb7f6f0$@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e256d438ee68..289aebc15529 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2324,7 +2324,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
-			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
@@ -2354,7 +2355,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
-			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-- 
2.20.1

