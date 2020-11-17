Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3349C6369E
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 01:35:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0DD24695
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 01:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dsg/hwWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0DD24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FF66179F;
	Tue, 17 Nov 2020 02:35:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FF66179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605576950;
	bh=2AyZv4I2MebFYcPbsqYHIJ5wozoCBPTQ/0lrhGulJJ4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dsg/hwWVLROnklHNG/6l9Tsyo03d/MszFBZKbFLMQPW2fjlXNMajJebJD4rmOnOo2
	 5K53g4fHRgAGrxVe8K22Lvp3s/Ofb4aaf5HyFtHjPeKYspwc5+GmbkaYM67tQITrBf
	 TLZKNPEhTUjr/ATzOSU9tpJq8m9utri3BbkAWGJo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C94F2F802A9;
	Tue, 17 Nov 2020 02:34:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B04BF8029B; Tue, 17 Nov 2020 02:34:03 +0100 (CET)
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA22BF80168
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 02:33:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA22BF80168
Received: by mail-oi1-f193.google.com with SMTP id f11so7236355oij.6
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 17:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7v83U4ZReYBGAfYOQtO/dOb1BUnzpl5ihuyBngAA7CU=;
 b=n18b0PSErmjEznE0SuBee9UZDVAheZ/iBnZ113JyhAChZL2G46jOeTyf6W3hEIrsVQ
 BqO7sQVNss1wiiS4KJuPePrPtEnnU6P7WtAlSMVKQNjE/T47n5/ginPaI8m3q7DxsB2k
 Mm9wp+pk3md+M30jG8MF/DXfXk7bttceJMTNws5WCKewIuZLp7NJq7OIxn9ejUxxnelG
 PkGuVggBkLI/9CyuEfFuTB9rrmhHa8mDq8RQ4enXa0mswE9Jf3wM5QFMTOGs/nCR2Dz/
 AW38f+yZN+SgMA5epdfO2jEPz6QdaFffv/CaPl2D/w7Kt8794s5oaDQwWhUYcWFqocB5
 CksA==
X-Gm-Message-State: AOAM532pZbmnABAPRjMWs8jvvOJ7PUGnpRhupWPtMbhGthR5lAKHbJVI
 Bt2mRSW+6uy6o+2Cdd/MfQ==
X-Google-Smtp-Source: ABdhPJzyi1Pq1zCgJvRLk5tSHnQcHJ5b4OUkT8Xd8ewHIyt1yL8BzhAIJOyKkE7LJYcFknVYD6ujrA==
X-Received: by 2002:aca:486:: with SMTP id 128mr997880oie.19.1605576834952;
 Mon, 16 Nov 2020 17:33:54 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id j9sm3861325oij.44.2020.11.16.17.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 17:33:54 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/4] ASoC: dt-bindings: Refine 'frame-master' and
 'bitclock-master' type
Date: Mon, 16 Nov 2020 19:33:49 -0600
Message-Id: <20201117013349.2458416-5-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117013349.2458416-1-robh@kernel.org>
References: <20201117013349.2458416-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sameer Pujar <spujar@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Lubomir Rintel <lkundrak@v3.sk>
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

'frame-master' and 'bitclock-master' are only a single phandle, so use
the more specific 'phandle' type definition instead.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/audio-graph-port.yaml         | 6 ++----
 Documentation/devicetree/bindings/sound/simple-card.yaml    | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index c05d5643b10e..7c13ca41d41f 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -43,12 +43,10 @@ properties:
             $ref: /schemas/types.yaml#/definitions/flag
           frame-master:
             description: Indicates dai-link frame master.
-            $ref: /schemas/types.yaml#/definitions/phandle-array
-            maxItems: 1
+            $ref: /schemas/types.yaml#/definitions/phandle
           bitclock-master:
             description: Indicates dai-link bit clock master
-            $ref: /schemas/types.yaml#/definitions/phandle-array
-            maxItems: 1
+            $ref: /schemas/types.yaml#/definitions/phandle
           dai-format:
             description: audio format.
             items:
diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index 35e669020296..45fd9fd9eb54 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -13,13 +13,11 @@ definitions:
 
   frame-master:
     description: Indicates dai-link frame master.
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   bitclock-master:
     description: Indicates dai-link bit clock master
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   frame-inversion:
     description: dai-link uses frame clock inversion
-- 
2.25.1

