Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4267BC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  2 May 2022 15:05:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E796F1631;
	Mon,  2 May 2022 17:04:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E796F1631
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651503946;
	bh=CZzHOHTyt0/NJuhiibdIU6jnyZYU1dz+Ov0av8mE7cs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FHzZSqZADAY9sw6oVPTAGIOimy2uXfoIhmP9/tSQ1pJMBAOFUZhYR2RDiGCzrXIm4
	 ZTXJb7DmxecmfwnkTGo0uJbM13YuW38r7bJP91Iq6zZmNm3f3HUTMod5ikp0ogfVGb
	 EllEACW3X+PEfOcG458UNxRfU5CEWy8brCncdF4U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CF96F80249;
	Mon,  2 May 2022 17:04:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45349F8032B; Mon,  2 May 2022 17:04:25 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D36CF80129
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2022 17:04:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D36CF80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SKRneMuU"
Received: by mail-io1-xd34.google.com with SMTP id e194so16220349iof.11
 for <alsa-devel@alsa-project.org>; Mon, 02 May 2022 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8DxlpgadTiwVlizG1qCAETIguSixVFF389rLQPdWWec=;
 b=SKRneMuUme2thc6bd4DpK/QnE63UxA8FYcx5YXg4f3qJJmmpaCgEu/tsyj62GLjY0T
 R6yWp8QaekUi61Jx4mqlHnybUBfTtxredSFMhJ7iG1xkC05/4lmQX2p6v8RQXp9rMqkj
 FcKzeUd7U6frS0eY/a5DAqmiRcG53J8XVHOcnfvPzp2QJamT4/Z6ufpIYo+PwPo9ZuL7
 PHdmg729QyW8SfloyFzm48SCgc/YJ5wS4ZE/tdja6CEiIe2gml/zIEKB5AKRY9fHbdSc
 VY/5FvGogtnZjFRy3RAs8PDgch8eOiz9xv2fow8mByqiJlz5saxQLCD2//JF4KnpJF2w
 5z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8DxlpgadTiwVlizG1qCAETIguSixVFF389rLQPdWWec=;
 b=E/pcN90mYmMdvll9vVEMq4kWRLQR2nFEWMng4oPPWeOtYO12/E2V8xpjhvICXxA9Wt
 /KKiT8NA+owvFcfjsr3sc67ycFPPLyG0fWeF297uNnjsdACVTXbdxZ5zuVBa4u+bwNDN
 DlziJYPuRzk8JWObCRe+hiBXxBkMxY/rcsCBRxfJsb225nqf06nnTbP0bGce8Lwr1GTz
 8rZbNjpI80P2FzKO+Fl3jhnGyBnckxb3ceoq6HGo2RzjU7GA3skYrMbakyLlns70MCWy
 NEAFzf6wdQKoUxMTn31fjRjhoNQixc44XgvOOWb3TAgBK+tU9W9pvzeK/MWLV7kWGFNH
 BBvQ==
X-Gm-Message-State: AOAM532/Op/2vaBgudHiujzr1jTucIQUyJSA4M/X6/g5xJL1BjqtcDmw
 E0m6HOtIK5wDafOq++A2H5M=
X-Google-Smtp-Source: ABdhPJyjoDDOuAccfUf+BYmCeffRX5YyOnnVwtgVr2CjFb0WTNRucvNcDcjpeFZ7lQxyp+LooPh8sA==
X-Received: by 2002:a05:6638:1914:b0:32a:8804:da85 with SMTP id
 p20-20020a056638191400b0032a8804da85mr4812972jal.212.1651503857260; 
 Mon, 02 May 2022 08:04:17 -0700 (PDT)
Received: from localhost.localdomain (cpe-65-29-252-111.wi.res.rr.com.
 [65.29.252.111]) by smtp.gmail.com with ESMTPSA id
 s12-20020a92c5cc000000b002cde6e352basm2718218ilt.4.2022.05.02.08.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 May 2022 08:04:16 -0700 (PDT)
From: Daniel Kaehn <kaehndan@gmail.com>
To: tiwai@suse.com,
	robh@kernel.org
Subject: [PATCH v5 1/2] dt-bindings: sound: Add generic serial MIDI device
Date: Mon,  2 May 2022 10:04:03 -0500
Message-Id: <20220502150404.20295-2-kaehndan@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220502150404.20295-1-kaehndan@gmail.com>
References: <20220502150404.20295-1-kaehndan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Adds dt-binding for a Generic MIDI Interface using a serial device.

Signed-off-by: Daniel Kaehn <kaehndan@gmail.com>
---
 .../devicetree/bindings/sound/serialmidi.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/serialmidi.yaml

diff --git a/Documentation/devicetree/bindings/sound/serialmidi.yaml b/Documentation/devicetree/bindings/sound/serialmidi.yaml
new file mode 100644
index 000000000000..06a894e1b91d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/serialmidi.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/serialmidi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Serial MIDI Interface
+
+maintainers:
+  - Daniel Kaehn <kaehndan@gmail.com>
+
+description: 
+  Generic MIDI interface using a serial device. This denotes that a serial device is
+  dedicated to MIDI communication, either to an external MIDI device through a DIN5
+  or other connector, or to a known hardwired MIDI controller. This device must be a
+  child node of a serial node.
+
+  Can only be set to use standard baud rates corresponding to supported rates of the
+  parent serial device. If the standard MIDI baud of 31.25 kBaud is needed 
+  (as would be the case if interfacing with arbitrary external MIDI devices),
+  configure the clocks of the parent serial device so that a requested baud of 38.4 kBaud
+  resuts in the standard MIDI baud rate, and set the 'current-speed' property to 38400.
+
+properties:
+  compatible:
+    const: serialmidi
+
+  current-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Baudrate to set the serial port to when this MIDI device is opened.
+      If not specified, the parent serial device is allowed to use its default baud.
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
+            current-speed = <38400>;
+        };
+    };
-- 
2.33.0

