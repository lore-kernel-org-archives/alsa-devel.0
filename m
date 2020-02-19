Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2B4C34056
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:04:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EC324654
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ie+Mwv3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EC324654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62E3F169F;
	Wed, 19 Feb 2020 22:03:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62E3F169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582146238;
	bh=T2DggjDripyTTbApw/x0hkWsFlLLHNPN5+K+XqhJERk=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ie+Mwv3H0ijc02g53jStFetaIDbCI/PrGEHkOZwerFeVP6PXAWijVH0d8ISibskmC
	 lGHrKLHKUV6l+ItX8CtGc3dcIPQQmAovsfCvhLMIYj0bRPrAInmODezQ8cJGdaFIKq
	 l1GedbQZFLoZllaQxiSovt8+KzZHf/t+Ts96FYPs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5CAEF802FB;
	Wed, 19 Feb 2020 21:57:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BA35F802FD; Wed, 19 Feb 2020 21:57:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1C32FF802F9
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 21:57:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C32FF802F9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1311A1FB;
 Wed, 19 Feb 2020 12:57:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BA5B3F68F;
 Wed, 19 Feb 2020 12:57:31 -0800 (PST)
Date: Wed, 19 Feb 2020 20:57:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: qcom: apq8016_sbc: use for_each_rtd_codec_dai() macro"
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
Message-ID: <20200219205730.A4pYEytthUazMi-0x699B3BO4phs24CnXQe4t_DE6BY@z>

The patch

   ASoC: qcom: apq8016_sbc: use for_each_rtd_codec_dai() macro

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

From cf4dae032096f1299cf390fd55da489cb445dcbb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Feb 2020 15:56:09 +0900
Subject: [PATCH] ASoC: qcom: apq8016_sbc: use for_each_rtd_codec_dai() macro

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87lfozjcaw.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index ac75838bbfab..2d064f3bc9b6 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -34,8 +34,8 @@ struct apq8016_sbc_data {
 static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai;
 	struct snd_soc_component *component;
-	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_card *card = rtd->card;
 	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
 	int i, rval;
@@ -90,10 +90,9 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 		pdata->jack_setup = true;
 	}
 
-	for (i = 0 ; i < dai_link->num_codecs; i++) {
-		struct snd_soc_dai *dai = rtd->codec_dais[i];
+	for_each_rtd_codec_dai(rtd, i, codec_dai) {
 
-		component = dai->component;
+		component = codec_dai->component;
 		/* Set default mclk for internal codec */
 		rval = snd_soc_component_set_sysclk(component, 0, 0, DEFAULT_MCLK_RATE,
 				       SND_SOC_CLOCK_IN);
-- 
2.20.1

