Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C16C4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:16:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CC5611BD
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CC5611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 214D616E1;
	Mon, 21 Jun 2021 20:15:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 214D616E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299376;
	bh=hgF29ZyTwWFBWYeXqBdoOYT0fcwuSIRsnYib6oP90RE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y9yDQfMev8ffs/VJOzqe4KRzA4e3weVkT4BjCiur9mO5JgIY+Bz6cTOB1dnw0fkYs
	 FyTzcmaex+7JTOyFPwUStaFhCOnPY0yBHhUrsVgEvcMUIgc8x3zfDNO4956sSuKgRu
	 /rPeb5/WwIMRB1QDRSg1Vou2NTIo6f7/qNfw9mlE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85289F80559;
	Mon, 21 Jun 2021 20:09:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 578ADF80548; Mon, 21 Jun 2021 20:09:56 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2BB8F8052E
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:09:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2BB8F8052E
Received: by m.b4.vu (Postfix, from userid 1000)
 id 419C461E5F04; Tue, 22 Jun 2021 03:39:46 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:39:46 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/31] ALSA: usb-audio: scarlett2: Fix Level Meter control
Message-ID: <5e9a2d5c136270db2d048db53a3b4b6e6d4a63de.1624294591.git.g@b4.vu>
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

The Level Meter control had a fixed number of channels and therefore
only worked with the 18i20 Gen 2. Fix the control to contain the
correct number of channels.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 7647b3428093..dde008ea21d7 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -161,10 +161,8 @@ static const u16 scarlett2_mixer_values[SCARLETT2_MIXER_VALUE_COUNT] = {
  */
 #define SCARLETT2_MUX_MAX 64
 
-/* Number of meters:
- * 18 inputs, 20 outputs, 18 matrix inputs
- */
-#define SCARLETT2_NUM_METERS 56
+/* Maximum number of meters (sum of output port counts) */
+#define SCARLETT2_MAX_METERS 56
 
 /* Hardware port types:
  * - None (no input to mux)
@@ -1097,26 +1095,26 @@ static int scarlett2_usb_set_mux(struct usb_mixer_interface *mixer)
 
 /* Send USB message to get meter levels */
 static int scarlett2_usb_get_meter_levels(struct usb_mixer_interface *mixer,
-					  u16 *levels)
+					  u16 num_meters, u16 *levels)
 {
 	struct {
 		__le16 pad;
 		__le16 num_meters;
 		__le32 magic;
 	} __packed req;
-	u32 resp[SCARLETT2_NUM_METERS];
+	u32 resp[SCARLETT2_MAX_METERS];
 	int i, err;
 
 	req.pad = 0;
-	req.num_meters = cpu_to_le16(SCARLETT2_NUM_METERS);
+	req.num_meters = cpu_to_le16(num_meters);
 	req.magic = cpu_to_le32(SCARLETT2_USB_METER_LEVELS_GET_MAGIC);
 	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_METER,
-			    &req, sizeof(req), resp, sizeof(resp));
+			    &req, sizeof(req), resp, num_meters * sizeof(u32));
 	if (err < 0)
 		return err;
 
 	/* copy, convert to u16 */
-	for (i = 0; i < SCARLETT2_NUM_METERS; i++)
+	for (i = 0; i < num_meters; i++)
 		levels[i] = resp[i];
 
 	return 0;
@@ -2053,10 +2051,11 @@ static int scarlett2_meter_ctl_get(struct snd_kcontrol *kctl,
 				   struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_info *elem = kctl->private_data;
-	u16 meter_levels[SCARLETT2_NUM_METERS];
+	u16 meter_levels[SCARLETT2_MAX_METERS];
 	int i, err;
 
-	err = scarlett2_usb_get_meter_levels(elem->head.mixer, meter_levels);
+	err = scarlett2_usb_get_meter_levels(elem->head.mixer, elem->channels,
+					     meter_levels);
 	if (err < 0)
 		return err;
 
@@ -2076,8 +2075,10 @@ static const struct snd_kcontrol_new scarlett2_meter_ctl = {
 
 static int scarlett2_add_meter_ctl(struct usb_mixer_interface *mixer)
 {
+	struct scarlett2_data *private = mixer->private_data;
+
 	return scarlett2_add_new_ctl(mixer, &scarlett2_meter_ctl,
-				     0, SCARLETT2_NUM_METERS,
+				     0, private->num_mux_dsts,
 				     "Level Meter", NULL);
 }
 
-- 
2.31.1

