Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA1EC07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:19:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEB761183
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEB761183
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD3191663;
	Thu, 15 Jul 2021 10:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD3191663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626337182;
	bh=ZNOjcVUmN7mpJBg0fwsyXG3qaNDYfAmD1igigzAYbBU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qavrnIh/mKdly7ykAOA9TI1Mm4ldrLEWe5HvJFpj1hEH96oMCkcGKeojvT5paoW+G
	 dHVYWJpg5F13lH0o34rQtosYZ4aMs7HiaJyoe4lQzDc6GFwhxIEqvGajnKZ1qDMOn1
	 KsXLfn12qpFkdgW6RwliZjrO9fdXPFFbnzo+6XSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 298C9F80714;
	Thu, 15 Jul 2021 10:01:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4A29F806ED; Thu, 15 Jul 2021 10:01:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A96FF80538
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 10:00:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A96FF80538
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="pHdCPoJt"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="S/6mzRDO"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 565B922833
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626336013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKlGyoq1rpQzmRBIL2v666jZgzLLVK+izAKnR8LW/ZM=;
 b=pHdCPoJthKyfYOg8NAvc8JWhIrzBtrkVtIFP05pI6k9y5I3rLf6Mp+CCnhIiV1uYEBN9ES
 Zl0Q8/9ifiELo5s5ye6tDbr7w8BRbC50ihwuG8bznCmRj5fx8uM4SuG6sHTkyfdppW5uv5
 bbPoCAj2HsmTWtc+TZ18JjVpBYas+NU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626336013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKlGyoq1rpQzmRBIL2v666jZgzLLVK+izAKnR8LW/ZM=;
 b=S/6mzRDOHJuzY3HlHjxoXAfoPurbTkwY7tfKeXzqksw701Ub8Dd+DAq+CPh/VvRKrht0w3
 MLQQnsd2y9kAZ5Dg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 456E4A3B9C;
 Thu, 15 Jul 2021 08:00:13 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 49/79] ALSA: vx: Manage vx_core object with devres
Date: Thu, 15 Jul 2021 09:59:11 +0200
Message-Id: <20210715075941.23332-50-tiwai@suse.de>
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

The firmware data are also released automatically.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/vx/vx_core.c | 12 ++++++++++--
 sound/pci/vx222/vx222.c    |  1 -
 sound/pcmcia/vx/vxpocket.c | 22 ----------------------
 3 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index a10449af5a76..18901e5bcfcf 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -774,6 +774,11 @@ int snd_vx_resume(struct vx_core *chip)
 EXPORT_SYMBOL(snd_vx_resume);
 #endif
 
+static void snd_vx_release(struct device *dev, void *data)
+{
+	snd_vx_free_firmware(data);
+}
+
 /**
  * snd_vx_create - constructor for struct vx_core
  * @card: card instance
@@ -784,6 +789,8 @@ EXPORT_SYMBOL(snd_vx_resume);
  * this function allocates the instance and prepare for the hardware
  * initialization.
  *
+ * The object is managed via devres, and will be automatically released.
+ *
  * return the instance pointer if successful, NULL in error.
  */
 struct vx_core *snd_vx_create(struct snd_card *card,
@@ -796,8 +803,9 @@ struct vx_core *snd_vx_create(struct snd_card *card,
 	if (snd_BUG_ON(!card || !hw || !ops))
 		return NULL;
 
-	chip = kzalloc(sizeof(*chip) + extra_size, GFP_KERNEL);
-	if (! chip)
+	chip = devres_alloc(snd_vx_release, sizeof(*chip) + extra_size,
+			    GFP_KERNEL);
+	if (!chip)
 		return NULL;
 	mutex_init(&chip->lock);
 	chip->irq = -1;
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index 04c7204cb7bc..46a80ef1d481 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -109,7 +109,6 @@ static int snd_vx222_free(struct vx_core *chip)
 	if (vx->port[0])
 		pci_release_regions(vx->pci);
 	pci_disable_device(vx->pci);
-	kfree(chip);
 	return 0;
 }
 
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 0dfb6a943b60..7a0f0e73ceb2 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -50,19 +50,6 @@ static void vxpocket_release(struct pcmcia_device *link)
 	pcmcia_disable_device(link);
 }
 
-/*
- * destructor, called from snd_card_free_when_closed()
- */
-static int snd_vxpocket_dev_free(struct snd_device *device)
-{
-	struct vx_core *chip = device->device_data;
-
-	snd_vx_free_firmware(chip);
-	kfree(chip);
-	return 0;
-}
-
-
 /*
  * Hardware information
  */
@@ -122,21 +109,12 @@ static int snd_vxpocket_new(struct snd_card *card, int ibl,
 {
 	struct vx_core *chip;
 	struct snd_vxpocket *vxp;
-	static const struct snd_device_ops ops = {
-		.dev_free =	snd_vxpocket_dev_free,
-	};
-	int err;
 
 	chip = snd_vx_create(card, &vxpocket_hw, &snd_vxpocket_ops,
 			     sizeof(struct snd_vxpocket) - sizeof(struct vx_core));
 	if (!chip)
 		return -ENOMEM;
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		kfree(chip);
-		return err;
-	}
 	chip->ibl.size = ibl;
 
 	vxp = to_vxpocket(chip);
-- 
2.26.2

