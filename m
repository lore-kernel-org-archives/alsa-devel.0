Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC32DC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 13:53:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2000A16A6;
	Fri, 22 Apr 2022 15:52:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2000A16A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650635620;
	bh=G+PPVeRROOZJ2oRYCx7dCLmO+wdcmDUBOAO6SGx1uYs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SDpp1uKvNwLPTIQpuiLtDKlDypWKLHEFQamRJNaLZVlVbB0+wIw54EMaiU0SjUKE/
	 5YwYE093Qr9VUvJMbeTUl/8M1kKoSOZi+sYqYHb2FLZlMwJ3NiMIMkoBVHmNUUnIhA
	 Y0BazhMavEXV6SADqD16LoMhMy/Y2xhgi5rjUSNE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77158F8087D;
	Fri, 22 Apr 2022 15:32:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E33F0F80128; Wed, 20 Apr 2022 21:47:58 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B482F800C1
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 21:47:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B482F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="eyyb9MlM"
Received: by mail-il1-x135.google.com with SMTP id b5so1707073ile.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1p1O4XA0YTs/pERSSWY2OpdFQqDv87mRBIy7EhYGPYA=;
 b=eyyb9MlML7cIBV0IgT5gbiL1y42f1VSb4mQvFiWaJ2aUoZ7zOSbPvKDVDRsP3cVmHL
 KqwYxg5rxj5wE0S5DRbYzGUfhIQF4cZNMjh/KkPl0+aooZNXaISwRf2c1Qv+d1eFl/wr
 kfIzA5ZaIqD4FKOZu4k++SJpseC37e9bzdEBuuEXpW3o4GNGGhnbkkIK0CfotDWZoZvl
 os233gF59h3dL8KA8FLpJWC9cc4Mu18IfyBc5e08LZKAEPbduK1jFUn1X5N1O3Rz+KTX
 Gn7I8BAF5i/jKtdaQDei1mkDV37Xg7sVBqhXjTVk22BlSOUlOUQ63Kvv3rTrje3toyZ/
 C5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1p1O4XA0YTs/pERSSWY2OpdFQqDv87mRBIy7EhYGPYA=;
 b=mLgCg0sr+gc6yfhHTMarBxilUA0ZQJkFHmLQDtEKCTB6jPw5SYrb7HMgwXNq3YNsKC
 89iH3La5OUVrqa8lMhSL/qsXKpJWihQDKJ937WdA19nPjAtY+7u28JvO/O7zAeaLeakp
 VZEmJSgW8ZKfHbeZuNiaZnkmW1v3snQo+2RIjg3NtGz1THzSj+aDVixuhD85USIuonr+
 j7oyqfDWY278JGRnH4j4r/qudzHWDRCFEYZ0EZZJnHnTORosXDHhnGyMTtIDc8niYo6o
 bbWyf3l2dCUU5MK+vJBtsNNiaZ9gK2jLQwHkr4acUWva5PgEllCF0G/z1ZQRAVAY45ur
 IXyA==
X-Gm-Message-State: AOAM533jJe2m5chwtKE8/jl7BHRK0v00DdpNqNi6TBplTr6y/OZpI4op
 812vqAXBgOfS0ulZA0KfipI=
X-Google-Smtp-Source: ABdhPJzR32OtX/2D92iQzvs1rNdKUjMl6ZtnoGCfMT6B7JiQVlPr0J+HeSaj09EY+foo/mjkhQX01A==
X-Received: by 2002:a05:6e02:1745:b0:2cc:5854:744b with SMTP id
 y5-20020a056e02174500b002cc5854744bmr2634037ill.237.1650484069422; 
 Wed, 20 Apr 2022 12:47:49 -0700 (PDT)
Received: from fedora.. (cpe-65-29-252-111.wi.res.rr.com. [65.29.252.111])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a056e02011200b002cbe6ce18e5sm10680977ilm.40.2022.04.20.12.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Apr 2022 12:47:49 -0700 (PDT)
From: Daniel Kaehn <kaehndan@gmail.com>
To: tiwai@suse.com
Subject: [PATCH 1/2] dt-bindings: sound: Add generic serial MIDI device
Date: Wed, 20 Apr 2022 14:47:46 -0500
Message-Id: <20220420194747.490542-2-kaehndan@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420194747.490542-1-kaehndan@gmail.com>
References: <20220420194747.490542-1-kaehndan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 Apr 2022 15:31:40 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org
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

Adds dt-binding for snd-serial-generic serial MIDI driver

Signed-off-by: Daniel Kaehn <kaehndan@gmail.com>
---
 .../devicetree/bindings/sound/serialmidi.yaml | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/serialmidi.yaml

diff --git a/Documentation/devicetree/bindings/sound/serialmidi.yaml b/Documentation/devicetree/bindings/sound/serialmidi.yaml
new file mode 100644
index 000000000000..900c57c1cfca
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/serialmidi.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/serialmidi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Serial MIDI Device
+
+maintainers:
+  - Daniel Kaehn <kaehndan@gmail.com>
+
+description: |
+  Generic MIDI interface using a serial device. Can only be set to use standard speeds
+  corresponding to supported baud rates of the underlying serial device. If standard MIDI
+  speed of 3.125 kBaud is needed, configure the clocks of the underlying serial device
+  so that a requested speed of 3.840 kBaud resuts in the standard MIDI baud rate.
+
+properties:
+  compatible:
+    const: serialmidi
+
+  speed:
+    maxItems: 1
+    description: |
+      Speed to set the serial port to when the MIDI device is opened.
+      If not specified, the underlying serial device is allowed to use its configured default speed.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+        midi {
+            compatible = "serialmidi";
+            speed = <38400>;
+        };
+    };
-- 
2.32.0

