Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DAC433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:14:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F4320772
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AqEBfIiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F4320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E0EB16EF;
	Thu,  2 Jul 2020 16:14:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E0EB16EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593699295;
	bh=+xtsKHhgvDzUuRlbIQ9OrXUfdWB0O+XWQrz6Y7VhSwY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AqEBfIiYiqGlsdwPR7BD6Nb0xm+/LhxBI0SXipFYJTLtSIWjyvACmhPWGC2Y8Y2/Z
	 snXv4VYUvkIdrrTT8JFar1ZCyUS/PuQj552YBy7EXz19fZRtSrbiVTbGRgbCmt3gVc
	 ieW4KDDqzcdmlKHr5S3kYUAWm4lNtYl6kG7Dms5o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB53EF8027B;
	Thu,  2 Jul 2020 16:12:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70BD5F8028F; Thu,  2 Jul 2020 16:12:27 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF272F8022B
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 16:12:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF272F8022B
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: aferraris)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 35F8E2A5EC4;
 Thu,  2 Jul 2020 15:12:19 +0100 (BST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
To: 
Subject: [PATCH 2/2] ASoC: fsl-asoc-card: add support for generic I2S slave
 use-case
Date: Thu,  2 Jul 2020 16:11:15 +0200
Message-Id: <20200702141114.232688-3-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
References: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, kernel@collabora.com,
 Fabio Estevam <festevam@gmail.com>
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

This commit implements support for generic codecs with the SoC acting as
I2S slave, by implementing the new `fsl,imx-audio-i2s-slave` compatible
and related properties.

This is particularly useful when using a Bluetooth controller acting as
I2S master, but other simple or dummy codecs might benefit from it too.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 46 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 57ea1b072326..6076b963c873 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -166,12 +166,15 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 
 	/* Specific configurations of DAIs starts from here */
-	ret = snd_soc_dai_set_sysclk(asoc_rtd_to_cpu(rtd, 0), cpu_priv->sysclk_id[tx],
-				     cpu_priv->sysclk_freq[tx],
-				     cpu_priv->sysclk_dir[tx]);
-	if (ret && ret != -ENOTSUPP) {
-		dev_err(dev, "failed to set sysclk for cpu dai\n");
-		return ret;
+	if (cpu_priv->sysclk_freq[tx] > 0) {
+		ret = snd_soc_dai_set_sysclk(asoc_rtd_to_cpu(rtd, 0),
+					     cpu_priv->sysclk_id[tx],
+					     cpu_priv->sysclk_freq[tx],
+					     cpu_priv->sysclk_dir[tx]);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dev, "failed to set sysclk for cpu dai\n");
+			return ret;
+		}
 	}
 
 	if (cpu_priv->slot_width) {
@@ -475,11 +478,14 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 		return 0;
 	}
 
-	ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
-				     codec_priv->mclk_freq, SND_SOC_CLOCK_IN);
-	if (ret && ret != -ENOTSUPP) {
-		dev_err(dev, "failed to set sysclk in %s\n", __func__);
-		return ret;
+	if (codec_priv->mclk_freq > 0) {
+		ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
+					     codec_priv->mclk_freq,
+					     SND_SOC_CLOCK_IN);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dev, "failed to set sysclk in %s\n", __func__);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -620,6 +626,23 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.slot_width = 32;
 		priv->card.dapm_routes = audio_map_tx;
 		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-i2s-slave")) {
+		ret = of_property_read_string(np, "audio-codec-dai-name",
+					      &codec_dai_name);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get codec DAI name\n");
+			ret = -EINVAL;
+			goto asrc_fail;
+		}
+		ret = of_property_read_u32(np, "audio-slot-width",
+					   &priv->cpu_priv.slot_width);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get slot width\n");
+			ret = -EINVAL;
+			goto asrc_fail;
+		}
+		priv->card.set_bias_level = NULL;
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		ret = -EINVAL;
@@ -763,6 +786,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-ac97", },
+	{ .compatible = "fsl,imx-audio-i2s-slave", },
 	{ .compatible = "fsl,imx-audio-cs42888", },
 	{ .compatible = "fsl,imx-audio-cs427x", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
-- 
2.27.0

