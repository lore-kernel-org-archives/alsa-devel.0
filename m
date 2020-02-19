Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E021AC34031
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:18:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF9224673
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="enzc1Rpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF9224673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF45416DE;
	Wed, 19 Feb 2020 01:17:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF45416DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582071512;
	bh=AA1qI1hr9qopC6Ea6yA/9BYTvNZDBhmEZSU0NSiSMBk=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=enzc1RpcXXCPY3ETgP7Qd4ZjFRhtIzbdjWylM5psw8I/DbXC2FDX/e0OYlJ2TJL/f
	 yKNMiETFb0hVHHeLEgG2CdpF/7mNAgG/G/sf+wtsORVvSYcORaEOpav8lwdPfHHdQ7
	 lMskRYQ8CFobKa8wzOQM5MM37xodBO3ZXjPLnMvI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 228E8F80305;
	Wed, 19 Feb 2020 01:10:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3936F80308; Wed, 19 Feb 2020 01:10:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 993F3F80305
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 01:10:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 993F3F80305
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2B51FB;
 Tue, 18 Feb 2020 16:10:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ACB13F68F;
 Tue, 18 Feb 2020 16:10:07 -0800 (PST)
Date: Wed, 19 Feb 2020 00:10:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-pcm: use dpcm_get_be() at dpcm_end_walk_at_be()"
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
Message-ID: <20200219001005.j5eJvPNlb8yxW2CAU1e1RzKp_URUGEbdNoFSQibOFPs@z>

The patch

   ASoC: soc-pcm: use dpcm_get_be() at dpcm_end_walk_at_be()

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

From 027a483871832044fa0cb8e9df208cca5230ae91 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Feb 2020 17:27:53 +0900
Subject: [PATCH] ASoC: soc-pcm: use dpcm_get_be() at dpcm_end_walk_at_be()

dpcm_end_walk_at_be() and dpcm_get_be() are almost same code.
This patch uses dpcm_get_be() from dpcm_end_walk_at_be().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87d0adbouh.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7d4419ae63f6..1d48be24bfaa 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1297,10 +1297,7 @@ static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
 {
 	struct snd_soc_card *card = widget->dapm->card;
 	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_dapm_widget *w;
-	struct snd_soc_dai *dai;
 	int stream;
-	int i;
 
 	/* adjust dir to stream */
 	if (dir == SND_SOC_DAPM_DIR_OUT)
@@ -1308,20 +1305,9 @@ static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
 	else
 		stream = SNDRV_PCM_STREAM_CAPTURE;
 
-	for_each_card_rtds(card, rtd) {
-		if (!rtd->dai_link->no_pcm)
-			continue;
-
-		w = dai_get_widget(rtd->cpu_dai, stream);
-		if (w == widget)
-			return true;
-
-		for_each_rtd_codec_dai(rtd, i, dai) {
-			w = dai_get_widget(dai, stream);
-			if (w == widget)
-				return true;
-		}
-	}
+	rtd = dpcm_get_be(card, widget, stream);
+	if (rtd)
+		return true;
 
 	return false;
 }
-- 
2.20.1

