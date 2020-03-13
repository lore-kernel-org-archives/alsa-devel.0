Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB91C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:06:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6566C20674
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qbhLKj0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6566C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1C5A1841;
	Fri, 13 Mar 2020 19:05:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1C5A1841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584122804;
	bh=tS2q+oXz20VqzSeHESYk3tjWn89uZDkDnSDm+k5Qa9M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qbhLKj0H5Sxpsbsxe7udECadFbGVUEdYamLULyWQU7Twfa8X415kaXdPRdZM08wSE
	 20Y3PrDHsVWXWt+zWJxl+u/NdMVQ2WVPAB19uzEGi4Ujw+5OIY+9Toz4i/9KwUIqX3
	 /dNTpf5bo6+a2ly2y/gukEFLZrIXZiCWhokS/JII=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26FF4F801A3;
	Fri, 13 Mar 2020 19:05:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4CE56F801EB; Fri, 13 Mar 2020 19:05:51 +0100 (CET)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF202F80086
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 19:05:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF202F80086
Received: by mail-ot1-f65.google.com with SMTP id h17so11020671otn.7
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 11:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q7+Nkcvfl4/gb9mNioMQHbyMcrjEyqR+fODsE4xtIGc=;
 b=Wi25RZuCv+PCTbtEizvxZnm5zYvQjv3+ocDFQaKxXy0gEFAWlgPkk9rstKFIpQcgbv
 NeN0MJxABCBp72kClssuud/1J0Rgmmx7vZ5cWLXIIMH1ttDU5fjFGHLYGESPn6gxjYfa
 9ghRnYMII1xDsSA5tCzxp4hbJdlhyPBWYftn/Ebu0mn9mvHobkTUipcD54bwbuAAHFw7
 8A0tSpj7ZHScRkIweWV+u3XznEZV0U6wJwHrr610GRSuH/7szZwm8uioj513tgTGtRjC
 49+fIq2V7kTCyExy/koABnuTL9s2N9/BhCL/b4I1WMow3pirNCeKZOYN7ZF751BNDP07
 9d/Q==
X-Gm-Message-State: ANhLgQ3Wi5gcxOw4Q9gHgZK3+eYASbDzakSWxKUoFVqOX8GXRmm5Zdo7
 8cZojpgo+g2ifzhG9f/tuA==
X-Google-Smtp-Source: ADFU+vuE1znAWJdS12d/3fpV7RSOblB37rwLd2+2qwovCXq+PD/Gh05XlFdke2N5njfGD69QMU3nNw==
X-Received: by 2002:a05:6830:1498:: with SMTP id
 s24mr10839643otq.242.1584122745570; 
 Fri, 13 Mar 2020 11:05:45 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id b15sm8012288oic.52.2020.03.13.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:05:44 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] ASoC: dt-bindings: google,
 cros-ec-codec: Fix dtc warnings in example
Date: Fri, 13 Mar 2020 13:05:43 -0500
Message-Id: <20200313180543.20497-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

Extra dtc warnings (roughly what W=1 enables) are now enabled by default
when building the binding examples. These were fixed treewide in
5.6-rc5, but the newly added google,cros-ec-codec schema adds some new
warnings:

Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:17.28-21.11:
Warning (unit_address_vs_reg): /example-0/reserved_mem: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:22.19-32.11:
Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit name, but no reg property
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:26.37-31.15:
Warning (unit_address_vs_reg): /example-0/cros-ec@0/ec-codec: node has a reg or ranges property, but no unit name

Fixing the above, then results in:

Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:26.13-23:
Warning (reg_format): /example-0/cros-ec@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:27.37-32.15:
Warning (unit_address_vs_reg): /example-0/cros-ec@0/ec-codec: node has a reg or ranges property, but no unit name

Fix these warnings and adjust the node name to 'audio-codec' while we're
touching the node name.

Fixes: eadd54c75f1e ("dt-bindings: Convert the binding file google, cros-ec-codec.txt to yaml format.")
Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: alsa-devel@alsa-project.org
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - s/ec-codec/audio-codec/
---
 .../bindings/sound/google,cros-ec-codec.yaml  | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
index 94a85d0cbf43..d62284288f23 100644
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -44,19 +44,24 @@ additionalProperties: false
 
 examples:
   - |
-    reserved_mem: reserved_mem {
+    reserved_mem: reserved-mem@52800000 {
         compatible = "shared-dma-pool";
-        reg = <0 0x52800000 0 0x100000>;
+        reg = <0x52800000 0x100000>;
         no-map;
     };
-    cros-ec@0 {
-        compatible = "google,cros-ec-spi";
-        #address-cells = <2>;
-        #size-cells = <1>;
-        cros_ec_codec: ec-codec {
-            compatible = "google,cros-ec-codec";
-            #sound-dai-cells = <1>;
-            reg = <0x0 0x10500000 0x80000>;
-            memory-region = <&reserved_mem>;
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cros-ec@0 {
+            compatible = "google,cros-ec-spi";
+            #address-cells = <2>;
+            #size-cells = <1>;
+            reg = <0>;
+            cros_ec_codec: audio-codec@10500000 {
+                compatible = "google,cros-ec-codec";
+                #sound-dai-cells = <1>;
+                reg = <0x0 0x10500000 0x80000>;
+                memory-region = <&reserved_mem>;
+            };
         };
     };
-- 
2.20.1

