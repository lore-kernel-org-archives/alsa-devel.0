Return-Path: <SRS0=reWy=25=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1DEC282DD
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:02:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6EB2070E
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ikQtG1I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6EB2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC1D01750;
	Wed,  8 Jan 2020 17:01:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC1D01750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578499320;
	bh=wqv3ZqA99nwQQZMfrD/GOf1vqpf9J3mtZdVLNAGZdnI=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ikQtG1I1FjjqhLP6dc0mq8P0NpEWh5+TqFf2H2NTB9QZsQLuIlLJTr2EGYLYmAKpb
	 dk/rjhAnX5IRbI824RlJvk8WaMijyK0f5X6xoGsGKmaaVfBQk2eJf+fRZr6/S5te1B
	 zdfnFaRRIH69ILactlHZytgZp9kQidtxUsLmHtuI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4344F80274;
	Wed,  8 Jan 2020 16:58:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AFD3F80271; Wed,  8 Jan 2020 16:58:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 6FBF1F801DA
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2020 16:58:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FBF1F801DA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00FFD328;
 Wed,  8 Jan 2020 07:58:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E213F534;
 Wed,  8 Jan 2020 07:58:44 -0800 (PST)
Date: Wed, 08 Jan 2020 15:58:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20200107070956.15807-1-tiwai@suse.de>
Message-Id: <applied-20200107070956.15807-1-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Ben Ho <Ben.Ho@mediatek.com>, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [alsa-devel] Applied "ASoC: Fix NULL dereference at freeing" to the
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

   ASoC: Fix NULL dereference at freeing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 8e3366cad2bfe4e669bfd3758110be90b1dc75aa Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 7 Jan 2020 08:09:56 +0100
Subject: [PATCH] ASoC: Fix NULL dereference at freeing

When an ASoC driver with pcm_destruct component ops is freed before
the PCM object instantiation (e.g. deferring the probe), it hits an
Oops at snd_soc_pcm_component_free() that calls the pcm_destruct ops
unconditionally.

Fix it by adding a NULL-check of rtd->pcm before calling callbacks.

Fixes: c64bfc906600 ("ASoC: soc-core: add new pcm_construct/pcm_destruct")
Reported-by: Matthias Brugger <matthias.bgg@gmail.com>
Tested-by: Ben Ho <ben.ho@mediatek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200107070956.15807-1-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-component.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 1590e805d016..6a8f26bf09ba 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -520,6 +520,9 @@ void snd_soc_pcm_component_free(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_component *component;
 
+	if (!rtd->pcm)
+		return;
+
 	for_each_rtd_components(rtd, rtdcom, component)
 		if (component->driver->pcm_destruct)
 			component->driver->pcm_destruct(component, rtd->pcm);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
