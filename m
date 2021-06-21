Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B2C4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:18:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A226100B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A226100B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 791E016BB;
	Mon, 21 Jun 2021 20:17:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 791E016BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299481;
	bh=XPXwYis85l+2H3wX2hRoWLPZFiJ4+8VSMwn2dqRDaTc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XQS4UF8JjwHvKn7NMrgi1v0Wyubw+ORymgydD7r3d86tNMXU4lOh3Ah1NCq1eGMOY
	 wh57vqQCJax9eDVJVKkbLU3ERE/eUt4ME2KURUL/EtymB9gHCvG5uk18XFbBo1fN/c
	 LFqBr8CbvXdiHHzBhHnRVG2SSmbiEEw+yrX1zFGA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C134EF805AA;
	Mon, 21 Jun 2021 20:10:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80F38F8057C; Mon, 21 Jun 2021 20:10:04 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8168F8055A
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:09:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8168F8055A
Received: by m.b4.vu (Postfix, from userid 1000)
 id 2EEF261E287C; Tue, 22 Jun 2021 03:39:55 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:39:55 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/31] ALSA: usb-audio: scarlett2: Move get config above set
 config
Message-ID: <61337880a0eaec60cb6c15e4882435408528694d.1624294591.git.g@b4.vu>
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

Move scarlett2_usb_get() and scarlett2_usb_get_config() above the
functions relating to updating the configuration so that
scarlett2_usb_set_config() can call scarlett2_usb_get() in a
subsequent patch.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 56 ++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 6995d692c6b2..87a90cafb175 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -985,6 +985,34 @@ static int scarlett2_usb(
 	return err;
 }
 
+/* Send a USB message to get data; result placed in *buf */
+static int scarlett2_usb_get(
+	struct usb_mixer_interface *mixer,
+	int offset, void *buf, int size)
+{
+	struct {
+		__le32 offset;
+		__le32 size;
+	} __packed req;
+
+	req.offset = cpu_to_le32(offset);
+	req.size = cpu_to_le32(size);
+	return scarlett2_usb(mixer, SCARLETT2_USB_GET_DATA,
+			     &req, sizeof(req), buf, size);
+}
+
+/* Send a USB message to get configuration parameters; result placed in *buf */
+static int scarlett2_usb_get_config(
+	struct usb_mixer_interface *mixer,
+	int config_item_num, int count, void *buf)
+{
+	const struct scarlett2_config *config_item =
+		&scarlett2_config_items[config_item_num];
+	int size = config_item->size * count;
+
+	return scarlett2_usb_get(mixer, config_item->offset, buf, size);
+}
+
 /* Send SCARLETT2_USB_DATA_CMD SCARLETT2_USB_CONFIG_SAVE */
 static void scarlett2_config_save(struct usb_mixer_interface *mixer)
 {
@@ -1049,34 +1077,6 @@ static int scarlett2_usb_set_config(
 	return 0;
 }
 
-/* Send a USB message to get data; result placed in *buf */
-static int scarlett2_usb_get(
-	struct usb_mixer_interface *mixer,
-	int offset, void *buf, int size)
-{
-	struct {
-		__le32 offset;
-		__le32 size;
-	} __packed req;
-
-	req.offset = cpu_to_le32(offset);
-	req.size = cpu_to_le32(size);
-	return scarlett2_usb(mixer, SCARLETT2_USB_GET_DATA,
-			     &req, sizeof(req), buf, size);
-}
-
-/* Send a USB message to get configuration parameters; result placed in *buf */
-static int scarlett2_usb_get_config(
-	struct usb_mixer_interface *mixer,
-	int config_item_num, int count, void *buf)
-{
-	const struct scarlett2_config *config_item =
-		&scarlett2_config_items[config_item_num];
-	int size = config_item->size * count;
-
-	return scarlett2_usb_get(mixer, config_item->offset, buf, size);
-}
-
 /* Send a USB message to get sync status; result placed in *sync */
 static int scarlett2_usb_get_sync_status(
 	struct usb_mixer_interface *mixer,
-- 
2.31.1

