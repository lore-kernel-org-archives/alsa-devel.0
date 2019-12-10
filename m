Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4415CC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:26:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66972073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EOnNCBRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66972073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17052166C;
	Tue, 10 Dec 2019 14:25:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17052166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575984363;
	bh=dX9cCKMVTAdi/LirzImVkA5cgsz9dYEQpxKF6JNwGSs=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=EOnNCBROSsKJny75qkaKYFnXFQI1VHvCBT/YwVWJaFMWG00RpObCwqH9yjiK51D1z
	 7v3EqSH1/bK+qdbr95cnyKoBEFFNF3nbBOZhy0oxrL29FgJcElyQeMfPghCcPBgAyh
	 unIaYUtaZTFqhqw7GXOZ6obZDJkLSZFEqxuHrcgU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F9ADF80269;
	Tue, 10 Dec 2019 14:22:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99186F8025E; Tue, 10 Dec 2019 14:22:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id EAC60F80249
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:22:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAC60F80249
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6F9E11B3;
 Tue, 10 Dec 2019 05:22:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 449513F52E;
 Tue, 10 Dec 2019 05:22:39 -0800 (PST)
Date: Tue, 10 Dec 2019 13:22:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y2vlxbkr.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87y2vlxbkr.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: soc-core: rename soc_link_init() to
	soc_init_pcm_runtime()" to the asoc tree
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

   ASoC: soc-core: rename soc_link_init() to soc_init_pcm_runtime()

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

From eaffeefbd042a44ca31f60f299a27d899aa4ec26 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Dec 2019 09:34:44 +0900
Subject: [PATCH] ASoC: soc-core: rename soc_link_init() to
 soc_init_pcm_runtime()

soc-core is using soc_link_init().
It sounds like dai_link function, but it is for pcm_runtime.
This patch renames soc_link_init() to soc_init_pcm_runtime().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87y2vlxbkr.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2af3df5d0d72..d18e30ec5a12 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1123,8 +1123,8 @@ static int soc_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
 	return 0;
 }
 
-static int soc_link_init(struct snd_soc_card *card,
-			 struct snd_soc_pcm_runtime *rtd)
+static int soc_init_pcm_runtime(struct snd_soc_card *card,
+				struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
@@ -1984,7 +1984,7 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 	}
 
 	for_each_card_rtds(card, rtd) {
-		ret = soc_link_init(card, rtd);
+		ret = soc_init_pcm_runtime(card, rtd);
 		if (ret < 0)
 			goto probe_end;
 	}
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
