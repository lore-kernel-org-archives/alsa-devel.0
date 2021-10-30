Return-Path: <SRS0=dquB=PT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4201DC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 31 Oct 2021 21:42:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1667460FD9
	for <alsa-devel@archiver.kernel.org>; Sun, 31 Oct 2021 21:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1667460FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ixit.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 295AA166A;
	Sun, 31 Oct 2021 22:41:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 295AA166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635716536;
	bh=htUNV3nN9rfSJKHFTABppvdwrhyH2fPZn2kZFTYSLPM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DIhBZeOplkGkMO5GZi2sCFxvkB0+TX5VhdXLDq3oq1GlCTcBBXrSKbYBGm4PqH73d
	 /do5v8ZU6vg6qNgNSw6MGnoWyZXs8jLsTNu07uVXlNw4an4Uhey3iFMQmyeQzUxnrO
	 MG+FAuWalSOMUodJ/1cVLPbWtwCJ4qM0m4HqGVM0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 994ADF80224;
	Sun, 31 Oct 2021 22:41:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DEBA5F80229; Sun, 31 Oct 2021 22:41:14 +0100 (CET)
Received: from ixit.cz (ixit.cz [94.230.151.217])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BE2AF800F8
 for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2021 22:41:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BE2AF800F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz
 header.b="V7deDvKA"
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz
 [89.176.96.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 48A1823D91;
 Sat, 30 Oct 2021 14:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1635596277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FR7paib0uEl/sED3/mdXPaDr+eojob1hVhc0mmDwmaQ=;
 b=V7deDvKAoAijgrcoJYKl84VyHZiVhsRr/EbyTU+Raf8Ldt5fnxv7Rd6cOSnf/c7fLtjuzB
 IKp886hB2PJZHV5oHefoS7ikPAEDRcIt9pdhhMSKNw5tLzI3dkS++bwkRnKdPv7afAYzg8
 /JRelF4Jl4yPQep3mYblWWcf4PxA8B4=
From: David Heidelberg <david@ixit.cz>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, - <kernel@puri.sm>
Subject: [PATCH v2] dt-bindings: sound: gtm601: convert to YAML
Date: Sat, 30 Oct 2021 14:17:52 +0200
Message-Id: <20211030121753.50191-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>,
 phone-devel@vger.kernel.org, ~okias/devicetree@lists.sr.ht
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

Convert GTM601 binding to the YAML format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - add #sound-dai-cells
 - put kernel@puri.sm into maintainers

 .../devicetree/bindings/sound/gtm601.txt      | 19 ----------
 .../devicetree/bindings/sound/gtm601.yaml     | 36 +++++++++++++++++++
 2 files changed, 36 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
 create mode 100644 Documentation/devicetree/bindings/sound/gtm601.yaml

diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
deleted file mode 100644
index efa32a486c4a..000000000000
--- a/Documentation/devicetree/bindings/sound/gtm601.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-GTM601 UMTS modem audio interface CODEC
-
-This device has no configuration interface. The sample rate and channels are
-based on the compatible string
-	"option,gtm601" = 8kHz mono
-	"broadmobi,bm818" = 48KHz stereo
-
-Required properties:
-
-  - compatible : one of
-	"option,gtm601"
-	"broadmobi,bm818"
-
-
-Example:
-
-codec: gtm601_codec {
-	compatible = "option,gtm601";
-};
diff --git a/Documentation/devicetree/bindings/sound/gtm601.yaml b/Documentation/devicetree/bindings/sound/gtm601.yaml
new file mode 100644
index 000000000000..e81a6aa75522
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/gtm601.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/gtm601.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GTM601 UMTS modem audio interface CODEC
+
+maintainers:
+  - kernel@puri.sm
+
+description: >
+  This device has no configuration interface. The sample rate and channels are
+  based on the compatible string
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: broadmobi,bm818
+          - const: option,gtm601
+      - items:
+          - enum:
+              - broadmobi,bm818  # 48 kHz stereo
+              - option,gtm601  # 8 kHz mono
+
+  '#sound-dai-cells':
+    const: 0
+
+additionalProperties: false
+
+examples:
+  - |
+    gtm601_codec {
+        compatible = "option,gtm601";
+    };
-- 
2.33.0

