Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86879C47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 14:23:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062FE60E08
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 14:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062FE60E08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A70A1811;
	Tue,  8 Jun 2021 16:22:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A70A1811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623162213;
	bh=g/NWurs6n9A2LQLnfhwFZzXWKEcKNYe36kwZZoAh7og=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t4chpsIeAa0wc/MM2RkkGkA688X0DxvrZuPcgrjT8GYMwyHxAm9hOHhr4WG5d5/vp
	 0fA6hapW/HROg2KswBKz8S4bgF7Zc/IE6czJ5JvlDtf2ofjaBOeclHD2kmMoZ98NmM
	 RvO83Z/XKLrNazxKELrwF8VjYfYxUesXV7uPuLRg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59608F80642;
	Tue,  8 Jun 2021 16:07:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95B03F8060F; Tue,  8 Jun 2021 16:06:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AD79F804FF
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 16:05:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AD79F804FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="qFThDeO3"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="aCmI6rqx"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 79770219E1
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623161143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZ+UG1uKBKDfqyKhHwCLbnj2k0VpNP9yVUA48AI6+wk=;
 b=qFThDeO3JId+fIhaBxuQ297+rpR91zEAW/iK9kp+fKkaF00X6+xjtSC4leQ6NWc4xvuhvi
 ZKhvbmHk/avEUcAx3zHcjrcc+iPFp1dIvLVxYNIbnQxawDsR99sL/0M/iqCsYX98SLzAdK
 WsxOy8yfg6UkKaZxU2ye7qELHwf/oys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623161143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZ+UG1uKBKDfqyKhHwCLbnj2k0VpNP9yVUA48AI6+wk=;
 b=aCmI6rqx0u7KymjW2irNXFmk7iskMKmsTLrAJmZyNAqJSXxKFPXKlUitgeG47irAuTTaj7
 yGi+rGFq6u8taXCg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 69858A3B84;
 Tue,  8 Jun 2021 14:05:43 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 18/66] ALSA: als4000: Fix assignment in if condition
Date: Tue,  8 Jun 2021 16:04:52 +0200
Message-Id: <20210608140540.17885-19-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210608140540.17885-1-tiwai@suse.de>
References: <20210608140540.17885-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

PCI ALS4000 driver code contains a few assignments in if condition,
which is a bad coding style that may confuse readers and occasionally
lead to bugs.

This patch is merely for coding-style fixes, no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/als4000.c | 55 ++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 139ac2a3a0ef..509f317ee682 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -832,9 +832,10 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	}
 
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0) {
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
-	}
+
 	/* check, if we can restrict PCI DMA transfers to 24 bits */
 	if (dma_set_mask_and_coherent(&pci->dev, DMA_BIT_MASK(24))) {
 		dev_err(&pci->dev, "architecture does not support 24bit PCI busmaster DMA\n");
@@ -842,7 +843,8 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 		return -ENXIO;
 	}
 
-	if ((err = pci_request_regions(pci, "ALS4000")) < 0) {
+	err = pci_request_regions(pci, "ALS4000");
+	if (err < 0) {
 		pci_disable_device(pci);
 		return err;
 	}
@@ -869,17 +871,17 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	/* disable all legacy ISA stuff */
 	snd_als4000_set_addr(acard->iobase, 0, 0, 0, 0);
 
-	if ((err = snd_sbdsp_create(card,
-				    iobase + ALS4K_IOB_10_ADLIB_ADDR0,
-				    pci->irq,
+	err = snd_sbdsp_create(card,
+			       iobase + ALS4K_IOB_10_ADLIB_ADDR0,
+			       pci->irq,
 		/* internally registered as IRQF_SHARED in case of ALS4000 SB */
-				    snd_als4000_interrupt,
-				    -1,
-				    -1,
-				    SB_HW_ALS4000,
-				    &chip)) < 0) {
+			       snd_als4000_interrupt,
+			       -1,
+			       -1,
+			       SB_HW_ALS4000,
+			       &chip);
+	if (err < 0)
 		goto out_err;
-	}
 	acard->chip = chip;
 
 	chip->pci = pci;
@@ -892,11 +894,12 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, chip->alt_port, chip->irq);
 
-	if ((err = snd_mpu401_uart_new( card, 0, MPU401_HW_ALS4000,
-					iobase + ALS4K_IOB_30_MIDI_DATA,
-					MPU401_INFO_INTEGRATED |
-					MPU401_INFO_IRQ_HOOK,
-					-1, &chip->rmidi)) < 0) {
+	err = snd_mpu401_uart_new(card, 0, MPU401_HW_ALS4000,
+				  iobase + ALS4K_IOB_30_MIDI_DATA,
+				  MPU401_INFO_INTEGRATED |
+				  MPU401_INFO_IRQ_HOOK,
+				  -1, &chip->rmidi);
+	if (err < 0) {
 		dev_err(&pci->dev, "no MPU-401 device at 0x%lx?\n",
 				iobase + ALS4K_IOB_30_MIDI_DATA);
 		goto out_err;
@@ -907,12 +910,13 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 	 * however there doesn't seem to be an ALSA API for this...
 	 * SPECS_PAGE: 21 */
 
-	if ((err = snd_als4000_pcm(chip, 0)) < 0) {
+	err = snd_als4000_pcm(chip, 0);
+	if (err < 0)
 		goto out_err;
-	}
-	if ((err = snd_sbmixer_new(chip)) < 0) {
+
+	err = snd_sbmixer_new(chip);
+	if (err < 0)
 		goto out_err;
-	}	    
 
 	if (snd_opl3_create(card,
 				iobase + ALS4K_IOB_10_ADLIB_ADDR0,
@@ -922,16 +926,17 @@ static int snd_card_als4000_probe(struct pci_dev *pci,
 			   iobase + ALS4K_IOB_10_ADLIB_ADDR0,
 			   iobase + ALS4K_IOB_12_ADLIB_ADDR2);
 	} else {
-		if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
+		err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (err < 0)
 			goto out_err;
-		}
 	}
 
 	snd_als4000_create_gameport(acard, dev);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0)
 		goto out_err;
-	}
+
 	pci_set_drvdata(pci, card);
 	dev++;
 	err = 0;
-- 
2.26.2

