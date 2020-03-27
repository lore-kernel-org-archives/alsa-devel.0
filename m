Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C017AC43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:56:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC97206E6
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nPa9THkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC97206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E5A516CF;
	Fri, 27 Mar 2020 16:55:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E5A516CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585324576;
	bh=/l2rBt5UVkvX9rucG6tL2g1eEtRClc6AWuUWLBlx8gM=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=nPa9THkHNkvieuQ5Ym39C4fJD+VPeKwdJ/hTpTfYI8iGb92nM2fx5BqbJvMEoFcsT
	 b8ktvH+5JM0M0vDKCbGIIoc8YwPZ+jhMhbLFMs6iw2TDrHvN8jNaLq8TNA4sksZO1U
	 U4ifwR0jjI2FW0QXzpf+Xw/0B3/RLft7seSefw4A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B9C7F8043B;
	Fri, 27 Mar 2020 16:36:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A63EEF80444; Fri, 27 Mar 2020 16:36:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4A09AF80274
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 16:36:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A09AF80274
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBD411FB;
 Fri, 27 Mar 2020 08:36:09 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FC703F71F;
 Fri, 27 Mar 2020 08:36:09 -0700 (PDT)
Date: Fri, 27 Mar 2020 15:36:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: generic: use asoc_rtd_to_cpu() / asoc_rtd_to_codec()
 macro for DAI pointer" to the asoc tree
In-Reply-To: <87tv2fir7y.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87tv2fir7y.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

   ASoC: generic: use asoc_rtd_to_cpu() / asoc_rtd_to_codec() macro for DAI pointer

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

From e7718a72653603722e1b0e06f6a4e76bcafdc431 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Mar 2020 14:18:41 +0900
Subject: [PATCH] ASoC: generic: use asoc_rtd_to_cpu() / asoc_rtd_to_codec()
 macro for DAI pointer

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87tv2fir7y.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index abbdf1054f6f..8c54dc6710fe 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -213,8 +213,8 @@ EXPORT_SYMBOL_GPL(asoc_simple_startup);
 void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
@@ -249,8 +249,8 @@ int asoc_simple_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
@@ -381,12 +381,12 @@ int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 	int ret;
 
-	ret = asoc_simple_init_dai(rtd->codec_dai,
+	ret = asoc_simple_init_dai(asoc_rtd_to_codec(rtd, 0),
 				   dai_props->codec_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_init_dai(rtd->cpu_dai,
+	ret = asoc_simple_init_dai(asoc_rtd_to_cpu(rtd, 0),
 				   dai_props->cpu_dai);
 	if (ret < 0)
 		return ret;
-- 
2.20.1

