Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D621C3B187
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:50:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CABC20656
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QkdqK0He"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CABC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D13C166C;
	Tue, 11 Feb 2020 16:49:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D13C166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581436214;
	bh=Q7r5N2xfF5KKRQYPLLoOaoPU90hoLsN20fLWFthB8nU=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=QkdqK0HePC8knT8szLPLbeXRkgVhRtdeINuGoXnayuU8MlVJU2LILFUEwRZfyBznW
	 VA0YzPLGKDmfUWwVJNZw/T8+Rb0LR77OUNxMBsTK6/JbO5SqgSOHdD4pAhYRK7S747
	 kLtkz9VpIZZ+OLY07JolAddZWu23zoyQXVwR/WnM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3267F8021E;
	Tue, 11 Feb 2020 16:48:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 670CEF80218; Tue, 11 Feb 2020 16:48:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 8EE83F8013D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 16:48:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EE83F8013D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E23AFEC;
 Tue, 11 Feb 2020 07:48:26 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98AF23F68E;
 Tue, 11 Feb 2020 07:48:25 -0800 (PST)
Date: Tue, 11 Feb 2020 15:48:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877e0vceyc.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-877e0vceyc.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-pcm: don't use bit-OR'ed error" to
	the asoc tree
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

   ASoC: soc-pcm: don't use bit-OR'ed error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From e82ebffce3ec07584bcc2fc4c4d33a43fd9515f5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 10 Feb 2020 12:14:26 +0900
Subject: [PATCH] ASoC: soc-pcm: don't use bit-OR'ed error

Current soc-pcm is using bit-OR'ed error

	ret |= snd_soc_component_close(component, substream);
	ret |= snd_soc_component_hw_free(component, substream);

The driver may return arbitrary error codes so they can conflict.
The bit-OR'ed error works only if the return code is always consistent.
This patch fixup it, and use *last* ret value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/877e0vceyc.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7a490c05d4e9..8d8ed4774e9c 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -498,13 +498,16 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component;
-	int i, ret = 0;
+	int i, r, ret = 0;
 
 	for_each_rtd_components(rtd, i, component) {
 		if (component == last)
 			break;
 
-		ret |= snd_soc_component_close(component, substream);
+		r = snd_soc_component_close(component, substream);
+		if (r < 0)
+			ret = r; /* use last ret */
+
 		snd_soc_component_module_put_when_close(component);
 	}
 
@@ -798,13 +801,15 @@ static int soc_pcm_components_hw_free(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component;
-	int i, ret = 0;
+	int i, r, ret = 0;
 
 	for_each_rtd_components(rtd, i, component) {
 		if (component == last)
 			break;
 
-		ret |= snd_soc_component_hw_free(component, substream);
+		r = snd_soc_component_hw_free(component, substream);
+		if (r < 0)
+			ret = r; /* use last ret */
 	}
 
 	return ret;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
