Return-Path: <SRS0=YoTX=4X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E469C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:06:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E079F20409
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kYIhvLl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E079F20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55C3582A;
	Fri,  6 Mar 2020 16:05:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55C3582A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583507190;
	bh=PPVL0uCsu7WPF0k5Viw065ckUzFsogu4Sv3mSLVAx+Y=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=kYIhvLl97X87Oi5i3T2hi9qAdXa7FgGMwPyvntJhZhBplPDPSlVlDFSkZXrFqDHMC
	 MgGo7Enp0vptxm7u6tbaAb+KignO7qAllqmUxjgn0AGQXhuLpkVxOf9PFPCvTkmGSN
	 A9ohcC42CnfAfpkk47odCsWeL8Kpub2kr3gi+X9w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 556C4F8029A;
	Fri,  6 Mar 2020 16:03:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DEDEF8029B; Fri,  6 Mar 2020 16:03:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id A7BABF8028E
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2020 16:03:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7BABF8028E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 859E131B;
 Fri,  6 Mar 2020 07:03:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A463F237;
 Fri,  6 Mar 2020 07:03:17 -0800 (PST)
Date: Fri, 06 Mar 2020 15:03:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-pcm: tidyup dulicate handing at
 dpcm_fe_dai_startup()" to the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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
Message-ID: <20200306150316.LJ_5q1raGk-qCtF4hhxeu6d42islho2KZXr4rofLelo@z>

The patch

   ASoC: soc-pcm: tidyup dulicate handing at dpcm_fe_dai_startup()

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

From 8a01fbf0ac115268293d8764850edc0628a58e4f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 6 Mar 2020 10:09:59 +0900
Subject: [PATCH] ASoC: soc-pcm: tidyup dulicate handing at
 dpcm_fe_dai_startup()

error handling at dpcm_fe_dai_startup() has duplicate code.
This patch tidyup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/87lfoep9ug.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3a30776858bf..7d787e0966f3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2162,17 +2162,13 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 	snd_pcm_limit_hw_rates(runtime);
 
 	ret = dpcm_apply_symmetry(fe_substream, stream);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(fe->dev, "ASoC: failed to apply dpcm symmetry %d\n",
 			ret);
-		goto unwind;
-	}
-
-	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
-	return 0;
 
 unwind:
-	dpcm_be_dai_startup_unwind(fe, stream);
+	if (ret < 0)
+		dpcm_be_dai_startup_unwind(fe, stream);
 be_err:
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
 	return ret;
-- 
2.20.1

