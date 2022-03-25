Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FD6C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Mar 2022 15:45:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43C94171E;
	Fri, 25 Mar 2022 16:44:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43C94171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648223133;
	bh=zW8PnmEKt5KbaGyqmP5Ywlvky3P9alY0nil2EBlvk0g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E4Of+8ZUOfberNPXENWJ7vXKuzpVaIIW2EZZQJ1fBtLmQoHj2BePgydP3Rz8WX+um
	 Q84eI1tR/EVo5H07mhJ0Me2rIibEbkt9BMyTdMhGnuVBHZJEowVm4gIRkQoBYqe7yD
	 dZ0fS2FhZ+vw7GKL/yd5MN/X6xQgycb1yQIBhXwM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF2CCF80519;
	Fri, 25 Mar 2022 16:43:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C03FF8051A; Fri, 25 Mar 2022 16:43:55 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB46FF80517
 for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2022 16:43:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB46FF80517
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TdouIa+g"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D77AAB827B7;
 Fri, 25 Mar 2022 15:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC59C340E9;
 Fri, 25 Mar 2022 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648223013;
 bh=zW8PnmEKt5KbaGyqmP5Ywlvky3P9alY0nil2EBlvk0g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TdouIa+g3hebWCbUeaeMhhpV3S+ZXbCTpX8A7X9CRhrUPsNwTYFQMLKwxnT7Ay5iG
 dFS4F/u13544RznyPEL6WObLRwJ3EtYrID0j5OTJpHG5DJFaVA+801oQ6DGiV85CXq
 uX2yQySJL5h/cnBgAxn4NAu41YBR/J1Ybz/lwE8zV2BFz2VkHHPxB/bKrbq5NEq/6S
 t2DUj8f6WxHXaet4nvbe6mO20ed0OrEbg3Mq96HCqqo1ufwPh3klvePL3XpAJIruha
 Jvb03JT17CSQPTk8ASpYZqpkFZOkZIVeFIkWBkwsqv8GjT7bDQQKeVEraNSVs+vV6S
 f/a555oM3gw+w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v1 2/3] ASoC: atmel: Fix error handling in at91samg20ek probe()
Date: Fri, 25 Mar 2022 15:42:40 +0000
Message-Id: <20220325154241.1600757-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325154241.1600757-1-broonie@kernel.org>
References: <20220325154241.1600757-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; h=from:subject;
 bh=zW8PnmEKt5KbaGyqmP5Ywlvky3P9alY0nil2EBlvk0g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiPeLvLm54d5ZOtO4ZWPZ1JAbCbUeO6Eg4aIH6kUmb
 Du3dVQuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYj3i7wAKCRAk1otyXVSH0I6uB/
 9yO5SP2kSH0g+jaZH8UUdPEIoOjZfzVTk9Lq7m5Z6kNeJBCB8Yk862oQzwderh9AanncZ544C2tnWI
 kHfUop8HNKQf0Nc2HdUg6Z95PQ7o6LnWr8RjNxBx7GjfiXPOVHaNeCAC1Mgbg5nyJTURCW5/HjnO/q
 uRnz7Jylxka8tWPh68z++NqqaBTdozlmqR5P/2MRHPObkKZLae6dp5/0psYSYe8G5owd+rS0Kgc3Wl
 cBS057i1QMBEvHcjeuVvhqepJm6nUEAVmAZSo+oSbw0NblfTEeDJpLosW7BQPqJKpGSKTQikVsitIt
 U6irnBbuFEuYwxC+Zzw63EMQRYkG+3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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

The error handling in the AT91SAM9G20-EK machine driver probe did not
consistently free the SSC in error paths, sometimes immediately returning
an error rather than doing cleanup. Fix this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/sam9g20_wm8731.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 0d639a33ad96..d771843011ea 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -148,7 +148,8 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	codec_np = of_parse_phandle(np, "atmel,audio-codec", 0);
 	if (!codec_np) {
 		dev_err(&pdev->dev, "codec info missing\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 	at91sam9g20ek_dai.codecs->of_node = codec_np;
 
@@ -159,7 +160,8 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "dai and pcm info missing\n");
 		of_node_put(codec_np);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 	at91sam9g20ek_dai.cpus->of_node = cpu_np;
 	at91sam9g20ek_dai.platforms->of_node = cpu_np;
@@ -170,9 +172,10 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed\n");
+		goto err;
 	}
 
-	return ret;
+	return 0;
 
 err:
 	atmel_ssc_put_audio(0);
-- 
2.30.2

