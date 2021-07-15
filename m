Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A28AC07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:23:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D3F6120A
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D3F6120A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F6A51731;
	Thu, 15 Jul 2021 10:23:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F6A51731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626337432;
	bh=6h9irJrIDEGyKS5Xu0pfBS6kV4Q5NR7VYeiYXW+mKC0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=smCmnkJRB16AHg40otHECTV/kVEFeNM0NS4udPYChKE3+eq48Azry43BB947/xd0U
	 lWASWd33ZpXuCaUr5rrey2YTWdu6bTChSwikH+XvNDVio+wOxF7jaaKorY9zlsrVMp
	 s53Rs5jxgBUbp9ZTWlzKRuvEpkfkQeHFObwlRJGM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2354FF80772;
	Thu, 15 Jul 2021 10:01:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EA69F8072A; Thu, 15 Jul 2021 10:01:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 266CBF8054A
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 10:00:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 266CBF8054A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="AHEdiU3b"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="Bv6YCRF3"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 01D521FDE5
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 08:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626336016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drthx1EGwL1/x7T6ZSLfCNWdvW5bSDZl7lLhK8kpG24=;
 b=AHEdiU3bbfQOYmOzakWctsipbYH8luL+2uBdXMfZI+MDApKM1pK2UQbPI7aGzQnJMKRdI+
 lysCRubtuI31nQGuwC9PlUmyjfuyRK6dh5Nn2ex4ahsZlAduAWjqXzrHKHA5tY7sd5Ldas
 ekJg0S5p4dtVkEoYYvBHOg5ZtC9FKqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626336016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drthx1EGwL1/x7T6ZSLfCNWdvW5bSDZl7lLhK8kpG24=;
 b=Bv6YCRF345ZZwrMjhJwM9CyFyC1ylodnAhovX2eniu1SUlr38YPOeVKhV52Ln4fFD9Fre/
 /f3ywf35O34FMoBg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id E544AA3B8F;
 Thu, 15 Jul 2021 08:00:15 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 55/79] ALSA: ad1848: Allocate resources with device-managed
 APIs
Date: Thu, 15 Jul 2021 09:59:17 +0200
Message-Id: <20210715075941.23332-56-tiwai@suse.de>
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

This patch converts the resource management in ISA ad1848 driver with
devres as a clean up.  Each manual resource management is converted
with the corresponding devres helper.  The remove callback became
superfluous and dropped.

This should give no user-visible functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/ad1848/ad1848.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index edafb49797e7..c471ac2aa450 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -72,7 +72,7 @@ static int snd_ad1848_probe(struct device *dev, unsigned int n)
 	struct snd_wss *chip;
 	int error;
 
-	error = snd_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
+	error = snd_devm_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
 	if (error < 0)
 		return error;
 
@@ -80,17 +80,17 @@ static int snd_ad1848_probe(struct device *dev, unsigned int n)
 			thinkpad[n] ? WSS_HW_THINKPAD : WSS_HW_DETECT,
 			0, &chip);
 	if (error < 0)
-		goto out;
+		return error;
 
 	card->private_data = chip;
 
 	error = snd_wss_pcm(chip, 0);
 	if (error < 0)
-		goto out;
+		return error;
 
 	error = snd_wss_mixer(chip);
 	if (error < 0)
-		goto out;
+		return error;
 
 	strscpy(card->driver, "AD1848", sizeof(card->driver));
 	strscpy(card->shortname, chip->pcm->name, sizeof(card->shortname));
@@ -106,18 +106,10 @@ static int snd_ad1848_probe(struct device *dev, unsigned int n)
 
 	error = snd_card_register(card);
 	if (error < 0)
-		goto out;
+		return error;
 
 	dev_set_drvdata(dev, card);
 	return 0;
-
-out:	snd_card_free(card);
-	return error;
-}
-
-static void snd_ad1848_remove(struct device *dev, unsigned int n)
-{
-	snd_card_free(dev_get_drvdata(dev));
 }
 
 #ifdef CONFIG_PM
@@ -145,7 +137,6 @@ static int snd_ad1848_resume(struct device *dev, unsigned int n)
 static struct isa_driver snd_ad1848_driver = {
 	.match		= snd_ad1848_match,
 	.probe		= snd_ad1848_probe,
-	.remove		= snd_ad1848_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_ad1848_suspend,
 	.resume		= snd_ad1848_resume,
-- 
2.26.2

