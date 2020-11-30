Return-Path: <SRS0=21/e=FE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3163C63777
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 21:57:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EE820857
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 21:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LeEJpjuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EE820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A53691689;
	Mon, 30 Nov 2020 22:56:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A53691689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606773451;
	bh=V7vcE0I1YsEKtKNHiG1dsj8Ic0Jxk66NV1IRbEE2ZXw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LeEJpjufgUZwbRPwFGNFoQiUbLpkU1hxTZz3NG6gMZsBlkOK9A06MgEQpJfTKeKlw
	 a3R7PN2GvyeXOekKF+kBcXKqDQ0Ks2bU0nfDHQJfh1EkN0A2DJUdnh6WgLTGDTyKO8
	 Y6xzAbw4aOgWQuJz676NGC80Xb3msY1fTdrXAmD8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 233F2F80254;
	Mon, 30 Nov 2020 22:56:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EE26F8025F; Mon, 30 Nov 2020 22:56:39 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CE5CF80247
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2020 22:56:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CE5CF80247
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr
 [86.194.74.19]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1F57F1BF206;
 Mon, 30 Nov 2020 21:56:28 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: adau1372: add missing dependencies
Date: Mon, 30 Nov 2020 22:56:26 +0100
Message-Id: <20201130215626.2400999-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org
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

SND_SOC_ADAU1372_I2C and SND_SOC_ADAU1372_SPI prpoerly select the REGMAP
config they need but forget to depend on the underlying bus.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 sound/soc/codecs/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a457300f95da..625f762903ea 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -371,11 +371,13 @@ config SND_SOC_ADAU1372
 
 config SND_SOC_ADAU1372_I2C
 	tristate "Analog Devices ADAU1372 CODEC (I2C)"
+	depends on I2C
 	select SND_SOC_ADAU1372
 	select REGMAP_I2C
 
 config SND_SOC_ADAU1372_SPI
 	tristate "Analog Devices ADAU1372 CODEC (SPI)"
+	depends on SPI
 	select SND_SOC_ADAU1372
 	select REGMAP_SPI
 
-- 
2.28.0

