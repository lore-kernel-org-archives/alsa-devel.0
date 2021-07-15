Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C79EC07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:23:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830C6611C0
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830C6611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2220816CB;
	Thu, 15 Jul 2021 10:22:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2220816CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626337379;
	bh=/egJmUr59IyDImqF+56T/sOM3qBax4Wvgj4zGplAkKY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QugjtFPvrcN+YO+uz+QI23UVNhRocS0gCGrE20HxdZzOzOZI0YN3GzPvw549HSTGX
	 MFjKS2utqJuJCyw74hFWdeH9E1+dHKD/MNdfexN5eNB93o/9NUq1JeoC8wn+ltjRWl
	 ceBZGH4v6SWjX8/3D78z60W0sM/rgSqJoQGFwxg4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BBA9F80765;
	Thu, 15 Jul 2021 10:01:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34BA3F80720; Thu, 15 Jul 2021 10:01:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F952F8055A
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 10:00:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F952F8055A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="ocL/1Q4W"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="5x/9JQrn"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 43B531FD3E
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626336017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8N5g+KTOoao1mhuTQ2kTRzNtUtzImdgSu3SqZkxl8eg=;
 b=ocL/1Q4WlAJzIbV1Wp0wgKC/9QKnAO6tojFCPOr8ENQX71wO3m3zEqbff9ToelSkNdLJsu
 chDtdsFLephxwyHAZIKb9KT3xwPCYT8LIS8fPQYEA4gA7RCssDThRNZeua0Vu9OIoTYz0w
 rn7++Y23fZ51ELELLCbkFFk0wFeNnZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626336017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8N5g+KTOoao1mhuTQ2kTRzNtUtzImdgSu3SqZkxl8eg=;
 b=5x/9JQrnFwiqFf93i/tQofZ0qzyXcDkjNrhXZ4m1rhmu+5OcJgghJdhHaR8LR060l673oB
 DcuI9PJfOrjJpwDQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 3BB07A3B8F;
 Thu, 15 Jul 2021 08:00:17 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 58/79] ALSA: azt2320: Allocate resources with
 device-managed APIs
Date: Thu, 15 Jul 2021 09:59:20 +0200
Message-Id: <20210715075941.23332-59-tiwai@suse.de>
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

This patch converts the resource management in ISA azt2320 driver with
devres as a clean up.  Each manual resource management is converted
with the corresponding devres helper.  The remove callback became
superfluous and dropped.

This should give no user-visible functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/azt2320.c | 49 +++++++++++----------------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index dd5c059b3744..761cd198df2b 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -169,33 +169,27 @@ static int snd_card_azt2320_probe(int dev,
 	struct snd_wss *chip;
 	struct snd_opl3 *opl3;
 
-	error = snd_card_new(&pcard->card->dev,
-			     index[dev], id[dev], THIS_MODULE,
-			     sizeof(struct snd_card_azt2320), &card);
+	error = snd_devm_card_new(&pcard->card->dev,
+				  index[dev], id[dev], THIS_MODULE,
+				  sizeof(struct snd_card_azt2320), &card);
 	if (error < 0)
 		return error;
 	acard = card->private_data;
 
 	error = snd_card_azt2320_pnp(dev, acard, pcard, pid);
-	if (error) {
-		snd_card_free(card);
+	if (error)
 		return error;
-	}
 
 	error = snd_card_azt2320_enable_wss(port[dev]);
-	if (error) {
-		snd_card_free(card);
+	if (error)
 		return error;
-	}
 
 	error = snd_wss_create(card, wss_port[dev], -1,
 			       irq[dev],
 			       dma1[dev], dma2[dev],
 			       WSS_HW_DETECT, 0, &chip);
-	if (error < 0) {
-		snd_card_free(card);
+	if (error < 0)
 		return error;
-	}
 
 	strcpy(card->driver, "AZT2320");
 	strcpy(card->shortname, "Aztech AZT2320");
@@ -203,20 +197,14 @@ static int snd_card_azt2320_probe(int dev,
 		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);
 
 	error = snd_wss_pcm(chip, 0);
-	if (error < 0) {
-		snd_card_free(card);
+	if (error < 0)
 		return error;
-	}
 	error = snd_wss_mixer(chip);
-	if (error < 0) {
-		snd_card_free(card);
+	if (error < 0)
 		return error;
-	}
 	error = snd_wss_timer(chip, 0);
-	if (error < 0) {
-		snd_card_free(card);
+	if (error < 0)
 		return error;
-	}
 
 	if (mpu_port[dev] > 0 && mpu_port[dev] != SNDRV_AUTO_PORT) {
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_AZT2320,
@@ -233,23 +221,17 @@ static int snd_card_azt2320_probe(int dev,
 				   fm_port[dev], fm_port[dev] + 2);
 		} else {
 			error = snd_opl3_timer_new(opl3, 1, 2);
-			if (error < 0) {
-				snd_card_free(card);
+			if (error < 0)
 				return error;
-			}
 			error = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
-			if (error < 0) {
-				snd_card_free(card);
+			if (error < 0)
 				return error;
-			}
 		}
 	}
 
 	error = snd_card_register(card);
-	if (error < 0) {
-		snd_card_free(card);
+	if (error < 0)
 		return error;
-	}
 	pnp_set_card_drvdata(pcard, card);
 	return 0;
 }
@@ -275,12 +257,6 @@ static int snd_azt2320_pnp_detect(struct pnp_card_link *card,
         return -ENODEV;
 }
 
-static void snd_azt2320_pnp_remove(struct pnp_card_link *pcard)
-{
-	snd_card_free(pnp_get_card_drvdata(pcard));
-	pnp_set_card_drvdata(pcard, NULL);
-}
-
 #ifdef CONFIG_PM
 static int snd_azt2320_pnp_suspend(struct pnp_card_link *pcard, pm_message_t state)
 {
@@ -310,7 +286,6 @@ static struct pnp_card_driver azt2320_pnpc_driver = {
 	.name           = "azt2320",
 	.id_table       = snd_azt2320_pnpids,
 	.probe          = snd_azt2320_pnp_detect,
-	.remove         = snd_azt2320_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_azt2320_pnp_suspend,
 	.resume		= snd_azt2320_pnp_resume,
-- 
2.26.2

