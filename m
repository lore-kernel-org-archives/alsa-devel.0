Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED36AC433C1
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 16:38:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A996199F
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 16:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A996199F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 872B3166C;
	Tue, 23 Mar 2021 17:37:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 872B3166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616517518;
	bh=HgKPHto8mHkCjyi5ILlZVzWSGyN6br21F84QT/vL+3Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vlDrvCmbdYwhUp5YsbbFzOk9S15FR0kQW0NCWZdAdlTpiDQPugT4z3RuSMcrYLxlo
	 611Xg8WLgA7kuFe9x1iKwjAkKfFyUGfg59pmwaWCl/NQHSLXXIkDM9Q/B7bJbjgXri
	 i70F32dgsgKNNNc+/upgiFZhFH7wttfa2RmJufSs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68007F80279;
	Tue, 23 Mar 2021 17:36:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3730FF80155; Tue, 23 Mar 2021 17:36:53 +0100 (CET)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60F68F80155
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 17:36:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60F68F80155
Received: by mail-il1-f179.google.com with SMTP id r8so18694819ilo.8
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 09:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a5L9Gfl5bF9CWxUCr8sVjvHZWCe8RrXgbQdGFig1nYs=;
 b=L3WUvRdIdh3H53mB8cZah7nclCHU/adIAe3mHSis3B8aIV6wVtHR3zEDOsESNRmkJ8
 wfMFYyI4Ec5AV+KHpSV7Esiyd1qV3V+qdfJ41HeXCEiLVQ+Qnx8aapYtpaKhFrPwN9xS
 ch9gIGXDQcHMeIpLO7/EOrnkjCR0hzKhgBhcw7AhEsSiA+UMjbkyFLldazF+rzJI3Ws4
 3R3/Tu5GyW5swtaQBWLg7UUvNIlAgb0YusAgonwCkVPkJq7hkDDuPvyYHDRVcYCAulVr
 e4SAolAHkdpGuej6gkYabgWIXmQqlRpq1Ol10phfelwGHlmpqFBCHQN0aSIfIiptRoUW
 FVhg==
X-Gm-Message-State: AOAM533pi8eJLE0goZxf019poQp9Kb1rHdvgDB7BCoiCZgS7hbchkMq/
 9X9sPDpOicp+HbHkkLJ2QA==
X-Google-Smtp-Source: ABdhPJzYv870/Z54kIEaV2byBDMaU5dDne7KIgxJcZeYgzfBYc+YJkBPqXyu1dPOH2Uoc8m3Hvw/Uw==
X-Received: by 2002:a92:194a:: with SMTP id e10mr5753956ilm.213.1616517406984; 
 Tue, 23 Mar 2021 09:36:46 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
 by smtp.googlemail.com with ESMTPSA id r18sm9771268ilj.86.2021.03.23.09.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Mar 2021 09:36:46 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: dt-bindings: socionext: Use audio-graph-port schema
Date: Tue, 23 Mar 2021 10:36:34 -0600
Message-Id: <20210323163634.877511-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210323163634.877511-1-robh@kernel.org>
References: <20210323163634.877511-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Lubomir Rintel <lkundrak@v3.sk>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org
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

Convert the Socionext audio schemas to use audio-graph-port.yaml schema
for 'port' nodes.

The number and numbering of port nodes should be documented, but is not.
Leave a FIXME here so others don't copy.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/socionext,uniphier-aio.yaml | 8 +++-----
 .../bindings/sound/socionext,uniphier-evea.yaml           | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml b/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
index 4987eb91f2ab..55ae198220f4 100644
--- a/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
+++ b/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
@@ -46,11 +46,9 @@ properties:
 
 patternProperties:
   "^port@[0-9]$":
-    type: object
-    properties:
-      endpoint: true
-    required:
-      - endpoint
+    description: FIXME, Need to define what each port is.
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
index 228168f685cf..48ddfcbbcbae 100644
--- a/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
+++ b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
@@ -40,11 +40,9 @@ properties:
 
 patternProperties:
   "^port@[0-9]$":
-    type: object
-    properties:
-      endpoint: true
-    required:
-      - endpoint
+    description: FIXME, Need to define what each port is.
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
 
 additionalProperties: false
 
-- 
2.27.0

