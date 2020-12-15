Return-Path: <SRS0=TlZm=FT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45423C4361B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 13:06:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A712206B6
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 13:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A712206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAA0C17E5;
	Tue, 15 Dec 2020 14:05:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAA0C17E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608037568;
	bh=VfVfWh096SdAJSzF0GylIrkgHRb944s47gtyKN4vjXo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LWh8BJlpBGu6AaZ13dlxIyY2XvFH/wBHKWofydkLZmphElIFmiH6M1gBCbnslFhOe
	 v9lYC69pz5oISQiQ4eFmyV71F3X4lnXg+a1bQQ7QswpSCB4s63jYAVDshaH5v1S6co
	 blmhE/HA+A8G0LO8QWxnsW6mCuTxhPr6qpWcnvaY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D575BF804B3;
	Tue, 15 Dec 2020 14:04:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9DBDF804BD; Tue, 15 Dec 2020 14:04:27 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2A23F80278
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2020 14:04:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2A23F80278
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cgn3PlV1"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BFD4JVD035358;
 Tue, 15 Dec 2020 07:04:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1608037459;
 bh=kh1JyF3myH9RigEpk6YlMVXN1XqHXg4sQ+Mvc4uclGU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=cgn3PlV1xMKPyBJekMu8/0uS5SpY7Eo4U7o68m/SaHRoxSlFs/nY5cMlryyl2JpsW
 HkLUPRDqUM4eA0lw+FG80s174wKvXI9yLe8MI+oBXGMqbZ9J81vQl+au3KDxkbQ4Hd
 L6XYd1UttQ5C+EWR8MSDb6nbR1pfskYUbvRbwhlU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BFD4JwR087832
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Dec 2020 07:04:19 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Dec 2020 07:04:18 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Dec 2020 07:04:18 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BFD49vM024224;
 Tue, 15 Dec 2020 07:04:16 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <jarkko.nikula@bitmer.com>,
 <robh+dt@kernel.org>
Subject: [PATCH 2/2] ASoC: dt-bindings: ti,
 j721e: Update maintainer and author information
Date: Tue, 15 Dec 2020 15:05:12 +0200
Message-ID: <20201215130512.8753-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215130512.8753-1-peter.ujfalusi@ti.com>
References: <20201215130512.8753-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, jsarha@ti.com, tiwai@suse.com,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

My employment with TI is coming to an end, add the copyright and author comments
as they due and change the maintainer mail address.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 .../devicetree/bindings/sound/ti,j721e-cpb-audio.yaml         | 4 +++-
 .../devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml     | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
index 805da4d6a88e..ec06789b21df 100644
--- a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+# Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/sound/ti,j721e-cpb-audio.yaml#
@@ -7,7 +9,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments J721e Common Processor Board Audio Support
 
 maintainers:
-  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
 
 description: |
   The audio support on the board is using pcm3168a codec connected to McASP10
diff --git a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
index bb780f621628..ee9f960de36b 100644
--- a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+# Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/sound/ti,j721e-cpb-ivi-audio.yaml#
@@ -7,7 +9,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments J721e Common Processor Board Audio Support
 
 maintainers:
-  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
 
 description: |
   The Infotainment board plugs into the Common Processor Board, the support of the
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

