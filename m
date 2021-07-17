Return-Path: <SRS0=ec3H=MJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B76C636CA
	for <alsa-devel@archiver.kernel.org>; Sat, 17 Jul 2021 12:27:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C425A61289
	for <alsa-devel@archiver.kernel.org>; Sat, 17 Jul 2021 12:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C425A61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31504168B;
	Sat, 17 Jul 2021 14:26:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31504168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626524858;
	bh=ESGc8PokAmodL0USFBs/7zg3F6tnVkZg1r8ipZuPP34=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SR4GxiRtLPa/r800RTSM+9ssfcGuZOCYW71HXhIvHhCCZf33e7K37oZLEKcmeMxkq
	 but+Z3lSOJ7vuKdiHQ+cCINS6xYkT2bYDgerO3u9tSH70s7yOIVOpQuJgMVjF0kqd5
	 csLvqNxwE7Z5rD/EbDF5ysVfEMcsfCBMbShmuNs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB065F80229;
	Sat, 17 Jul 2021 14:26:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A9D1F80431; Sat, 17 Jul 2021 14:25:59 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4BA1FF80229
 for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2021 14:25:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BA1FF80229
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RSzTnpMY"
Received: by mail-lf1-x131.google.com with SMTP id i5so20667017lfe.2
 for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2021 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ypbb2fZOaRerFrY+AdWyHL6dgvPr9G9nzcoyo2dI9vs=;
 b=RSzTnpMYDpqadLHPwYbC8EQLrodpl+80mHJYiWevdDIb1V2oPOYnQHQ7OaGgR3Atiq
 xpyBiaktS7dUJPoeBunnid2lGPRiAdTzWGMK7FuKOtqCBv7qreU1AnLrCIPJ6fTK/44+
 Y/jOgALdFKZy1PAjhxmVEUTev8sja9umFBwLFAeYdlSAejJb5jmoFRUB3UT1c9xMXU3g
 5nRhp5aHmWLtRH37wYGXPSNlkuRsbl7+Go6TRRd2N7b0yWKePn5C32y7V3bIXKmsHtW+
 +GsMNR92AOJGkwuNv7dp+CfuQjQcSN6HEPnEY0OJW3arhRNZSBqhPkf5fRpSRxIXIrJt
 46Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ypbb2fZOaRerFrY+AdWyHL6dgvPr9G9nzcoyo2dI9vs=;
 b=Lys/aB4baXZximMXaZy8EKlo7KwnddLg8K7MCRSrdhYSpXVZ137k8qPGoxIz1zdzxO
 GcMpdtWGGurMCQzHNqNI9BtWPNg9YddPgCokEvLzF8Ol0ax/iUVNRsuGKxcRTp2rW86s
 895WEOjVzrQ+J7LnqUv6tQC3wdd2OT/V2QLn3dRY457UaRZ69WYzUC05bhpqfRNYMmcw
 LfyXKt3++so9dwe/rCVabJ1VSs2YKEi5oO2Xi6S3Db9kFSltAADeH9hsbs7wUDxxDtnR
 y9NglLBNUwXdmN4ycc4oB3whV1NSoZyjFJDPB5whE9sQMEXbC7gUmzEHCXXnPE1ZoJx+
 4PSg==
X-Gm-Message-State: AOAM533GJh5WEuq0IjpPbHmk2/HJ1oAP9vgK5M6Knhp3C2MKW3GK66t7
 MK760A+vpI2kaBdUEZtNRlU=
X-Google-Smtp-Source: ABdhPJxBJoZBtAmyLPo2Nj1k9SAAHj225TeXbUiN2/MmD5VD/aJue+n8obkwrk7JkwyLlyQxIJKknQ==
X-Received: by 2002:a05:6512:158b:: with SMTP id
 bp11mr11091561lfb.172.1626524753557; 
 Sat, 17 Jul 2021 05:25:53 -0700 (PDT)
Received: from localhost.localdomain (91-155-111-71.elisa-laajakaista.fi.
 [91.155.111.71])
 by smtp.gmail.com with ESMTPSA id v4sm860087lfi.118.2021.07.17.05.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jul 2021 05:25:52 -0700 (PDT)
From: Peter Ujfalusi <peter.ujfalusi@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 1/3] ASoC: ti: j721e-evm: Fix unbalanced domain activity
 tracking during startup
Date: Sat, 17 Jul 2021 15:28:18 +0300
Message-Id: <20210717122820.1467-2-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717122820.1467-1-peter.ujfalusi@gmail.com>
References: <20210717122820.1467-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
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

In case of an error within j721e_audio_startup() the domain->active must
be decremented to avoid unbalanced counter.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 sound/soc/ti/j721e-evm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index a7c0484d44ec..017c4ad11ca6 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -278,23 +278,29 @@ static int j721e_audio_startup(struct snd_pcm_substream *substream)
 					  j721e_rule_rate, &priv->rate_range,
 					  SNDRV_PCM_HW_PARAM_RATE, -1);
 
-	mutex_unlock(&priv->mutex);
 
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Reset TDM slots to 32 */
 	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 32);
 	if (ret && ret != -ENOTSUPP)
-		return ret;
+		goto out;
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
 		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 0x3, 2, 32);
 		if (ret && ret != -ENOTSUPP)
-			return ret;
+			goto out;
 	}
 
-	return 0;
+	if (ret == -ENOTSUPP)
+		ret = 0;
+out:
+	if (ret)
+		domain->active--;
+	mutex_unlock(&priv->mutex);
+
+	return ret;
 }
 
 static int j721e_audio_hw_params(struct snd_pcm_substream *substream,
-- 
2.32.0

