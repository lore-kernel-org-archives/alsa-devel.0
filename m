Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E866C77B7E
	for <alsa-devel@archiver.kernel.org>; Thu, 25 May 2023 18:44:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47295DF3;
	Thu, 25 May 2023 20:44:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47295DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685040296;
	bh=mQZOCKaKu/hy1ed/IVeQUFZPlBqiN0A0UWtyYRHjdh8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YM2xLmrZNN7HOVqftgblylptKWhax1t/QeNiQ2LEYJ9w9Fn7eGBBdP/4ScD3dRxvg
	 1ZNvHFyJ6QyLlS1TRyx77SbkqNryFrMOLeCUVgNeiEfFu+Vhu0jQjTkPkTn/a5kmkH
	 Nm8UT4ZI6ow0wBOwoVKd8TgeMSsA1Loug2ke2cYA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 055F8F800DF; Thu, 25 May 2023 20:44:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A278F800DF;
	Thu, 25 May 2023 20:44:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AED98F80553; Thu, 25 May 2023 20:44:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21B35F800DF
	for <alsa-devel@alsa-project.org>; Thu, 25 May 2023 20:44:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21B35F800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PNKuDSq3
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 122EB64990;
	Thu, 25 May 2023 18:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B750AC4339B;
	Thu, 25 May 2023 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685040239;
	bh=mQZOCKaKu/hy1ed/IVeQUFZPlBqiN0A0UWtyYRHjdh8=;
	h=From:To:Cc:Subject:Date:From;
	b=PNKuDSq3ppJoagBmHEK4uP9ITaRrzbWs0thK96/hIxTn3mUXHLm0/8kEnqwxTr7iN
	 gwrWvpJCrwlmtVWut20DJMSneDJG3f/kJgIz7Ms2iChyRsiH9JPDp/jLI3ZAEgu6n9
	 qZJf8Wj3ti9Y56y9crCAID9UdzsFNaowyBv5mHj2xLjFlTDiGNt1t7fSjsd51KpxuF
	 ywt7l73QPv1VqEpq7f7vbQUlGa5T9amkWnlFKkm8mDHTqK8DS7DYLwvhcyDn/LbShN
	 sIzro2bCbagWueYY3+oDlnerxwCa0JW4kvqxWpin3ga2PeLGPreVXIhTncyLLlOjtn
	 OoBakceLcOg2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxim Kochetkov <fido_max@inbox.ru>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	ckeepax@opensource.cirrus.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 01/27] ASoC: dwc: limit the number of overrun
 messages
Date: Thu, 25 May 2023 14:43:27 -0400
Message-Id: <20230525184356.1974216-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: F2JJ7VYP6FKEGF5V4UDJVU5NXUPLGT5W
X-Message-ID-Hash: F2JJ7VYP6FKEGF5V4UDJVU5NXUPLGT5W
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F2JJ7VYP6FKEGF5V4UDJVU5NXUPLGT5W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Maxim Kochetkov <fido_max@inbox.ru>

[ Upstream commit ab6ecfbf40fccf74b6ec2ba7ed6dd2fc024c3af2 ]

On slow CPU (FPGA/QEMU emulated) printing overrun messages from
interrupt handler to uart console may leads to more overrun errors.
So use dev_err_ratelimited to limit the number of error messages.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru
Link: https://lore.kernel.org/r/20230505062820.21840-1-fido_max@inbox.ru
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/dwc/dwc-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 65112b9d8588a..90b8814d7506a 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -132,13 +132,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 
 		/* Error Handling: TX */
 		if (isr[i] & ISR_TXFO) {
-			dev_err(dev->dev, "TX overrun (ch_id=%d)\n", i);
+			dev_err_ratelimited(dev->dev, "TX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
 		}
 
 		/* Error Handling: TX */
 		if (isr[i] & ISR_RXFO) {
-			dev_err(dev->dev, "RX overrun (ch_id=%d)\n", i);
+			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
 		}
 	}
-- 
2.39.2

