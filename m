Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A57C64EC4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 17:46:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5A99118E;
	Mon,  6 Mar 2023 18:45:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5A99118E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678124764;
	bh=xYOEwY5kQ6Gyc2CDS0cFqPCFSmhO4xqRCo5LIOE6eP0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=U4x/oTqy4+MjIGF1vh0EEHQX5XIVaow4UpPYeGE8k7NfTZuJd7EErPPC5J8c2e3C2
	 pusa15cdJVmwaRckk1JGpz4DiDP6E6/H7/haDQrIPgc32Pf5eor3QBOs2/7YHa+TFl
	 7ZTy6jNu07nYCnhCC4aAadA98IeO3rnosOmPv2QU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B655F80529;
	Mon,  6 Mar 2023 18:40:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4DB87F80266; Fri,  3 Mar 2023 11:05:05 +0100 (CET)
Received: from out-61.mta1.migadu.com (out-61.mta1.migadu.com
 [IPv6:2001:41d0:203:375::3d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D99DCF8025A
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2023 11:04:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D99DCF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=NeQJKSuR
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1677837851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GW339QZ/TdS68WJ1B968sS6Y3hjxt+W7MaaQRsWYRFA=;
	b=NeQJKSuRZeOvVv8s+AOytxt9DC0bBF9R7g9zZHzlWCLcVyI4cTyZe972sMygJsVvZnfNxM
	rMatKFHbkVoqqH0zYq5WKDOZxZnWKRTBVkIYiDBezJvGo56BKPY0v0OZ7jRLEbR6RfLVnX
	Ide2ckQru9NXX2DW1LPkHVn2A885RkY=
From: richard.leitner@linux.dev
Date: Fri, 03 Mar 2023 11:04:01 +0100
Subject: [PATCH v2 1/3] ASoC: dt-bindings: maxim,max9867: convert txt
 bindings to yaml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230302-max9867-v2-1-fd2036d5e825@skidata.com>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
In-Reply-To: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ladislav Michl <ladis@linux-mips.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Benjamin Bara <benjamin.bara@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=bwaHQSWKYlK+16GPkCzDPEt1Tmvix8Ku+HlNfeU8Izc=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFIYj0la3Tv++fkUD7Xnu65Z93hO//TLpFpq72GV50qcppMs
 f33+31HKwiDGxSArpshib8zV7p5b9r5SUScXZg4rE8gQBi5OAZjIVDuG/x4M8x+Grp51rnFrdanlxU
 zDzw+sfJ5HbOL8tfXs20729XcZGSZks07INlp45nMy5y5xXX65fO/Jhz6XH+LaoCWpt2SvDTsA
X-Developer-Key: i=richard.leitner@skidata.com; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-MailFrom: richard.leitner@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 3DE3VPPJOWKKIESCHEFYYIIFIOE7UINI
X-Message-ID-Hash: 3DE3VPPJOWKKIESCHEFYYIIFIOE7UINI
X-Mailman-Approved-At: Mon, 06 Mar 2023 17:40:46 +0000
CC: Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Richard Leitner <richard.leitner@skidata.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3DE3VPPJOWKKIESCHEFYYIIFIOE7UINI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Richard Leitner <richard.leitner@skidata.com>

Convert from max9867.txt to maxim,max9867.yaml and add missing
'#sound-dai-cells' property.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 .../devicetree/bindings/sound/max9867.txt          | 17 -------
 .../devicetree/bindings/sound/maxim,max9867.yaml   | 55 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max9867.txt b/Documentation/devicetree/bindings/sound/max9867.txt
deleted file mode 100644
index b8bd914ee697..000000000000
--- a/Documentation/devicetree/bindings/sound/max9867.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-max9867 codec
-
-This device supports I2C mode only.
-
-Required properties:
-
-- compatible : "maxim,max9867"
-- reg : The chip select number on the I2C bus
-
-Example:
-
-&i2c {
-	max9867: max9867@18 {
-		compatible = "maxim,max9867";
-		reg = <0x18>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
new file mode 100644
index 000000000000..74cd163546ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max9867.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX9867 CODEC
+
+description: |
+  This device supports I2C only.
+  Pins on the device (for linking into audio routes):
+      * LOUT
+      * ROUT
+      * LINL
+      * LINR
+      * MICL
+      * MICR
+      * DMICL
+      * DMICR
+
+maintainers:
+  - Ladislav Michl <ladis@linux-mips.org>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max9867
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@18 {
+            compatible = "maxim,max9867";
+            #sound-dai-cells = <0>;
+            reg = <0x18>;
+        };
+    };
+...

-- 
2.39.2

