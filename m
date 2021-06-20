Return-Path: <SRS0=Bo48=LO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C3C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:49:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F31D6101D
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F31D6101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 244A516DE;
	Sun, 20 Jun 2021 18:48:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 244A516DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624207748;
	bh=sCOh6nO9WNBeQoEFBYnJxbl3Aqd7tslgYmsr9AxMLFQ=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=laN3bPXf5vHEcz+WT4jdn8RDG+6I4bODYIzAirXMyZbT9vHtNZP6drqPqC84FebRn
	 r+9TuHnziGDEY/GHdEpvYXZ1HNSGvn3J0FLFu9cC0VUDtCkpwtwZBe7Ti3qisjz8Pn
	 XAvYmovVKz6r5emNh5H90QGHgTMrP+iQx7iBekE4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56837F804E6;
	Sun, 20 Jun 2021 18:46:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B0D1F804D8; Sun, 20 Jun 2021 18:46:40 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C49FF8016D
 for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2021 18:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C49FF8016D
Received: by m.b4.vu (Postfix, from userid 1000)
 id 891CD61E287A; Mon, 21 Jun 2021 02:16:30 +0930 (ACST)
Date: Mon, 21 Jun 2021 02:16:30 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/14] ALSA: usb-audio: scarlett2: Remove unused/useless code
Message-ID: <20210620164630.GA9180@m.b4.vu>
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

Remove #define not used.
Remove useless assignments and copies.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 8026847d27b6..a5f5c537e344 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -271,7 +271,6 @@ static const struct scarlett2_device_info s6i6_gen2_info = {
 			.id = 0x000,
 			.num = { 1, 0, 8, 8, 8 },
 			.src_descr = "Off",
-			.src_num_offset = 0,
 		},
 		[SCARLETT2_PORT_TYPE_ANALOGUE] = {
 			.id = 0x080,
@@ -327,7 +326,6 @@ static const struct scarlett2_device_info s18i8_gen2_info = {
 			.id = 0x000,
 			.num = { 1, 0, 8, 8, 4 },
 			.src_descr = "Off",
-			.src_num_offset = 0,
 		},
 		[SCARLETT2_PORT_TYPE_ANALOGUE] = {
 			.id = 0x080,
@@ -393,7 +391,6 @@ static const struct scarlett2_device_info s18i20_gen2_info = {
 			.id = 0x000,
 			.num = { 1, 0, 8, 8, 6 },
 			.src_descr = "Off",
-			.src_num_offset = 0,
 		},
 		[SCARLETT2_PORT_TYPE_ANALOGUE] = {
 			.id = 0x080,
@@ -571,8 +568,6 @@ struct scarlett2_usb_packet {
 	u8 data[];
 };
 
-#define SCARLETT2_USB_PACKET_LEN (sizeof(struct scarlett2_usb_packet))
-
 static void scarlett2_fill_request_header(struct scarlett2_mixer_data *private,
 					  struct scarlett2_usb_packet *req,
 					  u32 cmd, u16 req_size)
@@ -595,8 +590,8 @@ static int scarlett2_usb(
 	struct scarlett2_mixer_data *private = mixer->private_data;
 	u16 req_buf_size = sizeof(struct scarlett2_usb_packet) + req_size;
 	u16 resp_buf_size = sizeof(struct scarlett2_usb_packet) + resp_size;
-	struct scarlett2_usb_packet *req = NULL, *resp = NULL;
-	int err = 0;
+	struct scarlett2_usb_packet *req, *resp = NULL;
+	int err;
 
 	req = kmalloc(req_buf_size, GFP_KERNEL);
 	if (!req) {
@@ -1026,10 +1021,6 @@ static int scarlett2_usb_set_mux(struct usb_mixer_interface *mixer)
 							ports, private->mux[j]
 						) << 12
 					  );
-
-			/* skip private->mux[j] entries not output */
-			j += ports[port_type].num[SCARLETT2_PORT_OUT] -
-			     ports[port_type].num[port_dir_rate];
 		}
 
 		err = scarlett2_usb(mixer, SCARLETT2_USB_SET_MUX,
@@ -1681,7 +1672,7 @@ static int scarlett2_add_mixer_ctls(struct usb_mixer_interface *mixer)
 	int num_inputs = ports[SCARLETT2_PORT_TYPE_MIX].num[SCARLETT2_PORT_OUT];
 	int num_outputs = ports[SCARLETT2_PORT_TYPE_MIX].num[SCARLETT2_PORT_IN];
 
-	for (i = 0, index = 0; i < num_outputs; i++) {
+	for (i = 0, index = 0; i < num_outputs; i++)
 		for (j = 0; j < num_inputs; j++, index++) {
 			snprintf(s, sizeof(s),
 				 "Mix %c Input %02d Playback Volume",
@@ -1691,7 +1682,6 @@ static int scarlett2_add_mixer_ctls(struct usb_mixer_interface *mixer)
 			if (err < 0)
 				return err;
 		}
-	}
 
 	return 0;
 }
@@ -1925,8 +1915,6 @@ static int scarlett2_read_configs(struct usb_mixer_interface *mixer)
 		ports[SCARLETT2_PORT_TYPE_ANALOGUE].num[SCARLETT2_PORT_OUT];
 	int num_mixer_out =
 		ports[SCARLETT2_PORT_TYPE_MIX].num[SCARLETT2_PORT_IN];
-	u8 level_switches[SCARLETT2_LEVEL_SWITCH_MAX];
-	u8 pad_switches[SCARLETT2_PAD_SWITCH_MAX];
 	struct scarlett2_usb_volume_status volume_status;
 	int err, i;
 
@@ -1935,11 +1923,9 @@ static int scarlett2_read_configs(struct usb_mixer_interface *mixer)
 			mixer,
 			SCARLETT2_CONFIG_LEVEL_SWITCH,
 			info->level_input_count,
-			level_switches);
+			private->level_switch);
 		if (err < 0)
 			return err;
-		for (i = 0; i < info->level_input_count; i++)
-			private->level_switch[i] = level_switches[i];
 	}
 
 	if (info->pad_input_count) {
@@ -1947,11 +1933,9 @@ static int scarlett2_read_configs(struct usb_mixer_interface *mixer)
 			mixer,
 			SCARLETT2_CONFIG_PAD_SWITCH,
 			info->pad_input_count,
-			pad_switches);
+			private->pad_switch);
 		if (err < 0)
 			return err;
-		for (i = 0; i < info->pad_input_count; i++)
-			private->pad_switch[i] = pad_switches[i];
 	}
 
 	err = scarlett2_usb_get_volume_status(mixer, &volume_status);
-- 
2.31.1

