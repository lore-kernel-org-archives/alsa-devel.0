Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC52C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 13:56:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A26D517F2;
	Fri, 22 Apr 2022 15:56:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A26D517F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650635812;
	bh=d7mfbZ5uvC+DwXS4kVHR4daklfyMX/mLdPH7270DjmU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iOt2O2H+Z8F4Lp1rt0e/HeFZjJ063XajsZghhvOLkc2rpM8cQtphMKLaUh2oqPWFB
	 wTxwrCc74z+vG2i1o5Oi4CaJ/cd/koHQu42OtnLGj1IYB5+cqobaWVQbN0nk8JLwC2
	 2HPvadZJSxg6QKFLTdP31gQ+yz080PvFEm58lo2c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 505C2F80C75;
	Fri, 22 Apr 2022 15:32:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AFBEDF80539; Thu, 21 Apr 2022 19:25:29 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64FDCF80534
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 19:25:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64FDCF80534
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="h5WmL172"
Received: by mail-il1-x12b.google.com with SMTP id b5so3509964ile.0
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wi2IQKyKSRRZggiHTtlLgyaAmdAA44lq7Ane7/mRjtA=;
 b=h5WmL172711rTzDKMaGLM1D9C9SlQpUnNp8h2CBLUQPJfOKYrld1VwtFOEELiuHPJx
 OTw6S7F7daVjv+sueLc7nv4kyhieQXIFOc4FEpcfVqWJdVHgG6IpVESQOkSUF4SJyMhd
 5tzsv500efhqyMZwQc8aWuMTUGdq6lkio5qpOg4utHRhTJgpRTvTzAREHFZCR40pkK2w
 QVOcLviz22SVliO9TRaE9hsqnhJv2eMSfYsue9RbPWZhyKBvbE23bPmERh16+zn8Dce9
 iDktSJD620nQNpFoasMmbqzvXq5msJSzvtg7zPx5fAi2gi5/I4uUhIl6BccXm+AAIMAu
 1M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wi2IQKyKSRRZggiHTtlLgyaAmdAA44lq7Ane7/mRjtA=;
 b=j9UxldeMwZiufJwgrNVYOuupgS5J+bpEbcLIO831uyM7Ja9HG4lrGXQzxMduuKbV26
 2Y3zbg4oPkb9GG3S3rEePrwYpmYc8Tj6VdW7Yb8+abPHV1QvslblGfX0asm9qdilDWiK
 3/rce2ZVHmVJ6+0GHQhQ4d9LX4VNsiAnvmwVVIzHcQQ8E031fKDyfNTTj/5wijHuhUGY
 QR0sTtNbQ24EeMsT9pI5G2qJSqT4COpzKyZBo/p8hs3GgVRG31GB2rtNZeOQWXdCwDai
 OUNg4Onp324/5SRfZtR/99QaFG0ScL9Ud7IA5j0bd2VQyRJZy5+HyuYcIvTO/hW01tmb
 oCMA==
X-Gm-Message-State: AOAM530lJc2x/nOpCBZpiLgCUbrESDlOMcSRJuEz8weMndZ2Cm9mkWxX
 xK+91lXvoQZp0Uq9e5aL864=
X-Google-Smtp-Source: ABdhPJwhT3+JOjv/sPS/0kggv3RrbDLZtdQ5kTGA1xfdcYh/QihDct17Mq0uNExOolnBtTryjQ64DQ==
X-Received: by 2002:a05:6e02:1785:b0:2cc:a32:98a7 with SMTP id
 y5-20020a056e02178500b002cc0a3298a7mr364196ilu.9.1650561920614; 
 Thu, 21 Apr 2022 10:25:20 -0700 (PDT)
Received: from localhost.localdomain (cpe-65-29-252-111.wi.res.rr.com.
 [65.29.252.111]) by smtp.gmail.com with ESMTPSA id
 o16-20020a92c690000000b002cbf7f76878sm10806260ilg.6.2022.04.21.10.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 10:25:20 -0700 (PDT)
From: Daniel Kaehn <kaehndan@gmail.com>
To: tiwai@suse.com
Subject: [PATCH v2 1/2] dt-bindings: sound: Add generic serial MIDI device
Date: Thu, 21 Apr 2022 12:24:26 -0500
Message-Id: <20220421172427.703231-2-kaehndan@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421172427.703231-1-kaehndan@gmail.com>
References: <20220421172427.703231-1-kaehndan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 Apr 2022 15:31:40 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Daniel Kaehn <kaehndan@gmail.com>
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
index 000000000000..74f02a9e1190
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
+  speed of 31.25 kBaud is needed, configure the clocks of the underlying serial device
+  so that a requested speed of 38.4 kBaud resuts in the standard MIDI baud rate.
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
2.35.1

