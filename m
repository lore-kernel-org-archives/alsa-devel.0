Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12209C34031
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:12:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9D922B48
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FcY8T9dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9D922B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBBF116A9;
	Wed, 19 Feb 2020 01:11:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBBF116A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582071159;
	bh=W9dOi0zg+/tSlmYG+4BVDnc1iPt4/lhGfIeTyALsHmc=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=FcY8T9dcr76JeV2jaoQN7B4SX2aRi+FSi+ZuhgmQVyA06tI8/c9zTkCJtTJ4d8PlN
	 iDwW7leno4BDKmIHMO4gLiV3t5whcZ/5KRNz2/cb7Ck+fhM0PCH1aa2HhkrESksi3V
	 WOM8ix4OR0Rr1I7F0vDkoZJ2m/BsgH5tom6fiGGY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3AE3F8027C;
	Wed, 19 Feb 2020 01:09:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBE11F8028B; Wed, 19 Feb 2020 01:09:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 217EBF80279
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 01:09:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 217EBF80279
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F5831FB;
 Tue, 18 Feb 2020 16:09:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C798A3F68F;
 Tue, 18 Feb 2020 16:09:22 -0800 (PST)
Date: Wed, 19 Feb 2020 00:09:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: dwc: dwc-i2s: use for_each_pcm_streams() macro" to the
 asoc tree
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
Message-ID: <20200219000921.GTyW5wxJV25WzfIYP8MRD-iSHVAzv3ikrGKmgnC6_CM@z>

The patch

   ASoC: dwc: dwc-i2s: use for_each_pcm_streams() macro

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

From 0a170be9631ea8335e494f3c5f7ab720287023a2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Feb 2020 17:28:36 +0900
Subject: [PATCH] ASoC: dwc: dwc-i2s: use for_each_pcm_streams() macro

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87y2t1aa8t.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/dwc-i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index a8bff6f08a69..515f88456dbd 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -422,15 +422,15 @@ static int dw_i2s_resume(struct snd_soc_component *component)
 {
 	struct dw_i2s_dev *dev = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dai *dai;
+	int stream;
 
 	if (dev->capability & DW_I2S_MASTER)
 		clk_enable(dev->clk);
 
 	for_each_component_dais(component, dai) {
-		if (dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK])
-			dw_i2s_config(dev, SNDRV_PCM_STREAM_PLAYBACK);
-		if (dai->stream_active[SNDRV_PCM_STREAM_CAPTURE])
-			dw_i2s_config(dev, SNDRV_PCM_STREAM_CAPTURE);
+		for_each_pcm_streams(stream)
+			if (dai->stream_active[stream])
+				dw_i2s_config(dev, stream);
 	}
 
 	return 0;
-- 
2.20.1

