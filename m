Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5ADC34031
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:13:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B54524656
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q3Piwc64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B54524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A626716A6;
	Wed, 19 Feb 2020 01:12:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A626716A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582071201;
	bh=qsGWScV+YIQ1zMk5RYMnyjs808fY5rdvAHq+P+YKbwg=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=q3Piwc64RqI+ZyQfZtLIiUPL5tJu1TJ9llBPZ1P+NvH+5CyeVv+EMqscifb2fGnfQ
	 YkCmIh5ZrQ49nx1Z2hw1bdRYZOwN2gLKd8pgvlLQ2j9UxktwKjWMz8p4pVDf5AEhxh
	 4bHVKS606y5fOgWFQwBeaDHVFJ6Gm9yV8RPgIQTI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A5EEF8028D;
	Wed, 19 Feb 2020 01:09:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 858B4F8028E; Wed, 19 Feb 2020 01:09:32 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 0DD91F8028B
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 01:09:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DD91F8028B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFC881FB;
 Tue, 18 Feb 2020 16:09:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 540B63F68F;
 Tue, 18 Feb 2020 16:09:27 -0800 (PST)
Date: Wed, 19 Feb 2020 00:09:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-generic-dmaengine-pcm: use for_each_pcm_streams()
 macro" to the asoc tree
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
Message-ID: <20200219000925.JjouHzll9pzhNua53sfq58rb9QEMN0rG7v9znEzu61o@z>

The patch

   ASoC: soc-generic-dmaengine-pcm: use for_each_pcm_streams() macro

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

From ee10fbe1cdf7cb4ae62f5e23ccd771e696b8f404 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Feb 2020 17:28:32 +0900
Subject: [PATCH] ASoC: soc-generic-dmaengine-pcm: use for_each_pcm_streams()
 macro

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87zhdhaa8x.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 2cc25651661c..d6b4831e8aec 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -237,7 +237,7 @@ static int dmaengine_pcm_new(struct snd_soc_component *component,
 		max_buffer_size = SIZE_MAX;
 	}
 
-	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
+	for_each_pcm_streams(i) {
 		substream = rtd->pcm->streams[i].substream;
 		if (!substream)
 			continue;
@@ -371,8 +371,7 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 		dev = config->dma_dev;
 	}
 
-	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE;
-	     i++) {
+	for_each_pcm_streams(i) {
 		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
 			name = "rx-tx";
 		else
@@ -401,8 +400,7 @@ static void dmaengine_pcm_release_chan(struct dmaengine_pcm *pcm)
 {
 	unsigned int i;
 
-	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE;
-	     i++) {
+	for_each_pcm_streams(i) {
 		if (!pcm->chan[i])
 			continue;
 		dma_release_channel(pcm->chan[i]);
-- 
2.20.1

