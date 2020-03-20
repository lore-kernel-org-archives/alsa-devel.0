Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB4C4332D
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 20:46:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8A420775
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 20:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SyKOTKuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8A420775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68E0A74C;
	Fri, 20 Mar 2020 21:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68E0A74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584737204;
	bh=WY2snJqdOnQ3w59Y6SPGf4EH4u/A2s2yi7amXbUtBHg=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=SyKOTKuPZSSSF8OcxgR7qkAuUUtgXck6VoFWPuv8p6YR0qiWfg0lGYyO2mOD7/6Mq
	 095syPxnougWHwe/09VTW4HTTcuPQL48hvLzZgeIfHeGSYFoheWSpFtdUiz5MV1GpE
	 tJrH6vtHfE6WgCAKJSHf0AwfUQx+xC+IPV7FzY/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 985FEF800C0;
	Fri, 20 Mar 2020 21:45:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 362D1F800C0; Fri, 20 Mar 2020 21:45:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id E289FF800C0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 21:45:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E289FF800C0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F07331B;
 Fri, 20 Mar 2020 13:45:46 -0700 (PDT)
Received: from localhost (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B873E3F792;
 Fri, 20 Mar 2020 13:45:45 -0700 (PDT)
Date: Fri, 20 Mar 2020 20:45:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-core: Merge CPU/Codec for soc_dai_pcm_new()" to
 the asoc tree
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
Message-ID: <20200320204544.fGv0DTiheU2psYg7AGjqnRNnSZN5keK8Io8ukCTeP4I@z>

The patch

   ASoC: soc-core: Merge CPU/Codec for soc_dai_pcm_new()

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

From d1eb6d116123b2bcebeefce8bcdc828c80b033b8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Mar 2020 15:37:20 +0900
Subject: [PATCH] ASoC: soc-core: Merge CPU/Codec for soc_dai_pcm_new()

Now CPU/Codec DAIs are alias for dais.
Thus, we can directly use for_each_rtd_dais() macro
for soc_dai_pcm_new().
This patch merge CPU/Codec for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87r1xsolen.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 246d59966795..843b8b1c89d4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1037,20 +1037,20 @@ int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_pcm_runtime);
 
-static int soc_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
-			   struct snd_soc_pcm_runtime *rtd)
+static int soc_dai_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_dai *dai;
 	int i, ret = 0;
 
-	for (i = 0; i < num_dais; ++i) {
-		struct snd_soc_dai_driver *drv = dais[i]->driver;
+	for_each_rtd_dais(rtd, i, dai) {
+		struct snd_soc_dai_driver *drv = dai->driver;
 
 		if (drv->pcm_new)
-			ret = drv->pcm_new(rtd, dais[i]);
+			ret = drv->pcm_new(rtd, dai);
 		if (ret < 0) {
-			dev_err(dais[i]->dev,
+			dev_err(dai->dev,
 				"ASoC: Failed to bind %s with pcm device\n",
-				dais[i]->name);
+				dai->name);
 			return ret;
 		}
 	}
@@ -1121,13 +1121,8 @@ static int soc_init_pcm_runtime(struct snd_soc_card *card,
 			dai_link->stream_name, ret);
 		return ret;
 	}
-	ret = soc_dai_pcm_new(rtd->cpu_dais,
-			      rtd->num_cpus, rtd);
-	if (ret < 0)
-		return ret;
-	ret = soc_dai_pcm_new(rtd->codec_dais,
-			      rtd->num_codecs, rtd);
-	return ret;
+
+	return soc_dai_pcm_new(rtd);
 }
 
 static void soc_set_name_prefix(struct snd_soc_card *card,
-- 
2.20.1

