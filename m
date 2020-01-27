Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3A0C3F68F
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:19:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F6621D7E
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qp/EYkFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F6621D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F40C166D;
	Mon, 27 Jan 2020 10:18:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F40C166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580116752;
	bh=GT2R7H6oQUcNafWKBzS2qraqrP14dTy6F32XE1TD1/w=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qp/EYkFDmfzwkV4aIcVaD4KsUpnNzfpz1OHGmOMnW7ZFAuCBkfrIPeH/YHQvkz2qf
	 ncMtJ4cANtzEgUOUBQfY7Hx4cRNLl4qfmvW0gLq3XQyj/kyLaOFxgLyXQ6AQTYN088
	 R7hrIvGl0FD8/S/WseafyFHhEBQnCdzLuS75AE6o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E868AF80085;
	Mon, 27 Jan 2020 10:18:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EAF9DF8021E; Mon, 27 Jan 2020 10:18:19 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF781F80085
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 10:18:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF781F80085
Received: from localhost.localdomain
 (p200300CB87166A002102C4F03A4721D7.dip0.t-ipconnect.de
 [IPv6:2003:cb:8716:6a00:2102:c4f0:3a47:21d7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 561FB29142A;
 Mon, 27 Jan 2020 09:18:15 +0000 (GMT)
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: alsa-devel@alsa-project.org
Date: Mon, 27 Jan 2020 10:18:06 +0100
Message-Id: <20200127091806.11403-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 dafna.hirschfeld@collabora.com, bleung@chromium.org, dafna3@gmail.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 enric.balletbo@collabora.com, helen.koike@collabora.com, robh+dt@kernel.org,
 broonie@kernel.org, groeck@chromium.org, kernel@collabora.com,
 ezequiel@collabora.com, cychiang@chromium.org
Subject: [alsa-devel] [PATCH] dt-bindings: Convert the binding file google,
	cros-ec-codec.txt to yaml format.
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This was tested and verified with:
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 .../bindings/sound/google,cros-ec-codec.txt   | 44 -------------
 .../bindings/sound/google,cros-ec-codec.yaml  | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
deleted file mode 100644
index 8ca52dcc5572..000000000000
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Audio codec controlled by ChromeOS EC
-
-Google's ChromeOS EC codec is a digital mic codec provided by the
-Embedded Controller (EC) and is controlled via a host-command interface.
-
-An EC codec node should only be found as a sub-node of the EC node (see
-Documentation/devicetree/bindings/mfd/cros-ec.txt).
-
-Required properties:
-- compatible: Must contain "google,cros-ec-codec"
-- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
-
-Optional properties:
-- reg: Pysical base address and length of shared memory region from EC.
-       It contains 3 unsigned 32-bit integer.  The first 2 integers
-       combine to become an unsigned 64-bit physical address.  The last
-       one integer is length of the shared memory.
-- memory-region: Shared memory region to EC.  A "shared-dma-pool".  See
-                 ../reserved-memory/reserved-memory.txt for details.
-
-Example:
-
-{
-	...
-
-	reserved_mem: reserved_mem {
-		compatible = "shared-dma-pool";
-		reg = <0 0x52800000 0 0x100000>;
-		no-map;
-	};
-}
-
-cros-ec@0 {
-	compatible = "google,cros-ec-spi";
-
-	...
-
-	cros_ec_codec: ec-codec {
-		compatible = "google,cros-ec-codec";
-		#sound-dai-cells = <1>;
-		reg = <0x0 0x10500000 0x80000>;
-		memory-region = <&reserved_mem>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
new file mode 100644
index 000000000000..94a85d0cbf43
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/google,cros-ec-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Audio codec controlled by ChromeOS EC
+
+maintainers:
+  - Cheng-Yi Chiang <cychiang@chromium.org>
+
+description: |
+  Google's ChromeOS EC codec is a digital mic codec provided by the
+  Embedded Controller (EC) and is controlled via a host-command interface.
+  An EC codec node should only be found as a sub-node of the EC node (see
+  Documentation/devicetree/bindings/mfd/cros-ec.txt).
+
+properties:
+  compatible:
+    const: google,cros-ec-codec
+
+  "#sound-dai-cells":
+    const: 1
+
+  reg:
+    items:
+      - description: |
+          Physical base address and length of shared memory region from EC.
+          It contains 3 unsigned 32-bit integer. The first 2 integers
+          combine to become an unsigned 64-bit physical address.
+          The last one integer is the length of the shared memory.
+
+  memory-region:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Shared memory region to EC.  A "shared-dma-pool".
+      See ../reserved-memory/reserved-memory.txt for details.
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    reserved_mem: reserved_mem {
+        compatible = "shared-dma-pool";
+        reg = <0 0x52800000 0 0x100000>;
+        no-map;
+    };
+    cros-ec@0 {
+        compatible = "google,cros-ec-spi";
+        #address-cells = <2>;
+        #size-cells = <1>;
+        cros_ec_codec: ec-codec {
+            compatible = "google,cros-ec-codec";
+            #sound-dai-cells = <1>;
+            reg = <0x0 0x10500000 0x80000>;
+            memory-region = <&reserved_mem>;
+        };
+    };
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
