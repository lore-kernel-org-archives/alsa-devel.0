Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A3C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:32:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0002073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j3JJDaHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0002073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8692A15F9;
	Tue, 10 Dec 2019 14:32:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8692A15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575984770;
	bh=2on/rvg3x/GvctlLMesDgBdR4CBNLN8vgIk8EU4Vp8M=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=j3JJDaHdtXbunlMQB2DbL9OrtegBfnhhCm46VlWMGbJy+tS1aR7UdHIYrKtVOYcbC
	 7kKvG4BGpoaNPI3EtuiWW8uxe/eHFd+n1RYNnECTKlhxG3wjaXNKCqUFjUW3NkfI8m
	 I8iXUXqWMAEEGdtLHOGcBeVk8XweB9dLLEQtGiw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC581F80306;
	Tue, 10 Dec 2019 14:23:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D6C3F802E7; Tue, 10 Dec 2019 14:23:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5702BF802DC
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:23:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5702BF802DC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8A66328;
 Tue, 10 Dec 2019 05:23:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29D303F52E;
 Tue, 10 Dec 2019 05:23:04 -0800 (PST)
Date: Tue, 10 Dec 2019 13:23:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d0cxyq6k.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87d0cxyq6k.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: soc-core: remove
	snd_soc_get_dai_substream()" to the asoc tree
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

   ASoC: soc-core: remove snd_soc_get_dai_substream()

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

From 8babfb7030573f7338b141d038c2094b7bb95034 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Dec 2019 09:33:55 +0900
Subject: [PATCH] ASoC: soc-core: remove snd_soc_get_dai_substream()

No driver is using snd_soc_get_dai_substream(),
and snd_soc_get_pcm_runtime() is enough for such purpose.
We can revival it if it was needed in the future.
Let's remove unused function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87d0cxyq6k.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  2 --
 sound/soc/soc-core.c | 15 ---------------
 2 files changed, 17 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b7ba3b91d080..68ec5a051afe 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -464,8 +464,6 @@ static inline int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 
 void snd_soc_disconnect_sync(struct device *dev);
 
-struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
-		const char *dai_link, int stream);
 struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
 		const char *dai_link);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0d436a2560e4..16265d0e48de 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -389,21 +389,6 @@ struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(snd_soc_lookup_component);
 
-struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
-		const char *dai_link, int stream)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	for_each_card_rtds(card, rtd) {
-		if (rtd->dai_link->no_pcm &&
-			!strcmp(rtd->dai_link->name, dai_link))
-			return rtd->pcm->streams[stream].substream;
-	}
-	dev_dbg(card->dev, "ASoC: failed to find dai link %s\n", dai_link);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(snd_soc_get_dai_substream);
-
 static const struct snd_soc_ops null_snd_soc_ops;
 
 static void soc_release_rtd_dev(struct device *dev)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
