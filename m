Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586EEC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:25:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72ED20578
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CkzacO/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72ED20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E7341674;
	Mon, 30 Mar 2020 19:24:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E7341674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585589137;
	bh=1rWtOOKu0F6MVgA1MfzwTSahzwXcPnofZuC7azCeajo=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=CkzacO/aAG95sig1zsePvJk7XmTGpPgErCj+bDyHNWApup1a8O/JfDGx1hfGm216s
	 ebTfifbigcUQVUm6G4Yzr2PiT9ArSLHk8sEEEVIqI2gJnNGqv1RuwodHwU90st4DiE
	 gjkun82JEEIm/hhQn6wHJbGPv0QNM6xNYW3ThCS4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6E8DF80254;
	Mon, 30 Mar 2020 19:23:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16FA5F80252; Mon, 30 Mar 2020 19:23:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id A3286F8015C
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 19:23:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3286F8015C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F22B101E;
 Mon, 30 Mar 2020 10:23:06 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5B3D3F68F;
 Mon, 30 Mar 2020 10:23:05 -0700 (PDT)
Date: Mon, 30 Mar 2020 18:23:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Applied "ASoC: Intel: bdw-rt5650: Remove ignore_suspend flag from
 SSP0 dai link" to the asoc tree
In-Reply-To: <20200319204947.18963-5-cezary.rojewski@intel.com>
Message-Id: <applied-20200319204947.18963-5-cezary.rojewski@intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, lgirdwood@gmail.com,
 vkoul@kernel.org, Mark Brown <broonie@kernel.org>
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

   ASoC: Intel: bdw-rt5650: Remove ignore_suspend flag from SSP0 dai link

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

From 793012c6c586fefef3abd45c9d2b94df042907b0 Mon Sep 17 00:00:00 2001
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Thu, 19 Mar 2020 21:49:47 +0100
Subject: [PATCH] ASoC: Intel: bdw-rt5650: Remove ignore_suspend flag from SSP0
 dai link

As of commit:
ASoC: soc-core: care .ignore_suspend for Component suspend

function soc-core::snd_soc_suspend no longer ignores 'ignore_suspend'
flag for dai links. While BE dai link for System Pin is
supposed to follow standard suspend-resume flow, appended
'ignore_suspend' flag disturbs that flow and causes audio to break
right after resume. Remove the flag to address this.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20200319204947.18963-5-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bdw-rt5650.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index 6c2fdb5659ed..af2f50293208 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -254,7 +254,6 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
 		.no_pcm = 1,
 		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
-		.ignore_suspend = 1,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = broadwell_ssp0_fixup,
 		.ops = &bdw_rt5650_ops,
-- 
2.20.1

