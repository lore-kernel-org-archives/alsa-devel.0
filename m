Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6CC11D00
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:02:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64592468A
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TYOXBDW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64592468A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3209816B6;
	Wed, 19 Feb 2020 22:01:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3209816B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582146128;
	bh=htjCbkwRA3SY/lTpsuB1+fcrDFQ24ebuLggNuvuUnUI=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=TYOXBDW91pimSdUwsIAT65UOUGf69GwR8OrifJ/J/c9sUUS0BwXhJ2lX6HJD71cs/
	 VSqJlSTmPYnFSNUJXH9DLyEJVQYP+98rCLMEdJ/m3oq01i/lDxf/NiByoaAAl0pXw2
	 vNa1Or5ucnnn60Xk0ib/jXUm6kG8nrYhQKjtbvTc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1D1CF802D2;
	Wed, 19 Feb 2020 21:57:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCEEFF802DB; Wed, 19 Feb 2020 21:57:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 05366F802C4
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 21:57:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05366F802C4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 031A61FB;
 Wed, 19 Feb 2020 12:57:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AEC53F68F;
 Wed, 19 Feb 2020 12:57:18 -0800 (PST)
Date: Wed, 19 Feb 2020 20:57:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: mediatek: mt8183-da7219-max98357: use
 for_each_rtd_codec_dai() macro" to the asoc tree
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
Message-ID: <20200219205717.vskgkSF47Nbklhp_yAmqlk-aGNPc_CGoTqTgqgJnNgM@z>

The patch

   ASoC: mediatek: mt8183-da7219-max98357: use for_each_rtd_codec_dai() macro

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

From 56f1003f65830697bd68ae1e26b5561e4cbe6523 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Feb 2020 15:56:25 +0900
Subject: [PATCH] ASoC: mediatek: mt8183-da7219-max98357: use
 for_each_rtd_codec_dai() macro

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87h7znjcag.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 03d104fbe185..4a5ef07e956b 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -40,6 +40,7 @@ static int mt8183_da7219_i2s_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai;
 	unsigned int rate = params_rate(params);
 	unsigned int mclk_fs_ratio = 256;
 	unsigned int mclk_fs = rate * mclk_fs_ratio;
@@ -51,8 +52,7 @@ static int mt8183_da7219_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		dev_err(rtd->dev, "failed to set cpu dai sysclk\n");
 
-	for (j = 0; j < rtd->num_codecs; j++) {
-		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+	for_each_rtd_codec_dai(rtd, j, codec_dai) {
 
 		if (!strcmp(codec_dai->component->name, "da7219.5-001a")) {
 			ret = snd_soc_dai_set_sysclk(codec_dai,
@@ -82,10 +82,10 @@ static int mt8183_da7219_i2s_hw_params(struct snd_pcm_substream *substream,
 static int mt8183_da7219_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai;
 	int ret = 0, j;
 
-	for (j = 0; j < rtd->num_codecs; j++) {
-		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+	for_each_rtd_codec_dai(rtd, j, codec_dai) {
 
 		if (!strcmp(codec_dai->component->name, "da7219.5-001a")) {
 			ret = snd_soc_dai_set_pll(codec_dai,
-- 
2.20.1

