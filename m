Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C4CC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 21:21:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA1564F0B
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 21:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA1564F0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E30E01681;
	Wed, 24 Feb 2021 22:20:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E30E01681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614201679;
	bh=Ce1JU/6X3WVIRarIjUQz/SfAfHyQuXxSl8iLiz+sv0A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1Y44b+l1ffYpL6qCZdax7Qy7cs6nSTB7bFQt4rm7HHJ8C5P0v7ORBO+i370TzQjB
	 RKze5MLTSJc4wJuKndkjj52WcRXrLoYcAFiMAy1Gzad0bOAjYRBewzGuhIYQlrLSiu
	 gPLecPAYfjIPKBQtlOVcDFCgvlt0e6Y/t9A+T7Vk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26949F8025E;
	Wed, 24 Feb 2021 22:19:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93907F80249; Wed, 24 Feb 2021 22:19:33 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C1EBF80129
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 22:19:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C1EBF80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="R5QRo2B2"
Received: by mail-lf1-x12d.google.com with SMTP id u4so5286652lfs.0
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 13:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bNR1KI2pRCEa4jeqkN89XkpppOEohChHDZHILgnnwVE=;
 b=R5QRo2B2oMgyIpvYMaARSzalCqNsNEewkuyK8GqD+9Hxagz9bsLLkL3DqooEcgoPIS
 YSn7T5HdPxdYPFyANbYByP47cXHJ+b5zszT61j4rpTxLntkL/dnP9ipBpyOrZFxkHEFn
 o/db+R45qrMfzJPxh8dHJzvycEmdduga3fFDd6jQXxpjYOQ/L3cfT+FZVVCONeyeZxR9
 /0OjgZkoBXHeBv1bYlTPezKforNeaHfM6frb60ElrEuYgOj/J6LzkRcNT1cX/Lm0f/GZ
 2uIXNDIPmpLtYNFoihpO8xrWwxcWbe0ohfc6IAt2doig6ZIQr0c1+DAhN+LQ0JErOTho
 D7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bNR1KI2pRCEa4jeqkN89XkpppOEohChHDZHILgnnwVE=;
 b=cpS4zdSldpmTmCPNLrfT34yVMMpGcbuz39QLixvlf0h+ztmDOuf+WfP1IG16kacPpE
 BfsNz7Txa6S14dZCeQFXJLgqbo1f4P2CgrnCzRKh/da1+ZXjYD9gh+nIxIlCLjol4PGa
 mEak8EvUBK1r0RLt7dXIPzVpwYMOk7tEzboCEFbJxa4dGp1EdJwSydeb7iCoUWcidhQK
 bZW+puoftthtZ1lsWr5QOSOIOVXmoJMhDHrQ9CNc3rG2NOztzs49fe1AXQ7bUhqkwTlA
 ReCR3qYsbfGBV7XgSHjjkC6xcXplAVkKyaCQCOWRIkwGZ68uqdbzJajX8ucXnx8QXjwl
 BLQQ==
X-Gm-Message-State: AOAM530o+1s0BPRaH8gpFkwMv3di2c9UyMZYBrunRQO4hzwJdyIgQF+o
 uOQY839edfFf9JdSdvTbp0Y=
X-Google-Smtp-Source: ABdhPJzQNo1uob0y8vJmKLbHqTEr+Oufmvez2ZwpS3vFdPnaJYuPf7kaRx3OTf4yuzXcJTaxneSGTQ==
X-Received: by 2002:ac2:420b:: with SMTP id y11mr19798338lfh.215.1614201569046; 
 Wed, 24 Feb 2021 13:19:29 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se.
 [98.128.229.129])
 by smtp.gmail.com with ESMTPSA id w26sm717116lfr.186.2021.02.24.13.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 13:19:28 -0800 (PST)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 4/4] ASoc: rt5631: Constify static struct coeff_clk_div
Date: Wed, 24 Feb 2021 22:19:18 +0100
Message-Id: <20210224211918.39109-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
References: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, linux-kernel@vger.kernel.org
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

coeff_div is only read from, so make it const to show the intent.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/codecs/rt5631.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 653da3eaf355..afc1305a7fa5 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1283,7 +1283,7 @@ static const struct pll_div codec_slave_pll_div[] = {
 	{3072000,  12288000,  0x0a90},
 };
 
-static struct coeff_clk_div coeff_div[] = {
+static const struct coeff_clk_div coeff_div[] = {
 	/* sysclk is 256fs */
 	{2048000,  8000 * 32,  8000, 0x1000},
 	{2048000,  8000 * 64,  8000, 0x0000},
-- 
2.30.1

