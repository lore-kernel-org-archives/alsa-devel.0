Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EE7C34031
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:17:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605AB2465A
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Oo77REs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605AB2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B137E16BC;
	Wed, 19 Feb 2020 01:16:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B137E16BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582071452;
	bh=YS7q/W1EvkNgIyGlu3a1b+mY4V0bdXTT6qNc8RpQCgg=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Oo77REs+f4Hdf4us0sQ4Q0BKtTPQ/REwbPy4gHBKAj5QijKHC/XSAO9AzU7Dnxlll
	 pQcwqwpe+6mDosqRG8jA4VxfD3r1Rc97JKxDjHr5eLfeD+cF3vHiWk8l581DKwdAxb
	 ivEJSmVXNipbbQvsGBJV3fuoCXAsOxLfuK4bSPbc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C44B5F802F8;
	Wed, 19 Feb 2020 01:10:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42E7AF802FE; Wed, 19 Feb 2020 01:10:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 710B5F802E9
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 01:09:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 710B5F802E9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF2AB1FB;
 Tue, 18 Feb 2020 16:09:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430273F68F;
 Tue, 18 Feb 2020 16:09:58 -0800 (PST)
Date: Wed, 19 Feb 2020 00:09:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-pcm: remove snd_soc_dpcm_be_get/set_state()" to
 the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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
Message-ID: <20200219000956.2AA9rX3whpw004VxvClHropBCYOvJOPzDbd1rjq-xkI@z>

The patch

   ASoC: soc-pcm: remove snd_soc_dpcm_be_get/set_state()

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

From 289a7e64f8583aaa45847c7fa3b7fabf8d48fd6b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Feb 2020 17:28:04 +0900
Subject: [PATCH] ASoC: soc-pcm: remove snd_soc_dpcm_be_get/set_state()

No one is using snd_soc_dpcm_be_get/set_state().
If it exists only by assumption that "it may be necessary someday",
let's remove it now. Otherwise code maintenance will be difficult.
We can revive it when we really needed it.
Let's remove it, so far.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87a75hbou7.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dpcm.h |  8 --------
 sound/soc/soc-pcm.c      | 16 ----------------
 2 files changed, 24 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 665516387671..3e7819d2a6aa 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -132,14 +132,6 @@ int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
 struct snd_pcm_substream *
 	snd_soc_dpcm_get_substream(struct snd_soc_pcm_runtime *be, int stream);
 
-/* get the BE runtime state */
-enum snd_soc_dpcm_state
-	snd_soc_dpcm_be_get_state(struct snd_soc_pcm_runtime *be, int stream);
-
-/* set the BE runtime state */
-void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be, int stream,
-	enum snd_soc_dpcm_state state);
-
 /* internal use only */
 int soc_dpcm_runtime_update(struct snd_soc_card *);
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index b8ea4d892031..bd4e4f86f5b2 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2954,22 +2954,6 @@ struct snd_pcm_substream *
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_get_substream);
 
-/* get the BE runtime state */
-enum snd_soc_dpcm_state
-	snd_soc_dpcm_be_get_state(struct snd_soc_pcm_runtime *be, int stream)
-{
-	return be->dpcm[stream].state;
-}
-EXPORT_SYMBOL_GPL(snd_soc_dpcm_be_get_state);
-
-/* set the BE runtime state */
-void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be,
-		int stream, enum snd_soc_dpcm_state state)
-{
-	be->dpcm[stream].state = state;
-}
-EXPORT_SYMBOL_GPL(snd_soc_dpcm_be_set_state);
-
 /*
  * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
  * are not running, paused or suspended for the specified stream direction.
-- 
2.20.1

