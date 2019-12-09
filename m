Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF53C2D0C9
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:26:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A21D24684
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a1Tka2TB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A21D24684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19F9416A8;
	Mon,  9 Dec 2019 20:08:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19F9416A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575918530;
	bh=Nj1SvI4KlFjxLuzkGrcekd/L18VB1XGTzNSmNn28084=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=a1Tka2TBnegY3V60LgfPt9zaXVG448C0PydfbAEdE+5dE3WmHTyEPrbRRsT7NSo7O
	 iDq33xRVUdCBK1cyPFVtwuZN89J5Z/NO3jU70d9jgM+Ln3nIDVnbyoQgAUE3e4aasP
	 GilUzyrk3hrgwYCfwsIrT4iE28XoKFqiR352d84Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98F79F80307;
	Mon,  9 Dec 2019 19:59:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35DADF802C3; Mon,  9 Dec 2019 19:59:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id DD70AF802A0
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 19:59:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD70AF802A0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B4B311D4;
 Mon,  9 Dec 2019 10:59:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B7B63F6CF;
 Mon,  9 Dec 2019 10:59:07 -0800 (PST)
Date: Mon, 09 Dec 2019 18:59:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20191206103542.485224-1-jbrunet@baylibre.com>
Message-Id: <applied-20191206103542.485224-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: [alsa-devel] Applied "ASoC: hdmi-codec: re-introduce mutex locking
	again" to the asoc tree
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

   ASoC: hdmi-codec: re-introduce mutex locking again

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

From 1442842952ccfe4178602c7a8459ac2ecb9d9e1a Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 6 Dec 2019 11:35:42 +0100
Subject: [PATCH] ASoC: hdmi-codec: re-introduce mutex locking again

The dai codec needs to ensure that on one dai is used at any time.
This is currently protected by bit atomic operation. With this change,
it done with a mutex instead.

This change is not about functionality or efficiency. It is done with
the hope that it help maintainability in the future.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20191206103542.485224-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f8b5b960e597..543363102d03 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -274,7 +274,8 @@ struct hdmi_codec_priv {
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
-	unsigned long busy;
+	struct mutex lock;
+	bool busy;
 	struct snd_soc_jack *jack;
 	unsigned int jack_status;
 };
@@ -390,9 +391,10 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	ret = test_and_set_bit(0, &hcp->busy);
-	if (ret) {
+	mutex_lock(&hcp->lock);
+	if (hcp->busy) {
 		dev_err(dai->dev, "Only one simultaneous stream supported!\n");
+		mutex_unlock(&hcp->lock);
 		return -EINVAL;
 	}
 
@@ -405,21 +407,21 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	if (hcp->hcd.ops->get_eld) {
 		ret = hcp->hcd.ops->get_eld(dai->dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
+		if (ret)
+			goto err;
+
+		ret = snd_pcm_hw_constraint_eld(substream->runtime, hcp->eld);
+		if (ret)
+			goto err;
 
-		if (!ret) {
-			ret = snd_pcm_hw_constraint_eld(substream->runtime,
-							hcp->eld);
-			if (ret)
-				goto err;
-		}
 		/* Select chmap supported */
 		hdmi_codec_eld_chmap(hcp);
 	}
-	return 0;
+
+	hcp->busy = true;
 
 err:
-	/* Release the exclusive lock on error */
-	clear_bit(0, &hcp->busy);
+	mutex_unlock(&hcp->lock);
 	return ret;
 }
 
@@ -431,7 +433,9 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 	hcp->hcd.ops->audio_shutdown(dai->dev->parent, hcp->hcd.data);
 
-	clear_bit(0, &hcp->busy);
+	mutex_lock(&hcp->lock);
+	hcp->busy = false;
+	mutex_unlock(&hcp->lock);
 }
 
 static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
@@ -811,6 +815,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
+	mutex_init(&hcp->lock);
+
 	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
 	if (!daidrv)
 		return -ENOMEM;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
