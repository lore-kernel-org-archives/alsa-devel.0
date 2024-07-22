Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB39DC3DA5D
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:03:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B6D1E80;
	Mon, 22 Jul 2024 15:03:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B6D1E80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1721653400;
	bh=Irjznp9s1xHSOnjL1LRDWbTo0pqFCAdZy/M6HPja0s0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=WxzxopmAMLDYgv0GpZ8qZsHzfsb+DO0nVYm8Mjt9HudCTk9mt0pw1RQ3BZL4DHsDy
	 wAHsURjZ5QYNIH7GaMHMs1HgpsM4pl4DhIWP7iWVWvvm/kVtJVCpn2M25z4J3uNuAx
	 iHYxxEm4ovKlyAb4arqgP2mew+LGrn7oTMhg0JmE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C6B2F80717; Mon, 22 Jul 2024 15:00:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EEC3F806B7;
	Mon, 22 Jul 2024 15:00:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AFB8EF801F5; Mon, 22 Jul 2024 03:30:37 +0200 (CEST)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by alsa1.perex.cz (Postfix) with ESMTP id C8811F800C9
	for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2024 03:30:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8811F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=qQOU12gz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xWXa+
	yb0Rmb14pkRECozZYNIRdp7liyu1MZuBlUcxow=; b=qQOU12gz++VWEmMFpSqlh
	b71LaJCBqda5uJt+avURs9HYpvYr6GUvsRsFoC4MxqHUrKq0rG1ws+jzX2UPaq9S
	khde5mCbE4n+krvf3qhw0dr+24QLYnGmsvyAazNS385iZB3quN1P17mpLiv/pKYi
	492Gr2UVcd02FRwaExCluo=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id
 _____wD3P5Mvtp1md4p1EA--.57896S2;
	Mon, 22 Jul 2024 09:30:25 +0800 (CST)
From: wangdicheng <wangdich9700@163.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH v2] ALSA: usb-audio: Add a quirk for Sonix HD USB Camera
Date: Mon, 22 Jul 2024 09:30:21 +0800
Message-Id: <20240722013021.10727-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3P5Mvtp1md4p1EA--.57896S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrykJr1kAw4kXw4fXFyfXrb_yoW8Xr18pr
	4xC395trn8Wr1UXr1UtFWUX3WfWw4kCay5Jry3Wwsxtr13Ka1rJF97A3yI9w42krZ8Caya
	q3Z0v395KFZakaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYMKZUUUUU=
X-Originating-IP: [111.48.69.245]
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbiNREkT2V4Iu6kVwAAst
X-MailFrom: wangdich9700@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: PJHIPNFC3OZ4IAYBWD3ME6SACYBBHJCG
X-Message-ID-Hash: PJHIPNFC3OZ4IAYBWD3ME6SACYBBHJCG
X-Mailman-Approved-At: Mon, 22 Jul 2024 13:00:44 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PJHIPNFC3OZ4IAYBWD3ME6SACYBBHJCG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: wangdicheng <wangdicheng@kylinos.cn>

Sonix HD USB Camera does not support reading the sample rate which leads
to many lines of "cannot get freq at ep 0x84".
This patch adds the USB ID to quirks.c and avoids those error messages.

(snip)
[1.789698] usb 3-3: new high-speed USB device number 2 using xhci_hcd
[1.984121] usb 3-3: New USB device found, idVendor=0c45, idProduct=6340, bcdDevice= 0.00
[1.984124] usb 3-3: New USB device strings: Mfr=2, Product=1, SerialNumber=0
[1.984127] usb 3-3: Product: USB 2.0 Camera
[1.984128] usb 3-3: Manufacturer: Sonix Technology Co., Ltd.
[5.440957] usb 3-3: 3:1: cannot get freq at ep 0x84
[12.130679] usb 3-3: 3:1: cannot get freq at ep 0x84
[12.175065] usb 3-3: 3:1: cannot get freq at ep 0x84

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
v1 -> v2: Arrange the ID in order
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 58156fbca02c..54b2d2f314ac 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2225,6 +2225,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x534d, 0x2109, /* MacroSilicon MS2109 */
 		   QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.25.1

