Return-Path: <SRS0=n4Uk=5Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345B5C2D0EA
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:06:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8242051A
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l5BCc5x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8242051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BBD11607;
	Wed,  8 Apr 2020 16:05:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BBD11607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586354806;
	bh=V6TalK+x3dnCUDkO4ZMUYqsx9glw820yKGmoWyPQNrI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l5BCc5x+KvupPbnvVp0Uh370bCVxAjxM9frEPVlTpXp7txSDejvzlRH5VARpKExBF
	 MFwRjfRo4R9j2//Z0LjlahnImAU4GhyXhHpkqezJx+Q02BMkeB7375oLKwNRkwMqxT
	 ekE2UPKhTUoJJYCiasjBKmxFs5ncNgfoyKVhyYU4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39A7BF80105;
	Wed,  8 Apr 2020 16:05:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C67CAF80143; Wed,  8 Apr 2020 16:05:01 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51704F8011B
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2020 16:04:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51704F8011B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E14EBAD72
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2020 14:04:53 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: usb-audio: Add mixer workaround for TRX40 and co
Date: Wed,  8 Apr 2020 16:04:48 +0200
Message-Id: <20200408140449.22319-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

Some recent boards (supposedly with a new AMD platform) contain the
USB audio class 2 device that is often tied with HD-audio.  The device
exposes an Input Gain Pad control (id=19, control=12) but this node
doesn't behave correctly, returning an error for each inquiry of
GET_MIN and GET_MAX that should have been mandatory.

As a workaround, simply ignore this node by adding a usbmix_name_map
table entry.  The currently known devices are:
* 0414:a002 - Gigabyte TRX40 Aorus Pro WiFi
* 0b05:1916 - ASUS ROG Zenith II
* 0b05:1917 - ASUS ROG Strix
* 0db0:0d64 - MSI TRX40 Creator
* 0db0:543d - MSI TRX40

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206543
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_maps.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 5ebca8013840..72b575c34860 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -359,6 +359,14 @@ static const struct usbmix_name_map corsair_virtuoso_map[] = {
 	{ 0 }
 };
 
+/* Some mobos shipped with a dummy HD-audio show the invalid GET_MIN/GET_MAX
+ * response for Input Gain Pad (id=19, control=12).  Skip it.
+ */
+static const struct usbmix_name_map asus_rog_map[] = {
+	{ 19, NULL, 12 }, /* FU, Input Gain Pad */
+	{}
+};
+
 /*
  * Control map entries
  */
@@ -488,6 +496,26 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x1b1c, 0x0a42),
 		.map = corsair_virtuoso_map,
 	},
+	{	/* Gigabyte TRX40 Aorus Pro WiFi */
+		.id = USB_ID(0x0414, 0xa002),
+		.map = asus_rog_map,
+	},
+	{	/* ASUS ROG Zenith II */
+		.id = USB_ID(0x0b05, 0x1916),
+		.map = asus_rog_map,
+	},
+	{	/* ASUS ROG Strix */
+		.id = USB_ID(0x0b05, 0x1917),
+		.map = asus_rog_map,
+	},
+	{	/* MSI TRX40 Creator */
+		.id = USB_ID(0x0db0, 0x0d64),
+		.map = asus_rog_map,
+	},
+	{	/* MSI TRX40 */
+		.id = USB_ID(0x0db0, 0x543d),
+		.map = asus_rog_map,
+	},
 	{ 0 } /* terminator */
 };
 
-- 
2.25.0

