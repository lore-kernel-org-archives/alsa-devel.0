Return-Path: <SRS0=eDLw=CB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D26C433E1
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2020 11:33:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C6A20774
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2020 11:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Pr2+b9pS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C6A20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFA2382E;
	Sun, 23 Aug 2020 13:32:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFA2382E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598182429;
	bh=N8Clq+yRxeXQ65VsJ6a7uxdPH+vqMr6mNHwpl+lJJdY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pr2+b9pSlsZoRTngxxAcIFQmW1uoZkFe9GdW1xRw9OgP1pEMhWw2Zx6YKsVdLg5IL
	 ho7/6QJ60yXJ1+nhfeQGrtNPb9+Z2Q9KALfjFnkoNYwZ+1CVtue7qe7urujnXgH2n2
	 EmEdkutZfW6GMgdVdZ+WooFZyMYdxV6bLguVwQmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D50EF80245;
	Sun, 23 Aug 2020 13:32:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33EC5F8025A; Sun, 23 Aug 2020 13:32:58 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B6D2F800EB
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2020 13:32:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B6D2F800EB
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 505BAAD46;
 Sun, 23 Aug 2020 11:33:21 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Correct wrongly matching entries with audio
 class
Date: Sun, 23 Aug 2020 13:32:51 +0200
Message-Id: <20200823113251.10175-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Alexander Tsoy <alexander@tsoy.me>
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

The commit 51ab5d77dcb8 ("ALSA: usb-audio: Properly match with audio
interface class") converted the quirk entries that have both vid/pid
pair and bInterface fields to match with all those with a new macro
USB_AUDIO_CLASS().  However, it turned out that those are false
conversions; all those (but the unknown KeithMcMillen device) are
actually with vendor-specific interface class, hence the conversions
broke the matching.

This patch corrects those entries to the right one,
USB_DEVICE_VENDOR_SPEC() (and USB_DEVICE() for KeithMcMillen to be
sure), and drop the unused USB_AUDIO_CLASS macro again.

Fixes: 51ab5d77dcb8 ("ALSA: usb-audio: Properly match with audio interface class")
Reported-by: Alexander Tsoy <alexander@tsoy.me>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 969c79d0c688..7fe9d3e75d59 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -35,14 +35,6 @@
 	.bInterfaceClass = USB_CLASS_AUDIO, \
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 
-/* Another standard entry matching with vid/pid and the audio class */
-#define USB_AUDIO_CLASS(vend, prod) \
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | \
-		       USB_DEVICE_ID_MATCH_INT_CLASS, \
-	.idVendor = vend, \
-	.idProduct = prod, \
-	.bInterfaceClass = USB_CLASS_AUDIO
-
 /* FTDI devices */
 {
 	USB_DEVICE(0x0403, 0xb8d8),
@@ -77,13 +69,13 @@
 },
 
 /* E-Mu 0202 USB */
-{ USB_AUDIO_CLASS(0x041e, 0x3f02) },
+{ USB_DEVICE_VENDOR_SPEC(0x041e, 0x3f02) },
 /* E-Mu 0404 USB */
-{ USB_AUDIO_CLASS(0x041e, 0x3f04) },
+{ USB_DEVICE_VENDOR_SPEC(0x041e, 0x3f04) },
 /* E-Mu Tracker Pre */
-{ USB_AUDIO_CLASS(0x041e, 0x3f0a) },
+{ USB_DEVICE_VENDOR_SPEC(0x041e, 0x3f0a) },
 /* E-Mu 0204 USB */
-{ USB_AUDIO_CLASS(0x041e, 0x3f19) },
+{ USB_DEVICE_VENDOR_SPEC(0x041e, 0x3f19) },
 
 /*
  * HP Wireless Audio
@@ -2756,7 +2748,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 
 /* KeithMcMillen Stringport */
-{ USB_AUDIO_CLASS(0x1f38, 0x0001) },
+{ USB_DEVICE(0x1f38, 0x0001) }, /* FIXME: should be more restrictive matching */
 
 /* Miditech devices */
 {
@@ -2979,7 +2971,7 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 },
 {
 	/* Tascam US122 MKII - playback-only support */
-	USB_AUDIO_CLASS(0x0644, 0x8021),
+	USB_DEVICE_VENDOR_SPEC(0x0644, 0x8021),
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "TASCAM",
 		.product_name = "US122 MKII",
@@ -3611,4 +3603,3 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE
-#undef USB_AUDIO_CLASS
-- 
2.16.4

