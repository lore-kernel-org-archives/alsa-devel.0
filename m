Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F908C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:56:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E07921734
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YG3x5gyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E07921734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F187F17DD;
	Fri,  3 Jan 2020 09:55:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F187F17DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578041803;
	bh=ooAZwD9T+BMxH4xkAI19HfCrkXuKYJyAtporuKYHEwo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YG3x5gybTkmPGInqJsRdHVwxHzRWxYQ2fkmmUbcUIeb/Z4bYWOBOGoJ7V6FsA5x3W
	 YLHSD5ZYPykIUFFy1rW1BKlizHEzSNnwssriDzgkxD2uu8ZKUAmnbZ50ZFKwDMzAFo
	 E2sr6lQBZkwGruaeZq0nTqjBPl+Pui1RNCBVsOdA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33D94F8057C;
	Fri,  3 Jan 2020 09:19:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DD36F803DF; Fri,  3 Jan 2020 09:19:01 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CA4EF802EB
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CA4EF802EB
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 23FE6B286
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:22 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:17:07 +0100
Message-Id: <20200103081714.9560-52-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 51/58] ALSA: usx2y: Constify struct
	snd_usb_audio_quirk entries
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The quirk entries used in us122l and usx2y drivers can be declared as
const as they are read-only.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/us122l.c     |  8 ++++----
 sound/usb/usx2y/usX2Yhwdep.c | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index e82c5236482d..f86f7a61fb36 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -40,13 +40,13 @@ static int snd_us122l_card_used[SNDRV_CARDS];
 
 static int us122l_create_usbmidi(struct snd_card *card)
 {
-	static struct snd_usb_midi_endpoint_info quirk_data = {
+	static const struct snd_usb_midi_endpoint_info quirk_data = {
 		.out_ep = 4,
 		.in_ep = 3,
 		.out_cables =	0x001,
 		.in_cables =	0x001
 	};
-	static struct snd_usb_audio_quirk quirk = {
+	static const struct snd_usb_audio_quirk quirk = {
 		.vendor_name =	"US122L",
 		.product_name =	NAME_ALLCAPS,
 		.ifnum = 	1,
@@ -62,13 +62,13 @@ static int us122l_create_usbmidi(struct snd_card *card)
 
 static int us144_create_usbmidi(struct snd_card *card)
 {
-	static struct snd_usb_midi_endpoint_info quirk_data = {
+	static const struct snd_usb_midi_endpoint_info quirk_data = {
 		.out_ep = 4,
 		.in_ep = 3,
 		.out_cables =	0x001,
 		.in_cables =	0x001
 	};
-	static struct snd_usb_audio_quirk quirk = {
+	static const struct snd_usb_audio_quirk quirk = {
 		.vendor_name =	"US144",
 		.product_name =	NAME_ALLCAPS,
 		.ifnum = 	0,
diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 9985fc139487..0e6d82b5778e 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -126,26 +126,26 @@ static int snd_usX2Y_hwdep_dsp_status(struct snd_hwdep *hw,
 
 static int usX2Y_create_usbmidi(struct snd_card *card)
 {
-	static struct snd_usb_midi_endpoint_info quirk_data_1 = {
+	static const struct snd_usb_midi_endpoint_info quirk_data_1 = {
 		.out_ep = 0x06,
 		.in_ep = 0x06,
 		.out_cables =	0x001,
 		.in_cables =	0x001
 	};
-	static struct snd_usb_audio_quirk quirk_1 = {
+	static const struct snd_usb_audio_quirk quirk_1 = {
 		.vendor_name =	"TASCAM",
 		.product_name =	NAME_ALLCAPS,
 		.ifnum = 	0,
        		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = &quirk_data_1
 	};
-	static struct snd_usb_midi_endpoint_info quirk_data_2 = {
+	static const struct snd_usb_midi_endpoint_info quirk_data_2 = {
 		.out_ep = 0x06,
 		.in_ep = 0x06,
 		.out_cables =	0x003,
 		.in_cables =	0x003
 	};
-	static struct snd_usb_audio_quirk quirk_2 = {
+	static const struct snd_usb_audio_quirk quirk_2 = {
 		.vendor_name =	"TASCAM",
 		.product_name =	"US428",
 		.ifnum = 	0,
@@ -154,7 +154,7 @@ static int usX2Y_create_usbmidi(struct snd_card *card)
 	};
 	struct usb_device *dev = usX2Y(card)->dev;
 	struct usb_interface *iface = usb_ifnum_to_if(dev, 0);
-	struct snd_usb_audio_quirk *quirk =
+	const struct snd_usb_audio_quirk *quirk =
 		le16_to_cpu(dev->descriptor.idProduct) == USB_ID_US428 ?
 		&quirk_2 : &quirk_1;
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
