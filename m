Return-Path: <SRS0=zwJL=MF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ED6C07E95
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 14:48:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50237611AB
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 14:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50237611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEE29176A;
	Tue, 13 Jul 2021 16:47:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEE29176A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626187729;
	bh=K6SYEnn0Tqwq/fjv+dY0b42AyzcgoOn2IYhhMSZuyDs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uf0iyQkq4Ed9AiLbqCHvgelSYIHJwNgeHwKZDCBLO07U8yJ4m68cekXG0+USA82Fw
	 9D96NAhp9h30anzdS1Zth262IsolVhCq4d6tmRZe3eTcHUkOPK6W12OQDXVcdyNX24
	 KVeS8FJ2s4qGwsOcbsPkhxW6lPnvj+BRmal1rO+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C731AF80659;
	Tue, 13 Jul 2021 16:31:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CD24F805AA; Tue, 13 Jul 2021 16:30:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F4E7F804FC
 for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2021 16:29:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F4E7F804FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="Z8c5UsqD"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="D+G6Ou3H"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4FBAE201DA
 for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2021 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626186586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m6xVTqFDQohmoxIEf9s0z5yYHkj3CpZtaIStWQHEs2I=;
 b=Z8c5UsqDxJhI+XREw34BLPnDG5s5MJxyEyMTa4k3DEejHhpPE1wTT5ynL7p7fvrruQeGwP
 l5uiQrilEiA1AhIvEtWW7SJmjqZ+Mu6r05cYSTGtNRHx9IaLRjGYwJ4vyZu1ufU2JhXQQH
 CYiIYbV2+15oefp2TdKnBIPGVzCvbBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626186586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m6xVTqFDQohmoxIEf9s0z5yYHkj3CpZtaIStWQHEs2I=;
 b=D+G6Ou3HrpKWocngJjebvn9rvitqCqLuOy231MVJftIlVyERP1OaJF2yzCLYQg0RMRzkMR
 qE38LHpBBSEN9lCA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 40070A3B8C;
 Tue, 13 Jul 2021 14:29:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 51/51] ALSA: mpu401: Allocate resources with device-managed
 APIs
Date: Tue, 13 Jul 2021 16:28:57 +0200
Message-Id: <20210713142857.19654-52-tiwai@suse.de>
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

This patch converts the card object management with devres as a clean
up.  The remove callback gets reduced by that.

This should give no user-visible functional changes.

Note that this converts only the mpu401 card driver.  The mpu401_uart
component is still managed with snd_device.  It's for the case where
the mpu401_uart component may be removed dynamically without the
actual device unbind.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/mpu401/mpu401.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index d0b55dbb411a..66b94f73956f 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -59,8 +59,8 @@ static int snd_mpu401_create(struct device *devptr, int dev,
 		snd_printk(KERN_ERR "the uart_enter option is obsolete; remove it\n");
 
 	*rcard = NULL;
-	err = snd_card_new(devptr, index[dev], id[dev], THIS_MODULE,
-			   0, &card);
+	err = snd_devm_card_new(devptr, index[dev], id[dev], THIS_MODULE,
+				0, &card);
 	if (err < 0)
 		return err;
 	strcpy(card->driver, "MPU-401 UART");
@@ -76,15 +76,11 @@ static int snd_mpu401_create(struct device *devptr, int dev,
 				  irq[dev], NULL);
 	if (err < 0) {
 		printk(KERN_ERR "MPU401 not detected at 0x%lx\n", port[dev]);
-		goto _err;
+		return err;
 	}
 
 	*rcard = card;
 	return 0;
-
- _err:
-	snd_card_free(card);
-	return err;
 }
 
 static int snd_mpu401_probe(struct platform_device *devptr)
@@ -105,20 +101,12 @@ static int snd_mpu401_probe(struct platform_device *devptr)
 	if (err < 0)
 		return err;
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
+	if (err < 0)
 		return err;
-	}
 	platform_set_drvdata(devptr, card);
 	return 0;
 }
 
-static int snd_mpu401_remove(struct platform_device *devptr)
-{
-	snd_card_free(platform_get_drvdata(devptr));
-	return 0;
-}
-
 #define SND_MPU401_DRIVER	"snd_mpu401"
 
 static struct platform_driver snd_mpu401_driver = {
@@ -184,10 +172,8 @@ static int snd_mpu401_pnp_probe(struct pnp_dev *pnp_dev,
 		if (err < 0)
 			return err;
 		err = snd_card_register(card);
-		if (err < 0) {
-			snd_card_free(card);
+		if (err < 0)
 			return err;
-		}
 		pnp_set_drvdata(pnp_dev, card);
 		snd_mpu401_devices++;
 		++dev;
@@ -196,19 +182,10 @@ static int snd_mpu401_pnp_probe(struct pnp_dev *pnp_dev,
 	return -ENODEV;
 }
 
-static void snd_mpu401_pnp_remove(struct pnp_dev *dev)
-{
-	struct snd_card *card = (struct snd_card *) pnp_get_drvdata(dev);
-
-	snd_card_disconnect(card);
-	snd_card_free_when_closed(card);
-}
-
 static struct pnp_driver snd_mpu401_pnp_driver = {
 	.name = "mpu401",
 	.id_table = snd_mpu401_pnpids,
 	.probe = snd_mpu401_pnp_probe,
-	.remove = snd_mpu401_pnp_remove,
 };
 #else
 static struct pnp_driver snd_mpu401_pnp_driver;
-- 
2.26.2

