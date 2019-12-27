Return-Path: <SRS0=/8xD=2R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047EC2D0C6
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 09:43:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2DD20CC7
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 09:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IAznJlkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2DD20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=boyle.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1B151714;
	Fri, 27 Dec 2019 10:42:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1B151714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577439808;
	bh=arw+3s7Lonw0BMbsZswn7Z71ouPboM6dTU9FUeZreu8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IAznJlkj5IwvyXQjFhoy/owIvPcdv/mpd5YAQsINwUAtKca8SIu0b3nTK0AgygZUo
	 LaQJm7rZi0d/B8bGad9aQRlJkUNqzkr8TrY7XgPw7XlObCdIcTpaSGJUhoE7/TNMJ8
	 lbU5Yb9YZzvVzv4ZBYo0KGLhcEGlUQ63JfYifYJ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C6CBF80131;
	Fri, 27 Dec 2019 10:42:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8098F80132; Fri, 27 Dec 2019 10:42:35 +0100 (CET)
Received: from chris.boyle.name (ipv6.chris.boyle.name
 [IPv6:2001:4b98:dc0:41:216:3eff:fe18:4418])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B874EF800CD
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2019 10:42:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B874EF800CD
Received: by chris.boyle.name (Postfix, from userid 1000)
 id A9B553DE5E; Fri, 27 Dec 2019 10:40:53 +0100 (CET)
Date: Fri, 27 Dec 2019 10:40:53 +0100
From: Chris Boyle <chris@boyle.name>
To: alsa-devel@alsa-project.org
Message-ID: <20191227094053.GA12167@nova.chris.boyle.name>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: [alsa-devel] [PATCH] ALSA: usb-audio: fix Corsair Virtuoso mixer
	label collision
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The Corsair Virtuoso RGB Wireless is a USB headset with a mic and a
sidetone feature. Label its mixer appropriately instead of all
"Headset", so that applications such as Pulseaudio don't just move
the sidetone control when they intend the main Headset control.

Signed-off-by: Chris Boyle <chris@boyle.name>
---
 sound/usb/mixer_maps.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 73baf398c84a..d094934ae6c5 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -349,6 +349,16 @@ static const struct usbmix_name_map dell_alc4020_map[] = {
 	{ 0 }
 };
 
+/*
+ * Corsair Virtuoso calls everything "Headset" without this, leading to
+ * applications moving the sidetone control instead of the main one.
+ */
+static const struct usbmix_name_map corsair_virtuoso_map[] = {
+	{ 3, "Mic Capture" },
+	{ 6, "Sidetone Playback" },
+	{ 0 }
+};
+
 /*
  * Control map entries
  */
@@ -468,6 +478,16 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x05a7, 0x1020),
 		.map = bose_companion5_map,
 	},
+	{
+		/* Corsair Virtuoso (wired mode) */
+		.id = USB_ID(0x1b1c, 0x0a41),
+		.map = corsair_virtuoso_map,
+	},
+	{
+		/* Corsair Virtuoso (wireless mode) */
+		.id = USB_ID(0x1b1c, 0x0a42),
+		.map = corsair_virtuoso_map,
+	},
 	{ 0 } /* terminator */
 };
 
-- 
2.20.1


-- 
Chris Boyle
https://chris.boyle.name/
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
