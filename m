Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C1BC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 10:34:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 139A31911;
	Tue, 12 Apr 2022 12:33:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 139A31911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649759673;
	bh=jnMaWXJW6GjMVOtPTxKVOdPoFp07E4LTnv0z/U7S7Wc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gB4CjF8gENkAI5XwnPv+pHq5GQH0kEUQw3xkdFZHb2mJClT+wjiUspfXIYFyMOOk0
	 t9q+epyHrYaSik/8wwhqmYC/cQwyQIRnTfOAjgdl85wqx79ODaT1N+TTaZhIbsB6td
	 +4zxSFsHkmpN3Enh/mxuQsBjKXKB91DMdm5nCxYc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C9E4F805E6;
	Tue, 12 Apr 2022 12:27:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01579F8052D; Tue, 12 Apr 2022 12:27:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9C08F8052D
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 12:26:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9C08F8052D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="UvciaLTz"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="OWMp8Dfl"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1A0E621612
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649759205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehylo5yqaXEf1g+aGbs/DleWSZeD8RPbeK8d2F2T+v8=;
 b=UvciaLTzvIHd8tOU9K0xQTsAe0NzS8zxp9sCrzXbH/xK7sryHAbeiPZIL5i6kkQNIH3yo2
 PVnLYmKc8u2eiVE6o27N/cu446zXe5GEJOgoPbgunjU/T8z61P04FYxtWSNrAQvkkZ7+2d
 SMiFrKoxWxtcGfw5xNULi4JikNMZwfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649759205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehylo5yqaXEf1g+aGbs/DleWSZeD8RPbeK8d2F2T+v8=;
 b=OWMp8DflqEh1rSpUaqyyRtrs+KoA6W/BtBT1Xr9Egk4U8b1L+OtzAcDxBiy43BXkSDzdr6
 8fj+mG1p4GN/KMAA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 0A830A3B88;
 Tue, 12 Apr 2022 10:26:45 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 38/39] ALSA: mtpav: Don't call card private_free at probe
 error path
Date: Tue, 12 Apr 2022 12:26:35 +0200
Message-Id: <20220412102636.16000-39-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220412102636.16000-1-tiwai@suse.de>
References: <20220412102636.16000-1-tiwai@suse.de>
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

The card destructor of nm256 driver does merely stopping the running
timer, and it's superfluous for the probe error handling.  Moreover,
calling this via the previous devres change would lead to another
problem due to the reverse call order.

This patch moves the setup of the private_free callback after the card
registration, so that it can be used only after fully set up.

Fixes: aa92050f10f0 ("ALSA: mtpav: Allocate resources with device-managed APIs")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/mtpav.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index 11235baaf6fa..f212f233ea61 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -693,8 +693,6 @@ static int snd_mtpav_probe(struct platform_device *dev)
 	mtp_card->outmidihwport = 0xffffffff;
 	timer_setup(&mtp_card->timer, snd_mtpav_output_timer, 0);
 
-	card->private_free = snd_mtpav_free;
-
 	err = snd_mtpav_get_RAWMIDI(mtp_card);
 	if (err < 0)
 		return err;
@@ -716,6 +714,8 @@ static int snd_mtpav_probe(struct platform_device *dev)
 	if (err < 0)
 		return err;
 
+	card->private_free = snd_mtpav_free;
+
 	platform_set_drvdata(dev, card);
 	printk(KERN_INFO "Motu MidiTimePiece on parallel port irq: %d ioport: 0x%lx\n", irq, port);
 	return 0;
-- 
2.31.1

