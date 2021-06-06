Return-Path: <SRS0=TNia=LA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73800C47096
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Jun 2021 17:47:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F52613D4
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Jun 2021 17:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F52613D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BD1B1752;
	Sun,  6 Jun 2021 19:47:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BD1B1752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623001670;
	bh=RlB7uGiPREaHSyH5l+otpxIMNLfM9e0zrGEGRDoKVfw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YNZOmORI/v6HS6ZjukQ9vPmcgC76uQRwUuQbzJL4kDgHgHbeq7nDiSXZVgz1DGMcL
	 MBNvnxWGWA7XBdsaY1rPYfBpyULQGRfVRK6yppa4megbt1JpvPVGaEZ6Xr6EMmr+aL
	 tHV3y1Q3swLiQh/1YM9hCnp6UhVkdZJLqdlBjXmQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C43D3F80218;
	Sun,  6 Jun 2021 19:46:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD788F804AD; Sun,  6 Jun 2021 19:46:33 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B14FFF80218
 for <alsa-devel@alsa-project.org>; Sun,  6 Jun 2021 19:46:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B14FFF80218
Received: by m.b4.vu (Postfix, from userid 1000)
 id 3E0DC61956CD; Mon,  7 Jun 2021 03:16:24 +0930 (ACST)
Date: Mon, 7 Jun 2021 03:16:24 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/8] ALSA: usb-audio: scarlett2: Rename buttons/interrupts
Message-ID: <b90f501fc41e7cbaffb9470bdf499d043941222d.1622999147.git.g@b4.vu>
References: <cover.1622999147.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1622999147.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Vladimir Sadovnikov <sadko4u@gmail.com>
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

To match the vendor's terminology, change #defines, function names,
and comments:
- hardware buttons are now called dim/mute
- mixer status/interrupt is now notify
- vol is now monitor

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 36 ++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 3f1148bc0883..d240fa9a4b59 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -194,7 +194,7 @@ enum {
 	SCARLETT2_PORT_DIRNS   = 5,
 };
 
-/* Hardware buttons on the 18i20 */
+/* Dim/Mute buttons on the 18i20 */
 #define SCARLETT2_BUTTON_MAX 2
 
 static const char *const scarlett2_button_names[SCARLETT2_BUTTON_MAX] = {
@@ -218,7 +218,7 @@ struct scarlett2_ports {
 
 struct scarlett2_device_info {
 	u8 line_out_hw_vol; /* line out hw volume is sw controlled */
-	u8 button_count; /* number of buttons */
+	u8 button_count; /* number of dim/mute buttons */
 	u8 level_input_count; /* inputs with level selectable */
 	u8 pad_input_count; /* inputs with pad selectable */
 	const char * const line_out_descrs[SCARLETT2_ANALOGUE_MAX];
@@ -454,9 +454,9 @@ static int scarlett2_get_port_start_num(const struct scarlett2_ports *ports,
 #define SCARLETT2_USB_INTERRUPT_MAX_DATA 64
 #define SCARLETT2_USB_INTERRUPT_INTERVAL 3
 
-/* Interrupt flags for volume and mute/dim button changes */
-#define SCARLETT2_USB_INTERRUPT_VOL_CHANGE    0x00400000
-#define SCARLETT2_USB_INTERRUPT_BUTTON_CHANGE 0x00200000
+/* Interrupt flags for mute/dim button and monitor changes */
+#define SCARLETT2_USB_NOTIFY_DIM_MUTE 0x00200000
+#define SCARLETT2_USB_NOTIFY_MONITOR  0x00400000
 
 /* Commands for sending/receiving requests/responses */
 #define SCARLETT2_USB_VENDOR_SPECIFIC_CMD_REQ  2
@@ -1546,7 +1546,7 @@ static int scarlett2_add_line_out_ctls(struct usb_mixer_interface *mixer)
 		}
 	}
 
-	/* Add HW button controls */
+	/* Add dim/mute controls */
 	for (i = 0; i < private->info->button_count; i++) {
 		err = scarlett2_add_new_ctl(mixer, &scarlett2_button_ctl,
 					    i, 1, scarlett2_button_names[i],
@@ -1974,8 +1974,8 @@ static int scarlett2_read_configs(struct usb_mixer_interface *mixer)
 	return scarlett2_usb_get_mux(mixer);
 }
 
-/* Notify on volume change */
-static void scarlett2_mixer_interrupt_vol_change(
+/* Notify on monitor change */
+static void scarlett2_notify_monitor(
 	struct usb_mixer_interface *mixer)
 {
 	struct scarlett2_mixer_data *private = mixer->private_data;
@@ -1997,8 +1997,8 @@ static void scarlett2_mixer_interrupt_vol_change(
 	}
 }
 
-/* Notify on button change */
-static void scarlett2_mixer_interrupt_button_change(
+/* Notify on dim/mute change */
+static void scarlett2_notify_dim_mute(
 	struct usb_mixer_interface *mixer)
 {
 	struct scarlett2_mixer_data *private = mixer->private_data;
@@ -2012,7 +2012,7 @@ static void scarlett2_mixer_interrupt_button_change(
 }
 
 /* Interrupt callback */
-static void scarlett2_mixer_interrupt(struct urb *urb)
+static void scarlett2_notify(struct urb *urb)
 {
 	struct usb_mixer_interface *mixer = urb->context;
 	int len = urb->actual_length;
@@ -2023,10 +2023,10 @@ static void scarlett2_mixer_interrupt(struct urb *urb)
 		goto requeue;
 
 	data = le32_to_cpu(*(__le32 *)urb->transfer_buffer);
-	if (data & SCARLETT2_USB_INTERRUPT_VOL_CHANGE)
-		scarlett2_mixer_interrupt_vol_change(mixer);
-	if (data & SCARLETT2_USB_INTERRUPT_BUTTON_CHANGE)
-		scarlett2_mixer_interrupt_button_change(mixer);
+	if (data & SCARLETT2_USB_NOTIFY_MONITOR)
+		scarlett2_notify_monitor(mixer);
+	if (data & SCARLETT2_USB_NOTIFY_DIM_MUTE)
+		scarlett2_notify_dim_mute(mixer);
 
 requeue:
 	if (ustatus != -ENOENT &&
@@ -2037,7 +2037,7 @@ static void scarlett2_mixer_interrupt(struct urb *urb)
 	}
 }
 
-static int scarlett2_mixer_status_create(struct usb_mixer_interface *mixer)
+static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
 {
 	struct usb_device *dev = mixer->chip->dev;
 	unsigned int pipe = usb_rcvintpipe(dev,
@@ -2063,7 +2063,7 @@ static int scarlett2_mixer_status_create(struct usb_mixer_interface *mixer)
 
 	usb_fill_int_urb(mixer->urb, dev, pipe,
 			 transfer_buffer, SCARLETT2_USB_INTERRUPT_MAX_DATA,
-			 scarlett2_mixer_interrupt, mixer,
+			 scarlett2_notify, mixer,
 			 SCARLETT2_USB_INTERRUPT_INTERVAL);
 
 	return usb_submit_urb(mixer->urb, GFP_KERNEL);
@@ -2111,7 +2111,7 @@ static int snd_scarlett_gen2_controls_create(struct usb_mixer_interface *mixer,
 
 	/* Set up the interrupt polling if there are hardware buttons */
 	if (info->button_count) {
-		err = scarlett2_mixer_status_create(mixer);
+		err = scarlett2_init_notify(mixer);
 		if (err < 0)
 			return err;
 	}
-- 
2.31.1

