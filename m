Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F8C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 14:50:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18AC20787
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 14:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nFRJAnO6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG9bX83O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18AC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E9C416BA;
	Tue, 14 Apr 2020 16:49:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E9C416BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586875840;
	bh=qjA05PCJaUeAVGIYRRdnwMLM3D2449bOe/G3vC8w9zY=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=nFRJAnO6t6QchWqqN5g1LvONKa9CMBaRn5YbtXFD5ZOPsiX5uJ9cITtLF85p3u8ig
	 AD9n56skKbNGU6qcs+KDTICkuVnuIcCQGzidJmybGWK2YbQZj/rbb86OJ6oT9ze/Uv
	 vgz8D5YJRysS2M8xMTM8UyJaU5brqz2Ws0cvpE5k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B753DF802DB;
	Tue, 14 Apr 2020 16:46:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD331F802DC; Tue, 14 Apr 2020 16:46:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 346C4F802C4
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 16:46:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 346C4F802C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HG9bX83O"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E3E72085B;
 Tue, 14 Apr 2020 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586875584;
 bh=qjA05PCJaUeAVGIYRRdnwMLM3D2449bOe/G3vC8w9zY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=HG9bX83OW/KSz+tCeLYIEQ+bZNtvDSICXD9vznzptBIbPiBETs+qcjGhn2wQkCREW
 pqUW7A4Tbzgcn5ciO+31IKf/Db3PST8Ow7iuOZ63qEgBrpaKpXKcIkez0Yq4pLPO91
 VDwdp8johqFbIJpbFoWeusdhhIAEln2gSXk9lXl4=
Date: Tue, 14 Apr 2020 15:46:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Applied "ASoC: dapm: Move error message to avoid some duplication" to
 the asoc tree
In-Reply-To: <20200409181209.30130-2-ckeepax@opensource.cirrus.com>
Message-Id: <applied-20200409181209.30130-2-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 patches@opensource.cirrus.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, vkoul@kernel.org,
 Mark Brown <broonie@kernel.org>, shreyas.nc@intel.com,
 yung-chuan.liao@linux.intel.com
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

   ASoC: dapm: Move error message to avoid some duplication

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

From 9a1bb600ecafcb07391c83f7c31057abdd3757b7 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 9 Apr 2020 19:12:08 +0100
Subject: [PATCH] ASoC: dapm: Move error message to avoid some duplication

Move the error message into snd_soc_dapm_new_dai from
dapm_connect_dai_pair, since the two copies are almost identical and
are the only callers.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200409181209.30130-2-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fe907f0cc709..33168980619b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4165,6 +4165,8 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card,
 	w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
 	if (IS_ERR(w)) {
 		ret = PTR_ERR(w);
+		dev_err(rtd->dev, "ASoC: Failed to create %s widget: %d\n",
+			link_name, ret);
 		goto outfree_kcontrol_news;
 	}
 
@@ -4327,13 +4329,8 @@ static void dapm_connect_dai_pair(struct snd_soc_card *card,
 		if (dai_link->params && !dai_link->playback_widget) {
 			substream = streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
 			dai = snd_soc_dapm_new_dai(card, substream, "playback");
-			if (IS_ERR(dai)) {
-				dev_err(rtd->dev,
-					"ASoC: Failed to create DAI %s: %ld\n",
-					codec_dai->name,
-					PTR_ERR(dai));
+			if (IS_ERR(dai))
 				goto capture;
-			}
 			dai_link->playback_widget = dai;
 		}
 
@@ -4350,13 +4347,8 @@ static void dapm_connect_dai_pair(struct snd_soc_card *card,
 		if (dai_link->params && !dai_link->capture_widget) {
 			substream = streams[SNDRV_PCM_STREAM_CAPTURE].substream;
 			dai = snd_soc_dapm_new_dai(card, substream, "capture");
-			if (IS_ERR(dai)) {
-				dev_err(rtd->dev,
-					"ASoC: Failed to create DAI %s: %ld\n",
-					codec_dai->name,
-					PTR_ERR(dai));
+			if (IS_ERR(dai))
 				return;
-			}
 			dai_link->capture_widget = dai;
 		}
 
-- 
2.20.1

