Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D6C07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:22:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6386D61183
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 08:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6386D61183
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDE681756;
	Thu, 15 Jul 2021 10:21:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDE681756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626337360;
	bh=RWLJMaRirfQbsUsqZ0jOaL1vpWvFHyJCdBoMJS8JcYY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YdPJdGwwB1x6yjo6HGbrSPDMtr0oWiC7YsgqExPJP4nbf83dJzYowH4I0iI7QW+2W
	 NEwPJjf7ywHBwmBA70MftZ2xwic5kYRd+DP2huIitWzCK8Uhc+MHK8yKc9ZGVBI+V+
	 fZUzAmShyc6F25W981Wr8dN0wU0Qj7G+1Sg+7bCg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC036F80760;
	Thu, 15 Jul 2021 10:01:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2530AF80722; Thu, 15 Jul 2021 10:01:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A07CF804D2
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 10:00:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A07CF804D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="AYjRs8uq"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="yJYtkO+t"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6208B22833
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 08:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626336016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvQU4Cnz68Qc1H+ELmRFr+SaYTSyr1oxM4UtKPI65yk=;
 b=AYjRs8uqLfdhopCdo72lRe+yrOwZ3Q+3T2zZ+uye9Sn3Q9rv2E7WjDs9le3Q24Vl3a02pb
 ybnftGsAgutmhUcobzB4XBh1IRTZug+534Pwqc/VtrzOuRogC50d4HaMaSK7NUfEOc8p/q
 RU8UrRvABHAnuBlt2SGI8BZfGFQcSrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626336016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvQU4Cnz68Qc1H+ELmRFr+SaYTSyr1oxM4UtKPI65yk=;
 b=yJYtkO+tyjXwEK9atp7Y6xkgdUDHjz3wwi2VIFpUGXJuqCOVxfV88jRSQvNMWLcYsMit76
 l0U96NyXDW6xwaCA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 50F14A3B8F;
 Thu, 15 Jul 2021 08:00:16 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 56/79] ALSA: adlib: Allocate resources with device-managed
 APIs
Date: Thu, 15 Jul 2021 09:59:18 +0200
Message-Id: <20210715075941.23332-57-tiwai@suse.de>
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

This patch converts the resource management in ISA adlib driver with
devres as a clean up.  Each manual resource management is converted
with the corresponding devres helper.  The remove callback became
superfluous and dropped.

This should give no user-visible functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/adlib.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/sound/isa/adlib.c b/sound/isa/adlib.c
index e6cd7c4da38e..f079ba4ef1a0 100644
--- a/sound/isa/adlib.c
+++ b/sound/isa/adlib.c
@@ -43,30 +43,23 @@ static int snd_adlib_match(struct device *dev, unsigned int n)
 	return 1;
 }
 
-static void snd_adlib_free(struct snd_card *card)
-{
-	release_and_free_resource(card->private_data);
-}
-
 static int snd_adlib_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
 	int error;
 
-	error = snd_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
+	error = snd_devm_card_new(dev, index[n], id[n], THIS_MODULE, 0, &card);
 	if (error < 0) {
 		dev_err(dev, "could not create card\n");
 		return error;
 	}
 
-	card->private_data = request_region(port[n], 4, CRD_NAME);
+	card->private_data = devm_request_region(dev, port[n], 4, CRD_NAME);
 	if (!card->private_data) {
 		dev_err(dev, "could not grab ports\n");
-		error = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
-	card->private_free = snd_adlib_free;
 
 	strcpy(card->driver, DEV_NAME);
 	strcpy(card->shortname, CRD_NAME);
@@ -75,37 +68,28 @@ static int snd_adlib_probe(struct device *dev, unsigned int n)
 	error = snd_opl3_create(card, port[n], port[n] + 2, OPL3_HW_AUTO, 1, &opl3);
 	if (error < 0) {
 		dev_err(dev, "could not create OPL\n");
-		goto out;
+		return error;
 	}
 
 	error = snd_opl3_hwdep_new(opl3, 0, 0, NULL);
 	if (error < 0) {
 		dev_err(dev, "could not create FM\n");
-		goto out;
+		return error;
 	}
 
 	error = snd_card_register(card);
 	if (error < 0) {
 		dev_err(dev, "could not register card\n");
-		goto out;
+		return error;
 	}
 
 	dev_set_drvdata(dev, card);
 	return 0;
-
-out:	snd_card_free(card);
-	return error;
-}
-
-static void snd_adlib_remove(struct device *dev, unsigned int n)
-{
-	snd_card_free(dev_get_drvdata(dev));
 }
 
 static struct isa_driver snd_adlib_driver = {
 	.match		= snd_adlib_match,
 	.probe		= snd_adlib_probe,
-	.remove		= snd_adlib_remove,
 
 	.driver		= {
 		.name	= DEV_NAME
-- 
2.26.2

