Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F17C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 07:44:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7336108E
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 07:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D7336108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=grieve.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 833581695;
	Fri, 15 Oct 2021 09:43:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 833581695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634283861;
	bh=q7JLyFI/DmFiTBbaru8IY2x2ZwyD+PPziWTEiaGQTf0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gFQTB3OmLHovDZ8SsPOmwU7p0S4HmJp72TiMjvvFIof8OVlw3KTGhNtmEEK+bausB
	 hao5gR501whmdH1kgUGu26MldRNKqfW8LYC5sKa755YjFDx3vHh7+3lKoj0zFd9AIL
	 75TIv/zkArPXZFnpvJj4YOYuI4AaCJ3yYOk8YG0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75C74F80290;
	Fri, 15 Oct 2021 09:43:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1EFAF80269; Fri, 15 Oct 2021 04:53:58 +0200 (CEST)
Received: from mail.worldguard.com.au (balthazar.worldguard.com.au
 [202.164.16.89])
 by alsa1.perex.cz (Postfix) with ESMTP id 6D507F80167
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 04:53:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D507F80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=grieve.com.au header.i=@grieve.com.au
 header.b="lOaw2uNd"
Received: from wg-server-submission (unknown [10.96.11.69])
 by mail.worldguard.com.au (Postfix) with ESMTP id B83B4A001D;
 Fri, 15 Oct 2021 02:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=grieve.com.au;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=aug2021; bh=q7JLyFI/DmFiTBbaru8IY2x2ZwyD+PPziWTEiaGQTf0=;
 b=lOaw2uNd9wL2jXDzF+BKgcWc7x09RLjTQRY2HZA1cuhi6zSDW53zY+IDB9LbsP+h+S6KyBZn4uAA/38w9S0t01NjlqXFsQL2Bizx+yjZ1pMk3aNjcjC+6TFgZmhwSBpXxhdLdrIaPcAxE9Lr38aNB5JiBr2kT3f48ghQHpd9cnhY0y1essdWI4WP6jHu7b7l4SwcBp9xaAy3cEkKvkXKlu4CtPzzpQZ3LYXklMZ2yeMmuEGb9V5OFCVEp4BA38KQWEDRR6ixMQNuFNqYdRmV8QbJQ1MRTUIjbex6yzQbtXXRhUi6OEAqr64KfRCDxKckFKiYKgqSATGdbIf5oSF53g==
Received: from 238.125.218.139.sta.wbroadband.net.au (HELO
 cat.internal.worldguard.com.au) (139.218.125.238)
 by wg-server-submission (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted)
 ESMTPSA; Fri, 15 Oct 2021 02:53:41 +0000
Authentication-Results: wg-server-submission;
 auth=pass (plain) smtp.auth=brendan@grieve.com.au
From: Brendan Grieve <brendan@grieve.com.au>
To: tiwai@suse.com
Subject: [PATCH] sound/usb: Provide quirk for Sennheiser GSP670 Headset
Date: Fri, 15 Oct 2021 10:53:35 +0800
Message-Id: <20211015025335.196592-1-brendan@grieve.com.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Checked: Checked by ClamAV on wg-server-submission
X-Mailman-Approved-At: Fri, 15 Oct 2021 09:43:06 +0200
Cc: alsa-devel@alsa-project.org, Brendan Grieve <brendan@grieve.com.au>
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

As per discussion at: https://github.com/szszoke/sennheiser-gsp670-pulseaudio-profile/issues/13

The GSP670 has 2 playback and 1 recording device that by default are
detected in an incompatible order for alsa. This may have been done to make
it compatible for the console by the manufacturer and only affects the
latest firmware which uses its own ID.

This quirk will resolve this by reordering the channels.

Signed-off-by: Brendan Grieve <brendan@grieve.com.au>
---
 sound/usb/quirks-table.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index de18fff69280..2af8c68fac27 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -4012,6 +4012,38 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/*
+	 * Sennheiser GSP670
+	 * Change order of interfaces loaded
+	 */
+	USB_DEVICE(0x1395, 0x0300),
+	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			// Communication
+			{
+				.ifnum = 3,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			// Recording
+			{
+				.ifnum = 4,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			// Main
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE
-- 
2.25.1

