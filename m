Return-Path: <SRS0=rSKw=LW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B06C11F64
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Jun 2021 21:06:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA03361CF1
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Jun 2021 21:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA03361CF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A43C21673;
	Mon, 28 Jun 2021 23:05:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A43C21673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624914366;
	bh=V6RWH1gKd66wrBdwbdjlNKzzy3buQ1fgN1oyaF/vc0g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WoQmiqrJ4T/gPkBj4Ve6pCr0IUbQLRgJd8gi/IZ8qhABXWaRymaiWaeo2wHPhdXKq
	 igfXkZLhudhfLEcGye4qhHgRCHKNLvDVQWw+SBpI7BDtZtCSYO+u6vm9BKjqT7rqRp
	 cXIJ/io5DlJvqdfXQWh2YELwWhelr5U5Hf3eDRTg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24921F8012A;
	Mon, 28 Jun 2021 23:05:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 943C5F80229; Mon, 28 Jun 2021 23:05:14 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E4C2F8012A
 for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2021 23:05:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E4C2F8012A
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
 by metis.ext.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1lxyRA-0000EG-Nc; Mon, 28 Jun 2021 23:05:00 +0200
From: Lucas Stach <l.stach@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: codecs: allow SSM2518 to be selected by the user
Date: Mon, 28 Jun 2021 23:04:58 +0200
Message-Id: <20210628210458.2508973-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 kernel@pengutronix.de, patchwork-lst@pengutronix.de
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

Allow the Analog SSM2518 driver to be enabled without a large
bunch of other drivers.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2a7b3e363069..8f67c400d268 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1316,7 +1316,7 @@ config SND_SOC_SSM2305
 	  high-efficiency mono Class-D audio power amplifiers.
 
 config SND_SOC_SSM2518
-	tristate
+	tristate "Analog Devices SSM2518 Class-D Amplifier"
 	depends on I2C
 
 config SND_SOC_SSM2602
-- 
2.30.2

