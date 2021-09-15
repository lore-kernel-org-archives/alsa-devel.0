Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B8AC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 03:11:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12A2611ED
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 03:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D12A2611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17FD517E3;
	Wed, 15 Sep 2021 05:10:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17FD517E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631675464;
	bh=UGFFnblOSiUxV+B17WRncLUONz3vaVIOioSYcebqxlg=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sVe1f+oG0C0vATtzdlPB3ALULkRZ1QsX/ZwkbTgrmIoH/I4Ey1ifZIKURwyBZ5k6D
	 sJ1eUWY7d3n6z37FtbDW8LMDKCZWN17MVrW34olP1V0dG7b4LvnB3pt8PGdGS7p7mK
	 XOPqV67B4Vh/ZOe3MeHILGP90wwItt6TGc54lDR8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97FBCF80227;
	Wed, 15 Sep 2021 05:10:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9E4BF80132; Wed, 15 Sep 2021 05:10:11 +0200 (CEST)
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76A76F80132
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 05:10:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76A76F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="QZzeguFK"
Received: by mail-qt1-x84a.google.com with SMTP id
 p21-20020ac846150000b02902982d999bfbso1211177qtn.7
 for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2021 20:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=jAy5ZO2AeP18Q1PLRPQevhEuoLi1BItbrfO3lZX0e/4=;
 b=QZzeguFKy9TLKw8z5mSOBfy/TDIRHtnS5H7qN/jShAO+2D7Xwv/vkvplU7REnkXTM7
 UHLW7OjxC11f1ZCxwnk5sjza3pC0w4wlMcqBgOANM7uvvMn0IMdfzhveJnY3W9HFo0B+
 YZM6HApRAA7U3+/D9cvWT80cf5XsmvMKe9S5y4/kEFCJ/CszhEH+3cjagUztSUeTtWgE
 Z0h24Otr0friyTLJWCp3RdyLij9zrBjKRS3o/JxeaQrM20U9mNZH413fuRpjwoYtb6aP
 9tboUQFCgfftuFArIU4eewPGBuMrCWFAjrk5LtLw+U2uiF7CFsjTVjmLYwYkaYmdj7ZK
 s42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=jAy5ZO2AeP18Q1PLRPQevhEuoLi1BItbrfO3lZX0e/4=;
 b=W+3zHDA16X7icbD3S0fuicgsienIoTinQEvWYaAWe5RRCgn/DjJ5LCRdCUf67DO/Gy
 dqNlOUajG/uHSsxpNWSuCDqZmnMbv7EebmFAlM1GNWModlv0M1HLVzezGanEYC01+td1
 iK/8HkSbdKiPLafvdPsBZ5cRszgYnyUcQe3U//D/XPDDL4+/6MhZrRgHDgPizd1EDlW9
 NEjFZIPiSa2iH7lDAOtBO20Kt1FTLG3dFQhJ7+uZqhmI/P5+oDuxEtCRYhxtfRldwjJB
 +wg8SiSr8Smgz8nfKUhu29wvrM54wCgcNiWYwxEMmZ/8ajwXluOCMs1YIxVMVPxwBnsO
 /P+g==
X-Gm-Message-State: AOAM533JECg6BVPjCrW28DwDtbNHVIyVGz1eB+dkerXBDFZ3ImTiaLdt
 ZWuyzUCxUBZw/z3yvEW+6JPDaGk8GU1s
X-Google-Smtp-Source: ABdhPJwvqKiGSSV6Z7HG2VYx+JKVRocjK1EXbL1IOtUvsjZjxJPnw/pSxdUioCC3EZSjArZHuu9B8+exbi1K
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:1d24:4827:7125:1e19])
 (user=tzungbi job=sendgmr) by 2002:a0c:9146:: with SMTP id
 q64mr8784899qvq.38.1631675400230; Tue, 14 Sep 2021 20:10:00 -0700 (PDT)
Date: Wed, 15 Sep 2021 11:09:53 +0800
Message-Id: <20210915030953.2347176-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v4] ASoC: dt-bindings: mediatek: mt8192: re-add audio afe
 document
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
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

The document was merged as commit 1afc60e00de3 ("dt-bindings:
mediatek: mt8192: add audio afe document").

However, [1] revealed that the commit 1afc60e00de3 breaks
dt_binding_check due to dt-bindings/clock/mt8192-clk.h doesn't
exist.

As a temporary fix, commit 7d94ca3c8acd ("ASoC: mt8192: revert
add audio afe document") reverted commit 1afc60e00de3.

dt-bindings/clock/mt8192-clk.h is in mainline per commit
f35f1a23e0e1 ("clk: mediatek: Add dt-bindings of MT8192 clocks").
Re-adds the document back.

[1]: https://mailman.alsa-project.org/pipermail/alsa-devel/2020-November/176873.html

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v3 (https://mailman.alsa-project.org/pipermail/alsa-devel/2021-September/189705.html):
- Fix the indent errors.

Changes from v2 (https://mailman.alsa-project.org/pipermail/alsa-devel/2021-August/189058.html):
- Simplify the commit message.

Changes from v1 (https://mailman.alsa-project.org/pipermail/alsa-devel/2021-August/189048.html):
- Add more context to the commit message.

 .../bindings/sound/mt8192-afe-pcm.yaml        | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml

diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
new file mode 100644
index 000000000000..5e9fe067f440
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mt8192-afe-pcm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek AFE PCM controller for mt8192
+
+maintainers:
+  - Jiaxin Yu <jiaxin.yu@mediatek.com>
+  - Shane Chien <shane.chien@mediatek.com>
+
+properties:
+  compatible:
+    const: mediatek,mt8192-audio
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: audiosys
+
+  mediatek,apmixedsys:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of the mediatek apmixedsys controller
+
+  mediatek,infracfg:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of the mediatek infracfg controller
+
+  mediatek,topckgen:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of the mediatek topckgen controller
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AFE clock
+      - description: ADDA DAC clock
+      - description: ADDA DAC pre-distortion clock
+      - description: audio infra sys clock
+      - description: audio infra 26M clock
+
+  clock-names:
+    items:
+      - const: aud_afe_clk
+      - const: aud_dac_clk
+      - const: aud_dac_predis_clk
+      - const: aud_infra_clk
+      - const: aud_infra_26m_clk
+
+required:
+  - compatible
+  - interrupts
+  - resets
+  - reset-names
+  - mediatek,apmixedsys
+  - mediatek,infracfg
+  - mediatek,topckgen
+  - power-domains
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8192-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/mt8192-power.h>
+    #include <dt-bindings/reset-controller/mt8192-resets.h>
+
+    afe: mt8192-afe-pcm {
+        compatible = "mediatek,mt8192-audio";
+        interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&watchdog MT8192_TOPRGU_AUDIO_SW_RST>;
+        reset-names = "audiosys";
+        mediatek,apmixedsys = <&apmixedsys>;
+        mediatek,infracfg = <&infracfg>;
+        mediatek,topckgen = <&topckgen>;
+        power-domains = <&scpsys MT8192_POWER_DOMAIN_AUDIO>;
+        clocks = <&audsys CLK_AUD_AFE>,
+                 <&audsys CLK_AUD_DAC>,
+                 <&audsys CLK_AUD_DAC_PREDIS>,
+                 <&infracfg CLK_INFRA_AUDIO>,
+                 <&infracfg CLK_INFRA_AUDIO_26M_B>;
+        clock-names = "aud_afe_clk",
+                      "aud_dac_clk",
+                      "aud_dac_predis_clk",
+                      "aud_infra_clk",
+                      "aud_infra_26m_clk";
+    };
+
+...
-- 
2.33.0.309.g3052b89438-goog

