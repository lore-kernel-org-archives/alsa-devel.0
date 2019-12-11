Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583E2C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:18:53 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F922073D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K7U3+dJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F922073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27F011698;
	Wed, 11 Dec 2019 18:18:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27F011698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576084731;
	bh=vQA6jr9hWLjzZrOyN3qw/zsheDKAFvLoSdUb7ikwXq4=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=K7U3+dJ7UK7AhSLsuoQq1LWIAO8L74D4KPWHKZDj9IrntC1D9NFtlfOb2py1hI7rt
	 G60vKYs2qPVf4LxZUCErv9RewQGPKtn6bX6EtXzvUIZpPyeeuh+eiA5rMcm87UN45L
	 L+8UIwfJOoqvhwrfVNoKMDjwz2rrbmk/F2HuPLlQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F3B3F80442;
	Wed, 11 Dec 2019 17:54:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DF44F8042B; Wed, 11 Dec 2019 17:54:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1893BF803FB
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:54:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1893BF803FB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC05B31B;
 Wed, 11 Dec 2019 08:54:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AB443F52E;
 Wed, 11 Dec 2019 08:54:35 -0800 (PST)
Date: Wed, 11 Dec 2019 16:54:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191210145406.21419-10-tiwai@suse.de>
Message-Id: <applied-20191210145406.21419-10-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: mediatek: Drop superfluous ioctl PCM
	ops" to the asoc tree
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

   ASoC: mediatek: Drop superfluous ioctl PCM ops

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

From a1b175b0828de15e04b551a8406affcddc552d7d Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Dec 2019 15:53:52 +0100
Subject: [PATCH] ASoC: mediatek: Drop superfluous ioctl PCM ops

ASoC PCM core deals the empty ioctl field now as default.
Let's kill the redundant lines.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191210145406.21419-10-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 1 -
 sound/soc/mediatek/common/mtk-btcvsd.c              | 1 -
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c          | 1 -
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c          | 1 -
 4 files changed, 4 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index b6624d8d084b..86c09165fae1 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -135,7 +135,6 @@ EXPORT_SYMBOL_GPL(mtk_afe_pcm_free);
 
 const struct snd_soc_component_driver mtk_afe_pcm_platform = {
 	.name		= AFE_PCM_NAME,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.pointer	= mtk_afe_pcm_pointer,
 	.pcm_construct	= mtk_afe_pcm_new,
 	.pcm_destruct	= mtk_afe_pcm_free,
diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index 2b490ae2e642..668fef3e319a 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -1271,7 +1271,6 @@ static const struct snd_soc_component_driver mtk_btcvsd_snd_platform = {
 	.probe		= mtk_btcvsd_snd_component_probe,
 	.open		= mtk_pcm_btcvsd_open,
 	.close		= mtk_pcm_btcvsd_close,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= mtk_pcm_btcvsd_hw_params,
 	.hw_free	= mtk_pcm_btcvsd_hw_free,
 	.prepare	= mtk_pcm_btcvsd_prepare,
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 033c07fb599c..cd7c5fabc605 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -712,7 +712,6 @@ static int mt6797_afe_component_probe(struct snd_soc_component *component)
 static const struct snd_soc_component_driver mt6797_afe_component = {
 	.name		= AFE_PCM_NAME,
 	.probe		= mt6797_afe_component_probe,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.pointer	= mtk_afe_pcm_pointer,
 	.pcm_construct	= mtk_afe_pcm_new,
 	.pcm_destruct	= mtk_afe_pcm_free,
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 76af09d8f1af..f6a0fadeb3cc 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1050,7 +1050,6 @@ static int mt8183_afe_component_probe(struct snd_soc_component *component)
 static const struct snd_soc_component_driver mt8183_afe_component = {
 	.name		= AFE_PCM_NAME,
 	.probe		= mt8183_afe_component_probe,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.pointer	= mtk_afe_pcm_pointer,
 	.pcm_construct	= mtk_afe_pcm_new,
 	.pcm_destruct	= mtk_afe_pcm_free,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
