Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B49BC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:27:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0706A2073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VKkY2mX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0706A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 553641669;
	Tue, 10 Dec 2019 14:27:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 553641669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575984470;
	bh=PmWclZFwlISWqqG50O2kYaeBzC6/Y+ouu64o5hCMngI=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=VKkY2mX/WsTnBpQw4o3VuQg/RNxIknj8/OJTCdtPqmpzniXi2s0AvsmPD7KJQxntz
	 zsXGn/PVH8Dq8XgcQrvSz66CNCAUq2TFBTapdYA0y9LoUm5tyGekIzTZgk45ZI/JdA
	 AjHt5d2pq0TcPDXLMLuLN2WuyTu1M+K45ZvsYnI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13F75F8028B;
	Tue, 10 Dec 2019 14:22:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98A6FF80279; Tue, 10 Dec 2019 14:22:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id DCFEEF80271
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:22:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCFEEF80271
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21D3B113E;
 Tue, 10 Dec 2019 05:22:47 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964723F52E;
 Tue, 10 Dec 2019 05:22:46 -0800 (PST)
Date: Tue, 10 Dec 2019 13:22:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8736dtyq5j.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-8736dtyq5j.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: soc-core: rename soc_link_dai_pcm_new()
	to soc_dai_pcm_new()" to the asoc tree
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

   ASoC: soc-core: rename soc_link_dai_pcm_new() to soc_dai_pcm_new()

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

From bfa0dd89536026e17b074eb2c42089f3455ea1a3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Dec 2019 09:34:32 +0900
Subject: [PATCH] ASoC: soc-core: rename soc_link_dai_pcm_new() to
 soc_dai_pcm_new()

soc_link_dai_pcm_new() sounds like dai_link function,
but it is not related to it.
This patch rename soc_link_dai_pcm_new() to soc_dai_pcm_new().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/8736dtyq5j.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8ace5f5b251c..81164b54632a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1102,8 +1102,8 @@ int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_pcm_runtime);
 
-static int soc_link_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
-				struct snd_soc_pcm_runtime *rtd)
+static int soc_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
+			   struct snd_soc_pcm_runtime *rtd)
 {
 	int i, ret = 0;
 
@@ -1464,11 +1464,11 @@ static int soc_link_init(struct snd_soc_card *card,
 			dai_link->stream_name, ret);
 		return ret;
 	}
-	ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
+	ret = soc_dai_pcm_new(&cpu_dai, 1, rtd);
 	if (ret < 0)
 		return ret;
-	ret = soc_link_dai_pcm_new(rtd->codec_dais,
-				   rtd->num_codecs, rtd);
+	ret = soc_dai_pcm_new(rtd->codec_dais,
+			      rtd->num_codecs, rtd);
 	return ret;
 }
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
