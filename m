Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C44C34031
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:12:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A85022B48
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PqqjXTue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A85022B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 670661699;
	Wed, 19 Feb 2020 01:11:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 670661699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582071144;
	bh=bMmGwoz7Jg0+BcA+YvsMicxqGFL3o6Egabny/cOsR7Y=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=PqqjXTue5yKf612hiwZLngkLwbKCl6mG9cRDVf3SBKDwMNL3AAeMo0/qKlk6AlX6e
	 V+y8YXX7Uvwm5AqQ1wp2Ygqgd2nc3rYkKItsjQ9mH1Qbyzhlni27//6EDTmmGV8dSp
	 jlQvVAsUnD5Y4IRMaMMffPnwa3tY7u/1sdO6u2z8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FF24F80277;
	Wed, 19 Feb 2020 01:09:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06B64F8025F; Wed, 19 Feb 2020 01:09:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 154BDF8025F
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 01:09:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 154BDF8025F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A640CFEC;
 Tue, 18 Feb 2020 16:09:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29C713F68F;
 Tue, 18 Feb 2020 16:09:18 -0800 (PST)
Date: Wed, 19 Feb 2020 00:09:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: fsl: fsl_asrc_dma: use for_each_pcm_streams() macro"
 to the asoc tree
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
Message-ID: <20200219000916.p568GTq6acYN7OpPLmo9l0ANnWz1TcRPXvuOVDXiUWM@z>

The patch

   ASoC: fsl: fsl_asrc_dma: use for_each_pcm_streams() macro

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

From fa7b2a1fcb92906a284b0824b45866a7b8afb599 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Feb 2020 17:28:40 +0900
Subject: [PATCH] ASoC: fsl: fsl_asrc_dma: use for_each_pcm_streams() macro

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87wo8laa8p.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index ece130f59d15..44e5924be870 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -400,7 +400,7 @@ static int fsl_asrc_dma_pcm_new(struct snd_soc_component *component,
 		return ret;
 	}
 
-	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_LAST; i++) {
+	for_each_pcm_streams(i) {
 		substream = pcm->streams[i].substream;
 		if (!substream)
 			continue;
@@ -428,7 +428,7 @@ static void fsl_asrc_dma_pcm_free(struct snd_soc_component *component,
 	struct snd_pcm_substream *substream;
 	int i;
 
-	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_LAST; i++) {
+	for_each_pcm_streams(i) {
 		substream = pcm->streams[i].substream;
 		if (!substream)
 			continue;
-- 
2.20.1

