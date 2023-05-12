Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBD9C77B75
	for <alsa-devel@archiver.kernel.org>; Fri, 12 May 2023 08:00:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23B67FA;
	Fri, 12 May 2023 09:59:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23B67FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683878427;
	bh=8dEYCsi1Pk8z5T/sB6fmafn4CUgGvA+CwcOWgLHRdhQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pFLH1zGuI+pC4NBipo7ohdf1agPrkuv4p6FLbBfzEBH5doVNbCOCwYXu4Vhggd3jz
	 OE9h9jUlbzNhbhiva3FQ2YxxTHKcwl7FxkzD2qVq2az4VxSrpiCuI4QsvJ48pGXUzD
	 ajdWwpOfinQ0ESVImngDwi4KTOa4HMZrBdUXYZeU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC275F80542; Fri, 12 May 2023 09:59:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 593B0F8052E;
	Fri, 12 May 2023 09:59:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA4A6F8052E; Fri, 12 May 2023 09:59:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1FB43F802E8
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2023 09:59:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FB43F802E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Ua6h9BIb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=DzM25ay1
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AB972184D;
	Fri, 12 May 2023 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1683878341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=UM3njMrXGhXjS90ki6nn9LWHBya7qvfhLtIh5evaIKE=;
	b=Ua6h9BIbFxiRUeDhbH5145IMjCiyWLsb/HS7uZzFDzlFMSZyashU1vzoZXn27sTmsSENev
	vO47w+7+thy2RTnTyDmGzZS8741XjJVULPskJR1rS/M1hLFZxMoDTrmgkFPuNZsY4zB5tL
	sIzaa5xlaE5BwXqLr1RU1+B3w7ErxAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683878341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=UM3njMrXGhXjS90ki6nn9LWHBya7qvfhLtIh5evaIKE=;
	b=DzM25ay1GRs8fhRMCb4Oh1E4dg67lzp7EoDGF/40mjLRRCT3V6l39I1wz9T0ww4Fds5kup
	LVI7zpUzuZG42xCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B73D13466;
	Fri, 12 May 2023 07:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nNaTDcXxXWRIEwAAMHmgww
	(envelope-from <tiwai@suse.de>); Fri, 12 May 2023 07:59:01 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: John Humlick <john@humlick.org>
Subject: [PATCH] ALSA: usb-audio: Add a sample rate workaround for Line6 Pod
 Go
Date: Fri, 12 May 2023 09:58:58 +0200
Message-Id: <20230512075858.22813-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2DCIGVKKBQL4UTL46CY2WTZ27A54T3UH
X-Message-ID-Hash: 2DCIGVKKBQL4UTL46CY2WTZ27A54T3UH
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2DCIGVKKBQL4UTL46CY2WTZ27A54T3UH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Line6 Pod Go (0e41:424b) requires the similar workaround for the fixed
48k sample rate like other Line6 models.  This patch adds the
corresponding entry to line6_parse_audio_format_rate_quirk().

Reported-by: John Humlick <john@humlick.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/format.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 4b1c5ba121f3..ab5fed9f55b6 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -423,6 +423,7 @@ static int line6_parse_audio_format_rates_quirk(struct snd_usb_audio *chip,
 	case USB_ID(0x0e41, 0x4248): /* Line6 Helix >= fw 2.82 */
 	case USB_ID(0x0e41, 0x4249): /* Line6 Helix Rack >= fw 2.82 */
 	case USB_ID(0x0e41, 0x424a): /* Line6 Helix LT >= fw 2.82 */
+	case USB_ID(0x0e41, 0x424b): /* Line6 Pod Go */
 	case USB_ID(0x19f7, 0x0011): /* Rode Rodecaster Pro */
 		return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);
 	}
-- 
2.35.3

