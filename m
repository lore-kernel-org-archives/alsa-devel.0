Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E2EC2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 08:57:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F4220738
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 08:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sUAGIAdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F4220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D92E1616;
	Mon, 23 Nov 2020 09:56:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D92E1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606121846;
	bh=/80Wxo3ZBHitJnvwBpweaPaqAkVaQ0AlbHTjkacSdjU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sUAGIAdqjEZsRQceLPSrN4dZS5fvmeYU2bcocEMKd832P7f7hhxjLb+OL5xzl5s8D
	 3esf9AUjGs3sVv2cfW5KyF1y5hWHSOpUP+v11+SwJcumtt4z1BY/VrnPE1VY3z6WPD
	 ZJklJHB7ehgXOXhVBrtClsocN3oNRDp/L9iJ+DnU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F4C9F80520;
	Mon, 23 Nov 2020 09:54:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3030FF8051B; Mon, 23 Nov 2020 09:54:12 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0819CF8027C
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:53:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0819CF8027C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1F634AF90;
 Mon, 23 Nov 2020 08:53:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/41] ALSA: usb-audio: Add snd_usb_get_endpoint() helper
Date: Mon, 23 Nov 2020 09:53:11 +0100
Message-Id: <20201123085347.19667-6-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201123085347.19667-1-tiwai@suse.de>
References: <20201123085347.19667-1-tiwai@suse.de>
Cc: Matwey Kornilov <matwey.kornilov@gmail.com>,
 Dylan Robinson <dylan_robinson@motu.com>,
 Keith Milner <kamilner@superlative.org>
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

Factor out the code to obtain snd_usb_endpoint object matching with
the given endpoint.  It'll be used in the later patch to add the
implicit feedback hw-constraint.

No functional change by this patch itself.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c | 36 +++++++++++++++++++++++++++---------
 sound/usb/endpoint.h |  4 ++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e2f9ce2f5b8b..cf00871fd278 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -439,6 +439,26 @@ static void snd_complete_urb(struct urb *urb)
 	clear_bit(ctx->index, &ep->active_mask);
 }
 
+/*
+ * Get the existing endpoint object corresponding EP, iface and alt numbers
+ * Returns NULL if not present.
+ * Call inside chip->mutex locking for avoiding the race.
+ */
+struct snd_usb_endpoint *
+snd_usb_get_endpoint(struct snd_usb_audio *chip,
+		     int ep_num, int iface, int altsetting)
+{
+	struct snd_usb_endpoint *ep;
+
+	list_for_each_entry(ep, &chip->ep_list, list) {
+		if (ep->ep_num == ep_num &&
+		    ep->iface == iface &&
+		    ep->altsetting == altsetting)
+			return ep;
+	}
+	return NULL;
+}
+
 /**
  * snd_usb_add_endpoint: Add an endpoint to an USB audio chip
  *
@@ -470,15 +490,13 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 
 	mutex_lock(&chip->mutex);
 
-	list_for_each_entry(ep, &chip->ep_list, list) {
-		if (ep->ep_num == ep_num &&
-		    ep->iface == alts->desc.bInterfaceNumber &&
-		    ep->altsetting == alts->desc.bAlternateSetting) {
-			usb_audio_dbg(ep->chip,
-				      "Re-using EP %x in iface %d,%d @%p\n",
-					ep_num, ep->iface, ep->altsetting, ep);
-			goto __exit_unlock;
-		}
+	ep = snd_usb_get_endpoint(chip, ep_num,
+				  alts->desc.bInterfaceNumber,
+				  alts->desc.bAlternateSetting);
+	if (ep) {
+		usb_audio_dbg(ep->chip, "Re-using EP %x in iface %d,%d @%p\n",
+			      ep_num, ep->iface, ep->altsetting, ep);
+		goto __exit_unlock;
 	}
 
 	usb_audio_dbg(chip, "Creating new %s %s endpoint #%x\n",
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index d23fa0a8c11b..61487095a766 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -5,6 +5,10 @@
 #define SND_USB_ENDPOINT_TYPE_DATA     0
 #define SND_USB_ENDPOINT_TYPE_SYNC     1
 
+struct snd_usb_endpoint *snd_usb_get_endpoint(struct snd_usb_audio *chip,
+					      int ep_num, int iface,
+					      int altsetting);
+
 struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 					      struct usb_host_interface *alts,
 					      int ep_num, int direction, int type);
-- 
2.16.4

