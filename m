Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFD5C56202
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:11:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDD120756
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZkecK7mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDD120756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 997F1172F;
	Mon, 23 Nov 2020 10:10:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 997F1172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606122659;
	bh=b+M1+mpnYUdn4TzcRPK6iwU9rtb8Dp/Z08q046TBAT8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZkecK7mP84Wd/YQ+vvQ5nzupdRlePM8XgNu6qbd++9Wuut2mcnRQxmk0BRCIXDXgB
	 RkcExl3airURyX4/gdFJoqvqgLA9LrF/sm2VfrDBKfI1PU6BUJ1yFSduoBlthaZQTZ
	 ++8Ew2KWM/ZVLgyTf5ovjzfG9KUTBBxqdW7J92i8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F454F80622;
	Mon, 23 Nov 2020 09:55:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A7AFF80571; Mon, 23 Nov 2020 09:54:55 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E07D1F804FD
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:54:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E07D1F804FD
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 18BC7AE2E;
 Mon, 23 Nov 2020 08:53:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 41/41] ALSA: usb-audio: Fix MOTU M-Series quirks
Date: Mon, 23 Nov 2020 09:53:47 +0100
Message-Id: <20201123085347.19667-42-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201123085347.19667-1-tiwai@suse.de>
References: <20201123085347.19667-1-tiwai@suse.de>
Cc: Matwey Kornilov <matwey.kornilov@gmail.com>,
 Dylan Robinson <dylan_robinson@motu.com>,
 Keith Milner <kamilner@superlative.org>
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

From: Dylan Robinson <dylan_robinson@motu.com>

Now that the usb audio driver correctly finds implicit feedback endpoints,
the implicit feedback quirk for the MOTU M-Series is no longer required.

This also removes some unnecessary vendor specific messages from the MOTU
M-Series boot quirk. The removed vendor specific messages turned on vendor
specific interrupts to the host every 32 samples. The only thing the boot
quirk needs to do is wait for 2 seconds.

Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/implicit.c |  1 -
 sound/usb/quirks.c   | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 1f7fb036c5b6..386198b36b87 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -52,7 +52,6 @@ static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 	IMPLICIT_FB_FIXED_DEV(0x1397, 0x0001, 0x81, 1), /* Behringer UFX1604 */
 	IMPLICIT_FB_FIXED_DEV(0x1397, 0x0002, 0x81, 1), /* Behringer UFX1204 */
 	IMPLICIT_FB_FIXED_DEV(0x2466, 0x8010, 0x81, 2), /* Fractal Audio Axe-Fx III */
-	IMPLICIT_FB_FIXED_DEV(0x07fd, 0x0008, 0x81, 2), /* MOTU M Series */
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0001, 0x81, 2), /* Solid State Logic SSL2 */
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0002, 0x81, 2), /* Solid State Logic SSL2+ */
 	IMPLICIT_FB_FIXED_DEV(0x0499, 0x172f, 0x81, 2), /* Steinberg UR22C */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 02f3f6ed9390..63cdf3c8c2bc 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1110,24 +1110,8 @@ static int snd_usb_motu_microbookii_boot_quirk(struct usb_device *dev)
 
 static int snd_usb_motu_m_series_boot_quirk(struct usb_device *dev)
 {
-	int ret;
-
-	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-			      1, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      0x0, 0, NULL, 0, 1000);
-
-	if (ret < 0)
-		return ret;
-
 	msleep(2000);
 
-	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-			      1, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      0x20, 0, NULL, 0, 1000);
-
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
-- 
2.16.4

