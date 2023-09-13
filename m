Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C78EEAA4E
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Sep 2023 15:08:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BADBEDE5;
	Thu, 14 Sep 2023 17:07:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BADBEDE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694704085;
	bh=TdL1S+VKsScHsxi4hpp71c0KHJEECPS83FKQ9/98Bxs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jJz4jLh5WbRWS0wvHj71WIgD1otlfgejczlEaE/LW33SxRMd825P5DJ0JTAHSPPbt
	 mgxu1+cSQkefKeoXKfdn0rdimakf+L6jVVlXsptuV7dKkbrL4b1Hi3syx13W1wUl0n
	 yFfGREiC/UAvai9W5v98cxeceG8P7uffwoMoSWVQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48E15F8057F; Thu, 14 Sep 2023 17:06:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 611E5F8057A;
	Thu, 14 Sep 2023 17:06:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33D37F80425; Wed, 13 Sep 2023 04:41:46 +0200 (CEST)
Received: from smtp158.hiworks.co.kr (smtp158.hiworks.co.kr [211.43.203.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2507DF8007C
	for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2023 04:41:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2507DF8007C
Received: (qmail 148222 invoked from network); 13 Sep 2023 11:41:35 +0900
Received: from unknown (HELO smtp4.hiworks.co.kr) (121.254.168.203)
	by 0 (qmail 1.03 + ejcp v14) with SMTP;
	13 Sep 2023 11:41:35 +0900
Received: (qmail 18468 invoked from network); 13 Sep 2023 11:41:35 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.161)
	by 0 (qmail 1.03 + ejcp v14) with SMTP;
	13 Sep 2023 11:41:35 +0900
Received: (qmail 71941 invoked from network); 13 Sep 2023 11:41:35 +0900
Received: from unknown (HELO saram-MINIPC-PN53..)
 (mwkim@gaonchips.com@220.88.49.178)
	by 0 (qmail 1.03 + ejcp v14) with SMTP;
	13 Sep 2023 11:41:35 +0900
X-Authinfo: HIWORKS SMTP authenticated
 <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230913114135_422671671>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From: Myunguk Kim <mwkim@gaonchips.com>
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org,
	fido_max@inbox.ru,
	kuninori.morimoto.gx@renesas.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	u.kleine-koenig@pengutronix.de,
	xingyu.wu@starfivetech.com,
	mwkim@gaonchips.com
Subject: [PATCH] [v2] ASoC: dwc: fix typo in comment
Date: Wed, 13 Sep 2023 11:41:04 +0900
Message-Id: <20230913024103.1454354-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mwkim@gaonchips.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 46WPU2AUXWDBFELX664P5YGH3JH3YJRC
X-Message-ID-Hash: 46WPU2AUXWDBFELX664P5YGH3JH3YJRC
X-Mailman-Approved-At: Thu, 14 Sep 2023 15:06:21 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/46WPU2AUXWDBFELX664P5YGH3JH3YJRC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ISR_RXFO means "Status of Data Overrun interrupt for the RX channel"
according to the datasheet.

So, the comment should be RX, not TX

Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>
---
 sound/soc/dwc/dwc-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 22c004179214..c71c17ef961d 100644
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

