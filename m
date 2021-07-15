Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E7C07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:29:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28100611C0
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28100611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7BB6176C;
	Thu, 15 Jul 2021 10:28:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7BB6176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626337746;
	bh=1LgK4r7Nt4cZqkoHSz3NM/gpMmd8SDCt8Uebltn1EFI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M8clb0PqqNf/DRke5Y8zee5IEwQxCrh0iVKVozqO8fq3kQSg1+zNeCZCeFaUL8z4g
	 hiBsTN/Yws5I7Q15neNTy7F9HvCGK9DVAUhcgOaq6yRm9gFagLpoDghzA7GuA/wmbR
	 g7N+OYIU84eNYDI+IKlT/BKxwg3nTfPCslYYbJ2w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0005F8051C;
	Thu, 15 Jul 2021 10:01:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A076BF807DC; Thu, 15 Jul 2021 10:01:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA91CF804E3
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 10:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA91CF804E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="ivnog7FC"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="1qHayyij"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C59F52284F
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626336023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fmFbwAl0scRniMBGRmt/LYV5Q59V+Yu7zP10IIZFwE=;
 b=ivnog7FChMq8/6wE1tFilL35CW1/ar/fVHicR8vqRx66Gi3B5p9IMMFlb+9KatY8QgJOLB
 SelQQn5K+EJGlVblixRtdmYFt5iOtD5Vx1MRxQs4X2A8jS3PNOHdfm8+whgq3mp01IKPa8
 vAJUDB8mg+5+9BPvVwf/IvyzsZMJdY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626336023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fmFbwAl0scRniMBGRmt/LYV5Q59V+Yu7zP10IIZFwE=;
 b=1qHayyijiqRg4zjRKeUULvrWYGnAhoLcfOhnFjKgZqoezNQbcitxysT771vtKL6Cf3PYps
 4bYQNamsRA9jM8CA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id B49E0A3B9D;
 Thu, 15 Jul 2021 08:00:23 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 72/79] ALSA: x86: Allocate resources with device-managed
 APIs
Date: Thu, 15 Jul 2021 09:59:34 +0200
Message-Id: <20210715075941.23332-73-tiwai@suse.de>
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

This patch converts the resource management in x86 HDMI LPE audio
driver with devres as a clean up.  Each manual resource management is
converted with the corresponding devres helper now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 57 ++++++++++--------------------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 6d87c099d997..d60e532edf5f 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1657,11 +1657,6 @@ static void hdmi_lpe_audio_free(struct snd_card *card)
 
 		cancel_work_sync(&ctx->hdmi_audio_wq);
 	}
-
-	if (card_ctx->mmio_start)
-		iounmap(card_ctx->mmio_start);
-	if (card_ctx->irq >= 0)
-		free_irq(card_ctx->irq, card_ctx);
 }
 
 /*
@@ -1699,8 +1694,8 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	}
 
 	/* create a card instance with ALSA framework */
-	ret = snd_card_new(&pdev->dev, hdmi_card_index, hdmi_card_id,
-			   THIS_MODULE, sizeof(*card_ctx), &card);
+	ret = snd_devm_card_new(&pdev->dev, hdmi_card_index, hdmi_card_id,
+				THIS_MODULE, sizeof(*card_ctx), &card);
 	if (ret)
 		return ret;
 
@@ -1736,20 +1731,20 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		__func__, (unsigned int)res_mmio->start,
 		(unsigned int)res_mmio->end);
 
-	card_ctx->mmio_start = ioremap(res_mmio->start,
-					       (size_t)(resource_size(res_mmio)));
+	card_ctx->mmio_start =
+		devm_ioremap(&pdev->dev, res_mmio->start,
+			     (size_t)(resource_size(res_mmio)));
 	if (!card_ctx->mmio_start) {
 		dev_err(&pdev->dev, "Could not get ioremap\n");
-		ret = -EACCES;
-		goto err;
+		return -EACCES;
 	}
 
 	/* setup interrupt handler */
-	ret = request_irq(irq, display_pipe_interrupt_handler, 0,
-			  pdev->name, card_ctx);
+	ret = devm_request_irq(&pdev->dev, irq, display_pipe_interrupt_handler,
+			       0, pdev->name, card_ctx);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "request_irq failed\n");
-		goto err;
+		return ret;
 	}
 
 	card_ctx->irq = irq;
@@ -1769,7 +1764,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		ret = snd_pcm_new(card, INTEL_HAD, port, MAX_PB_STREAMS,
 				  MAX_CAP_STREAMS, &pcm);
 		if (ret)
-			goto err;
+			return ret;
 
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
@@ -1790,31 +1785,29 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 			struct snd_kcontrol *kctl;
 
 			kctl = snd_ctl_new1(&had_controls[i], ctx);
-			if (!kctl) {
-				ret = -ENOMEM;
-				goto err;
-			}
+			if (!kctl)
+				return -ENOMEM;
 
 			kctl->id.device = pcm->device;
 
 			ret = snd_ctl_add(card, kctl);
 			if (ret < 0)
-				goto err;
+				return ret;
 		}
 
 		/* Register channel map controls */
 		ret = had_register_chmap_ctls(ctx, pcm);
 		if (ret < 0)
-			goto err;
+			return ret;
 
 		ret = had_create_jack(ctx, pcm);
 		if (ret < 0)
-			goto err;
+			return ret;
 	}
 
 	ret = snd_card_register(card);
 	if (ret)
-		goto err;
+		return ret;
 
 	spin_lock_irq(&pdata->lpe_audio_slock);
 	pdata->notify_audio_lpe = notify_audio_lpe;
@@ -1831,23 +1824,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err:
-	snd_card_free(card);
-	return ret;
-}
-
-/*
- * hdmi_lpe_audio_remove - stop bridge with i915
- *
- * This function is called when the platform device is destroyed.
- */
-static int hdmi_lpe_audio_remove(struct platform_device *pdev)
-{
-	struct snd_intelhad_card *card_ctx = platform_get_drvdata(pdev);
-
-	snd_card_free(card_ctx->card);
-	return 0;
 }
 
 static const struct dev_pm_ops hdmi_lpe_audio_pm = {
@@ -1860,7 +1836,6 @@ static struct platform_driver hdmi_lpe_audio_driver = {
 		.pm = &hdmi_lpe_audio_pm,
 	},
 	.probe          = hdmi_lpe_audio_probe,
-	.remove		= hdmi_lpe_audio_remove,
 };
 
 module_platform_driver(hdmi_lpe_audio_driver);
-- 
2.26.2

