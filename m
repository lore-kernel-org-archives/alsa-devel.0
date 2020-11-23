Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32237C2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:10:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC1420756
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F8eHaKIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC1420756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C999172B;
	Mon, 23 Nov 2020 10:09:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C999172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606122638;
	bh=8c67hbcqSjedQsnC1Rm3n97xs+jO13/52jHobUqK4og=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F8eHaKIK829+HmGwDKJ3BDNe/Ky5S4L642bB1FkyE/mWCk+YiHMRw9QBBoB7Ti/oU
	 PHvftXA1F/dA8kr7Qgiaarb9ZsRoeBOOdYig15C/d2lphSY0DwFSJ0/Q/45U6hXkEA
	 9RhHoZX4I7hcANJP5NTbvE2Vz1FXOWBv0iEpE75k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A5D7F8061E;
	Mon, 23 Nov 2020 09:55:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B488F804FA; Mon, 23 Nov 2020 09:54:54 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6A81F804F2
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:54:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6A81F804F2
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D772CAF72;
 Mon, 23 Nov 2020 08:53:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 35/41] ALSA: usb-audio: Show sync endpoint information in proc
 outputs
Date: Mon, 23 Nov 2020 09:53:41 +0100
Message-Id: <20201123085347.19667-36-tiwai@suse.de>
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

Now the sync endpoints have been parsed at the beginning and won't be
changed dynamically, let's show them in the proc outputs for helping
debugging.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/proc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index 447ba32e281c..e9bbaea7b2fa 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -108,7 +108,8 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 					    snd_pcm_format_name(fmt));
 		snd_iprintf(buffer, "\n");
 		snd_iprintf(buffer, "    Channels: %d\n", fp->channels);
-		snd_iprintf(buffer, "    Endpoint: %d %s (%s)\n",
+		snd_iprintf(buffer, "    Endpoint: 0x%02x (%d %s) (%s)\n",
+			    fp->endpoint,
 			    fp->endpoint & USB_ENDPOINT_NUMBER_MASK,
 			    fp->endpoint & USB_DIR_IN ? "IN" : "OUT",
 			    sync_types[(fp->ep_attr & USB_ENDPOINT_SYNCTYPE) >> 2]);
@@ -150,6 +151,19 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 			snd_iprintf(buffer, "\n");
 		}
 
+		if (fp->sync_ep) {
+			snd_iprintf(buffer, "    Sync Endpoint: 0x%02x (%d %s)\n",
+				    fp->sync_ep,
+				    fp->sync_ep & USB_ENDPOINT_NUMBER_MASK,
+				    fp->sync_ep & USB_DIR_IN ? "IN" : "OUT");
+			snd_iprintf(buffer, "    Sync EP Interface: %d\n",
+				    fp->sync_iface);
+			snd_iprintf(buffer, "    Sync EP Altset: %d\n",
+				    fp->sync_altsetting);
+			snd_iprintf(buffer, "    Implicit Feedback Mode: %s\n",
+				    fp->implicit_fb ? "Yes" : "No");
+		}
+
 		// snd_iprintf(buffer, "    Max Packet Size = %d\n", fp->maxpacksize);
 		// snd_iprintf(buffer, "    EP Attribute = %#x\n", fp->attributes);
 	}
-- 
2.16.4

