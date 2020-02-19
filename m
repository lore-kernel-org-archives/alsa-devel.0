Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D71DC34031
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:18:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAAE24654
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VnjkdjN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAAE24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42B4516B8;
	Wed, 19 Feb 2020 01:17:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42B4516B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582071479;
	bh=maV5mAVIyJkixU+b50Z9UyTr+iWoSV2v7mz8GjXDjuE=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=VnjkdjN09Qiwu7B2M9oJH8Ei5QWdceqObvWRrFDsHKgq8cGCIRnmJn+b6jU+uPBMn
	 XpW4gQ+smpPoCICm6Md28Wia+z+pwBkxVnewdrvtycnXyxJOrHjgeoxoP03QBwbvSF
	 m1BJgPF1xA5Ikp2oq4RTnuBRVRwcUleF0rHw7ODo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42CAFF802FF;
	Wed, 19 Feb 2020 01:10:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CE19F80304; Wed, 19 Feb 2020 01:10:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1383EF802FF
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 01:10:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1383EF802FF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448E01FB;
 Tue, 18 Feb 2020 16:10:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48443F68F;
 Tue, 18 Feb 2020 16:10:02 -0800 (PST)
Date: Wed, 19 Feb 2020 00:10:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-pcm: remove soc_dpcm_be_digital_mute()" to the
 asoc tree
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
Message-ID: <20200219001001.3MwE9SKnRQAVuQjPoFL3DDqnGVZc0y90-mhklLyKu4U@z>

The patch

   ASoC: soc-pcm: remove soc_dpcm_be_digital_mute()

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

From c9645d2a952b7925b6708b24242cd5ed04975648 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Feb 2020 17:27:57 +0900
Subject: [PATCH] ASoC: soc-pcm: remove soc_dpcm_be_digital_mute()

No one is using soc_dpcm_be_digital_mute().
If it exists only by assumption that "it may be necessary someday",
let's remove it now. Otherwise code maintenance will be difficult.
We can revive it when we really needed it.
Let's remove it, so far.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87blpxbouc.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dpcm.h |  1 -
 sound/soc/soc-pcm.c      | 27 ---------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index b654ebfc8766..665516387671 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -141,7 +141,6 @@ void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be, int stream,
 	enum snd_soc_dpcm_state state);
 
 /* internal use only */
-int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute);
 int soc_dpcm_runtime_update(struct snd_soc_card *);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1d48be24bfaa..b8ea4d892031 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2719,33 +2719,6 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 	mutex_unlock(&card->mutex);
 	return ret;
 }
-int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
-{
-	struct snd_soc_dpcm *dpcm;
-	struct snd_soc_dai *dai;
-
-	for_each_dpcm_be(fe, SNDRV_PCM_STREAM_PLAYBACK, dpcm) {
-
-		struct snd_soc_pcm_runtime *be = dpcm->be;
-		int i;
-
-		if (be->dai_link->ignore_suspend)
-			continue;
-
-		for_each_rtd_codec_dai(be, i, dai) {
-			struct snd_soc_dai_driver *drv = dai->driver;
-
-			dev_dbg(be->dev, "ASoC: BE digital mute %s\n",
-					 be->dai_link->name);
-
-			if (drv->ops && drv->ops->digital_mute &&
-							dai->playback_active)
-				drv->ops->digital_mute(dai, mute);
-		}
-	}
-
-	return 0;
-}
 
 static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 {
-- 
2.20.1

