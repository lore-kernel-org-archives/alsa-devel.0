Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C891C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8492072D
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AKL0d7ZE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1cZQ4ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8492072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3257D1686;
	Mon, 17 Aug 2020 11:19:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3257D1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597656047;
	bh=qRHsHRA7KmECicOC62HgQzrio8TohFZFtpHnGtSa3CE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AKL0d7ZEaq2GInrJsjd6Ol9wuAdvkuJuWw6MHGw2NOcIiNoGya2Mu0NX/n1zVOZB1
	 09cmXxJ7i5M7s+UMUhkFCL4wx+oLpxcOglrsC1yOAIAKzJS8fl/CnOdloMHqg7vYgq
	 wznSBmVEmbTxvIAwGlQh1sueTdTiYpzobGr17R10=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33ED0F802DB;
	Mon, 17 Aug 2020 11:17:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CEE1F80218; Mon, 17 Aug 2020 10:57:43 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CBAAF800EF
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 10:57:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CBAAF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="e1cZQ4ub"
Received: by mail-pj1-x1044.google.com with SMTP id 2so7481924pjx.5
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 01:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GYPUX223cEk7sfseKTxO6Wl2a86PZnTF5NOlEuFwhHI=;
 b=e1cZQ4ubmOyb/7m500QwlXNssWIHPs/Q6N0IXUiEuPicA0waQPM4rXDUgS7oGR1Qi5
 SxkjfKNWKAdDGf6wQs8A5OntcwIGD6wJ5R4FQSDrNtT46ITVL+EnIO0dBjRhPZ31NI+9
 xcBpGocniVNBTR3H6kqL1Om6YbYXsebwlyln067CWz+8PoKojJEszmQQbUKxcEP459M2
 iBXIB5ZyzBj56xcaODPTZYpADcPDMshAIby+J/sslm3j9yQN7gB6mhZ2XsW+ifVENTAz
 BLGumgFxMoG1PEiJKxXhZH7jwu32FIbUgdIGMW2GH6TsGWDQB5JTr1WO/Xy+NbOkTUR5
 mxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GYPUX223cEk7sfseKTxO6Wl2a86PZnTF5NOlEuFwhHI=;
 b=t5deaNiirdg8nStyhBozO6VXU/6VT84MPZPBduT7oFOMR4iPQxeoUiQ92d/TAOU07v
 xm7Ozkh/hGjF+v7b0B8dvY+9fiZA10p4nflw7bV6pfPi8yGMd7s3yfG/I7RTi1JevnQK
 1rDOzaH8kn0OYygUnleuSIWP3NwvvCH5Gf137w1jnb7HRNAcHfbJB7t/bGK1r6DTGNbD
 IHLLbeYecfK928whwBLyUlx6/MLHnMMg2IGvHVFIbTkSWbsTyUfke3Yk+xdwX3E+nfha
 4P4azVvotULmrBwwbeFk2WaQ4mWwWhNTj9oms9kjcT5UnhqWeJm1sO27dkh7TsboDbQz
 H+lw==
X-Gm-Message-State: AOAM530YaEVhlfd6cvR4EZi+QBRAHiXhziy/I7BlIxE4crgSaU1KTxgj
 s6KzS9no0OhwhTsJu0BXjK0=
X-Google-Smtp-Source: ABdhPJwIJG3YXsNl5fJt9BlQ6Vtf6Rc8gfiB60iBmkaUop2zKiVr9jOHcWia3jkqjMEsJzNj8Bm4+w==
X-Received: by 2002:a17:902:9e04:: with SMTP id
 d4mr10015126plq.296.1597654650775; 
 Mon, 17 Aug 2020 01:57:30 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:57:30 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
 o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com
Subject: [PATCH 03/10] sound: asihpi: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 14:26:56 +0530
Message-Id: <20200817085703.25732-4-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817085703.25732-1-allen.cryptic@gmail.com>
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
X-Mailman-Approved-At: Mon, 17 Aug 2020 11:17:21 +0200
Cc: alsa-devel@alsa-project.org, keescook@chromium.org,
 Allen Pais <allen.lkml@gmail.com>, linux-kernel@vger.kernel.org,
 Romain Perier <romain.perier@gmail.com>, linuxppc-dev@lists.ozlabs.org
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

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 sound/pci/asihpi/asihpi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 023c35a2a951..35e76480306e 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -921,10 +921,10 @@ static void snd_card_asihpi_timer_function(struct timer_list *t)
 		add_timer(&dpcm->timer);
 }
 
-static void snd_card_asihpi_int_task(unsigned long data)
+static void snd_card_asihpi_int_task(struct tasklet_struct *t)
 {
-	struct hpi_adapter *a = (struct hpi_adapter *)data;
-	struct snd_card_asihpi *asihpi;
+	struct snd_card_asihpi *asihpi = from_tasklet(asihpi, t, t);
+	struct hpi_adapter *a = asihpi->hpi;
 
 	WARN_ON(!a || !a->snd_card || !a->snd_card->private_data);
 	asihpi = (struct snd_card_asihpi *)a->snd_card->private_data;
@@ -2871,8 +2871,7 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 	if (hpi->interrupt_mode) {
 		asihpi->pcm_start = snd_card_asihpi_pcm_int_start;
 		asihpi->pcm_stop = snd_card_asihpi_pcm_int_stop;
-		tasklet_init(&asihpi->t, snd_card_asihpi_int_task,
-			(unsigned long)hpi);
+		tasklet_setup(&asihpi->t, snd_card_asihpi_int_task);
 		hpi->interrupt_callback = snd_card_asihpi_isr;
 	} else {
 		asihpi->pcm_start = snd_card_asihpi_pcm_timer_start;
-- 
2.17.1

