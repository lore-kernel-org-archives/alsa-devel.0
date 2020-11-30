Return-Path: <SRS0=21/e=FE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E790C64E7B
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 04:07:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C602D20756
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 04:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ncfv58LA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C602D20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 272A81757;
	Mon, 30 Nov 2020 05:06:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 272A81757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606709228;
	bh=7DvGdJVQ90+MK6QoVE9CzxoWwmWGxb57inbFsWleS3w=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ncfv58LAYzMTPpl6btktvvYPtruKo107uU0qePkMP4AR16agY6t+mPoD2+Sja6Dzo
	 t6p2lr16QfxZi1RCHsZLmlbpLdYPB55OCPl1dfZEpArX/2d8r2OW2QwY3ayME/hejZ
	 F1a7hJ+NtQ2RA3Dk7SeZC7EJvU7Fx0Ut3AIOwJ/Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0858F804AA;
	Mon, 30 Nov 2020 05:05:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 830A8F8025F; Mon, 30 Nov 2020 05:05:25 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1B30F80247
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2020 05:05:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1B30F80247
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2473C20074A;
 Mon, 30 Nov 2020 05:05:16 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0922320073E;
 Mon, 30 Nov 2020 05:05:11 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C89D540326;
 Mon, 30 Nov 2020 05:05:04 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] ASoC: fsl-asoc-card: Add support for si476x codec
Date: Mon, 30 Nov 2020 11:57:47 +0800
Message-Id: <1606708668-28786-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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

The si476x codec is used for FM radio function on i.MX6
auto board, it only supports recording function.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index a2dd3b6b7fec..f62f81ceab0d 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -131,6 +131,13 @@ static const struct snd_soc_dapm_route audio_map_tx[] = {
 	{"CPU-Playback",  NULL, "ASRC-Playback"},
 };
 
+static const struct snd_soc_dapm_route audio_map_rx[] = {
+	/* 1st half -- Normal DAPM routes */
+	{"CPU-Capture",  NULL, "Capture"},
+	/* 2nd half -- ASRC DAPM routes */
+	{"ASRC-Capture",  NULL, "CPU-Capture"},
+};
+
 /* Add all possible widgets into here without being redundant */
 static const struct snd_soc_dapm_widget fsl_asoc_card_dapm_widgets[] = {
 	SND_SOC_DAPM_LINE("Line Out Jack", NULL),
@@ -653,6 +660,11 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.slot_width = 32;
 		priv->card.dapm_routes = audio_map_tx;
 		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-si476x")) {
+		codec_dai_name = "si476x-codec";
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+		priv->card.dapm_routes = audio_map_rx;
+		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_rx);
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		ret = -EINVAL;
@@ -869,6 +881,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-wm8960", },
 	{ .compatible = "fsl,imx-audio-mqs", },
 	{ .compatible = "fsl,imx-audio-wm8524", },
+	{ .compatible = "fsl,imx-audio-si476x", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_asoc_card_dt_ids);
-- 
2.27.0

