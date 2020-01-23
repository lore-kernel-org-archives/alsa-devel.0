Return-Path: <SRS0=ePgV=3M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF8C2D0DB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:40:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7939424655
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qm4NHDCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7939424655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E00471681;
	Thu, 23 Jan 2020 13:39:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E00471681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579783211;
	bh=MwCI8x7iKT1ZF3p+LaAsUd+ghsD3o08UFS3tR8Fao8M=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=qm4NHDCXWfbA9f/6F43XuXqaxOyojotA5Tia7VV7XyLPBMbGV6+dc2XJJ5DNf+NQV
	 NkJNvZvsGO1uB+fHotlWFf3lHN52W/Xlcyj6oLKiNtTWjXDVYjUCUiRb8tRfkLvudq
	 1hNZCJ+u9G3LCinBX0ogpAssgVQEFKcQ9vpxtdu4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27B03F8028B;
	Thu, 23 Jan 2020 13:36:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 554A7F80278; Thu, 23 Jan 2020 13:36:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1D556F80233
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2020 13:36:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D556F80233
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0545E328;
 Thu, 23 Jan 2020 04:36:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6308E3F6C4;
 Thu, 23 Jan 2020 04:36:05 -0800 (PST)
Date: Thu, 23 Jan 2020 12:36:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <875zh4mi9v.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-875zh4mi9v.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-pcm: add soc_rtd_prepare()" to the
	asoc tree
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

   ASoC: soc-pcm: add soc_rtd_prepare()

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

From 44c1a75b0d889b3a5faff9edc837d972806bb46a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 22 Jan 2020 09:44:44 +0900
Subject: [PATCH] ASoC: soc-pcm: add soc_rtd_prepare()

Add soc_rtd_prepare() to make the code easier to read

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/875zh4mi9v.wl-kuninori.morimoto.gx@renesas.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8095c64c4e3e..ccd6c9ca55ab 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -45,6 +45,15 @@ static void soc_rtd_shutdown(struct snd_soc_pcm_runtime *rtd,
 		rtd->dai_link->ops->shutdown(substream);
 }
 
+static int soc_rtd_prepare(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_pcm_substream *substream)
+{
+	if (rtd->dai_link->ops &&
+	    rtd->dai_link->ops->prepare)
+		return rtd->dai_link->ops->prepare(substream);
+	return 0;
+}
+
 /**
  * snd_soc_runtime_activate() - Increment active count for PCM runtime components
  * @rtd: ASoC PCM runtime that is activated
@@ -716,13 +725,11 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 
 	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
 
-	if (rtd->dai_link->ops->prepare) {
-		ret = rtd->dai_link->ops->prepare(substream);
-		if (ret < 0) {
-			dev_err(rtd->card->dev, "ASoC: machine prepare error:"
-				" %d\n", ret);
-			goto out;
-		}
+	ret = soc_rtd_prepare(rtd, substream);
+	if (ret < 0) {
+		dev_err(rtd->card->dev,
+			"ASoC: machine prepare error: %d\n", ret);
+		goto out;
 	}
 
 	for_each_rtd_components(rtd, i, component) {
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
