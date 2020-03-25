Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4225AC43331
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:52:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C207C2076A
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YjrpiZnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C207C2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2482D1669;
	Wed, 25 Mar 2020 22:51:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2482D1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585173150;
	bh=VbNhBOxifWBkyR8n1qu5Bev6b2pUxM/oCDfoSYBFU9o=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=YjrpiZnA4fQSkY67kDdEQiS5tnr9sHEMMFBHeqfSdGczo0KZjRHFeekTSSwvqhTP6
	 zoK4WzVrV3XRLN/WjpBTCqHswxsb07mBNK24ekR6hYiT10Cy7Skkmknm0MLtA13b4Q
	 TLaomL9eU2h5R5emyaCi8SelezOnsusDchZt+/T4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09DF1F802A8;
	Wed, 25 Mar 2020 22:49:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE315F80273; Wed, 25 Mar 2020 22:48:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 20AF4F8028B
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 22:33:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20AF4F8028B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0B9D31B;
 Wed, 25 Mar 2020 14:33:47 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DA5C3F71E;
 Wed, 25 Mar 2020 14:33:42 -0700 (PDT)
Date: Wed, 25 Mar 2020 21:33:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Applied "ASoC: Intel: bdw-rt5650: Revert SSP0 link to use dummy
 components" to the asoc tree
In-Reply-To: <20200325131611.545-4-cezary.rojewski@intel.com>
Message-Id: <applied-20200325131611.545-4-cezary.rojewski@intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux@dominikbrodowski.net, tiwai@suse.com
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

   ASoC: Intel: bdw-rt5650: Revert SSP0 link to use dummy components

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

From f25e203070e5b12e4db366ee99b86f33a968f1ae Mon Sep 17 00:00:00 2001
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Wed, 25 Mar 2020 14:16:11 +0100
Subject: [PATCH] ASoC: Intel: bdw-rt5650: Revert SSP0 link to use dummy
 components

Recent series of patches targeting broadwell boards, while enabling
SOF, changed behavior for non-SOF solutions. In essence replacing
platform 'dummy' with actual 'platform' causes redundant stream
initialization to occur during audio start. hw_params for haswell-pcm
destroys initial stream right after its creation - only to recreate it
again from proceed from there.

While harmless so far, this flow isn't right and should be corrected.
The actual need for dummy components for SSP0 link is questionable but
that issue is subject for another series.

Fixes: a40acc6bfceb ("ASoC: Intel: bdw-rt5650: change cpu_dai and platform components for SOF")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200325131611.545-4-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bdw-rt5650.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index 1a302436d450..6cff603d4656 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -226,9 +226,6 @@ SND_SOC_DAILINK_DEF(be,
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 SND_SOC_DAILINK_DEF(ssp0_port,
 	    DAILINK_COMP_ARRAY(COMP_CPU("ssp0-port")));
-#else
-SND_SOC_DAILINK_DEF(ssp0_port,
-	    DAILINK_COMP_ARRAY(COMP_DUMMY()));
 #endif
 
 static struct snd_soc_dai_link bdw_rt5650_dais[] = {
@@ -264,7 +261,11 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.init = bdw_rt5650_init,
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
+		SND_SOC_DAILINK_REG(dummy, be, dummy),
+#else
 		SND_SOC_DAILINK_REG(ssp0_port, be, platform),
+#endif
 	},
 };
 
-- 
2.20.1

