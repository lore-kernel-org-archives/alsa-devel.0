Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91231C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:33:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D53822519
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pgg/Ogbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D53822519
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C5AE15E5;
	Tue, 14 Jul 2020 19:32:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C5AE15E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594747998;
	bh=vf3hjbGw/1FGWae2S+TGW9c2qBzUAHUmT8AgQ3QJKtc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pgg/OgbpSOxxG0J5lL+kxkKPffl/z0Asp87ydueKYjAVH9i7wE7qJSQL0WBjxzAcp
	 LN4YqYwsoP7pWMA4L42KiEDwcMLCTCA4dNCtYxG4EgwRQeLsBaTB/PCLLMJ0Fs7XLh
	 3xBoUlYbkVbYLdKJQbUcQRy6YFFU29SD8daxr3Jw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47AD3F80308;
	Tue, 14 Jul 2020 19:27:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39D26F802F9; Tue, 14 Jul 2020 19:27:05 +0200 (CEST)
Received: from mx2.suse.de (unknown [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E333F8026F
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 19:26:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E333F8026F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5D5C1AD77
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 17:26:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/10] ALSA: nm256: Replace the words blacklist
Date: Tue, 14 Jul 2020 19:26:29 +0200
Message-Id: <20200714172631.25371-9-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200714172631.25371-1-tiwai@suse.de>
References: <20200714172631.25371-1-tiwai@suse.de>
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

Follow the recent inclusive terminology guidelines and replace the
words "whitelist" and "blacklist" appropriately.

Only comment or enum/variable renames, no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/nm256/nm256.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 240195e85e3d..975994623c2c 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1632,11 +1632,11 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 }
 
 
-enum { NM_BLACKLISTED, NM_RESET_WORKAROUND, NM_RESET_WORKAROUND_2 };
+enum { NM_IGNORED, NM_RESET_WORKAROUND, NM_RESET_WORKAROUND_2 };
 
 static const struct snd_pci_quirk nm256_quirks[] = {
 	/* HP omnibook 4150 has cs4232 codec internally */
-	SND_PCI_QUIRK(0x103c, 0x0007, "HP omnibook 4150", NM_BLACKLISTED),
+	SND_PCI_QUIRK(0x103c, 0x0007, "HP omnibook 4150", NM_IGNORED),
 	/* Reset workarounds to avoid lock-ups */
 	SND_PCI_QUIRK(0x104d, 0x8041, "Sony PCG-F305", NM_RESET_WORKAROUND),
 	SND_PCI_QUIRK(0x1028, 0x0080, "Dell Latitude LS", NM_RESET_WORKAROUND),
@@ -1658,9 +1658,9 @@ static int snd_nm256_probe(struct pci_dev *pci,
 		dev_dbg(&pci->dev, "Enabled quirk for %s.\n",
 			    snd_pci_quirk_name(q));
 		switch (q->value) {
-		case NM_BLACKLISTED:
+		case NM_IGNORED:
 			dev_info(&pci->dev,
-				 "The device is blacklisted. Loading stopped\n");
+				 "The device is on the denylist. Loading stopped\n");
 			return -ENODEV;
 		case NM_RESET_WORKAROUND_2:
 			reset_workaround_2 = 1;
-- 
2.16.4

