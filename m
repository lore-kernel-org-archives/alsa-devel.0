Return-Path: <SRS0=xxPz=2E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5441C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:58:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6172072B
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XUbl6c0+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="bGI6A9XL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="bGI6A9XL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6172072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7D9D1670;
	Sun, 15 Dec 2019 00:57:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7D9D1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576367883;
	bh=khqyK2mKCEep103HooCvwT1jrSpeTuWvEcO52N5Z8/Y=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XUbl6c0+qdX7tEW+o38kwyXrq25PdljhDNUKOkPAOP1uIQr4F9cRmCtoYTc99jJCk
	 2MhHAt1zsIVmEFn8p1FbXL4uppLDya2QIuCXOWRpwoJZhuDdctjZhfHx9Z/WBl+qEf
	 Lvq9D0cwpYiRfhvBGhKW7QDhChV0A07KQ5nyCeCQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5D93F80248;
	Sun, 15 Dec 2019 00:56:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBB34F80109; Sun, 15 Dec 2019 00:56:16 +0100 (CET)
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E693F801D8
 for <alsa-devel@alsa-project.org>; Sun, 15 Dec 2019 00:56:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E693F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="bGI6A9XL"; 
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="bGI6A9XL"
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 7475F4E201A;
 Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1576367770; bh=BO3TEYl21sA/wMKA0yRtarf1F3XV3vT6Pf1Un5gTO5Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bGI6A9XLGa6MrFrHhC6w/It3fZHvDUlVHSpv4YH6UM5fB8ANQqkwUddkNT6j6jelp
 uQuj/bSMwKUWYQp0eC7K9dq6NWoCoVvxlFDe8OQWbc0bWgRDd8pVfwDmVaOyTYyY37
 1i4dDF9W1EHREi8eiYhxD96w1Tctfebkff6ep59A=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JAx7lS-p9mz6; Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
Received: from thinkpad-tablet.localdomain (S0106788a2041785e.gv.shawcable.net
 [70.66.86.75])
 by node.akkea.ca (Postfix) with ESMTPSA id EFB2D4E2006;
 Sat, 14 Dec 2019 23:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1576367770; bh=BO3TEYl21sA/wMKA0yRtarf1F3XV3vT6Pf1Un5gTO5Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bGI6A9XLGa6MrFrHhC6w/It3fZHvDUlVHSpv4YH6UM5fB8ANQqkwUddkNT6j6jelp
 uQuj/bSMwKUWYQp0eC7K9dq6NWoCoVvxlFDe8OQWbc0bWgRDd8pVfwDmVaOyTYyY37
 1i4dDF9W1EHREi8eiYhxD96w1Tctfebkff6ep59A=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: Mark Brown <broonie@kernel.org>
Date: Sat, 14 Dec 2019 15:55:49 -0800
Message-Id: <20191214235550.31257-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214235550.31257-1-angus@akkea.ca>
References: <20191214235550.31257-1-angus@akkea.ca>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 "Angus Ainslie \(Purism\)" <angus@akkea.ca>, kernel@puri.sm,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [alsa-devel] [PATCH v2 1/2] sound: codecs: gtm601: add Broadmobi
	bm818 sound profile
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

The Broadmobi bm818 uses stereo sound at 48Khz sample rate

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 sound/soc/codecs/gtm601.c | 46 ++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index d454294c8d06..44cdbd016761 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -37,7 +37,7 @@ static struct snd_soc_dai_driver gtm601_dai = {
 		.channels_max = 1,
 		.rates = SNDRV_PCM_RATE_8000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-		},
+	},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
@@ -47,6 +47,24 @@ static struct snd_soc_dai_driver gtm601_dai = {
 	},
 };
 
+static struct snd_soc_dai_driver bm818_dai = {
+	.name = "bm818",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+
 static const struct snd_soc_component_driver soc_component_dev_gtm601 = {
 	.dapm_widgets		= gtm601_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(gtm601_dapm_widgets),
@@ -58,20 +76,32 @@ static const struct snd_soc_component_driver soc_component_dev_gtm601 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int gtm601_platform_probe(struct platform_device *pdev)
-{
-	return devm_snd_soc_register_component(&pdev->dev,
-			&soc_component_dev_gtm601, &gtm601_dai, 1);
-}
-
 #if defined(CONFIG_OF)
 static const struct of_device_id gtm601_codec_of_match[] = {
-	{ .compatible = "option,gtm601", },
+	{ .compatible = "option,gtm601", .data = (void *)&gtm601_dai },
+	{ .compatible = "broadmobi,bm818", .data = (void *)&bm818_dai },
 	{},
 };
 MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
 #endif
 
+static int gtm601_platform_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct snd_soc_dai_driver *dai_driver = &gtm601_dai;
+	const struct of_device_id *id;
+
+#if defined(CONFIG_OF)
+	if (np) {
+		id = of_match_node(gtm601_codec_of_match, pdev->dev.of_node);
+		dai_driver = id->data;
+	}
+#endif
+
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_gtm601, dai_driver, 1);
+}
+
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
 		.name = "gtm601",
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
