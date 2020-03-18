Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94842C4332B
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 21:45:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9D620768
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 21:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TymV3Dxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9D620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72963173E;
	Wed, 18 Mar 2020 22:44:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72963173E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584567913;
	bh=/9nSN2i4/ou2uEhr5nak8IwvEU2dspFM4dhe+9ZzbPg=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=TymV3DxzX8nLsD5d68qA57dFbf0bW1W4YCQ80Fzqtw79jBEekikIUEmidBGM4IYJJ
	 ssy3jCdIxvJCiVVVWmrgkdkEovHcMHzbsDjw8/GQJLG2aS3EVe9wDWEnyPS94GB3+y
	 9eorYOShLlt88cgGdfbjbRtHgkkTX+iDP0+W3gUU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 192DAF80292;
	Wed, 18 Mar 2020 22:42:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04FC5F801DB; Wed, 18 Mar 2020 22:41:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 18EB3F800C0
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 22:41:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18EB3F800C0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05BC2FEC;
 Wed, 18 Mar 2020 14:41:48 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E6BB3F67D;
 Wed, 18 Mar 2020 14:41:47 -0700 (PDT)
Date: Wed, 18 Mar 2020 21:41:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Applied "ASoC: codecs: wsa881x: remove soundwire stream handling" to
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
Message-ID: <20200318214146.cjctHtQIJD-elVk2sRo0_Kz5hp7X_TA3-Fa_wHk7LYY@z>

The patch

   ASoC: codecs: wsa881x: remove soundwire stream handling

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

From 16252a8f3af77f69c2193fdc7b2f595b30845a44 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 17 Mar 2020 15:12:33 +0000
Subject: [PATCH] ASoC: codecs: wsa881x: remove soundwire stream handling

There could be multiple instances of this codec on any platform,
so handling stream directly in this codec driver can lead to
multiple calls to prepare/enable/disable on the same SoundWire stream.
Move this stream handling to machine driver to fix this issue.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200317151233.8763-3-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wsa881x.c | 44 +-------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index b59f1d0e7f84..3d525297eac9 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -676,7 +676,6 @@ struct wsa881x_priv {
 	int active_ports;
 	bool port_prepared[WSA881X_MAX_SWR_PORTS];
 	bool port_enable[WSA881X_MAX_SWR_PORTS];
-	bool stream_prepared;
 };
 
 static void wsa881x_init(struct wsa881x_priv *wsa881x)
@@ -954,41 +953,6 @@ static const struct snd_soc_dapm_widget wsa881x_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("SPKR"),
 };
 
-static int wsa881x_prepare(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *dai)
-{
-	struct wsa881x_priv *wsa881x = dev_get_drvdata(dai->dev);
-	int ret;
-
-	if (wsa881x->stream_prepared) {
-		sdw_disable_stream(wsa881x->sruntime);
-		sdw_deprepare_stream(wsa881x->sruntime);
-		wsa881x->stream_prepared = false;
-	}
-
-
-	ret = sdw_prepare_stream(wsa881x->sruntime);
-	if (ret)
-		return ret;
-
-	/**
-	 * NOTE: there is a strict hw requirement about the ordering of port
-	 * enables and actual PA enable. PA enable should only happen after
-	 * soundwire ports are enabled if not DC on the line is accumulated
-	 * resulting in Click/Pop Noise
-	 * PA enable/mute are handled as part of DAPM and digital mute.
-	 */
-
-	ret = sdw_enable_stream(wsa881x->sruntime);
-	if (ret) {
-		sdw_deprepare_stream(wsa881x->sruntime);
-		return ret;
-	}
-	wsa881x->stream_prepared = true;
-
-	return ret;
-}
-
 static int wsa881x_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
@@ -1016,12 +980,7 @@ static int wsa881x_hw_free(struct snd_pcm_substream *substream,
 {
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(dai->dev);
 
-	if (wsa881x->stream_prepared) {
-		sdw_disable_stream(wsa881x->sruntime);
-		sdw_deprepare_stream(wsa881x->sruntime);
-		sdw_stream_remove_slave(wsa881x->slave, wsa881x->sruntime);
-		wsa881x->stream_prepared = false;
-	}
+	sdw_stream_remove_slave(wsa881x->slave, wsa881x->sruntime);
 
 	return 0;
 }
@@ -1052,7 +1011,6 @@ static int wsa881x_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 
 static struct snd_soc_dai_ops wsa881x_dai_ops = {
 	.hw_params = wsa881x_hw_params,
-	.prepare = wsa881x_prepare,
 	.hw_free = wsa881x_hw_free,
 	.mute_stream = wsa881x_digital_mute,
 	.set_sdw_stream = wsa881x_set_sdw_stream,
-- 
2.20.1

