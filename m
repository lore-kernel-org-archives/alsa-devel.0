Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F043C04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 09:36:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59272611EE
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 09:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59272611EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71EA0166D;
	Mon, 24 May 2021 11:35:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71EA0166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621848964;
	bh=8a+ezmFdyK1wfbfVsWAGWnpJ+e8v5mYFC2u8x6hWa6g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fRGDcsGtQw9n9/GRqxhsbHQQK/n9p3r1q4vum1LQVjzzyHPVBbU2gc/InMdlJRVwR
	 mppRRwPZ1tdEB6ktme+iQ6P7c1z5l7W1C3mW9RbDoCAq1JtYXeK/fjTwvIsyU7rzD3
	 kHXB6oNIsFuDSN4IuHo65xz5l+ZZqsJmF66hO2Lg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC835F8021D;
	Mon, 24 May 2021 11:35:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B781F8022B; Mon, 24 May 2021 11:35:12 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CC9BF80149
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 11:35:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CC9BF80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="oQTQ2EZX"
Received: by mail-wm1-x334.google.com with SMTP id
 z19-20020a7bc7d30000b029017521c1fb75so1063376wmk.0
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62PaeGm/tBJ//uGzYHNPfzzgrMdbT7h0TiIpVr9Cdhw=;
 b=oQTQ2EZXiqyQF23C+25JhSVHZpnMy1UlC/iAjYjDU735seJre1JC5UDfqK3Fphitf2
 LPpLz98GFdYTpeyVUHrCPkQHSQORehwA8nzL57nF56H/13kWRsF8F2Qij7/3LMbZ+XSV
 TPLUkOr73fIjwcGwCmmtcQf4XlAjAUjkWppdeJsdqG7QzqcuDvgl4KLAeYRKZTST5BLs
 uUzvxmewHR3agPx27h0hVMcAenRJeFAn2UqT38E7VPTwCTzI9j+ifDlU6g0IqrJDgLBr
 a6rPKGXu9TueSWkFkZMs/kI7TucgAe786TbD+uYsJoe3KHwH6KwWPe4BfpFpfCovJCQw
 6Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62PaeGm/tBJ//uGzYHNPfzzgrMdbT7h0TiIpVr9Cdhw=;
 b=XQLPVuEDEy38X1frVnshfW/bKFOYeyXmRKe3E7wyR6tgS8LuVAmE7uu8b6gzcxyqOt
 okbE4wLNNfMcWQPZzcrLJSEjkfBtliQTBRSZUAFUQ2IUIqGoX/mY8chZTz5P9A+0Ca4d
 Jo+zvgPI2lAEQIiHkz6LHt1QnAdN/8O7hsphlnJAiU2u3GICaWZruM+vf2ILF7e4X6Nn
 5dnV71wpQ52lmUOwa844TdlHc5JVud1K7Bf1LFFEsx5o1q7QqA42Jiz1WKPsfE00H+u9
 AsmVha/Wt+2J5hJKRoHs1us11IpRwnInXEhnOSK11zRKi59K+iNhqeCgHHkyTTcub2ae
 CZcQ==
X-Gm-Message-State: AOAM531/aDeINvVhfsGKiROUPNBBgiiOJZPrGRBFT3m6w7HbxD5Ih/CY
 UaEVZApBfvHfqnDINis7pojK6Q==
X-Google-Smtp-Source: ABdhPJxHI5iSFZNJeQGs9c4fFwSfr366nLRLlKUkhGpSdqZSTLuYpYtZnagbzMC1XSzVri4QPcPqFQ==
X-Received: by 2002:a05:600c:35cc:: with SMTP id
 r12mr18373680wmq.157.1621848903248; 
 Mon, 24 May 2021 02:35:03 -0700 (PDT)
Received: from jackdaw.baylibre.com (82-65-169-74.subs.proxad.net.
 [82.65.169.74])
 by smtp.googlemail.com with ESMTPSA id p6sm7317267wma.4.2021.05.24.02.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 02:35:02 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: meson: gx-card: fix sound-dai dt schema
Date: Mon, 24 May 2021 11:34:48 +0200
Message-Id: <20210524093448.357140-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>
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

There is a fair amount of warnings when running 'make dtbs_check' with
amlogic,gx-sound-card.yaml.

Ex:
arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0:1: missing phandle tag in 0
arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0:2: missing phandle tag in 0
arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0: [66, 0, 0] is too long

The reason is that the sound-dai phandle provided has cells, and in such
case the schema should use 'phandle-array' instead of 'phandle'.

Fixes: fd00366b8e41 ("ASoC: meson: gx: add sound card dt-binding documentation")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/amlogic,gx-sound-card.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
index db61f0731a20..2e35aeaa8781 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
@@ -57,7 +57,7 @@ patternProperties:
           rate
 
       sound-dai:
-        $ref: /schemas/types.yaml#/definitions/phandle
+        $ref: /schemas/types.yaml#/definitions/phandle-array
         description: phandle of the CPU DAI
 
     patternProperties:
@@ -71,7 +71,7 @@ patternProperties:
 
         properties:
           sound-dai:
-            $ref: /schemas/types.yaml#/definitions/phandle
+            $ref: /schemas/types.yaml#/definitions/phandle-array
             description: phandle of the codec DAI
 
         required:
-- 
2.32.0.rc0

