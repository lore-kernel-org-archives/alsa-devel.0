Return-Path: <SRS0=Bo48=LO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF7EC48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:52:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B917C61042
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B917C61042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5759016CD;
	Sun, 20 Jun 2021 18:51:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5759016CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624207947;
	bh=ZnW2OesNnZ4rVQTKtql34NF/pUSGTDIkusOUm/C+vWw=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uMns0CY6UdN/ZLI4f0CvCwFqHtC4M/WwjnXFgA17Fgd3LVQ6WfIUnUlciSEuSTS+p
	 hsTVjxSzI15c43G4BoFBDn42il513+/qV+BFFeVLS3sib8/0Ho0uVkKwp2/YqFfSxs
	 Q2sOMWWSUFqec2gjHImtQJlZ3VksVREJIG3dGzQk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F1A6F80536;
	Sun, 20 Jun 2021 18:47:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46FDAF804EB; Sun, 20 Jun 2021 18:46:54 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66EC9F804EB
 for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2021 18:46:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66EC9F804EB
Received: by m.b4.vu (Postfix, from userid 1000)
 id E951661E5F1E; Mon, 21 Jun 2021 02:16:48 +0930 (ACST)
Date: Mon, 21 Jun 2021 02:16:48 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/14] ALSA: usb-audio: scarlett2: Don't copy struct
 scarlett2_config
Message-ID: <20210620164648.GA9231@m.b4.vu>
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

scarlett2_usb_set_config() and scarlett2_usb_get_config() were copying
struct scarlett2_config. Use a pointer instead.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 49c4662531a3..45fd540920b9 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -706,8 +706,8 @@ static int scarlett2_usb_set_config(
 	struct usb_mixer_interface *mixer,
 	int config_item_num, int index, int value)
 {
-	const struct scarlett2_config config_item =
-	       scarlett2_config_items[config_item_num];
+	const struct scarlett2_config *config_item =
+	       &scarlett2_config_items[config_item_num];
 	struct {
 		__le32 offset;
 		__le32 bytes;
@@ -721,17 +721,17 @@ static int scarlett2_usb_set_config(
 	cancel_delayed_work_sync(&private->work);
 
 	/* Send the configuration parameter data */
-	req.offset = cpu_to_le32(config_item.offset + index * config_item.size);
-	req.bytes = cpu_to_le32(config_item.size);
+	req.offset = cpu_to_le32(config_item->offset + index * config_item->size);
+	req.bytes = cpu_to_le32(config_item->size);
 	req.value = cpu_to_le32(value);
 	err = scarlett2_usb(mixer, SCARLETT2_USB_SET_DATA,
-			    &req, sizeof(u32) * 2 + config_item.size,
+			    &req, sizeof(u32) * 2 + config_item->size,
 			    NULL, 0);
 	if (err < 0)
 		return err;
 
 	/* Activate the change */
-	req2 = cpu_to_le32(config_item.activate);
+	req2 = cpu_to_le32(config_item->activate);
 	err = scarlett2_usb(mixer, SCARLETT2_USB_DATA_CMD,
 			    &req2, sizeof(req2), NULL, 0);
 	if (err < 0)
@@ -764,11 +764,11 @@ static int scarlett2_usb_get_config(
 	struct usb_mixer_interface *mixer,
 	int config_item_num, int count, void *buf)
 {
-	const struct scarlett2_config config_item =
-	       scarlett2_config_items[config_item_num];
-	int size = config_item.size * count;
+	const struct scarlett2_config *config_item =
+		&scarlett2_config_items[config_item_num];
+	int size = config_item->size * count;
 
-	return scarlett2_usb_get(mixer, config_item.offset, buf, size);
+	return scarlett2_usb_get(mixer, config_item->offset, buf, size);
 }
 
 /* Send a USB message to get volume status; result placed in *buf */
-- 
2.31.1

