Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0BCC352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:52:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C26620714
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aIDXeRem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C26620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 728C386E;
	Tue, 11 Feb 2020 16:51:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 728C386E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581436322;
	bh=max1QgaNXKKTBILoeGJc0EGm25qAzntBH4fg3KHnN5c=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=aIDXeRemHexHF7LhvJFtCUzyZ01vAUQbcjb0v1kBWgQTUXd7nGE4eaRcqXs1k3Lnz
	 C3C0viGDHaHAgjtS+1BGau8gnDp99yF3W3FUXZmXDO3Oh/80+xTNmWIMzVYNcs/Z/z
	 Rz8cxpKUB0tMzvbk3guewNjiKW0K1SxWZFFYZ6zc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50EB0F80290;
	Tue, 11 Feb 2020 16:48:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9377F8013D; Tue, 11 Feb 2020 16:48:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id E84C1F80147
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 16:48:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E84C1F80147
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9B10FEC;
 Tue, 11 Feb 2020 07:48:30 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DA9D3F68E;
 Tue, 11 Feb 2020 07:48:30 -0800 (PST)
Date: Tue, 11 Feb 2020 15:48:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a75rceyl.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87a75rceyl.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-pcm: adjustment for DAI member 0
	reset" to the asoc tree
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

   ASoC: soc-pcm: adjustment for DAI member 0 reset

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From 5c25bd641a7b195b5ed71ce9d6955618bae7b7d3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 10 Feb 2020 12:14:18 +0900
Subject: [PATCH] ASoC: soc-pcm: adjustment for DAI member 0 reset

commit 3635bf09a89cf ("ASoC: soc-pcm: add symmetry for channels and
sample bits") set 0 not only to dai->rate but also to dai->channels and
dai->sample_bits if DAI was not active at soc_pcm_close().

and

commit d3383420c969c ("ASoC: soc-pcm: move DAIs parameters cleaning into
hw_free()") moved it from soc_pcm_close() to soc_pcm_hw_free().

These happen at v3.14.
But, maybe because of branch merge conflict or something similar happen
then, soc_pcm_close() still has old settings
(care only dai->rate, doesn't care dai->channels/sample_bits).
This is 100% duplicated operation.

This patch removes soc_pcm_close() side operation which supposed to
already moved to soc_pcm_hw_free().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/87a75rceyl.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4d26558fcbfc..2a4f7ac5f563 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -687,15 +687,6 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 
 	snd_soc_runtime_deactivate(rtd, substream->stream);
 
-	/* clear the corresponding DAIs rate when inactive */
-	if (!cpu_dai->active)
-		cpu_dai->rate = 0;
-
-	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		if (!codec_dai->active)
-			codec_dai->rate = 0;
-	}
-
 	snd_soc_dai_digital_mute(cpu_dai, 1, substream->stream);
 
 	snd_soc_dai_shutdown(cpu_dai, substream);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
