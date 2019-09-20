Return-Path: <SRS0=YPxo=XP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C1C49ED7
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:00:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A0B206C2
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bpz9Kmx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A0B206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thundersoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1DE1167E;
	Fri, 20 Sep 2019 08:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1DE1167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568962842;
	bh=saKzFqhwa2vXGnUyijJzcyYiiUwg6EWm4JAq6EJB+7o=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bpz9Kmx2kpsVFd2Ggb0v+2hi7fmJDIATZnzm6EBJrUiUO+fzAj4fL3RjCa2SeZlmz
	 VSPjNFLjso1aOE6recBbv7zsER3XSpRlp9F4b+w5Q6Jhr20/ecDzX39itM86JGqnX3
	 WAoTCB+58wNiEfoIncQ3gN9mIJkf8R67L6+6eLr0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A93EDF805FA;
	Fri, 20 Sep 2019 08:58:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B13EAF80146; Fri, 20 Sep 2019 08:58:54 +0200 (CEST)
Received: from mail2.thundersoft.com (unknown [114.242.213.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2502FF80096
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 08:58:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2502FF80096
Received: from localhost (unknown [192.168.122.240])
 by mail2.thundersoft.com (Postfix) with ESMTPA id 031BA1520AFD;
 Fri, 20 Sep 2019 14:58:34 +0800 (CST)
From: shifu0704@thundersoft.com
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 robh+dt@kernel.org
Date: Fri, 20 Sep 2019 14:58:28 +0800
Message-Id: <1568962709-19185-1-git-send-email-shifu0704@thundersoft.com>
X-Mailer: git-send-email 2.7.4
Cc: Frank Shi <shifu0704@thundersoft.com>, dmurphy@ti.com, navada@ti.com
Subject: [alsa-devel] [PATCH v7] dt-bindings: ASoC: Add tas2770 smart PA dt
	bindings
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

From: Frank Shi <shifu0704@thundersoft.com>

Add tas2770 smart PA dt bindings

Signed-off-by: Frank Shi <shifu0704@thundersoft.com>
---
 .../devicetree/bindings/sound/tas2770.txt          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2770.txt

diff --git a/Documentation/devicetree/bindings/sound/tas2770.txt b/Documentation/devicetree/bindings/sound/tas2770.txt
new file mode 100644
index 0000000..ede6bb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2770.txt
@@ -0,0 +1,37 @@
+Texas Instruments TAS2770 Smart PA
+
+The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
+efficiently driving high peak power into small loudspeakers.
+Integrated speaker voltage and current sense provides for
+real time monitoring of loudspeaker behavior.
+
+Required properties:
+
+ - compatible:	   - Should contain "ti,tas2770".
+ - reg:		       - The i2c address. Should contain <0x4c>, <0x4d>,<0x4e>, or <0x4f>.
+ - #address-cells  - Should be <1>.
+ - #size-cells     - Should be <0>.
+ - ti,asi-format:  - Sets TDM RX capture edge. 0->Rising; 1->Falling.
+ - ti,imon-slot-no:- TDM TX current sense time slot.
+ - ti,vmon-slot-no:- TDM TX voltage sense time slot.
+
+Optional properties:
+
+- interrupt-parent: the phandle to the interrupt controller which provides
+                     the interrupt.
+- interrupts: interrupt specification for data-ready.
+
+Examples:
+
+    tas2770@4c {
+                compatible = "ti,tas2770";
+                reg = <0x4c>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                interrupt-parent = <&msm_gpio>;
+                interrupts = <97 0>;
+                ti,asi-format = <0>;
+                ti,imon-slot-no = <0>;
+                ti,vmon-slot-no = <2>;
+        };
+
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
