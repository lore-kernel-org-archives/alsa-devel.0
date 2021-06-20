Return-Path: <SRS0=Bo48=LO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C04C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:48:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B0061057
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B0061057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FCFE16D9;
	Sun, 20 Jun 2021 18:47:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FCFE16D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624207707;
	bh=+HryLOxYbGPShMdlxWYVSN74g0JBIQsyAYRgYvrNGAs=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CSll/C665NIt830mR3O48aNpqkCqEd3hQ7uWjf/KaAvPReqOpfultyjDbqsGlx8gM
	 2HZQdtd8OX+x+FUaQeMBxuEe3B+8XvCl7pb0T7sQHx0T40Q04aPWdjB3l+luIKVyDk
	 E8ZUSaRfxYrdzmcHvvvbs8S/SjIlqgVrYAQVp2Hc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B383F804E0;
	Sun, 20 Jun 2021 18:46:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6F4DF804DA; Sun, 20 Jun 2021 18:46:37 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04C0DF8026A
 for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2021 18:46:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04C0DF8026A
Received: by m.b4.vu (Postfix, from userid 1000)
 id 8801861E286F; Mon, 21 Jun 2021 02:16:28 +0930 (ACST)
Date: Mon, 21 Jun 2021 02:16:28 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/14] ALSA: usb-audio: scarlett2: Coding style improvements
Message-ID: <20210620164628.GA9172@m.b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Improve alignment and readability with:
- Whitespace fixes
- Add leading zeros to 32-bit flag values
- Rename SCARLETT2_USB_GET_METER_LEVELS to SCARLETT2_USB_GET_METER
- Rename SCARLETT2_PORT_DIRECTIONS to SCARLETT2_PORT_DIRNS

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 53 +++++++++++++++++----------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index e327f15b89ce..8026847d27b6 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -175,23 +175,23 @@ static const u16 scarlett2_mixer_values[SCARLETT2_MIXER_VALUE_COUNT] = {
  * - PCM I/O
  */
 enum {
-	SCARLETT2_PORT_TYPE_NONE = 0,
+	SCARLETT2_PORT_TYPE_NONE     = 0,
 	SCARLETT2_PORT_TYPE_ANALOGUE = 1,
-	SCARLETT2_PORT_TYPE_SPDIF = 2,
-	SCARLETT2_PORT_TYPE_ADAT = 3,
-	SCARLETT2_PORT_TYPE_MIX = 4,
-	SCARLETT2_PORT_TYPE_PCM = 5,
-	SCARLETT2_PORT_TYPE_COUNT = 6,
+	SCARLETT2_PORT_TYPE_SPDIF    = 2,
+	SCARLETT2_PORT_TYPE_ADAT     = 3,
+	SCARLETT2_PORT_TYPE_MIX      = 4,
+	SCARLETT2_PORT_TYPE_PCM      = 5,
+	SCARLETT2_PORT_TYPE_COUNT    = 6,
 };
 
 /* Count of total I/O and number available at each sample rate */
 enum {
-	SCARLETT2_PORT_IN = 0,
-	SCARLETT2_PORT_OUT = 1,
-	SCARLETT2_PORT_OUT_44 = 2,
-	SCARLETT2_PORT_OUT_88 = 3,
+	SCARLETT2_PORT_IN      = 0,
+	SCARLETT2_PORT_OUT     = 1,
+	SCARLETT2_PORT_OUT_44  = 2,
+	SCARLETT2_PORT_OUT_88  = 3,
 	SCARLETT2_PORT_OUT_176 = 4,
-	SCARLETT2_PORT_DIRECTIONS = 5,
+	SCARLETT2_PORT_DIRNS   = 5,
 };
 
 /* Hardware buttons on the 18i20 */
@@ -210,7 +210,7 @@ static const char *const scarlett2_button_names[SCARLETT2_BUTTON_MAX] = {
  */
 struct scarlett2_ports {
 	u16 id;
-	int num[SCARLETT2_PORT_DIRECTIONS];
+	int num[SCARLETT2_PORT_DIRNS];
 	const char * const src_descr;
 	int src_num_offset;
 	const char * const dst_descr;
@@ -458,22 +458,23 @@ static int scarlett2_get_port_start_num(const struct scarlett2_ports *ports,
 #define SCARLETT2_USB_INTERRUPT_INTERVAL 3
 
 /* Interrupt flags for volume and mute/dim button changes */
-#define SCARLETT2_USB_INTERRUPT_VOL_CHANGE 0x400000
-#define SCARLETT2_USB_INTERRUPT_BUTTON_CHANGE 0x200000
+#define SCARLETT2_USB_INTERRUPT_VOL_CHANGE    0x00400000
+#define SCARLETT2_USB_INTERRUPT_BUTTON_CHANGE 0x00200000
 
 /* Commands for sending/receiving requests/responses */
-#define SCARLETT2_USB_VENDOR_SPECIFIC_CMD_REQ 2
+#define SCARLETT2_USB_VENDOR_SPECIFIC_CMD_REQ  2
 #define SCARLETT2_USB_VENDOR_SPECIFIC_CMD_RESP 3
 
-#define SCARLETT2_USB_INIT_SEQ 0x00000000
-#define SCARLETT2_USB_GET_METER_LEVELS 0x00001001
-#define SCARLETT2_USB_GET_MIX 0x00002001
-#define SCARLETT2_USB_SET_MIX 0x00002002
-#define SCARLETT2_USB_GET_MUX 0x00003001
-#define SCARLETT2_USB_SET_MUX 0x00003002
-#define SCARLETT2_USB_GET_DATA 0x00800000
-#define SCARLETT2_USB_SET_DATA 0x00800001
-#define SCARLETT2_USB_DATA_CMD 0x00800002
+#define SCARLETT2_USB_INIT_SEQ  0x00000000
+#define SCARLETT2_USB_GET_METER 0x00001001
+#define SCARLETT2_USB_GET_MIX   0x00002001
+#define SCARLETT2_USB_SET_MIX   0x00002002
+#define SCARLETT2_USB_GET_MUX   0x00003001
+#define SCARLETT2_USB_SET_MUX   0x00003002
+#define SCARLETT2_USB_GET_DATA  0x00800000
+#define SCARLETT2_USB_SET_DATA  0x00800001
+#define SCARLETT2_USB_DATA_CMD  0x00800002
+
 #define SCARLETT2_USB_CONFIG_SAVE 6
 
 #define SCARLETT2_USB_VOLUME_STATUS_OFFSET 0x31
@@ -835,7 +836,7 @@ static int scarlett2_usb_get_mix(struct usb_mixer_interface *mixer,
  * (values obtained from private->mix[])
  */
 static int scarlett2_usb_set_mix(struct usb_mixer_interface *mixer,
-				     int mix_num)
+				 int mix_num)
 {
 	struct scarlett2_mixer_data *private = mixer->private_data;
 	const struct scarlett2_device_info *info = private->info;
@@ -1056,7 +1057,7 @@ static int scarlett2_usb_get_meter_levels(struct usb_mixer_interface *mixer,
 	req.pad = 0;
 	req.num_meters = cpu_to_le16(SCARLETT2_NUM_METERS);
 	req.magic = cpu_to_le32(SCARLETT2_USB_METER_LEVELS_GET_MAGIC);
-	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_METER_LEVELS,
+	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_METER,
 			    &req, sizeof(req), resp, sizeof(resp));
 	if (err < 0)
 		return err;
-- 
2.31.1

