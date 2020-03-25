Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB9C43331
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:52:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4398320737
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ou6ZgRMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4398320737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8B981671;
	Wed, 25 Mar 2020 22:52:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8B981671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585173172;
	bh=Mgojjxq2CNJ30z0Gw1Wh0d6odVZ6DCNSc3LxEYGzNRA=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ou6ZgRMkbbWolq9xFj6YicLyt2OzfcKRKCT3IHQDZbtAsi0C5l4CfBO0DbgYtjnHn
	 HAxFxWsiUL7SXp6gKN0H4q3uZrQ9Yh6EKWY5SVaJglDIbzG1GdjlOQqg/GkDu8qtxz
	 06K/aWmHY1KmgV7y+CPJLnkkn3s1BOfG9CdtVS4E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CFEFF802BE;
	Wed, 25 Mar 2020 22:49:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBB10F8028B; Wed, 25 Mar 2020 22:48:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id C29E6F8028C
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 22:33:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C29E6F8028C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C687E31B;
 Wed, 25 Mar 2020 14:33:51 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B2023F71E;
 Wed, 25 Mar 2020 14:33:51 -0700 (PDT)
Date: Wed, 25 Mar 2020 21:33:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Applied "ASoC: Intel: broadwell: Revert back SSP0 link to use dummy
 components" to the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>
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
Message-ID: <20200325213349.-MdbAIxs6oiB8Or-I0OZHXBGGBnaMYFx_BqRo8JsVhw@z>

The patch

   ASoC: Intel: broadwell: Revert back SSP0 link to use dummy components

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

From 68999d939dcfb430dd9834df56c71e43b7f37c6e Mon Sep 17 00:00:00 2001
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Wed, 25 Mar 2020 14:16:09 +0100
Subject: [PATCH] ASoC: Intel: broadwell: Revert back SSP0 link to use dummy
 components

Recent series of patches targeting broadwell boards, while enabling
SOF, changed behavior for non-SOF solutions. In essence replacing
platform 'dummy' with actual 'platform' causes redundant stream
initialization to occur during audio start. hw_params for haswell-pcm
destroys initial stream right after its creation - only to recreate it
again from proceed from there.

While harmless so far, this flow isn't correct and should be corrected.
The actual need for dummy components for SSP0 link is questionable but
that issue is subject for another series.

Link to first message in conversation:
https://lkml.org/lkml/2020/3/18/54

Fixes: 64df6afa0dab ("ASoC: Intel: broadwell: change cpu_dai and platform components for SOF")
Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200325131611.545-2-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/broadwell.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index b9c12e24c70b..ffbb597052aa 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -167,9 +167,6 @@ SND_SOC_DAILINK_DEF(codec,
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 SND_SOC_DAILINK_DEF(ssp0_port,
 	    DAILINK_COMP_ARRAY(COMP_CPU("ssp0-port")));
-#else
-SND_SOC_DAILINK_DEF(ssp0_port,
-	    DAILINK_COMP_ARRAY(COMP_DUMMY()));
 #endif
 
 /* broadwell digital audio interface glue - connects codec <--> CPU */
@@ -226,7 +223,11 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.ops = &broadwell_rt286_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
+		SND_SOC_DAILINK_REG(dummy, codec, dummy),
+#else
 		SND_SOC_DAILINK_REG(ssp0_port, codec, platform),
+#endif
 	},
 };
 
-- 
2.20.1

