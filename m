Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1704BC3F2CD
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:26:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0A0246A3
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oGs5NI6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0A0246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB70516EE;
	Fri, 28 Feb 2020 19:25:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB70516EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582914398;
	bh=UiyE1YOrVDZnW3h9SDBpQoeU5NuhymoXLZgv0hsjavk=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=oGs5NI6rIFAQ7ibaT9mgtpUwCxS4HxRUW+ua/qmLep9B4SlvvZX+f0SrroURWgUSh
	 MlUvS2c68/0S5p49dpUOfPc88jD6h9QfNBol9vVJAZaufMSq5hWqa0i5yBjlAfHunU
	 j/hHLUekO4nNNr9WfJ3NkuBuvYMNMmRsgxE/Mi4g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A49AAF801F2;
	Fri, 28 Feb 2020 19:24:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71D38F80213; Fri, 28 Feb 2020 19:24:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id EACFEF80086
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 19:24:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EACFEF80086
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43248FEC;
 Fri, 28 Feb 2020 10:24:51 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8AD03F7B4;
 Fri, 28 Feb 2020 10:24:50 -0800 (PST)
Date: Fri, 28 Feb 2020 18:24:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-dapm: don't use rtd->cpu_dai on
 for_each_rtd_cpu_dai()" to the asoc tree
In-Reply-To: <87pne07qeh.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87pne07qeh.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Shreyas NC <shreyas.nc@intel.com>
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

   ASoC: soc-dapm: don't use rtd->cpu_dai on for_each_rtd_cpu_dai()

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

From ac5bf39e39683c6f06c2e5b4baf27c7208f0c86d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 27 Feb 2020 10:47:02 +0900
Subject: [PATCH] ASoC: soc-dapm: don't use rtd->cpu_dai on
 for_each_rtd_cpu_dai()

soc_dapm_stream_event() is using for_each_rtd_cpu_dais().
It should use "cpu_dai", instead of "rtd->cpu_dai".
This patch fixup it.

Fixes: commit de6214a33633d ("ASoC: Add multiple CPU DAI support in DAPM")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87pne07qeh.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6ce024d52170..9a809f2caa10 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4438,7 +4438,7 @@ static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	int i;
 
 	for_each_rtd_cpu_dai(rtd, i, cpu_dai)
-		soc_dapm_dai_stream_event(rtd->cpu_dai, stream, event);
+		soc_dapm_dai_stream_event(cpu_dai, stream, event);
 	for_each_rtd_codec_dai(rtd, i, codec_dai)
 		soc_dapm_dai_stream_event(codec_dai, stream, event);
 
-- 
2.20.1

