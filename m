Return-Path: <SRS0=2VZE=MQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38023C4338F
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 09:00:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A779460EB0
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 09:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A779460EB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E9DD177D;
	Sat, 24 Jul 2021 10:59:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E9DD177D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627117212;
	bh=lA1SeTbLOiJuhIfhpEeJJtVDfLt0+CpHgV6R/aRtuS0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Zu2y7qeAHFAyEinoHHSePUkEDi8Sa+931+38xE4rMN4g9JKS0aHd67v0kAo/iqfr3
	 BD6M1f/kjiEDlVJN8+0lr4uksATJS/MloRiI7vqIQ0lKPfZpDOoj1ldrREI59LKiuE
	 bNDCQRY/zv0Ql5C8wSFO2B2VG9WNJ5qHx2eQ7dAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5572F8053A;
	Sat, 24 Jul 2021 10:53:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E83CF80227; Sat, 24 Jul 2021 06:24:27 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5851F800F0
 for <alsa-devel@alsa-project.org>; Sat, 24 Jul 2021 06:24:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5851F800F0
X-UUID: 835c1033b48042da90d5566321577798-20210724
X-UUID: 835c1033b48042da90d5566321577798-20210724
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <chihhao.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1923782835; Sat, 24 Jul 2021 12:24:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 24 Jul 2021 12:24:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Sat, 24 Jul 2021 12:24:06 +0800
From: <chihhao.chen@mediatek.com>
To: <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <alsa-devel@alsa-project.org>, <damien@zamaudio.com>,
 <chihhao.chen@mediatek.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <matthias.bgg@gmail.com>
Subject: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
Date: Sat, 24 Jul 2021 12:23:41 +0800
Message-ID: <1627100621-19225-1-git-send-email-chihhao.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Approved-At: Sat, 24 Jul 2021 10:53:22 +0200
Cc: wsd_upstream@mediatek.com
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

From: "chihhao.chen" <chihhao.chen@mediatek.com>

The following scenario describes an echo test for
Samsung USBC Headset (AKG) with VID/PID (0x04e8/0xa051).

We first start a capture stream(USB IN transfer) in 96Khz/24bit/1ch mode.
In clock find source function, we get value 0x2 for clock selector
and 0x1 for clock source.

Kernel-4.14 behavior
Since clock source is valid so clock selector was not set again.
We pass through this function and start a playback stream(USB OUT transfer)
in 48Khz/32bit/2ch mode. This time we get value 0x1 for clock selector
and 0x1 for clock source. Finally clock id with this setting is 0x9.

Kernel-5.10 behavior
Clock selector was always set one more time even it is valid.
When we start a playback stream, we will get 0x2 for clock selector
and 0x1 for clock source. In this case clock id becomes 0xA.
This is an incorrect clock source setting and results in severe noises.
We see wrong data rate in USB IN transfer.
(From 288 bytes/ms becomes 144 bytes/ms) It should keep in 288 bytes/ms.

This earphone works fine on older kernel version load because
this is a newly-added behavior.

Signed-off-by: chihhao.chen <chihhao.chen@mediatek.com>
---
 sound/usb/clock.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 52de522..14456f6 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -324,6 +324,12 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 					      sources[ret - 1],
 					      visited, validate);
 		if (ret > 0) {
+			/*
+			 * For Samsung USBC Headset (AKG), setting clock selector again
+			 * will result in incorrect default clock setting problems
+			 */
+			if (chip->usb_id == USB_ID(0x04e8, 0xa051))
+				return ret;
 			err = uac_clock_selector_set_val(chip, entity_id, cur);
 			if (err < 0)
 				return err;
-- 
1.7.9.5

