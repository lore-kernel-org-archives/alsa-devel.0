Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3B3C4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Dec 2021 08:39:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4C7F2528;
	Thu,  2 Dec 2021 09:38:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4C7F2528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638434375;
	bh=vtu9qPlQxm9G7clp6AEqeW0Hmr/2A4PKsYMTTrNKil4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KLUkug8/DiGgajkEYc2yJAjRFxKvMPnHz3Ia7Oz9vRf+vOFF+PnTCzSYmf7hxQVpY
	 Y8cyZVwA5KFET4AOW7hWFSRsHw/pdBhzmgMyElmMSofB1NN7Jg7LO80Q/xRPqCzUpS
	 bDZNmdm6Nv8UlZbhC2nPAwEfk/bLd5cw6QMuSIV0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76A1BF80290;
	Thu,  2 Dec 2021 09:38:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99DC1F802A0; Thu,  2 Dec 2021 09:38:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89990F800BE
 for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2021 09:38:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89990F800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="WMoD7mR/"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="pRVEgCoE"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6F5E9218A4
 for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2021 08:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638434314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5LLzmOgeFfpIqmG8KzFwj3YKtsnTYu13ADrB1GPuqvI=;
 b=WMoD7mR/AeNIIOxQCQr2qqaxGRwLgNzNggk4sJ//bKg06NZ3rwfYMWNB3HTNvdoIcDX1E4
 66+vxB3zlEQMLpr1Ka5Wvhg2VM/+CEcyDXS0UtjriS0iPr1dRiEgWlWxmlnbHFHFwB3UzM
 /oD1MWOrmfO61KRBOIWQ6U11U8AhS/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638434314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5LLzmOgeFfpIqmG8KzFwj3YKtsnTYu13ADrB1GPuqvI=;
 b=pRVEgCoEG7ae/bR/oLozY2LH3yP0GiTm6k2kCuDX/o/YWc6qRpYRyBacbhaMKYdgaeWvwz
 GSiAsgIm1TYgeLDg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 599A9A3D0B;
 Thu,  2 Dec 2021 08:38:34 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Drop superfluous '0' in Presonus Studio
 1810c's ID
Date: Thu,  2 Dec 2021 09:38:33 +0100
Message-Id: <20211202083833.17784-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The vendor ID of Presonus Studio 1810c had a superfluous '0' in its
USB ID.  Drop it.

Fixes: 8dc5efe3d17c ("ALSA: usb-audio: Add support for Presonus Studio 1810c")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/format.c       | 2 +-
 sound/usb/mixer_quirks.c | 2 +-
 sound/usb/quirks.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index f5e676a51b30..405dc0bf6678 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -375,7 +375,7 @@ static int parse_uac2_sample_rate_range(struct snd_usb_audio *chip,
 		for (rate = min; rate <= max; rate += res) {
 
 			/* Filter out invalid rates on Presonus Studio 1810c */
-			if (chip->usb_id == USB_ID(0x0194f, 0x010c) &&
+			if (chip->usb_id == USB_ID(0x194f, 0x010c) &&
 			    !s1810c_valid_sample_rate(fp, rate))
 				goto skip_rate;
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index d489c1de3bae..db194ad168d0 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3254,7 +3254,7 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_rme_controls_create(mixer);
 		break;
 
-	case USB_ID(0x0194f, 0x010c): /* Presonus Studio 1810c */
+	case USB_ID(0x194f, 0x010c): /* Presonus Studio 1810c */
 		err = snd_sc1810_init_mixer(mixer);
 		break;
 	case USB_ID(0x2a39, 0x3fb0): /* RME Babyface Pro FS */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 64e1c20311ed..ab9f3da49941 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1290,7 +1290,7 @@ int snd_usb_apply_interface_quirk(struct snd_usb_audio *chip,
 	if (chip->usb_id == USB_ID(0x0763, 0x2012))
 		return fasttrackpro_skip_setting_quirk(chip, iface, altno);
 	/* presonus studio 1810c: skip altsets incompatible with device_setup */
-	if (chip->usb_id == USB_ID(0x0194f, 0x010c))
+	if (chip->usb_id == USB_ID(0x194f, 0x010c))
 		return s1810c_skip_setting_quirk(chip, iface, altno);
 
 
-- 
2.31.1

