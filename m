Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB98EE7FF4
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Sep 2023 07:34:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F65FAE9;
	Mon, 11 Sep 2023 09:33:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F65FAE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694417659;
	bh=bzJxkBfpVm1/deBBiF/eNjThcHxDvsNuUv8j7H0sCsY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=l9ts5OTyK7Xo8QrPGPyUCCRNQzeusOZemMM21FSpLf1CqTc8ZTHsnVwBLgs8GhK1s
	 MI8NREMO34UUVL7V9CBzUSN4Js8gQEkgbx1ArAJUErk47vSoWCad6KijoDVPl/6rHw
	 oyfNfPykr2scLbR83bx4lQtZJrsaDJOvhmlnKx7U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A7C26F805C9; Mon, 11 Sep 2023 09:31:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EBDE4F805AF;
	Mon, 11 Sep 2023 09:31:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70856F80425; Mon, 11 Sep 2023 08:47:05 +0200 (CEST)
Received: from smtp3.hiworks.co.kr (smtp3.hiworks.co.kr [121.254.168.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E68D1F800AA
	for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2023 08:46:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E68D1F800AA
Received: (qmail 149409 invoked from network); 11 Sep 2023 15:46:50 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.162)
	by 0 (qmail 1.03 + ejcp v14) with SMTP;
	11 Sep 2023 15:46:50 +0900
Received: (qmail 79196 invoked from network); 11 Sep 2023 15:46:50 +0900
Received: from unknown (HELO saram-MINIPC-PN53..)
 (mwkim@gaonchips.com@220.88.49.178)
	by 0 (qmail 1.03 + ejcp v14) with SMTP;
	11 Sep 2023 15:46:50 +0900
X-Authinfo: HIWORKS SMTP authenticated
 <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230911154650_360978981>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From: Myunguk Kim <mwkim@gaonchips.com>
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Maxim Kochetkov <fido_max@inbox.ru>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Myunguk Kim <mwkim@gaonchips.com>
Subject: [PATCH] ASoC: dwc: fix typo in comment
Date: Mon, 11 Sep 2023 15:46:46 +0900
Message-Id: <20230911064646.168181-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mwkim@gaonchips.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: SFPBXWVOBMAM44Q7UOQIEEG564VQPFGI
X-Message-ID-Hash: SFPBXWVOBMAM44Q7UOQIEEG564VQPFGI
X-Mailman-Approved-At: Mon, 11 Sep 2023 07:31:22 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SFPBXWVOBMAM44Q7UOQIEEG564VQPFGI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This fixes typo in comment

Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>
---
 sound/soc/dwc/dwc-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 71ff894035a4..45e55e550924 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -138,7 +138,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 			irq_valid = true;
 		}
 
-		/* Error Handling: TX */
+		/* Error Handling: RX */
 		if (isr[i] & ISR_RXFO) 
{ 			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
-- 
2.34.1

