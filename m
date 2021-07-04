Return-Path: <SRS0=9fdC=L4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19007C07E95
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Jul 2021 15:04:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DE7613E0
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Jul 2021 15:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DE7613E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95BF615E2;
	Sun,  4 Jul 2021 17:03:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95BF615E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625411060;
	bh=r2d7hz6CaMOA9hIyHT7KzsUERCqR5aCXm8BZlxxWcQg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q7L698JLt88MA8+e5bT1xkOu6/6qqqgRAxxT6mYRlbqRrCT0t8SQGGC4og7SQ+a7F
	 oMDQu5duMVaJRHS38YLSa74FhkQtZRYD35Zuiq7p++RQlxCTVmowZ8ho+K1Db+dl5n
	 MGEJmvduQeDSJZjbWJBTtRDkrTKXgv/z3TpsbAqM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3AC4F802BE;
	Sun,  4 Jul 2021 17:02:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6432F80425; Sun,  4 Jul 2021 17:02:40 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17A4DF80259
 for <alsa-devel@alsa-project.org>; Sun,  4 Jul 2021 17:02:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17A4DF80259
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ndzUD/rg"
Received: by mail-lf1-x12f.google.com with SMTP id p16so224975lfc.5
 for <alsa-devel@alsa-project.org>; Sun, 04 Jul 2021 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nOpUy5xHeuJOos9ar9hRXmpZzYmMtFmjPsSjfELVa8A=;
 b=ndzUD/rgkvhBq1IG58jEEg8IZKvma1NB89a5uziZmIsbIxT3MEiTNYvo5OtnRRujCn
 RLN6XOMRapqlr9hF5nUOYiRcPggIZILVvw51/Q+YqR9cbZPWAXwThThgFkxpF+GkEO0G
 RQVd4o2ndoSNs4zc9q7EOCaMZL5tMJWvVogrOlU28Q9MGvyk0ChcAhIsSwSO+n7apbVv
 fo4ofZZr43wmUGU8SX16F4D0wPPvBkGVb4Vp6WLqc4bCBpz/PkjfYrduma76pd+OifmI
 bwupaouPjs2r0408d7mt8+jczb8daTv9OACsQB3Gk0oTB78Gq2iNu9JOA7hehn9Tlr4S
 OOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nOpUy5xHeuJOos9ar9hRXmpZzYmMtFmjPsSjfELVa8A=;
 b=hPvc+hKfms+EHW1B1BBo78jfnPGpSoNIyq5f5MePcqZj06O7WU0kSWeveJYSwrxz3i
 s6OSUBYTCpEkuwsvxl9y9xHshrMuzHeZC/m1L+KHBVqfKMDTfckLsXC62ERGkNf4CrDh
 y1CHu2CTl3ufUA9mxYka4BdmDqncWLnx2DtVMZF1hh4ewpj9Kqq8r7PRUt69EhABeT+e
 uF5SyEogqKxos3Fw+37IHz23iTSDbIQQgBhZUU/Qv+nHGqrO0JsxxowstkcMF9MEjguk
 g7AUMgc2kLHFQ2LJrv790tPoWZXDiQ0hkr94gZywiHHaGzCch8dXYyL3hJTUq6+Oroi1
 KuAw==
X-Gm-Message-State: AOAM531DCbg+/sZO9MKoTOuGn/sQ44FRtd+Aey8NGLFQqXgQXiio3gK9
 pCUQeRtmlxxPlLU9eegM+c8=
X-Google-Smtp-Source: ABdhPJxViP7tCqgW6wU2dgnzo0XeICUptuEXwzf0L4TRojqYvknubl3Utv2E+uZmbXAgVH2GP7sd+Q==
X-Received: by 2002:a05:6512:2086:: with SMTP id
 t6mr7065840lfr.424.1625410956508; 
 Sun, 04 Jul 2021 08:02:36 -0700 (PDT)
Received: from localhost.localdomain (91-155-111-71.elisa-laajakaista.fi.
 [91.155.111.71])
 by smtp.gmail.com with ESMTPSA id k11sm268826lfc.272.2021.07.04.08.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 08:02:35 -0700 (PDT)
From: Peter Ujfalusi <peter.ujfalusi@gmail.com>
To: broonie@kernel.org,
	tony@atomide.com
Subject: [PATCH 2/5] ASoC: dt-bindings: davinci-mcasp: Add compatible string
 for OMAP4
Date: Sun,  4 Jul 2021 18:04:47 +0300
Message-Id: <20210704150450.20106-3-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704150450.20106-1-peter.ujfalusi@gmail.com>
References: <20210704150450.20106-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: hns@goldelico.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 lgirdwood@gmail.com
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

OMAP4 has one McASP instance with single serializer and supporting only
DIT mode.
According to the TRM the DAT port needs to be accessed as specific offset
compared to other devices where access to any part of the DAT region is
valid.
To handle this constraint we need to introduce a new compatiple string for
OMAP4.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index c483dcec01f8..bd863bd69501 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -6,6 +6,7 @@ Required properties:
 	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
 	"ti,am33xx-mcasp-audio"	: for AM33xx platforms (AM33xx, AM43xx, TI81xx)
 	"ti,dra7-mcasp-audio"	: for DRA7xx platforms
+	"ti,omap4-mcasp-audio"	: for OMAP4
 
 - reg : Should contain reg specifiers for the entries in the reg-names property.
 - reg-names : Should contain:
-- 
2.32.0

