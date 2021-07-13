Return-Path: <SRS0=zwJL=MF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA7C07E95
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 14:38:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F14C610CB
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 14:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F14C610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF28916DF;
	Tue, 13 Jul 2021 16:37:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF28916DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626187091;
	bh=+zZ82PvAwfuGDL+lk+bxHefvcy6qWb9WRLvqm6rUJtQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YVV5kUHzr/GRtM2b5jN9JSrIZmo/5UURHH3F0Akw2NUbMxnM3qqpMvXemOmlp2Ot5
	 81f06Xn8XE9U4UK/RLB0K2HGvW+fd4pL1kOvJN+C7CFTqIlNgamr+X0rct0O/9vMuT
	 DbuAXjEdNEeMnxdvYGQs7pJgt364xtCP6rxqI8f0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B1C5F80551;
	Tue, 13 Jul 2021 16:30:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68B02F80558; Tue, 13 Jul 2021 16:29:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72B00F804B3
 for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2021 16:29:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72B00F804B3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="xlohLgop"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="Mj5tU57n"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4A558201E4
 for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2021 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626186567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPwkniyc4i2ebrNRn1DxMXVIXeRB3qPV1y4v5jAw8Dk=;
 b=xlohLgopJOcv9j4bEkJzvA3iRV504PRxq6d17qJxlM94TErNmaR/6hFXGFWW3ua6btIl50
 VpdV+6KpjZXphJ9eVpB8XNwM+hVjll7uolA0WAgzA0vsPduLHpFPKN3WQdDcL90ZE1F2Ep
 xvqV+0/TlsT8woEBQ7Si06Zj2Epa8aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626186567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPwkniyc4i2ebrNRn1DxMXVIXeRB3qPV1y4v5jAw8Dk=;
 b=Mj5tU57nLij5hqMwZ077VvbKTb0dgdxUiyt5YVm8bblIo85Nx7KWUBzONebza2twGZrr1K
 abUs0i318GXumiDQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 3A2F6A3B90;
 Tue, 13 Jul 2021 14:29:27 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 21/51] ALSA: rme96: Allocate resources with device-managed APIs
Date: Tue, 13 Jul 2021 16:28:27 +0200
Message-Id: <20210713142857.19654-22-tiwai@suse.de>
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

This patch converts the resource management in PCI rme96 driver with
devres as a clean up.  Each manual resource management is converted
with the corresponding devres helper.

This should give no user-visible functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme96.c | 57 ++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index fc7ac077559c..8fc811504920 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -1562,33 +1562,17 @@ static const struct snd_pcm_ops snd_rme96_capture_adat_ops = {
 };
 
 static void
-snd_rme96_free(void *private_data)
+snd_rme96_free(struct rme96 *rme96)
 {
-	struct rme96 *rme96 = (struct rme96 *)private_data;
-
-	if (!rme96)
-	        return;
-
 	if (rme96->irq >= 0) {
 		snd_rme96_trigger(rme96, RME96_STOP_BOTH);
 		rme96->areg &= ~RME96_AR_DAC_EN;
 		writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
-		free_irq(rme96->irq, (void *)rme96);
-		rme96->irq = -1;
-	}
-	if (rme96->iobase) {
-		iounmap(rme96->iobase);
-		rme96->iobase = NULL;
-	}
-	if (rme96->port) {
-		pci_release_regions(rme96->pci);
-		rme96->port = 0;
 	}
 #ifdef CONFIG_PM_SLEEP
 	vfree(rme96->playback_suspend_buffer);
 	vfree(rme96->capture_suspend_buffer);
 #endif
-	pci_disable_device(rme96->pci);
 }
 
 static void
@@ -1614,7 +1598,7 @@ snd_rme96_create(struct rme96 *rme96)
 	rme96->irq = -1;
 	spin_lock_init(&rme96->lock);
 
-	err = pci_enable_device(pci);
+	err = pcim_enable_device(pci);
 	if (err < 0)
 		return err;
 
@@ -1623,16 +1607,16 @@ snd_rme96_create(struct rme96 *rme96)
 		return err;
 	rme96->port = pci_resource_start(rme96->pci, 0);
 
-	rme96->iobase = ioremap(rme96->port, RME96_IO_SIZE);
+	rme96->iobase = devm_ioremap(&pci->dev, rme96->port, RME96_IO_SIZE);
 	if (!rme96->iobase) {
 		dev_err(rme96->card->dev,
 			"unable to remap memory region 0x%lx-0x%lx\n",
 			rme96->port, rme96->port + RME96_IO_SIZE - 1);
-		return -ENOMEM;
+		return -EBUSY;
 	}
 
-	if (request_irq(pci->irq, snd_rme96_interrupt, IRQF_SHARED,
-			KBUILD_MODNAME, rme96)) {
+	if (devm_request_irq(&pci->dev, pci->irq, snd_rme96_interrupt,
+			     IRQF_SHARED, KBUILD_MODNAME, rme96)) {
 		dev_err(rme96->card->dev, "unable to grab IRQ %d\n", pci->irq);
 		return -EBUSY;
 	}
@@ -2462,8 +2446,8 @@ snd_rme96_probe(struct pci_dev *pci,
 		dev++;
 		return -ENOENT;
 	}
-	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
-			   sizeof(struct rme96), &card);
+	err = snd_devm_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+				sizeof(*rme96), &card);
 	if (err < 0)
 		return err;
 	card->private_free = snd_rme96_card_free;
@@ -2472,19 +2456,15 @@ snd_rme96_probe(struct pci_dev *pci,
 	rme96->pci = pci;
 	err = snd_rme96_create(rme96);
 	if (err)
-		goto free_card;
+		return err;
 	
 #ifdef CONFIG_PM_SLEEP
 	rme96->playback_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
-	if (!rme96->playback_suspend_buffer) {
-		err = -ENOMEM;
-		goto free_card;
-	}
+	if (!rme96->playback_suspend_buffer)
+		return -ENOMEM;
 	rme96->capture_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
-	if (!rme96->capture_suspend_buffer) {
-		err = -ENOMEM;
-		goto free_card;
-	}
+	if (!rme96->capture_suspend_buffer)
+		return -ENOMEM;
 #endif
 
 	strcpy(card->driver, "Digi96");
@@ -2511,26 +2491,17 @@ snd_rme96_probe(struct pci_dev *pci,
 		rme96->port, rme96->irq);
 	err = snd_card_register(card);
 	if (err)
-		goto free_card;
+		return err;
 
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
-free_card:
-	snd_card_free(card);
-	return err;
-}
-
-static void snd_rme96_remove(struct pci_dev *pci)
-{
-	snd_card_free(pci_get_drvdata(pci));
 }
 
 static struct pci_driver rme96_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_rme96_ids,
 	.probe = snd_rme96_probe,
-	.remove = snd_rme96_remove,
 	.driver = {
 		.pm = RME96_PM_OPS,
 	},
-- 
2.26.2

