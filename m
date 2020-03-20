Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B2C4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 20:48:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BD820409
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 20:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W48fhtCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BD820409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9236A886;
	Fri, 20 Mar 2020 21:47:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9236A886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584737305;
	bh=CtqqtKk0pAA3LKLgyJhO5ajaHYytszs1O//4ga5QsqY=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=W48fhtCISO9rH24KK72NgbX1SIBe+cOr5RLxG2Ynje+ihqvKEpzvwrUqn+MzibAYq
	 ml/rQyIfz/Yobg/oqRgFfBQZMMeO0fVg1b9wVu2SaJhR+5aB5Re7NVPokYoHcWzXSB
	 FnMaiL1+0LondXQjQ7zMXBlk6MwFfOX89om8xDns=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02CD4F80290;
	Fri, 20 Mar 2020 21:46:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5B6AF80256; Fri, 20 Mar 2020 21:45:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 26B22F801F9
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 21:45:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26B22F801F9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A001831B;
 Fri, 20 Mar 2020 13:45:53 -0700 (PDT)
Received: from localhost (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 572983F792;
 Fri, 20 Mar 2020 13:45:53 -0700 (PDT)
Date: Fri, 20 Mar 2020 20:45:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-dapm: Merge for_each_rtd_cpu/codec_dais()" to the
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
Message-ID: <20200320204551.X33yNjNEoF3COfDYB47-STZoXwenjvd4ljS50P_p62o@z>

The patch

   ASoC: soc-dapm: Merge for_each_rtd_cpu/codec_dais()

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

From e3c3cf71013fd959abf455abc20386051d37c529 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Mar 2020 15:37:09 +0900
Subject: [PATCH] ASoC: soc-dapm: Merge for_each_rtd_cpu/codec_dais()

Now we can use for_each_rtd_dais().
Let's use it instead of for_each_rtd_cpu/codec_dais().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87tv2ooley.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d5eb52fe115b..04da7928c873 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4433,14 +4433,11 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	int event)
 {
-	struct snd_soc_dai *codec_dai;
-	struct snd_soc_dai *cpu_dai;
+	struct snd_soc_dai *dai;
 	int i;
 
-	for_each_rtd_cpu_dais(rtd, i, cpu_dai)
-		soc_dapm_dai_stream_event(cpu_dai, stream, event);
-	for_each_rtd_codec_dais(rtd, i, codec_dai)
-		soc_dapm_dai_stream_event(codec_dai, stream, event);
+	for_each_rtd_dais(rtd, i, dai)
+		soc_dapm_dai_stream_event(dai, stream, event);
 
 	dapm_power_widgets(rtd->card, event);
 }
-- 
2.20.1

