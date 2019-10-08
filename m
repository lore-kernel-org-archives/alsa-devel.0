Return-Path: <SRS0=gTnd=YB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE39C10F14
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:16:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38CF2070B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AJo1z3qy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c3Y+k5fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38CF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68F86857;
	Tue,  8 Oct 2019 20:15:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68F86857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570558595;
	bh=Nz7FKEkjqF1lItTrSttDmaIxrRypsyxxonlkC1pHO50=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AJo1z3qyqiEvCMO7ssLxX8V1eZJhQFH3DAGmOSaKQkkrdDH3m5pi1XA/lj3kybs3J
	 NaBRKIiW2c1QFLRlfl1xIdTplcWl6dN1L1G9a5eEvqZ842E1K6HtogwuonWPYZNBYP
	 x26gHcmuvL55Td3HhnE3F86bFGYFBshRnLbnK8Xs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9ED0F80322;
	Tue,  8 Oct 2019 20:15:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B969DF80447; Tue,  8 Oct 2019 20:15:42 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEABBF80113
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2019 20:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEABBF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c3Y+k5fg"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x98IFZYd055295;
 Tue, 8 Oct 2019 13:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1570558535;
 bh=MHbt/egTxGNc/lCwyNbm8rdYzujVZ7DY1baO8ocVABU=;
 h=From:To:CC:Subject:Date;
 b=c3Y+k5fgd7o03DtgIecpJ/TGaYIJGTN0hde/Hu9HP21ivAvfZjAR1Ej1ZJJ/XE1L6
 HKJQrAhfAZyVGu4GLaEEjfgtY7u0vlZ5E12Fos/zlSNhfsz9UI38rlD2FwzH/GdKza
 OtOaDPet+pflnPMTxUc8wzLPMsCDRKOlogeoJTKo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x98IFZ72085052
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Oct 2019 13:15:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 8 Oct
 2019 13:15:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 8 Oct 2019 13:15:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x98IFZD4029023;
 Tue, 8 Oct 2019 13:15:35 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <broonie@kernel.org>
Date: Tue, 8 Oct 2019 13:15:16 -0500
Message-ID: <20191008181517.5332-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, navada@ti.com,
 Dan Murphy <dmurphy@ti.com>
Subject: [alsa-devel] [PATCH 1/2] ASoc: Add Texas Instruments TAS2562
	amplifier binding
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add the DT binding for the TAS2562 amplifier.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tas2562.txt     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
new file mode 100644
index 000000000000..658e1fb18a99
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -0,0 +1,34 @@
+Texas Instruments TAS2562 Smart PA
+
+The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
+efficiently driving high peak power into small loudspeakers.
+Integrated speaker voltage and current sense provides for
+real time monitoring of loudspeaker behavior.
+
+Required properties:
+ - #address-cells  - Should be <1>.
+ - #size-cells     - Should be <0>.
+ - compatible:	   - Should contain "ti,tas2562".
+ - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
+ - ti,imon-slot-no:- TDM TX current sense time slot.
+
+Optional properties:
+- interrupt-parent: phandle to the interrupt controller which provides
+                    the interrupt.
+- interrupts: (GPIO) interrupt to which the chip is connected.
+- shut-down: GPIO used to control the state of the device.
+
+Examples:
+tas2562@4c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "ti,tas2562";
+        reg = <0x4c>;
+
+        interrupt-parent = <&gpio1>;
+        interrupts = <14>;
+
+	shut-down = <&gpio1 15 0>;
+        ti,imon-slot-no = <0>;
+};
+
-- 
2.22.0.214.g8dca754b1e

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
