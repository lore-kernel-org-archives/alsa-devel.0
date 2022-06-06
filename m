Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F2FC43334
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jun 2022 16:10:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16CE11A48;
	Mon,  6 Jun 2022 18:09:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16CE11A48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654531827;
	bh=XlOFVbFNccqK8c9FdaOVgywRIcmM7ZPVePVUpmfc3+A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3w4r+Z0PfyOfudP3CtXWOt4DmWOo2pPeAlgAWXxnYG1mh2Mdf/71Lz2kcrvSh2Q/
	 oVzeVTHy3QFaZXSCLWF0+wqHuDclG99GmHGALmtGDEGpM9BdDSWYhrnpPmY4B/ExXm
	 oDmz+MQmt1tVjvwCy27tVrzBI/YwZ6yAe2p6aTUk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13AC5F80529;
	Mon,  6 Jun 2022 18:09:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 619F1F80526; Mon,  6 Jun 2022 18:09:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33A66F80526
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2022 18:09:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33A66F80526
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="VN3jkdt0"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="NZg6lMft"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AAC3D1F9E0;
 Mon,  6 Jun 2022 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1654531753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0x8v33dHdO6cSdiiS2dYjUghvsX7J20C1soNLX1oL4=;
 b=VN3jkdt054iW0rIN3DFZFSbpLzKWJ4UqVCOb86pTt2wELzrKMQD0o/6nTPma2T622gKaoi
 COIU8Z7IOWIh8+vFMtcsec/XzmEdgQUgtM+FNR2PGUSAs8wEJfHG2UlCTmrqwS5kmMBpLM
 C9o3R00r8Kcl1m3Jes62YszPAMsGhOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1654531753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0x8v33dHdO6cSdiiS2dYjUghvsX7J20C1soNLX1oL4=;
 b=NZg6lMftdylpKoS8Xk01wWrotCMS9swzlEnPdmFVKLa6EauyOClVO5ZKdchqscNYwen/X+
 KecTE0bDN7f3/ECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B26213AA2;
 Mon,  6 Jun 2022 16:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GMgSIakmnmKoAwAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 06 Jun 2022 16:09:13 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: usb-audio: Skip generic sync EP parse for secondary
 EP
Date: Mon,  6 Jun 2022 18:09:09 +0200
Message-Id: <20220606160910.6926-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220606160910.6926-1-tiwai@suse.de>
References: <20220606160910.6926-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Andr=C3=A9=20Kapelrud?= <a.kapelrud@gmail.com>
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

When ep_idx is already non-zero, it means usually a capture stream
that is set up explicity by a fixed-format quirk, and applying the
check for generic (non-implicit-fb) sync EPs might hit incorrectly,
resulting in a bogus sync endpoint for the capture stream.

This patch adds a check for the ep_idx and skip if it's a secondary
endpoint.  It's a part of the fixes for regressions on Saffire 6.

Fixes: 7b0efea4baf0 ("ALSA: usb-audio: Add missing ep_idx in fixed EP quirks")
Reported-and-tested-by: André Kapelrud <a.kapelrud@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b470404a5376..b0369df53910 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -304,7 +304,7 @@ int snd_usb_audioformat_set_sync_ep(struct snd_usb_audio *chip,
 	 * Generic sync EP handling
 	 */
 
-	if (altsd->bNumEndpoints < 2)
+	if (fmt->ep_idx > 0 || altsd->bNumEndpoints < 2)
 		return 0;
 
 	is_playback = !(get_endpoint(alts, 0)->bEndpointAddress & USB_DIR_IN);
-- 
2.35.3

