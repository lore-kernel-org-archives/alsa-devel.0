Return-Path: <SRS0=JRP5=NQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB27EC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 06:20:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B9F61184
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 06:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40B9F61184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 800EE1689;
	Wed, 25 Aug 2021 08:19:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 800EE1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629872423;
	bh=jZBn775/JDtPZkTlSM+vfKQAx5C9ObiQDo4tQJtoTPA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sT9KCTbiLo/49czCkcdT2qFsuoG/rETrvS27UByjWTymsRrNRYnlVWck/GUu3gBj9
	 uO2BtyZbqIQzc3BhAL8nGXPXDwzI08OJ+MfzDiF8fS14K9ofYqclekLt0dGihq2TtG
	 PRFcisSUXh/VHSEJm5fjuIoIcOgQ10H21NmPiSf0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2980F80240;
	Wed, 25 Aug 2021 08:18:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B44B0F802C4; Sat, 21 Aug 2021 09:56:00 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC308F8016B
 for <alsa-devel@alsa-project.org>; Sat, 21 Aug 2021 09:55:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC308F8016B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com
 header.i=@timesys-com.20150623.gappssmtp.com header.b="yrjAQb4s"
Received: by mail-ej1-x631.google.com with SMTP id lo4so24875599ejb.7
 for <alsa-devel@alsa-project.org>; Sat, 21 Aug 2021 00:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tm7ebvKIHJ7AeKUA9v8CHuxGhcPcPAtO1oMTAzgC4Ns=;
 b=yrjAQb4sQls5zrVRO6QKDLxfW88552VD/xwFSLL8Ep72lTP49xcgJdBsiOM+BkAUt4
 BKW1nWPgndTVIORGptVpZHHLZnN8kxfR9e9bGAZjARlwWlLeZXny2h5AsLzgZAFKXokp
 9aJvHSOKtNbK08OUnj9bC2QhyJ4+xKOJKrPjLLArKu5kEy6dhQhOj3CyrVK398QjqJCX
 PvDkPS59brVuNM9GPOe7JGYiZ9LOUf67ZNztgFXpa7vKWZ9OSpAN9rU2DvV4BnNU2Ju7
 eAR0/2uZDF+EDTNscdyqHGvTkBK8NEBA8LkRHzxG6V6+k1CV79RMSY/3hnqLWDKEXljg
 Herg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tm7ebvKIHJ7AeKUA9v8CHuxGhcPcPAtO1oMTAzgC4Ns=;
 b=q4gsSVFvDnm6CcWsa7qPqFUbg0g6Td1q+Ws4GcT65oBxq2Wc1fkbGnw5osvKopc0dS
 zMDqpEWnsc/hg/wZDdgNAltrooNasEVXZV8I3EcNYRjeQbDET/PZADO6L8sLI4N0mChP
 cD44m/EqNqyzEg7bJ9bVAM+Dvy6gq7PcP4xFLbPZNTyP5RDq2R3UO3t5kbdz8UI8Spso
 1VdmoXnVSxt3GnAfzwZfBEzApM7Kgq/a5oqyOQJQU73MPizDxDqdGAhaD5iVZLztOESL
 FQMNdmsQ71igg4QFtPweKZ88z3C+Ee9UNJPJz5m9ChZ7GEeoWwqaL6dtP5iW/G7k4vIH
 +bzA==
X-Gm-Message-State: AOAM531WbG2zMQHaIrQL+mOslnha2pDGtha5BsRKXnOHGm7/wkeoByIA
 OmTEB3/uuZeki2jmlRl3kTLFrKislch0919e
X-Google-Smtp-Source: ABdhPJy9RqkpkFLQRIqmvUSK9b+WXMFBfZx1NKQIY875cimxfPjLjkowKuC9d88LL1hWwrQVcee1pA==
X-Received: by 2002:a17:906:a852:: with SMTP id
 dx18mr26920839ejb.458.1629532551433; 
 Sat, 21 Aug 2021 00:55:51 -0700 (PDT)
Received: from dfj.1.1.1.1 (host-95-246-39-126.retail.telecomitalia.it.
 [95.246.39.126])
 by smtp.gmail.com with ESMTPSA id i11sm4848914edu.97.2021.08.21.00.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Aug 2021 00:55:51 -0700 (PDT)
From: Angelo Dureghello <angelo.dureghello@timesys.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Subject: [RESEND 2/3] dt-bindings: add compatible vendor prefix for CUI Devices
Date: Sat, 21 Aug 2021 09:53:53 +0200
Message-Id: <20210821075354.4140327-2-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210821075354.4140327-1-angelo.dureghello@timesys.com>
References: <20210821075354.4140327-1-angelo.dureghello@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Aug 2021 08:18:36 +0200
Cc: ricard.wanderlof@axis.com,
 Angelo Dureghello <angelo.dureghello@timesys.com>
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

Add vendor prefix for CUI Devices.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 07fb0d25fc15..ed4f66ec9a65 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -271,6 +271,8 @@ patternProperties:
     description: Shenzen Chuangsiqi Technology Co.,Ltd.
   "^cubietech,.*":
     description: Cubietech, Ltd.
+  "^cui,.*":
+    description: CUI Devices
   "^cypress,.*":
     description: Cypress Semiconductor Corporation
   "^cznic,.*":
-- 
2.32.0

