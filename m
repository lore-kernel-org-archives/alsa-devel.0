Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E033C433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 14:30:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F6460FF0
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 14:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F6460FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D09F01690;
	Wed, 31 Mar 2021 16:29:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D09F01690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617201023;
	bh=HgKPHto8mHkCjyi5ILlZVzWSGyN6br21F84QT/vL+3Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sQyeLC4i4HyQIpzpVQtmaPKVciWmIXoJnh1fB7+40qicOfu0baQ6rpRJTZuY2/oD5
	 PJEKTBMk5x0ta/ALWmVZHz91KvxVQpl/tBk1cI5NtqACXbTUiNuNq+zo9dLDAo5iPx
	 j5YIKDetcMMswWwq0FTmJiC/50XKbvsOtj+fKoD4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 191B5F8032D;
	Wed, 31 Mar 2021 16:28:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13D00F8020C; Wed, 31 Mar 2021 16:28:06 +0200 (CEST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3BAEF8016E
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 16:28:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3BAEF8016E
Received: by mail-ot1-f45.google.com with SMTP id
 y19-20020a0568301d93b02901b9f88a238eso19089987oti.11
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 07:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a5L9Gfl5bF9CWxUCr8sVjvHZWCe8RrXgbQdGFig1nYs=;
 b=FVobW2c0EeXFs2umQ4Z0CAd+jbSkkVvJbQLP45q9x9z4yIsQbGaZxvvl+N/CEC9GQ0
 8MstQI3EhS5phzuxONpHaUwmll7yXgBLwm4DpQVNfWjy/9eszd2CTxOjmYG41yS2yMVs
 GbJSPidyu20ppy9fVOz4iqTRbekC4oPVW9ueoylKk20CUaxlqM0NnrQxHjLVDtvvQWOZ
 8KdVtblsmePmqeit/aAbu90FOQJjq8iQG2GN14BJgcxQOn5Pzw/GuPlk0drx+27HckLe
 Fw8oztz6T+IGKFux9WAqjbvrh+V5BNQ80urP8AAk4ENIlSqmC0S4QftaFx9m2RYIyOAA
 x3Ag==
X-Gm-Message-State: AOAM531CeszEqP43ZzIWzmXTI8mTOwmRUMQ5yHbm6974UG1yJ27B8w19
 vkFb38E6t13+7aCJ1NkUQA==
X-Google-Smtp-Source: ABdhPJyOs4V5V3Q3Hn8BauTqhypFGiAuWczQrsYjG6DCb8QtcbtJDsu+mU39XCkUHElkU3lAcJXO9g==
X-Received: by 2002:a9d:68d7:: with SMTP id i23mr3005001oto.133.1617200879927; 
 Wed, 31 Mar 2021 07:27:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id v136sm451146oie.15.2021.03.31.07.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 07:27:56 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] ASoC: dt-bindings: socionext: Use audio-graph-port
 schema
Date: Wed, 31 Mar 2021 09:27:48 -0500
Message-Id: <20210331142748.2163272-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210331142748.2163272-1-robh@kernel.org>
References: <20210331142748.2163272-1-robh@kernel.org>
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

