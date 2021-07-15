Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C2C07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:30:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1FF6127C
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1FF6127C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D94A16E1;
	Thu, 15 Jul 2021 10:29:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D94A16E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626337798;
	bh=ikXnwzJZ5my4pJOsNUJLH1f9DfRUdtT8Vdutbg8Rja0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=beA8/7nhB+WAQNYlJo3RV0kSxD8PAJI5EfOSihKrfvLLFrhOVFwOmPyVX7AN6jDQZ
	 ERcorbjVGWGPuCZ4rlku0FwS1Y1sj+YlkQS0m2t7Ppq/8ptbwrsglk9fGF+i2IV1x+
	 w/XwXijhMik8UAPbga0XhDaJxlp88xyMZsTYa5Vw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AC5DF80862;
	Thu, 15 Jul 2021 10:02:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3D9FF804E2; Thu, 15 Jul 2021 10:01:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12B0BF804E2
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 10:00:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12B0BF804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="E7zSmzve"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="q7WF2HBX"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CF6121FDEA
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626336025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCd9c1zgyBBKJAW/4WqODYcciQ3eutX3GjhAua4snGU=;
 b=E7zSmzvesx/PYgyzVaPbb/4UmK2QVC2kl9xLoNVZGnG4spnrMSodUCEVadZrg9QRZlLNn1
 yniSkSn7U4MKCq2fCCae5GGUXxF0JlRXUZLC7k41MtXzWTjhGXlbOTUj8mjl+F4cG+EEwp
 1S/9ecwPT18QjN3gVPVwf5CeoXgC2sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626336025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCd9c1zgyBBKJAW/4WqODYcciQ3eutX3GjhAua4snGU=;
 b=q7WF2HBXsCCmi3eBHVktBed/YGfb6S+tYtE3KHyfqoKC3znnkEdRqteDs1NaB6x7OW0pnj
 S7wPk22BvDvb88AQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id C0016A3BA4;
 Thu, 15 Jul 2021 08:00:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 75/79] ALSA: serial-u16550: Allocate resources with
 device-managed APIs
Date: Thu, 15 Jul 2021 09:59:37 +0200
Message-Id: <20210715075941.23332-76-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715075941.23332-1-tiwai@suse.de>
References: <20210715075941.23332-1-tiwai@suse.de>
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

This patch converts the resource management in serial u16550 driver
with devres as a clean up.  Each manual resource management is
converted with the corresponding devres helper, and the card object
release is managed now via card->private_free instead of a lowlevel
snd_device.

This should give no user-visible functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/serial-u16550.c | 57 ++++++-----------------------------
 1 file changed, 9 insertions(+), 48 deletions(-)

diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index da9983cba01c..3cbc7a4adcb4 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -115,7 +115,6 @@ struct snd_uart16550 {
 	int irq;
 
 	unsigned long base;
-	struct resource *res_base;
 
 	unsigned int speed;
 	unsigned int speed_base;
@@ -323,8 +322,7 @@ static int snd_uart16550_detect(struct snd_uart16550 *uart)
 		return -ENODEV;	/* Not configured */
 	}
 
-	uart->res_base = request_region(io_base, 8, "Serial MIDI");
-	if (uart->res_base == NULL) {
+	if (!devm_request_region(uart->card->dev, io_base, 8, "Serial MIDI")) {
 		snd_printk(KERN_ERR "u16550: can't grab port 0x%lx\n", io_base);
 		return -EBUSY;
 	}
@@ -752,21 +750,6 @@ static const struct snd_rawmidi_ops snd_uart16550_input =
 	.trigger =	snd_uart16550_input_trigger,
 };
 
-static int snd_uart16550_free(struct snd_uart16550 *uart)
-{
-	if (uart->irq >= 0)
-		free_irq(uart->irq, uart);
-	release_and_free_resource(uart->res_base);
-	kfree(uart);
-	return 0;
-};
-
-static int snd_uart16550_dev_free(struct snd_device *device)
-{
-	struct snd_uart16550 *uart = device->device_data;
-	return snd_uart16550_free(uart);
-}
-
 static int snd_uart16550_create(struct snd_card *card,
 				unsigned long iobase,
 				int irq,
@@ -776,14 +759,11 @@ static int snd_uart16550_create(struct snd_card *card,
 				int droponfull,
 				struct snd_uart16550 **ruart)
 {
-	static const struct snd_device_ops ops = {
-		.dev_free =	snd_uart16550_dev_free,
-	};
 	struct snd_uart16550 *uart;
 	int err;
 
 
-	uart = kzalloc(sizeof(*uart), GFP_KERNEL);
+	uart = devm_kzalloc(card->dev, sizeof(*uart), GFP_KERNEL);
 	if (!uart)
 		return -ENOMEM;
 	uart->adaptor = adaptor;
@@ -796,13 +776,12 @@ static int snd_uart16550_create(struct snd_card *card,
 	err = snd_uart16550_detect(uart);
 	if (err <= 0) {
 		printk(KERN_ERR "no UART detected at 0x%lx\n", iobase);
-		snd_uart16550_free(uart);
 		return -ENODEV;
 	}
 
 	if (irq >= 0 && irq != SNDRV_AUTO_IRQ) {
-		if (request_irq(irq, snd_uart16550_interrupt,
-				0, "Serial MIDI", uart)) {
+		if (devm_request_irq(card->dev, irq, snd_uart16550_interrupt,
+				     0, "Serial MIDI", uart)) {
 			snd_printk(KERN_WARNING
 				   "irq %d busy. Using Polling.\n", irq);
 		} else {
@@ -819,13 +798,6 @@ static int snd_uart16550_create(struct snd_card *card,
 	timer_setup(&uart->buffer_timer, snd_uart16550_buffer_timer, 0);
 	uart->timer_running = 0;
 
-	/* Register device */
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, uart, &ops);
-	if (err < 0) {
-		snd_uart16550_free(uart);
-		return err;
-	}
-
 	switch (uart->adaptor) {
 	case SNDRV_SERIAL_MS124W_SA:
 	case SNDRV_SERIAL_MS124W_MB:
@@ -927,8 +899,8 @@ static int snd_serial_probe(struct platform_device *devptr)
 		return -ENODEV;
 	}
 
-	err  = snd_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
-			    0, &card);
+	err  = snd_devm_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
+				 0, &card);
 	if (err < 0)
 		return err;
 
@@ -939,11 +911,11 @@ static int snd_serial_probe(struct platform_device *devptr)
 				   base[dev], adaptor[dev], droponfull[dev],
 				   &uart);
 	if (err < 0)
-		goto _err;
+		return err;
 
 	err = snd_uart16550_rmidi(uart, 0, outs[dev], ins[dev], &uart->rmidi);
 	if (err < 0)
-		goto _err;
+		return err;
 
 	sprintf(card->longname, "%s [%s] at %#lx, irq %d",
 		card->shortname,
@@ -953,27 +925,16 @@ static int snd_serial_probe(struct platform_device *devptr)
 
 	err = snd_card_register(card);
 	if (err < 0)
-		goto _err;
+		return err;
 
 	platform_set_drvdata(devptr, card);
 	return 0;
-
- _err:
-	snd_card_free(card);
-	return err;
-}
-
-static int snd_serial_remove(struct platform_device *devptr)
-{
-	snd_card_free(platform_get_drvdata(devptr));
-	return 0;
 }
 
 #define SND_SERIAL_DRIVER	"snd_serial_u16550"
 
 static struct platform_driver snd_serial_driver = {
 	.probe		= snd_serial_probe,
-	.remove		=  snd_serial_remove,
 	.driver		= {
 		.name	= SND_SERIAL_DRIVER,
 	},
-- 
2.26.2

