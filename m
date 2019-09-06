Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F78C43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 07:05:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBB321D7C
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 07:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MrddRLqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBB321D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thundersoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFCC7820;
	Fri,  6 Sep 2019 09:04:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFCC7820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567753547;
	bh=RcpQhJNq3fduT+E1+ly3RrSmgqid8I+pGUZrpGOomS8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MrddRLqJjuW/Y3LazQ0XYHtBZxmBpdX1BRAEaSrCvgb8t1WhmkPp4qSY/FDE/w1Kf
	 SJd59NL4cOVpjMww9UStOltoPuuc4FBbD7b1b+l1evcr3ZnniSsTirxwzgoSbPohrV
	 VtoJ0TrvXzCVwHbPlqTO0mC3huP3d/WZ8briG92U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D02C5F80394;
	Fri,  6 Sep 2019 09:04:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78763F80390; Fri,  6 Sep 2019 09:04:54 +0200 (CEST)
Received: from mail1.thundersoft.com (unknown [114.242.213.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B38EF80390
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 09:04:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B38EF80390
Received: from localhost (unknown [192.168.122.240])
 by mail1.thundersoft.com (Postfix) with ESMTPA id 94E6517455F5;
 Fri,  6 Sep 2019 15:04:38 +0800 (CST)
From: shifu0704@thundersoft.com
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date: Fri,  6 Sep 2019 15:06:03 +0800
Message-Id: <1567753564-13699-1-git-send-email-shifu0704@thundersoft.com>
X-Mailer: git-send-email 2.7.4
Cc: Frank Shi <shifu0704@thundersoft.com>, dmurphy@ti.com, navada@ti.com
Subject: [alsa-devel] [PATCH] tas2770: add tas2770 smart PA dt bindings
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

add tas2770 smart PA dt bindings

Signed-off-by: Frank Shi <shifu0704@thundersoft.com>
---
 Documentation/devicetree/bindings/tas2770.txt | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/tas2770.txt

diff --git a/Documentation/devicetree/bindings/tas2770.txt b/Documentation/devicetree/bindings/tas2770.txt
new file mode 100644
index 0000000..f70b310
--- /dev/null
+++ b/Documentation/devicetree/bindings/tas2770.txt
@@ -0,0 +1,38 @@
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
+ - ti,left-slot:   - Sets TDM RX left time slots.
+ - ti,right-slot:  - Sets TDM RX right time slots.
+ - ti,imon-slot-no:- TDM TX current sense time slot.
+ - ti,vmon-slot-no:- TDM TX voltage sense time slot.
+
+Optional properties:
+
+ - reset-gpio:	Reset GPIO number of left device.
+ - irq-gpio:  IRQ GPIO number of left device.
+
+Examples:
+
+    tas2770@4c {
+                compatible = "ti,tas2770";
+                reg = <0x4c>;
+                reset-gpio = <&gpio15 1 GPIO_ACTIVE_LOW>;
+                irq-gpio = <&gpio16 1 GPIO_ACTIVE_LOW>;
+                ti,asi-format = <0>;
+                ti,left-slot = <0>;
+                ti,right-slot = <1>;
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
