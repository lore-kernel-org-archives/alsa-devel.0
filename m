Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322F4C54E60
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Mar 2024 08:59:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63D69279E;
	Sun, 17 Mar 2024 09:59:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63D69279E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710665989;
	bh=PZctGisBviZ+mhYGc0hACek77ifie3PoPw9sdjq58Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OS4Y7N3Gv8qVx4pMJ7X8x0pEfyCjAnBZkq4jBfIFRF2tLlJbmyidIWS3sr7kql+Os
	 GPTTN1L7d3B2CZlWW1XMj5JroXUAgLfaPtylTkT/QRgwHOsMpULwDZs7QqDtM7cuhc
	 0zGsZXm14g38jfzC5Pb7+JSwpCxxzHNcs7uNvd28=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A8BEF805F4; Sun, 17 Mar 2024 09:58:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9316AF805EA;
	Sun, 17 Mar 2024 09:58:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D604F8028D; Fri, 15 Mar 2024 12:28:27 +0100 (CET)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7DF5DF80564
	for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2024 12:28:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DF5DF80564
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=OAmeDyl1
Received: by mail.gandi.net (Postfix) with ESMTPA id A5B21E0008;
	Fri, 15 Mar 2024 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUQ51tONiYtM45o3XTZI6XR8a2iefLuxKfBONeCjMBU=;
	b=OAmeDyl1URRkwdmnV9xjdSDYTqCPZq7Lo3uQP/qsirimdgj75LzvdooBBW64tSkVs7UBNK
	Qr1Nj27ust8cyzZouNhKUw4IJWAOvjsRzEVi5jEG+nXP+8p0QhR6matgyotrrjUjGsqqkI
	aKcXz/29Qf2HpLk8UZ7vR9bkykTtEHUnqfKFD0f/SRk2n5GzDG9NP09QOPrwi1iGNledPR
	kSHRn5ukgDVX2jKd/cl2A0NWdRb5mmUFaKMLTLpOQTFLBZQicHu/3u39aO/3SOZZCTRL+I
	Bwa9DnkmdK0iDXNHA1Xpe6dGJHgrmCx45p9101QFwX8Q8GmhiFDdFHga5TUQOw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH 04/13] ASoC: ti: davinci-i2s: Replace dev_err with
 dev_err_probe
Date: Fri, 15 Mar 2024 12:27:36 +0100
Message-ID: <20240315112745.63230-5-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
X-MailFrom: bastien.curutchet@bootlin.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: UX2VRHEGYVG5YFLS3AWYTWVXNT7SPD5S
X-Message-ID-Hash: UX2VRHEGYVG5YFLS3AWYTWVXNT7SPD5S
X-Mailman-Approved-At: Sun, 17 Mar 2024 08:56:00 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There are dev_err() in the probe() function.

Replace them with dev_err_probe()

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 5c906641640e..4cb3ef62db20 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -644,8 +644,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 			 "\"mpu\" mem resource not found, using index 0\n");
 		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!mem) {
-			dev_err(&pdev->dev, "no mem resource?\n");
-			return -ENODEV;
+			return dev_err_probe(&pdev->dev, -ENODEV, "no mem resource?\n");
 		}
 	}
 
@@ -672,8 +671,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	} else if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
 		dma_data->filter_data = "tx";
 	} else {
-		dev_err(&pdev->dev, "Missing DMA tx resource\n");
-		return -ENODEV;
+		return dev_err_probe(&pdev->dev, -ENODEV, "Missing DMA tx resource\n");
 	}
 
 	dma_data = &dev->dma_data[SNDRV_PCM_STREAM_CAPTURE];
@@ -687,8 +685,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	} else if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
 		dma_data->filter_data = "rx";
 	} else {
-		dev_err(&pdev->dev, "Missing DMA rx resource\n");
-		return -ENODEV;
+		return dev_err_probe(&pdev->dev, -ENODEV, "Missing DMA rx resource\n");
 	}
 
 	dev->clk = clk_get(&pdev->dev, NULL);
@@ -708,7 +705,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	ret = edma_pcm_platform_register(&pdev->dev);
 	if (ret) {
-		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "register PCM failed\n");
 		goto err_unregister_component;
 	}
 
-- 
2.43.2

