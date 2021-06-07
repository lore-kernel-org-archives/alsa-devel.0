Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0378CC47094
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 19:15:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F80610E7
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 19:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F80610E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 871251687;
	Mon,  7 Jun 2021 21:14:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 871251687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623093313;
	bh=3HZ0nLslh1OwUhLgjjqklhD99blvjVlQ0P/nPY0yVmU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vn0UOwqsnSaEn7W0adMO8Y6A+VWqN7NR9N/ZsieKErOOO0txhuaPEZbLuzSp6mEka
	 Pu9yH/mos+ls6bvqIZ+yEqkGlrOiU0OmG/2ZqxdZVKk9dH8tgwKsIPzhnKP+AQ1IP6
	 suTDcvnaZNzix6qL/ZE4VFZ/7lRW/7nt3CV8CM6M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33B3EF8026C;
	Mon,  7 Jun 2021 21:13:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73C4BF8020D; Mon,  7 Jun 2021 21:13:35 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F8DBF8020D
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 21:13:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F8DBF8020D
Received: by m.b4.vu (Postfix, from userid 1000)
 id 2551361956CD; Tue,  8 Jun 2021 04:43:25 +0930 (ACST)
Date: Tue, 8 Jun 2021 04:43:25 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH V2 1/2] ALSA: usb-audio: scarlett2: Read mixer volumes at
 init time
Message-ID: <bb33fa9b79efc6f7a0f0e6fb7018cc8d4d59b3ba.1623091570.git.g@b4.vu>
References: <cover.1623091570.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623091570.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Daniel Sales <daniel.sales.z@gmail.com>,
 Markus Schroetter <project.m.schroetter@gmail.com>,
 Vladimir Sadovnikov <sadko4u@gmail.com>, Alex Fellows <alex.fellows@gmail.com>
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

Add support for reading the mixer volumes from the hardware when the
driver is initialising. Previously these ALSA volume controls were
initialised to zero instead of being initialised to match the hardware
state.

Fixes: 9e4d5c1be21f ("ALSA: usb-audio: Scarlett Gen 2 mixer interface")
Suggested-by: Vladimir Sadovnikov <sadko4u@gmail.com>
Tested-by: Markus Schroetter <project.m.schroetter@gmail.com>
Tested-by: Alex Fellows <alex.fellows@gmail.com>
Tested-by: Daniel Sales <daniel.sales.z@gmail.com>
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 57 +++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 4caf379d5b99..5969d6bda58d 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -117,11 +117,12 @@
 #define SCARLETT2_MIXER_MAX_DB 6
 #define SCARLETT2_MIXER_MAX_VALUE \
 	((SCARLETT2_MIXER_MAX_DB - SCARLETT2_MIXER_MIN_DB) * 2)
+#define SCARLETT2_MIXER_VALUE_COUNT (SCARLETT2_MIXER_MAX_VALUE + 1)
 
 /* map from (dB + 80) * 2 to mixer value
  * for dB in 0 .. 172: int(8192 * pow(10, ((dB - 160) / 2 / 20)))
  */
-static const u16 scarlett2_mixer_values[173] = {
+static const u16 scarlett2_mixer_values[SCARLETT2_MIXER_VALUE_COUNT] = {
 	0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
 	2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 8, 8,
 	9, 9, 10, 10, 11, 12, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
@@ -465,6 +466,7 @@ static int scarlett2_get_port_start_num(const struct scarlett2_ports *ports,
 
 #define SCARLETT2_USB_INIT_SEQ 0x00000000
 #define SCARLETT2_USB_GET_METER_LEVELS 0x00001001
+#define SCARLETT2_USB_GET_MIX 0x00002001
 #define SCARLETT2_USB_SET_MIX 0x00002002
 #define SCARLETT2_USB_SET_MUX 0x00003002
 #define SCARLETT2_USB_GET_DATA 0x00800000
@@ -784,6 +786,49 @@ static int scarlett2_usb_get_volume_status(
 				 buf, sizeof(*buf));
 }
 
+/* Send a USB message to get the volumes for all inputs of one mix
+ * and put the values into private->mix[]
+ */
+static int scarlett2_usb_get_mix(struct usb_mixer_interface *mixer,
+				 int mix_num)
+{
+	struct scarlett2_mixer_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+
+	int num_mixer_in =
+		info->ports[SCARLETT2_PORT_TYPE_MIX].num[SCARLETT2_PORT_OUT];
+	int err, i, j, k;
+
+	struct {
+		__le16 mix_num;
+		__le16 count;
+	} __packed req;
+
+	__le16 data[SCARLETT2_INPUT_MIX_MAX];
+
+	req.mix_num = cpu_to_le16(mix_num);
+	req.count = cpu_to_le16(num_mixer_in);
+
+	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_MIX,
+			    &req, sizeof(req),
+			    data, num_mixer_in * sizeof(u16));
+	if (err < 0)
+		return err;
+
+	for (i = 0, j = mix_num * num_mixer_in; i < num_mixer_in; i++, j++) {
+		u16 mixer_value = le16_to_cpu(data[i]);
+
+		for (k = 0; k < SCARLETT2_MIXER_VALUE_COUNT; k++)
+			if (scarlett2_mixer_values[k] >= mixer_value)
+				break;
+		if (k == SCARLETT2_MIXER_VALUE_COUNT)
+			k = SCARLETT2_MIXER_MAX_VALUE;
+		private->mix[j] = k;
+	}
+
+	return 0;
+}
+
 /* Send a USB message to set the volumes for all inputs of one mix
  * (values obtained from private->mix[])
  */
@@ -1831,7 +1876,7 @@ static int scarlett2_init_private(struct usb_mixer_interface *mixer,
 	return scarlett2_usb(mixer, SCARLETT2_USB_INIT_SEQ, NULL, 0, NULL, 0);
 }
 
-/* Read line-in config and line-out volume settings on start */
+/* Read configuration from the interface on start */
 static int scarlett2_read_configs(struct usb_mixer_interface *mixer)
 {
 	struct scarlett2_mixer_data *private = mixer->private_data;
@@ -1839,6 +1884,8 @@ static int scarlett2_read_configs(struct usb_mixer_interface *mixer)
 	const struct scarlett2_ports *ports = info->ports;
 	int num_line_out =
 		ports[SCARLETT2_PORT_TYPE_ANALOGUE].num[SCARLETT2_PORT_OUT];
+	int num_mixer_out =
+		ports[SCARLETT2_PORT_TYPE_MIX].num[SCARLETT2_PORT_IN];
 	u8 level_switches[SCARLETT2_LEVEL_SWITCH_MAX];
 	u8 pad_switches[SCARLETT2_PAD_SWITCH_MAX];
 	struct scarlett2_usb_volume_status volume_status;
@@ -1894,6 +1941,12 @@ static int scarlett2_read_configs(struct usb_mixer_interface *mixer)
 	for (i = 0; i < info->button_count; i++)
 		private->buttons[i] = !!volume_status.buttons[i];
 
+	for (i = 0; i < num_mixer_out; i++) {
+		err = scarlett2_usb_get_mix(mixer, i);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
2.31.1

