Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A1CA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:07:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A093F20873
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AWnh8mA4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="B2Y4N3ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A093F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED3951FD6;
	Mon, 28 Oct 2019 16:06:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED3951FD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572275223;
	bh=h+so+3rF61oknDHnQST6d8oJPykJyVgVgPoobZjfGX0=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=AWnh8mA4WSrcvA1wzYkwQUXOiOOI9SCBHBTuCSEddjtBYM94CGc4lb+tGbAYkFPwe
	 AA2zqCzMa6d4RcNk5Gm+bQzJU+KpkT+hylPU8PoYtXnV3Ks3yYT+JniIaLVhFjSaX3
	 WZpsQuh2H3dB+T0BpmFOeiX516jSgE2m2BnI7mwQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E802DF80722;
	Mon, 28 Oct 2019 15:57:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38992F8067C; Mon, 28 Oct 2019 15:56:51 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1BB3F802BD
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 15:56:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1BB3F802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="B2Y4N3ip"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=gOcOEJt2q/D+fwIXs54Af+3qLEpeDDeV9dlFYIVsJHc=; b=B2Y4N3ipbhYV
 uxRkKiQlC5PhIAo3M6FbnwBDtmHOTvsS65xXjhvfhuNvtAsFdfWx+vBbUxJlcv+mJYbHS4HiGIUNo
 kralZKPoAhyVCwNmb+7WaiZghlc/EmHc1RYIzEDO9Ehu7eGp05SvkPaX+y16lH7j6w+Xw8rnxj77Y
 3eQiE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iP6Rd-0008PZ-Fs; Mon, 28 Oct 2019 14:56:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id AD02F274168E; Mon, 28 Oct 2019 14:56:31 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Keyon Jie <yang.jie@linux.intel.com>
In-Reply-To: <20191025224122.7718-10-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191028145631.AD02F274168E@ypsilon.sirena.org.uk>
Date: Mon, 28 Oct 2019 14:56:31 +0000 (GMT)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: topology: parse and store
	d0i3_compatible flag" to the asoc tree
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

   ASoC: SOF: topology: parse and store d0i3_compatible flag

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

From c5232c0171428f005a3204e1c264231fb5999b28 Mon Sep 17 00:00:00 2001
From: Keyon Jie <yang.jie@linux.intel.com>
Date: Fri, 25 Oct 2019 17:41:05 -0500
Subject: [PATCH] ASoC: SOF: topology: parse and store d0i3_compatible flag

Parses the token from tplg file and store it to snd_sof_pcm_stream
d0i3_compatible flag, which can be used later for d0ix transition
management.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191025224122.7718-10-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/topology.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 121e5d6f8477..cc138ac6a8eb 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2307,6 +2307,7 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct snd_soc_tplg_stream_caps *caps;
+	struct snd_soc_tplg_private *private = &pcm->priv;
 	struct snd_sof_pcm *spcm;
 	int stream = SNDRV_PCM_STREAM_PLAYBACK;
 	int ret = 0;
@@ -2329,10 +2330,22 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 	dai_drv->dobj.private = spcm;
 	list_add(&spcm->list, &sdev->pcm_list);
 
+	ret = sof_parse_tokens(scomp, spcm, stream_tokens,
+			       ARRAY_SIZE(stream_tokens), private->array,
+			       le32_to_cpu(private->size));
+	if (ret) {
+		dev_err(sdev->dev, "error: parse stream tokens failed %d\n",
+			le32_to_cpu(private->size));
+		return ret;
+	}
+
 	/* do we need to allocate playback PCM DMA pages */
 	if (!spcm->pcm.playback)
 		goto capture;
 
+	dev_vdbg(sdev->dev, "tplg: pcm %s stream tokens: playback d0i3:%d\n",
+		 spcm->pcm.pcm_name, spcm->stream[0].d0i3_compatible);
+
 	caps = &spcm->pcm.caps[stream];
 
 	/* allocate playback page table buffer */
@@ -2360,6 +2373,9 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 	if (!spcm->pcm.capture)
 		return ret;
 
+	dev_vdbg(sdev->dev, "tplg: pcm %s stream tokens: capture d0i3:%d\n",
+		 spcm->pcm.pcm_name, spcm->stream[1].d0i3_compatible);
+
 	caps = &spcm->pcm.caps[stream];
 
 	/* allocate capture page table buffer */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
