Return-Path: <SRS0=zwJL=MF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E41C07E95
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 14:35:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E316610CB
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 14:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E316610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AA821714;
	Tue, 13 Jul 2021 16:34:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AA821714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626186900;
	bh=mw4JtYCHJ2pf6HznXvX4m8Fu/EADLfJUC23SCsnG6gU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=giK22tBEe4SEqfFxri2zV18iRdasuH5MmgI6AXMqJn88v/qAh8pdPnhPm4MTUYKCj
	 M1QxPP3RqKOs4u4QfsWA0N0yZqcjyItO3jAHEjRgS0I69xK2iX3NBjOqapbifH42O1
	 ZmKWMgTrzro/HVwQ5/0Z1/8VE6D1a+CO7Gq4QUFs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C97A9F80578;
	Tue, 13 Jul 2021 16:29:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75FB4F80526; Tue, 13 Jul 2021 16:29:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA92FF804FD
 for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2021 16:29:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA92FF804FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="Yp08jK5+"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="QkN/GxMy"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A5FAF22855
 for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2021 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626186558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aSdB5A3jNN15Bs459uAMWvF1X+PvntD1lKNIMMu9/8=;
 b=Yp08jK5+ZcKYU0759hyKkc8kXhySMUhktyaLX9oIoDeFQUdzU1FJL01iIT+993wYU0fcGl
 qVUWcT/Ec4yh33NMRaBhKnDzYH5BjOqBcuMIsbEe8e+tXpmIsGiKtzccKULbLFhkvrLMcV
 nDNbBu19Az7U6p2WEBevuLpuquMcxbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626186558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aSdB5A3jNN15Bs459uAMWvF1X+PvntD1lKNIMMu9/8=;
 b=QkN/GxMywcpSq74G1NydAwzPL268hPerxk6x4tgUUojXimQgVnBU1y4QHoMjVNX97+dp0x
 7lDBpN2sc1DCXaDA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 93F5AA3B88;
 Tue, 13 Jul 2021 14:29:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 11/51] ALSA: bt87x: Allocate resources with device-managed APIs
Date: Tue, 13 Jul 2021 16:28:17 +0200
Message-Id: <20210713142857.19654-12-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210713142857.19654-1-tiwai@suse.de>
References: <20210713142857.19654-1-tiwai@suse.de>
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

This patch converts the resource management in PCI bt87x driver with
devres as a clean up.  Each manual resource management is converted
with the corresponding devres helper, and the card object release is
managed now via card->private_free instead of a lowlevel snd_device.

This should give no user-visible functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/bt87x.c | 97 ++++++++++++-----------------------------------
 1 file changed, 24 insertions(+), 73 deletions(-)

diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 39bcfb81e81c..4ca58be3a0c9 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -656,23 +656,11 @@ static const struct snd_kcontrol_new snd_bt87x_capture_source = {
 	.put = snd_bt87x_capture_source_put,
 };
 
-static int snd_bt87x_free(struct snd_bt87x *chip)
-{
-	if (chip->mmio)
-		snd_bt87x_stop(chip);
-	if (chip->irq >= 0)
-		free_irq(chip->irq, chip);
-	iounmap(chip->mmio);
-	pci_release_regions(chip->pci);
-	pci_disable_device(chip->pci);
-	kfree(chip);
-	return 0;
-}
-
-static int snd_bt87x_dev_free(struct snd_device *device)
+static void snd_bt87x_free(struct snd_card *card)
 {
-	struct snd_bt87x *chip = device->device_data;
-	return snd_bt87x_free(chip);
+	struct snd_bt87x *chip = card->private_data;
+
+	snd_bt87x_stop(chip);
 }
 
 static int snd_bt87x_pcm(struct snd_bt87x *chip, int device, char *name)
@@ -694,43 +682,24 @@ static int snd_bt87x_pcm(struct snd_bt87x *chip, int device, char *name)
 }
 
 static int snd_bt87x_create(struct snd_card *card,
-			    struct pci_dev *pci,
-			    struct snd_bt87x **rchip)
+			    struct pci_dev *pci)
 {
-	struct snd_bt87x *chip;
+	struct snd_bt87x *chip = card->private_data;
 	int err;
-	static const struct snd_device_ops ops = {
-		.dev_free = snd_bt87x_dev_free
-	};
-
-	*rchip = NULL;
 
-	err = pci_enable_device(pci);
+	err = pcim_enable_device(pci);
 	if (err < 0)
 		return err;
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (!chip) {
-		pci_disable_device(pci);
-		return -ENOMEM;
-	}
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
 	spin_lock_init(&chip->reg_lock);
 
-	err = pci_request_regions(pci, "Bt87x audio");
-	if (err < 0) {
-		kfree(chip);
-		pci_disable_device(pci);
+	err = pcim_iomap_regions(pci, 1 << 0, "Bt87x audio");
+	if (err < 0)
 		return err;
-	}
-	chip->mmio = pci_ioremap_bar(pci, 0);
-	if (!chip->mmio) {
-		dev_err(card->dev, "cannot remap io memory\n");
-		err = -ENOMEM;
-		goto fail;
-	}
+	chip->mmio = pcim_iomap_table(pci)[0];
 
 	chip->reg_control = CTL_A_PWRDN | CTL_DA_ES2 |
 			    CTL_PKTP_16 | (15 << CTL_DA_SDR_SHIFT);
@@ -739,26 +708,18 @@ static int snd_bt87x_create(struct snd_card *card,
 	snd_bt87x_writel(chip, REG_INT_MASK, 0);
 	snd_bt87x_writel(chip, REG_INT_STAT, MY_INTERRUPTS);
 
-	err = request_irq(pci->irq, snd_bt87x_interrupt, IRQF_SHARED,
-			  KBUILD_MODNAME, chip);
+	err = devm_request_irq(&pci->dev, pci->irq, snd_bt87x_interrupt,
+			       IRQF_SHARED, KBUILD_MODNAME, chip);
 	if (err < 0) {
 		dev_err(card->dev, "cannot grab irq %d\n", pci->irq);
-		goto fail;
+		return err;
 	}
 	chip->irq = pci->irq;
 	card->sync_irq = chip->irq;
+	card->private_free = snd_bt87x_free;
 	pci_set_master(pci);
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0)
-		goto fail;
-
-	*rchip = chip;
 	return 0;
-
-fail:
-	snd_bt87x_free(chip);
-	return err;
 }
 
 #define BT_DEVICE(chip, subvend, subdev, id) \
@@ -868,14 +829,14 @@ static int snd_bt87x_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
-			   0, &card);
+	err = snd_devm_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+				sizeof(*chip), &card);
 	if (err < 0)
 		return err;
 
-	err = snd_bt87x_create(card, pci, &chip);
+	err = snd_bt87x_create(card, pci);
 	if (err < 0)
-		goto _error;
+		return err;
 
 	memcpy(&chip->board, &snd_bt87x_boards[boardid], sizeof(chip->board));
 
@@ -887,24 +848,24 @@ static int snd_bt87x_probe(struct pci_dev *pci,
 
 		err = snd_bt87x_pcm(chip, DEVICE_DIGITAL, "Bt87x Digital");
 		if (err < 0)
-			goto _error;
+			return err;
 	}
 	if (!chip->board.no_analog) {
 		err = snd_bt87x_pcm(chip, DEVICE_ANALOG, "Bt87x Analog");
 		if (err < 0)
-			goto _error;
+			return err;
 		err = snd_ctl_add(card, snd_ctl_new1(
 				  &snd_bt87x_capture_volume, chip));
 		if (err < 0)
-			goto _error;
+			return err;
 		err = snd_ctl_add(card, snd_ctl_new1(
 				  &snd_bt87x_capture_boost, chip));
 		if (err < 0)
-			goto _error;
+			return err;
 		err = snd_ctl_add(card, snd_ctl_new1(
 				  &snd_bt87x_capture_source, chip));
 		if (err < 0)
-			goto _error;
+			return err;
 	}
 	dev_info(card->dev, "bt87x%d: Using board %d, %sanalog, %sdigital "
 		   "(rate %d Hz)\n", dev, boardid,
@@ -920,20 +881,11 @@ static int snd_bt87x_probe(struct pci_dev *pci,
 
 	err = snd_card_register(card);
 	if (err < 0)
-		goto _error;
+		return err;
 
 	pci_set_drvdata(pci, card);
 	++dev;
 	return 0;
-
-_error:
-	snd_card_free(card);
-	return err;
-}
-
-static void snd_bt87x_remove(struct pci_dev *pci)
-{
-	snd_card_free(pci_get_drvdata(pci));
 }
 
 /* default entries for all Bt87x cards - it's not exported */
@@ -948,7 +900,6 @@ static struct pci_driver driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_bt87x_ids,
 	.probe = snd_bt87x_probe,
-	.remove = snd_bt87x_remove,
 };
 
 static int __init alsa_card_bt87x_init(void)
-- 
2.26.2

