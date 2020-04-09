Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55696C2BA2B
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 12:06:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68B52078E
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 12:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A4dG/ZHo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlLfp34D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68B52078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 414441680;
	Thu,  9 Apr 2020 14:05:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 414441680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586434007;
	bh=0RhdgZMhyHcNjCx39jhyBFBVPoS25anDvv4mOZYWqPY=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=A4dG/ZHoFkXLNnaG00reu3k8rkRhAmDM3jHBS5Hh/sJCF/nuTUCKH/KFvNgYvMCU3
	 VKDfVAsY5XFEBQ6oJb4B8wr7gaxr7GAQFWwdmTeAKPxwTw3AS7EDMg9mFnRansEVk1
	 Qf/xpsimmsWFTPrZf3LI4fdEPS1k2l0bD1ylZsC0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55209F802A8;
	Thu,  9 Apr 2020 14:02:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E033F802A2; Thu,  9 Apr 2020 14:02:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 809C4F80292
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 14:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 809C4F80292
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hlLfp34D"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 78A4620753;
 Thu,  9 Apr 2020 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586433773;
 bh=0RhdgZMhyHcNjCx39jhyBFBVPoS25anDvv4mOZYWqPY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=hlLfp34Dr3hIWD6W/mngzzttrjv6vSzV17QbQm3B4+UYBMdbYgKBOjhdqHm2sasTc
 PH/m8U/Z4X8RcD6h9HUX86AAXDfx/I/Af2JHhx/cXFnGAyi4y0blwmOMqFk/ndUbr4
 jiBIBkUjzWPhhLPJXJSE1bMIzU78wkSIC+W6Hnww=
Date: Thu, 09 Apr 2020 13:02:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Subject: Applied "ASoC: topology: Add missing memory checks" to the asoc tree
In-Reply-To: <20200327204729.397-2-amadeuszx.slawinski@linux.intel.com>
Message-Id: <applied-20200327204729.397-2-amadeuszx.slawinski@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
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

The patch

   ASoC: topology: Add missing memory checks

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

From abc3caac24501008465fdb55c5e89e16d58d5a3d Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Date: Fri, 27 Mar 2020 16:47:24 -0400
Subject: [PATCH] ASoC: topology: Add missing memory checks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kstrdup is an allocation function and it can fail, so its return value
should be checked and handled appropriately.

In order to check all cases, we need to modify set_stream_info to return
a value, so check that everything went correctly when doing kstrdup().
Later add proper checks and error handlers.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200327204729.397-2-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 62 +++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 87f75edba3dc..73fc304c9aca 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1766,10 +1766,13 @@ static int soc_tplg_dapm_complete(struct soc_tplg *tplg)
 	return 0;
 }
 
-static void set_stream_info(struct snd_soc_pcm_stream *stream,
+static int set_stream_info(struct snd_soc_pcm_stream *stream,
 	struct snd_soc_tplg_stream_caps *caps)
 {
 	stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
+	if (!stream->stream_name)
+		return -ENOMEM;
+
 	stream->channels_min = le32_to_cpu(caps->channels_min);
 	stream->channels_max = le32_to_cpu(caps->channels_max);
 	stream->rates = le32_to_cpu(caps->rates);
@@ -1777,6 +1780,8 @@ static void set_stream_info(struct snd_soc_pcm_stream *stream,
 	stream->rate_max = le32_to_cpu(caps->rate_max);
 	stream->formats = le64_to_cpu(caps->formats);
 	stream->sig_bits = le32_to_cpu(caps->sig_bits);
+
+	return 0;
 }
 
 static void set_dai_flags(struct snd_soc_dai_driver *dai_drv,
@@ -1812,20 +1817,29 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	if (dai_drv == NULL)
 		return -ENOMEM;
 
-	if (strlen(pcm->dai_name))
+	if (strlen(pcm->dai_name)) {
 		dai_drv->name = kstrdup(pcm->dai_name, GFP_KERNEL);
+		if (!dai_drv->name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
 	dai_drv->id = le32_to_cpu(pcm->dai_id);
 
 	if (pcm->playback) {
 		stream = &dai_drv->playback;
 		caps = &pcm->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
-		set_stream_info(stream, caps);
+		ret = set_stream_info(stream, caps);
+		if (ret < 0)
+			goto err;
 	}
 
 	if (pcm->capture) {
 		stream = &dai_drv->capture;
 		caps = &pcm->caps[SND_SOC_TPLG_STREAM_CAPTURE];
-		set_stream_info(stream, caps);
+		ret = set_stream_info(stream, caps);
+		if (ret < 0)
+			goto err;
 	}
 
 	if (pcm->compress)
@@ -1835,11 +1849,7 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	ret = soc_tplg_dai_load(tplg, dai_drv, pcm, NULL);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
-		kfree(dai_drv->playback.stream_name);
-		kfree(dai_drv->capture.stream_name);
-		kfree(dai_drv->name);
-		kfree(dai_drv);
-		return ret;
+		goto err;
 	}
 
 	dai_drv->dobj.index = tplg->index;
@@ -1860,6 +1870,14 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 		return ret;
 	}
 
+	return 0;
+
+err:
+	kfree(dai_drv->playback.stream_name);
+	kfree(dai_drv->capture.stream_name);
+	kfree(dai_drv->name);
+	kfree(dai_drv);
+
 	return ret;
 }
 
@@ -1916,11 +1934,20 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	if (strlen(pcm->pcm_name)) {
 		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
 		link->stream_name = kstrdup(pcm->pcm_name, GFP_KERNEL);
+		if (!link->name || !link->stream_name) {
+			ret = -ENOMEM;
+			goto err;
+		}
 	}
 	link->id = le32_to_cpu(pcm->pcm_id);
 
-	if (strlen(pcm->dai_name))
+	if (strlen(pcm->dai_name)) {
 		link->cpus->dai_name = kstrdup(pcm->dai_name, GFP_KERNEL);
+		if (!link->cpus->dai_name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
 
 	link->codecs->name = "snd-soc-dummy";
 	link->codecs->dai_name = "snd-soc-dummy-dai";
@@ -2436,13 +2463,17 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 	if (d->playback) {
 		stream = &dai_drv->playback;
 		caps = &d->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
-		set_stream_info(stream, caps);
+		ret = set_stream_info(stream, caps);
+		if (ret < 0)
+			goto err;
 	}
 
 	if (d->capture) {
 		stream = &dai_drv->capture;
 		caps = &d->caps[SND_SOC_TPLG_STREAM_CAPTURE];
-		set_stream_info(stream, caps);
+		ret = set_stream_info(stream, caps);
+		if (ret < 0)
+			goto err;
 	}
 
 	if (d->flag_mask)
@@ -2454,10 +2485,15 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 	ret = soc_tplg_dai_load(tplg, dai_drv, NULL, dai);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
-		return ret;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	kfree(dai_drv->playback.stream_name);
+	kfree(dai_drv->capture.stream_name);
+	return ret;
 }
 
 /* load physical DAI elements */
-- 
2.20.1

