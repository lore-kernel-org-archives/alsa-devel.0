Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969F2EE643D
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 08:30:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CFC3DEC;
	Fri, 15 Sep 2023 10:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CFC3DEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694766620;
	bh=LWtOIDysbnrHxHoXBIT/6Vq2hwfUpj0Czv70X79bV8s=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pJihFKKCGT7EYo4S/QWJwoqm9CYmThAofo7njN7+rQtoMnBVEbEFUgh+nONaedFKW
	 0pR9u0bv9WT1UKolLPxbLl/irH24CJzN4DYjkSW8EdqTnOjsH2lZezWxtapzgJtobi
	 FHzk2klYr1Mjr3HvulQ2SZ7pY5DXGPq4uL86FH0o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7117BF80587; Fri, 15 Sep 2023 10:28:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9E6DF8059F;
	Fri, 15 Sep 2023 10:28:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E126F80558; Fri, 15 Sep 2023 10:28:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 89F8CF8055B
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 10:28:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89F8CF8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Dr6D3ukm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=LJDwXzR3
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CB9A1F8AA;
	Fri, 15 Sep 2023 08:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1694766488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axDHq4ILyRhDpmp7P7MGy69b+ilkW7vSp1dIYKZpI6g=;
	b=Dr6D3ukmP7cU3WakHskZoxV8q6W/KZ4gttmI6EFJxlroWkVxj8kt1Qu6UdXQCEjfHG1Qvw
	dOcuR+QYOvm6vZwMvbvpXCyKECWrVYxEbwIG9arcjKXQc+loYmuvobdHv7vecJH3Lo3gJF
	QGTdavCCXpiXr/6jC/txbWek78tmz/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694766488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axDHq4ILyRhDpmp7P7MGy69b+ilkW7vSp1dIYKZpI6g=;
	b=LJDwXzR35HQIv9lGh7QeNTryxdgFI6EyXFzdh1S7j/gpO6ndWz4pot7wP7wwa3r8YgvzJS
	DHyXanwa/JieG5DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1CBE13A34;
	Fri, 15 Sep 2023 08:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8Lb2OZcVBGVfQQAAMHmgww
	(envelope-from <tiwai@suse.de>); Fri, 15 Sep 2023 08:28:07 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 12/13] ALSA: cmipci: Fix -Wformat-truncation warning
Date: Fri, 15 Sep 2023 10:28:01 +0200
Message-Id: <20230915082802.28684-13-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230915082802.28684-1-tiwai@suse.de>
References: <20230915082802.28684-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: N73UNEYJP6WI4QRBK5FPV27QAFLG6Y5Y
X-Message-ID-Hash: N73UNEYJP6WI4QRBK5FPV27QAFLG6Y5Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N73UNEYJP6WI4QRBK5FPV27QAFLG6Y5Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

CMIPCI driver got compile warnings with -Wformat-truncation at a
couple of plain sprintf() usages.  Use scnprintf() for filling the
longname string for avoiding the warnings.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cmipci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 1415baac9c36..08e34b184780 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -3102,11 +3102,13 @@ static int snd_cmipci_create(struct snd_card *card, struct pci_dev *pci,
 	}
 	sprintf(card->shortname, "C-Media CMI%d", val);
 	if (cm->chip_version < 68)
-		sprintf(modelstr, " (model %d)", cm->chip_version);
+		scnprintf(modelstr, sizeof(modelstr),
+			  " (model %d)", cm->chip_version);
 	else
 		modelstr[0] = '\0';
-	sprintf(card->longname, "%s%s at %#lx, irq %i",
-		card->shortname, modelstr, cm->iobase, cm->irq);
+	scnprintf(card->longname, sizeof(card->longname),
+		  "%s%s at %#lx, irq %i",
+		  card->shortname, modelstr, cm->iobase, cm->irq);
 
 	if (cm->chip_version >= 39) {
 		val = snd_cmipci_read_b(cm, CM_REG_MPU_PCI + 1);
-- 
2.35.3

