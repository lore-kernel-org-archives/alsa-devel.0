Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F69C388F7
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 08:05:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F320A20829
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 08:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iH0+6kGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F320A20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E4CE16C2;
	Tue, 10 Nov 2020 09:04:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E4CE16C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604995527;
	bh=m43OKHsF8igua0bNCq7s6AvTqMEdAZmT44c9Grm7oD4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iH0+6kGhBT4rXe2n4riK0y1CY+WnmyiuyFd97CHmi7CjVFMBYalCp59s6fodx+IZu
	 Z/bkBRS8WIjehVddvWVD1kO7EhPPpZsnaj84XtFWhWn+d28o6+zFZVk55cxkhEQiRg
	 cq0qgvrYrJ6LjEhpq3W1EuQlv2xICvvPe7r6AI8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B61EBF80161;
	Tue, 10 Nov 2020 09:04:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C001F801D5; Tue, 10 Nov 2020 09:04:35 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id 6F1A1F80059
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 09:04:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F1A1F80059
X-UUID: 11ecea745cf34cf1b480769982905ca6-20201110
X-UUID: 11ecea745cf34cf1b480769982905ca6-20201110
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <macpaul.lin@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 708621736; Tue, 10 Nov 2020 16:04:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Nov 2020 16:04:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Tue, 10 Nov 2020 16:04:18 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, Alexander Tsoy <alexander@tsoy.me>,
 Nicola
 Lunghi <nick83ola@gmail.com>, Christopher Swenson <swenson@swenson.io>, Nick
 Kossifidis <mickflemm@gmail.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH] ALSA: usb-audio: disable 96khz support for HUAWEI USB-C
 HEADSET
Date: Tue, 10 Nov 2020 16:04:03 +0800
Message-ID: <1604995443-30453-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: linux-usb@vger.kernel.org,
 Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
 Eddie Hung <eddie.hung@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Macpaul Lin <macpaul@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 Ainge Hsu <ainge.hsu@mediatek.com>
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

The HUAWEI USB-C headset (VID:0x12d1, PID:0x3a07) reported it supports
96khz. However there will be some random issue under 96khz.
Not sure if there is any alternate setting could be applied.
Hence 48khz is suggested to be applied at this moment.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Eddie Hung <eddie.hung@mediatek.com>
---
 sound/usb/format.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 1b28d01..6f6e79b 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -217,6 +217,11 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 			    (chip->usb_id == USB_ID(0x041e, 0x4064) ||
 			     chip->usb_id == USB_ID(0x041e, 0x4068)))
 				rate = 8000;
+			/* Huawei headset can't support 96kHz fully */
+			if (rate == 96000 &&
+			    chip->usb_id == USB_ID(0x12d1, 0x3a07) &&
+			    le16_to_cpu(udev->descriptor.bcdDevice) == 0x49)
+				continue;
 
 			fp->rate_table[fp->nr_rates] = rate;
 			if (!fp->rate_min || rate < fp->rate_min)
-- 
1.7.9.5

