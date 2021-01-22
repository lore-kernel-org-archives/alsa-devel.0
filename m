Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB4C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 10:09:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F40239EF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 10:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F40239EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26E131AE4;
	Fri, 22 Jan 2021 11:08:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26E131AE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611310188;
	bh=DW/L42FzV0B1yJ5q6SNG8Ti1I20WNptRWTBTA5tAQ4k=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M2XqU/C4/u0wjRIxFrGvAs0p2Biodsu0o8+UjBuOmhtLVtkvIuyj9S06D4/W9DUrO
	 KZgrOKSsS+8AeXHUQcDN+UVB4i9HWwtxyOmZdPOkpJnnvcle3qIHdMeZHSCdTWSjOh
	 pKtQf6qd65WaZSTmFYlcGhhEE0A8JI0ZKW9zTsno=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85456F804BD;
	Fri, 22 Jan 2021 11:08:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1B33F804BD; Fri, 22 Jan 2021 11:08:07 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D3CAF80218
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 11:08:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D3CAF80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Z0v6Y+wS"
Received: by mail-yb1-xb49.google.com with SMTP id y1so4996029ybe.11
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 02:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=v0aGf6GESKmGuuzroZCK6d4SzanQPWilzAzV1+qKSgM=;
 b=Z0v6Y+wSq4pyl+Q1641+wtOBTgshl6SBfhuUkWX8uKyijVdB85/3ARoRx2Teg36e13
 tm1oQvUq03VVqaI5eFIGpqLRx94cyCEAguUy/EqS6xnbyHKJA0cGX3M/Nfy/tOQALg9Z
 RBISXcmnSRhP7rFDBq2KUnyjAoD1rcQpQq9vPH+/XI639ndRWpsd/JGhTrTfLhQslu1c
 UYEIyJcOR6mVjZfGgDqrQGi7K9lkL/JMx7So2RmEYvhRKBM763mLpW7yUPou4Re8azHV
 J644Wmn7L6kVEex6gxOxAFqeTxWaeTHgZoqmWmvxDDsSx0qSyDSkIA7+NePrIjQagu51
 Nv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=v0aGf6GESKmGuuzroZCK6d4SzanQPWilzAzV1+qKSgM=;
 b=U8rjKMBgP694wwE//+vnCGwGHiKQLYIQWDuGc0b/sn4XDw8bIzKs3df5zlYB77dT07
 pX6uPuq0/qXj+1Uglxy/ONblbhnBQHXf5c3CKAgfQcsnbrIa/28kVqea4k8fXslqYJRM
 t56KJpZRrN34UILtYXRPDoLHewvv6rgtE+r1zuhrNfUwyPkN2jafvWWdOAHPerp60G3r
 uMv+cCeBOQmAA+MprRMtVRx0ttAyb82GTWveCuWBmysOZNUMyaS3UVV6twlxvvGsGLY7
 4HtUoxAs8FR5jm/C2nbKSexfCbLahJ3okJGjHyMQYtFbPIwM43e6bUh3xMKPx9TpHFPQ
 GA8Q==
X-Gm-Message-State: AOAM531wAU6sDBpEhv8STeKA8apkTNgu3m6Q6s5kEsR9wK20UoMev0kG
 AAQtnRC1T+Y2ed8ZQouq31NJ9XdYix1p
X-Google-Smtp-Source: ABdhPJy3aywJ0ct+IKjL8LxDV0+crdoO7BMWrjlfPz6ZeLnP8ySUM05lXS/byJJSxRIEPK24ORT6Uc3gPxv2
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:4552:5bc1:d50a:b3ff])
 (user=tzungbi job=sendgmr) by 2002:a25:ca09:: with SMTP id
 a9mr5463018ybg.48.1611310078441; Fri, 22 Jan 2021 02:07:58 -0800 (PST)
Date: Fri, 22 Jan 2021 18:07:40 +0800
In-Reply-To: <20210122100742.3699128-1-tzungbi@google.com>
Message-Id: <20210122100742.3699128-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20210122100742.3699128-1-tzungbi@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 2/4] ASoC: mediatek: mt8192: use asoc_substream_to_rtd()
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

Uses asoc_substream_to_rtd() helper.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index e7fec2d75e3d..7a1724f5ff4c 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -42,7 +42,7 @@ static const struct snd_pcm_hardware mt8192_afe_hardware = {
 static int mt8192_memif_fs(struct snd_pcm_substream *substream,
 			   unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
@@ -59,7 +59,7 @@ static int mt8192_get_dai_fs(struct mtk_base_afe *afe,
 
 static int mt8192_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_component *component =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
-- 
2.30.0.280.ga3ce27912f-goog

