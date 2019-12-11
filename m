Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF2DC43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:54:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4FD214D8
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="keA3bJKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4FD214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57FBF1668;
	Wed, 11 Dec 2019 17:53:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57FBF1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576083241;
	bh=RTwVRGdJAY0saCYC5zyIVaF0/mNesYrt7nFmZlVUJsM=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=keA3bJKsnlfJQk//tChcCsldJ0Tkc6VY8XSLRlWLZn2rS6QBw+TChJSyF/wnZG6Bh
	 KAAv/GVTYKMZ4BWnx7HACojTBVGOudeA7gXITiIAA+Zq8ZG0bDvwyeQFOfqJiimsXm
	 5uY8iCIgvv/Exec/V2D7R8fw/c7jsKlo58fn8aUo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E83FF8021E;
	Wed, 11 Dec 2019 17:53:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5921F8021E; Wed, 11 Dec 2019 17:53:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 444EBF8019B
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:53:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 444EBF8019B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC9FF30E;
 Wed, 11 Dec 2019 08:53:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CDD43F52E;
 Wed, 11 Dec 2019 08:53:04 -0800 (PST)
Date: Wed, 11 Dec 2019 16:53:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191210145406.21419-24-tiwai@suse.de>
Message-Id: <applied-20191210145406.21419-24-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: Drop snd_soc_pcm_lib_ioctl()" to the
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

   ASoC: Drop snd_soc_pcm_lib_ioctl()

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

From 01fec8cce7cc68bb88b1ff55bc03da5f3e6625e3 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Dec 2019 15:54:06 +0100
Subject: [PATCH] ASoC: Drop snd_soc_pcm_lib_ioctl()

Now all snd_soc_pcm_lib_ioctl() calls were dropped, and it became
superfluous.  Let's kill it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191210145406.21419-24-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  5 -----
 sound/soc/soc-core.c | 12 ------------
 2 files changed, 17 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a6a3a7d54c70..82e65235c60d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1399,11 +1399,6 @@ static inline void snd_soc_dapm_mutex_unlock(struct snd_soc_dapm_context *dapm)
 	mutex_unlock(&dapm->card->dapm_mutex);
 }
 
-/* bypass */
-int snd_soc_pcm_lib_ioctl(struct snd_soc_component *component,
-			  struct snd_pcm_substream *substream,
-			  unsigned int cmd, void *arg);
-
 #include <sound/soc-component.h>
 
 #endif
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3eb874c4a340..ee77db253bcc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -258,18 +258,6 @@ static inline void snd_soc_debugfs_exit(void)
 
 #endif
 
-/*
- * This is glue code between snd_pcm_lib_ioctl() and
- * snd_soc_component_driver :: ioctl
- */
-int snd_soc_pcm_lib_ioctl(struct snd_soc_component *component,
-			  struct snd_pcm_substream *substream,
-			  unsigned int cmd, void *arg)
-{
-	return snd_pcm_lib_ioctl(substream, cmd, arg);
-}
-EXPORT_SYMBOL_GPL(snd_soc_pcm_lib_ioctl);
-
 static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 			      struct snd_soc_component *component)
 {
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
