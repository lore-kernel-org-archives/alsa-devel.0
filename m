Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046AFC7618A
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Mar 2023 18:00:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34E531DF;
	Mon, 20 Mar 2023 18:59:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34E531DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679335201;
	bh=BZFruPnhpY51lw+awF05tp/17kwiYrKq7o8p8gL9mks=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:Cc:From;
	b=jS5IYOE6rfewkSe4+ykNg74yleKqI38zWSnhp0BpPIduxc/mUnmLG98XGaw3T0uWe
	 WqWfpmXukoXiLtUyXBrJ0B7+HSrZ4TdhRY1A77RplYDRJRylozS98Hgq8CxUIXw4i9
	 hx3l6RejgBV/Kg+BJc72CZlmUrPYD4CX74NXl/lE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C3EDF80551;
	Mon, 20 Mar 2023 18:58:20 +0100 (CET)
To: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring
	<robh+dt@kernel.org>
Subject: [PATCH v3 2/5] ASoC: dt-bindings: cs35l45: GPIOs configuration
Date: Wed, 15 Mar 2023 10:47:19 -0500
In-Reply-To: <20230315154722.3911463-1-vkarpovi@opensource.cirrus.com>
References: <20230315154722.3911463-1-vkarpovi@opensource.cirrus.com>
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Approved-At: Mon, 20 Mar 2023 17:58:12 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3DTBTELVQ2OK7VB4SI7UNMPZKR7QWT7R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
MIME-Version: 1.0
Message-ID: <167933509887.26.521198853617763422@mailman-core.alsa-project.org>
From: Vlad Karpovich via Alsa-devel <alsa-devel@alsa-project.org>
Reply-To: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
Content-Type: message/rfc822
Content-Disposition: inline

Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4110BF80568; Wed, 15 Mar 2023 16:47:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on alsa1.perex.cz
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 485DFF8051B
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2023 16:47:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 485DFF8051B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=p+1hV7sW
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32FFMHZ9015868;
	Wed, 15 Mar 2023 10:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=dPToRk/+soaeY948VOsT5VDpfTszKykVdxRQIdaJ4k8=;
 b=p+1hV7sWSHo5hIReEy59RVHQpa0rBH5blKa3a9arfdl8kMhyBQ4MD8iUMxERVaUz/1HY
 2j5s4nEWgsuDGI9Ia5/LGDs29RDCeJ3+0K74pkSpqQawBuA1dK8hDzf8xOH8FDhnyQAU
 s4luAqXnrEjs6FL/EhzLQLTUZGMg3YGXUIHHcwnqdZqGv/6ML5/BRYLbSAm2/0hTjLX3
 w+tpj3UBA6I9csIk5iAGTRnB6nXE0VZi7TcmXFYBnzuR+wzTfjrIxhqSvCgg7wVeMqJX
 ICOJVdSrXQO2PcbE9nAF5Lm/fctVYBki6ME1AVqg3+Mmz68WgnjEKUiU7Pp0oJzkCVxD OQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pb2cr8rmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Mar 2023 10:47:44 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 15 Mar
 2023 10:47:42 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 15 Mar 2023 10:47:42 -0500
Received: from vkarpovich-ThinkStation-P620.crystal.cirrus.com
 (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.206.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 30CC345;
	Wed, 15 Mar 2023 15:47:40 +0000 (UTC)
From: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
To: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring
	<robh+dt@kernel.org>
Subject: [PATCH v3 2/5] ASoC: dt-bindings: cs35l45: GPIOs configuration
Date: Wed, 15 Mar 2023 10:47:19 -0500
Message-ID: <20230315154722.3911463-2-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315154722.3911463-1-vkarpovi@opensource.cirrus.com>
References: <20230315154722.3911463-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Nc3rwwIbfbxLDRRkvWpQKOFxmLJBfL_z
X-Proofpoint-GUID: Nc3rwwIbfbxLDRRkvWpQKOFxmLJBfL_z
X-Proofpoint-Spam-Reason: safe
X-MailFrom: prvs=843822f42b=vkarpovi@opensource.cirrus.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 3DTBTELVQ2OK7VB4SI7UNMPZKR7QWT7R
X-Message-ID-Hash: 3DTBTELVQ2OK7VB4SI7UNMPZKR7QWT7R
X-Mailman-Approved-At: Mon, 20 Mar 2023 17:58:12 +0000
CC: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3DTBTELVQ2OK7VB4SI7UNMPZKR7QWT7R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>

This adds description of CS35L45 GPIOs configuration.

Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
---
 .../bindings/sound/cirrus,cs35l45.yaml        | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
index 184a1344ea76..34c2867e2fd9 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
@@ -47,6 +47,74 @@ properties:
     maximum: 3
     default: 2
 
+patternProperties:
+  "^cirrus,gpio-ctrl[1-3]$":
+    description:
+      GPIO pins configuration.
+    type: object
+    additionalProperties: false
+    properties:
+      gpio-dir:
+        description:
+          GPIO pin direction. Valid only when 'gpio-ctrl' is 1
+            0 = Output
+            1 = Input
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 1
+        default: 1
+      gpio-lvl:
+        description:
+          GPIO level. Valid only when 'gpio-ctrl' is 1 and 'gpio-dir' is 0
+            0 = Low
+            1 = High
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 1
+        default: 0
+      gpio-op-cfg:
+        description:
+          GPIO level. Valid only when 'gpio-ctrl' is 1 and 'gpio-dir' is 0
+            0 = CMOS
+            1 = Open Drain
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 1
+        default: 0
+      gpio-pol:
+        description:
+          GPIO output polarity select. Valid only when 'gpio-ctrl' is 1
+          and 'gpio-dir' is 0
+            0 = Non-inverted, Active High
+            1 = Inverted, Active Low
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 1
+        default: 0
+      gpio-ctrl:
+        description:
+          Defines the function of the GPIO pin.
+          GPIO1
+            0 = High impedance input
+            1 = Pin acts as a GPIO, direction controlled by 'gpio-dir'
+            2 = Pin acts as MDSYNC, direction controlled by MDSYNC
+            3-7 = Reserved
+          GPIO2
+            0 = High impedance input
+            1 = Pin acts as a GPIO, direction controlled by 'gpio-dir'
+            2 = Pin acts as open drain INT
+            3 = Reserved
+            4 = Pin acts as push-pull output INT. Active low.
+            5 = Pin acts as push-pull output INT. Active high.
+            6,7 = Reserved
+          GPIO3
+            0 = High impedance input
+            1 = Pin acts as a GPIO, direction controlled by 'gpio-dir'
+            2-7 = Reserved
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 7
+        default: 0
 required:
   - compatible
   - reg
@@ -71,5 +139,15 @@ examples:
           reset-gpios = <&gpio 110 0>;
           cirrus,asp-sdout-hiz-ctrl = <(CS35L45_ASP_TX_HIZ_UNUSED |
                                         CS35L45_ASP_TX_HIZ_DISABLED)>;
+          cirrus,gpio-ctrl1 {
+             gpio-ctrl = <0x2>;
+          };
+          cirrus,gpio-ctrl2 {
+             gpio-ctrl = <0x2>;
+          };
+          cirrus,gpio-ctrl3 {
+             gpio-ctrl = <0x1>;
+             gpio-dir = <0x1>;
+          };
         };
     };
-- 
2.25.1

