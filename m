Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE25C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:16:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2673F204EF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Nm4T0H28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2673F204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80C9A1664;
	Mon,  8 Jun 2020 09:15:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80C9A1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591600590;
	bh=V9k4mktH26u9Mcugij3k0lRj1pnh7CMwEFhzn49Vw6w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Nm4T0H28nvXyGIVxd1W6wLEk+7WyUzcHTKgOPN/v1Emsm5wNJ30sCIsBmsD3YIEvO
	 axhQC8Su+EnWEkQ6MBMQb7oXCeWwp/QLQCMl+Cq8siQjRTM50ET8oudk7E3GtGTV5Z
	 x2RKOfQHJrzC5B2eszebWM6BvCaGw6QDmzU9mQy0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A4B5F8024A;
	Mon,  8 Jun 2020 09:15:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82EE2F80252; Mon,  8 Jun 2020 09:15:20 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7F55F8021E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 09:15:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7F55F8021E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 07BA0B143;
 Mon,  8 Jun 2020 07:15:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Use the new macro for HP Dock rename quirks
Date: Mon,  8 Jun 2020 09:15:13 +0200
Message-Id: <20200608071513.570-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
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

Replace the open-code with the new QUIRK_DEVICE_PROFILE() macro for
simplicity.

Fixes: 0c5086f56999 ("ALSA: usb-audio: Add vendor, product and profile name for HP Thunderbolt Dock")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 90d65bfa733d..4ec491011b19 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -43,22 +43,14 @@
 /* HP Thunderbolt Dock Audio Headset */
 {
 	USB_DEVICE(0x03f0, 0x0269),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "HP",
-		.product_name = "Thunderbolt Dock Audio Headset",
-		.profile_name = "HP-Thunderbolt-Dock-Audio-Headset",
-		.ifnum = QUIRK_NO_INTERFACE
-	}
+	QUIRK_DEVICE_PROFILE("HP", "Thunderbolt Dock Audio Headset",
+			     "HP-Thunderbolt-Dock-Audio-Headset"),
 },
 /* HP Thunderbolt Dock Audio Module */
 {
 	USB_DEVICE(0x03f0, 0x0567),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "HP",
-		.product_name = "Thunderbolt Dock Audio Module",
-		.profile_name = "HP-Thunderbolt-Dock-Audio-Module",
-		.ifnum = QUIRK_NO_INTERFACE
-	}
+	QUIRK_DEVICE_PROFILE("HP", "Thunderbolt Dock Audio Module",
+			     "HP-Thunderbolt-Dock-Audio-Module"),
 },
 /* FTDI devices */
 {
-- 
2.16.4

