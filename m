Return-Path: <SRS0=ePgV=3M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B72C2D0DB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:41:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD6121835
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eA756ZBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD6121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 793AE1678;
	Thu, 23 Jan 2020 13:40:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 793AE1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579783282;
	bh=+WwUJnV8xkgV/74YKXi4cynYRxe0PqtQhzLZDVjn0hY=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=eA756ZBL+FYsy3XJ9ZPsb/YSU08CjhdpD+70g4Gu6OtIyszFSztp3B9SaCGVmltPE
	 bAYlr8GPLAchp6Elt7wnIJNEjgmhdz9sfwkl9pieYeuZCtFenv+ULjkdTKix9LNQ3D
	 o1lprBf+783mRJSjSZE8MGxYZYTnNjZ3iaYGewE0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2FBCF802BC;
	Thu, 23 Jan 2020 13:36:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11B60F80290; Thu, 23 Jan 2020 13:36:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 0B64EF8027D
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2020 13:36:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B64EF8027D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B7DF328;
 Thu, 23 Jan 2020 04:36:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B00393F6C4;
 Thu, 23 Jan 2020 04:36:10 -0800 (PST)
Date: Thu, 23 Jan 2020 12:36:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878sm0mia4.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-878sm0mia4.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-pcm: add soc_rtd_startup()" to the
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

   ASoC: soc-pcm: add soc_rtd_startup()

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

From f183f9277a0f16e340bbcb28bf30834652ef10e1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 22 Jan 2020 09:44:35 +0900
Subject: [PATCH] ASoC: soc-pcm: add soc_rtd_startup()

Add soc_rtd_startup() to make the code easier to read

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/878sm0mia4.wl-kuninori.morimoto.gx@renesas.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 74d340d1c9f7..c0018293c67b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -28,6 +28,15 @@
 
 #define DPCM_MAX_BE_USERS	8
 
+static int soc_rtd_startup(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_pcm_substream *substream)
+{
+	if (rtd->dai_link->ops &&
+	    rtd->dai_link->ops->startup)
+		return rtd->dai_link->ops->startup(substream);
+	return 0;
+}
+
 /**
  * snd_soc_runtime_activate() - Increment active count for PCM runtime components
  * @rtd: ASoC PCM runtime that is activated
@@ -522,13 +531,11 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			codec_dai->rx_mask = 0;
 	}
 
-	if (rtd->dai_link->ops->startup) {
-		ret = rtd->dai_link->ops->startup(substream);
-		if (ret < 0) {
-			pr_err("ASoC: %s startup failed: %d\n",
-			       rtd->dai_link->name, ret);
-			goto machine_err;
-		}
+	ret = soc_rtd_startup(rtd, substream);
+	if (ret < 0) {
+		pr_err("ASoC: %s startup failed: %d\n",
+		       rtd->dai_link->name, ret);
+		goto machine_err;
 	}
 
 	/* Dynamic PCM DAI links compat checks use dynamic capabilities */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
