Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84967C47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 14:06:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3E46127A
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 14:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3E46127A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D86A382E;
	Tue,  8 Jun 2021 16:05:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D86A382E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623161206;
	bh=W+73SVXzuX5vOPgfmc3nBF86dEDoi6auFNmFju8yfP4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b08FPOBqsVEKI3mXljcn5eAHixCZwwnlfzdi3/kwPN9kv/1FVkKamZlLH0MM71iLu
	 1q5kCiy5Va+EdRhyPOorRW+DED6WfcFhm8fupsP/wkVyTLIQuFWRCneVyT+8E1SeJv
	 S4iu+rCDfI4+kRrYh+PeDOcjarC4Qh6DfnWG1l9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD47DF80510;
	Tue,  8 Jun 2021 16:05:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6424F804FE; Tue,  8 Jun 2021 16:05:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 620DEF800FD
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 16:05:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 620DEF800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="w/V1HYcz"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="RfrBW7lb"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0EDA81FD53
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623161143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4fI4ry4NS51ViqA/znja68g32EK0QGyk/PhdRkxGG8=;
 b=w/V1HYczYte5rTU9ATiNJ3eXFkFD/0lQpoHX16PnjB3KOdjocF436No+H2z0oCaPs5gfG9
 CuuP37MN6CEUhwsy7mXSgIo3x65eEAnqiHkIdtgMfOZc9ZWa9FoN05V/fL6RWmDftQDZWU
 EPqgmK0HFyy+C8ZJJuc9Q3KCf98TDTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623161143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4fI4ry4NS51ViqA/znja68g32EK0QGyk/PhdRkxGG8=;
 b=RfrBW7lb6RKMJ4+ZrO4fz2hv8FNDG6ab7S/25gR+dgufhSjruayjDQInUJi+q58JeJZoD2
 iKUiGd/53dCYr4Cw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id F2D50A3B84;
 Tue,  8 Jun 2021 14:05:42 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 09/66] ALSA: opl3sa2: Fix assignment in if condition
Date: Tue,  8 Jun 2021 16:04:43 +0200
Message-Id: <20210608140540.17885-10-tiwai@suse.de>
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

ISA OPL3SA2 driver code contains lots of assignments in if condition,
which is a bad coding style that may confuse readers and occasionally
lead to bugs.

This patch is merely for coding-style fixes, no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/opl3sa2.c | 68 +++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index 9bde11d1cfe8..6f42f869928c 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -208,7 +208,8 @@ static int snd_opl3sa2_detect(struct snd_card *card)
 	char str[2];
 
 	port = chip->port;
-	if ((chip->res_port = request_region(port, 2, "OPL3-SA control")) == NULL) {
+	chip->res_port = request_region(port, 2, "OPL3-SA control");
+	if (!chip->res_port) {
 		snd_printk(KERN_ERR PFX "can't grab port 0x%lx\n", port);
 		return -EBUSY;
 	}
@@ -239,14 +240,16 @@ static int snd_opl3sa2_detect(struct snd_card *card)
 	str[1] = 0;
 	strcat(card->shortname, str);
 	snd_opl3sa2_write(chip, OPL3SA2_MISC, tmp ^ 7);
-	if ((tmp1 = snd_opl3sa2_read(chip, OPL3SA2_MISC)) != tmp) {
+	tmp1 = snd_opl3sa2_read(chip, OPL3SA2_MISC);
+	if (tmp1 != tmp) {
 		snd_printd("OPL3-SA [0x%lx] detect (1) = 0x%x (0x%x)\n", port, tmp, tmp1);
 		return -ENODEV;
 	}
 	/* try if the MIC register is accessible */
 	tmp = snd_opl3sa2_read(chip, OPL3SA2_MIC);
 	snd_opl3sa2_write(chip, OPL3SA2_MIC, 0x8a);
-	if (((tmp1 = snd_opl3sa2_read(chip, OPL3SA2_MIC)) & 0x9f) != 0x8a) {
+	tmp1 = snd_opl3sa2_read(chip, OPL3SA2_MIC);
+	if ((tmp1 & 0x9f) != 0x8a) {
 		snd_printd("OPL3-SA [0x%lx] detect (2) = 0x%x (0x%x)\n", port, tmp, tmp1);
 		return -ENODEV;
 	}
@@ -489,32 +492,38 @@ static int snd_opl3sa2_mixer(struct snd_card *card)
 	/* reassign AUX0 to CD */
         strcpy(id1.name, "Aux Playback Switch");
         strcpy(id2.name, "CD Playback Switch");
-        if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0) {
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0) {
 		snd_printk(KERN_ERR "Cannot rename opl3sa2 control\n");
                 return err;
 	}
         strcpy(id1.name, "Aux Playback Volume");
         strcpy(id2.name, "CD Playback Volume");
-        if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0) {
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0) {
 		snd_printk(KERN_ERR "Cannot rename opl3sa2 control\n");
                 return err;
 	}
 	/* reassign AUX1 to FM */
         strcpy(id1.name, "Aux Playback Switch"); id1.index = 1;
         strcpy(id2.name, "FM Playback Switch");
-        if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0) {
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0) {
 		snd_printk(KERN_ERR "Cannot rename opl3sa2 control\n");
                 return err;
 	}
         strcpy(id1.name, "Aux Playback Volume");
         strcpy(id2.name, "FM Playback Volume");
-        if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0) {
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0) {
 		snd_printk(KERN_ERR "Cannot rename opl3sa2 control\n");
                 return err;
 	}
 	/* add OPL3SA2 controls */
 	for (idx = 0; idx < ARRAY_SIZE(snd_opl3sa2_controls); idx++) {
-		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_opl3sa2_controls[idx], chip))) < 0)
+		kctl = snd_ctl_new1(&snd_opl3sa2_controls[idx], chip);
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			return err;
 		switch (idx) {
 		case 0: chip->master_switch = kctl; kctl->private_free = snd_opl3sa2_master_free; break;
@@ -522,9 +531,11 @@ static int snd_opl3sa2_mixer(struct snd_card *card)
 		}
 	}
 	if (chip->version > 2) {
-		for (idx = 0; idx < ARRAY_SIZE(snd_opl3sa2_tone_controls); idx++)
-			if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_opl3sa2_tone_controls[idx], chip))) < 0)
+		for (idx = 0; idx < ARRAY_SIZE(snd_opl3sa2_tone_controls); idx++) {
+			err = snd_ctl_add(card, snd_ctl_new1(&snd_opl3sa2_tone_controls[idx], chip));
+			if (err < 0)
 				return err;
+		}
 	}
 	return 0;
 }
@@ -677,20 +688,24 @@ static int snd_opl3sa2_probe(struct snd_card *card, int dev)
 	if (err < 0)
 		return err;
 	if (fm_port[dev] >= 0x340 && fm_port[dev] < 0x400) {
-		if ((err = snd_opl3_create(card, fm_port[dev],
-					   fm_port[dev] + 2,
-					   OPL3_HW_OPL3, 0, &opl3)) < 0)
+		err = snd_opl3_create(card, fm_port[dev],
+				      fm_port[dev] + 2,
+				      OPL3_HW_OPL3, 0, &opl3);
+		if (err < 0)
 			return err;
-		if ((err = snd_opl3_timer_new(opl3, 1, 2)) < 0)
+		err = snd_opl3_timer_new(opl3, 1, 2);
+		if (err < 0)
 			return err;
-		if ((err = snd_opl3_hwdep_new(opl3, 0, 1, &chip->synth)) < 0)
+		err = snd_opl3_hwdep_new(opl3, 0, 1, &chip->synth);
+		if (err < 0)
 			return err;
 	}
 	if (midi_port[dev] >= 0x300 && midi_port[dev] < 0x340) {
-		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_OPL3SA2,
-					       midi_port[dev],
-					       MPU401_INFO_IRQ_HOOK, -1,
-					       &chip->rmidi)) < 0)
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_OPL3SA2,
+					  midi_port[dev],
+					  MPU401_INFO_IRQ_HOOK, -1,
+					  &chip->rmidi);
+		if (err < 0)
 			return err;
 	}
 	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
@@ -721,11 +736,13 @@ static int snd_opl3sa2_pnp_detect(struct pnp_dev *pdev,
 	err = snd_opl3sa2_card_new(&pdev->dev, dev, &card);
 	if (err < 0)
 		return err;
-	if ((err = snd_opl3sa2_pnp(dev, card->private_data, pdev)) < 0) {
+	err = snd_opl3sa2_pnp(dev, card->private_data, pdev);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_opl3sa2_probe(card, dev)) < 0) {
+	err = snd_opl3sa2_probe(card, dev);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -785,11 +802,13 @@ static int snd_opl3sa2_pnp_cdetect(struct pnp_card_link *pcard,
 	err = snd_opl3sa2_card_new(&pdev->dev, dev, &card);
 	if (err < 0)
 		return err;
-	if ((err = snd_opl3sa2_pnp(dev, card->private_data, pdev)) < 0) {
+	err = snd_opl3sa2_pnp(dev, card->private_data, pdev);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_opl3sa2_probe(card, dev)) < 0) {
+	err = snd_opl3sa2_probe(card, dev);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -865,7 +884,8 @@ static int snd_opl3sa2_isa_probe(struct device *pdev,
 	err = snd_opl3sa2_card_new(pdev, dev, &card);
 	if (err < 0)
 		return err;
-	if ((err = snd_opl3sa2_probe(card, dev)) < 0) {
+	err = snd_opl3sa2_probe(card, dev);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.26.2

