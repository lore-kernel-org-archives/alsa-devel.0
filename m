Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9C8C2D0BF
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:32:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EFB2073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="syUc/zmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EFB2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BA641660;
	Tue, 10 Dec 2019 14:31:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BA641660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575984720;
	bh=SrRE3xuECVx89X0QnNXDGRErn+h6uAkeAMCn4qMkGyA=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=syUc/zmbiimxTh+Mw9QlfMb4vdWGHgJZ7cw9hj9osG3Cjr0I1LdxKm9gEAIF1p6IJ
	 z/jO9VPGikO/iHTjSW4v0Fxv4T/72sXwPtIEVirswM0khIDUPISaipopWr//I7kRyL
	 9QENMiR3R6LKX/swiR8BHxGdvb2DHQy5oC0uG900=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16B70F802EC;
	Tue, 10 Dec 2019 14:23:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C9B4F802DF; Tue, 10 Dec 2019 14:23:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id DD4BBF802DC
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:23:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD4BBF802DC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E4E1113E;
 Tue, 10 Dec 2019 05:23:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B19253F52E;
 Tue, 10 Dec 2019 05:23:01 -0800 (PST)
Date: Tue, 10 Dec 2019 13:23:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87blshyq6e.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87blshyq6e.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: soc-core: move
	snd_soc_get_pcm_runtime()" to the asoc tree
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

   ASoC: soc-core: move snd_soc_get_pcm_runtime()

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

From 94def8ea66be2ea9f6aac61549b6b5874bca6235 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Dec 2019 09:34:01 +0900
Subject: [PATCH] ASoC: soc-core: move snd_soc_get_pcm_runtime()

This patch moves snd_soc_get_pcm_runtime() next to
snd_soc_get_dai_substream().
This is prepare for snd_soc_get_pcm_runtime() cleanup.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87blshyq6e.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16265d0e48de..f215a37fd3d6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -391,6 +391,21 @@ EXPORT_SYMBOL_GPL(snd_soc_lookup_component);
 
 static const struct snd_soc_ops null_snd_soc_ops;
 
+struct snd_soc_pcm_runtime
+*snd_soc_get_pcm_runtime(struct snd_soc_card *card,
+			 const char *dai_link)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	for_each_card_rtds(card, rtd) {
+		if (!strcmp(rtd->dai_link->name, dai_link))
+			return rtd;
+	}
+	dev_dbg(card->dev, "ASoC: failed to find rtd %s\n", dai_link);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_pcm_runtime);
+
 static void soc_release_rtd_dev(struct device *dev)
 {
 	/* "dev" means "rtd->dev" */
@@ -491,20 +506,6 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 	return NULL;
 }
 
-struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
-		const char *dai_link)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	for_each_card_rtds(card, rtd) {
-		if (!strcmp(rtd->dai_link->name, dai_link))
-			return rtd;
-	}
-	dev_dbg(card->dev, "ASoC: failed to find rtd %s\n", dai_link);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(snd_soc_get_pcm_runtime);
-
 static void snd_soc_flush_all_delayed_work(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
