Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E383AC4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:13:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7F8611BD
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7F8611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12BB716B4;
	Mon, 21 Jun 2021 20:12:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12BB716B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299212;
	bh=Tf5+DpK3oZ1NE6PDaXsq41h8dJR4xen/+ZWIgzdsPT0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FxATUaJZpKQxRKWsnEa6kcDd12eXfurTusuy8vHcIRtKVijUFD+VMuud0u/XhA0zZ
	 JJWRH02a8buX/yDeEixDTEalGmiD3F72I3wY+a9cd1NxTXdMFpYfeix6SIeC1uowgk
	 j2C7dqxDWPfpTOl2DbhPTSYn01uRZi/tIZFTno7o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E59C8F80518;
	Mon, 21 Jun 2021 20:09:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12FF3F8050F; Mon, 21 Jun 2021 20:09:37 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D88DF804F2
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:09:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D88DF804F2
Received: by m.b4.vu (Postfix, from userid 1000)
 id 9000F61E5F01; Tue, 22 Jun 2021 03:39:31 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:39:31 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/31] ALSA: usb-audio: scarlett2: Improve device info lookup
Message-ID: <474c408c29fb280a611e47e49e59ca2fb9810d27.1624294591.git.g@b4.vu>
References: <cover.1624294591.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624294591.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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

Add the USB device ID to the scarlett2_device_info struct so that the
switch statement which finds the appropriate struct can be replaced
with a loop that looks through an array of pointers to those structs.

Suggested-by: Vladimir Sadovnikov <sadko4u@gmail.com>
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 37 ++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 4a36181e61ab..481ebdd1a0df 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -217,6 +217,7 @@ struct scarlett2_ports {
 };
 
 struct scarlett2_device_info {
+	u32 usb_id; /* USB device identifier */
 	u8 line_out_hw_vol; /* line out hw volume is sw controlled */
 	u8 level_input_count; /* inputs with level selectable */
 	u8 pad_input_count; /* inputs with pad selectable */
@@ -257,6 +258,8 @@ struct scarlett2_data {
 /*** Model-specific data ***/
 
 static const struct scarlett2_device_info s6i6_gen2_info = {
+	.usb_id = USB_ID(0x1235, 0x8203),
+
 	/* The first two analogue inputs can be switched between line
 	 * and instrument levels.
 	 */
@@ -310,6 +313,8 @@ static const struct scarlett2_device_info s6i6_gen2_info = {
 };
 
 static const struct scarlett2_device_info s18i8_gen2_info = {
+	.usb_id = USB_ID(0x1235, 0x8204),
+
 	/* The first two analogue inputs can be switched between line
 	 * and instrument levels.
 	 */
@@ -371,6 +376,8 @@ static const struct scarlett2_device_info s18i8_gen2_info = {
 };
 
 static const struct scarlett2_device_info s18i20_gen2_info = {
+	.usb_id = USB_ID(0x1235, 0x8201),
+
 	/* The analogue line outputs on the 18i20 can be switched
 	 * between software and hardware volume control
 	 */
@@ -437,6 +444,16 @@ static const struct scarlett2_device_info s18i20_gen2_info = {
 	},
 };
 
+static const struct scarlett2_device_info *scarlett2_devices[] = {
+	/* Supported Gen 2 devices */
+	&s6i6_gen2_info,
+	&s18i8_gen2_info,
+	&s18i20_gen2_info,
+
+	/* End of list */
+	NULL
+};
+
 /* get the starting port index number for a given port type/direction */
 static int scarlett2_get_port_start_num(const struct scarlett2_ports *ports,
 					int direction, int port_type)
@@ -2293,26 +2310,18 @@ static int snd_scarlett_gen2_controls_create(struct usb_mixer_interface *mixer,
 int snd_scarlett_gen2_init(struct usb_mixer_interface *mixer)
 {
 	struct snd_usb_audio *chip = mixer->chip;
-	const struct scarlett2_device_info *info;
+	const struct scarlett2_device_info **info = scarlett2_devices;
 	int err;
 
 	/* only use UAC_VERSION_2 */
 	if (!mixer->protocol)
 		return 0;
 
-	switch (chip->usb_id) {
-	case USB_ID(0x1235, 0x8203):
-		info = &s6i6_gen2_info;
-		break;
-	case USB_ID(0x1235, 0x8204):
-		info = &s18i8_gen2_info;
-		break;
-	case USB_ID(0x1235, 0x8201):
-		info = &s18i20_gen2_info;
-		break;
-	default: /* device not (yet) supported */
+	/* find device in scarlett2_devices */
+	while (*info && (*info)->usb_id != chip->usb_id)
+		info++;
+	if (!*info)
 		return -EINVAL;
-	}
 
 	if (!(chip->setup & SCARLETT2_ENABLE)) {
 		usb_audio_info(chip,
@@ -2329,7 +2338,7 @@ int snd_scarlett_gen2_init(struct usb_mixer_interface *mixer)
 		"Focusrite Scarlett Gen 2 Mixer Driver enabled pid=0x%04x",
 		USB_ID_PRODUCT(chip->usb_id));
 
-	err = snd_scarlett_gen2_controls_create(mixer, info);
+	err = snd_scarlett_gen2_controls_create(mixer, *info);
 	if (err < 0)
 		usb_audio_err(mixer->chip,
 			      "Error initialising Scarlett Mixer Driver: %d",
-- 
2.31.1

