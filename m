Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF48C433E3
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:23:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033C720657
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jr41JDZg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cskJHjmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033C720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A6C616E0;
	Mon, 17 Aug 2020 19:22:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A6C616E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597684986;
	bh=iBJ1EFBzXy+fbJey3Hab4W2rLUjr9PjU2ROJbiQpL3w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jr41JDZgZjnx81pHaW0RfkZGU/hFce/UM88vOZgPS7LXE0OezQCHxouNcAB3SbM3j
	 TSABJfVAc5ij13XGRVH48l42Vj7hQ/XWKONiSN5lYdtzQBnryEhnzIuiclBzui2akR
	 08RG89Xf/8XtNyl0kLGcQjhFirA2uQ3E9otuguMo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1451AF80216;
	Mon, 17 Aug 2020 19:22:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18165F8025A; Mon, 17 Aug 2020 19:22:14 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F477F80216
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 19:22:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F477F80216
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cskJHjmS"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07HHLv8o048896;
 Mon, 17 Aug 2020 12:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1597684917;
 bh=LklfsQNtzEgv4Muun+dSl7Ny7j+95Ivu7/MecpZEky0=;
 h=From:To:CC:Subject:Date;
 b=cskJHjmSEpYEbTI8yN/aG5sv6LTSTZD8UxSG54Pmh+5Xa7F0Wuzd7WxCdp0UBzomR
 /QsCKvJW1Tza7CmR+BrNClMInj/J7zEHDMqUKU3h3vtymBtw4417dXEWs/2B8ji4yV
 hL/8UFY2aQSKfnxEPeP6O+rC4QeC0lT/quSAUEzE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07HHLvbx063744
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Aug 2020 12:21:57 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 17
 Aug 2020 12:21:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 17 Aug 2020 12:21:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07HHLv4L073434;
 Mon, 17 Aug 2020 12:21:57 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: tas2562: Remove tas2562 text file
Date: Mon, 17 Aug 2020 12:21:50 -0500
Message-ID: <20200817172151.26564-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
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

Remove the tas2562 text file as the tas2562.yaml is now available.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tas2562.txt     | 37 -------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
deleted file mode 100644
index dc6d7362ded7..000000000000
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Texas Instruments TAS2562 Smart PA
-
-The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
-efficiently driving high peak power into small loudspeakers.
-Integrated speaker voltage and current sense provides for
-real time monitoring of loudspeaker behavior.
-
-Required properties:
- - #address-cells  - Should be <1>.
- - #size-cells     - Should be <0>.
- - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
- - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
- - ti,imon-slot-no:- TDM TX current sense time slot.
- - ti,vmon-slot-no:- TDM TX voltage sense time slot. This slot must always be
-		     greater then ti,imon-slot-no.
-
-Optional properties:
-- interrupt-parent: phandle to the interrupt controller which provides
-                    the interrupt.
-- interrupts: (GPIO) interrupt to which the chip is connected.
-- shut-down-gpio: GPIO used to control the state of the device.
-
-Examples:
-tas2562@4c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        compatible = "ti,tas2562";
-        reg = <0x4c>;
-
-        interrupt-parent = <&gpio1>;
-        interrupts = <14>;
-
-	shut-down-gpio = <&gpio1 15 0>;
-        ti,imon-slot-no = <0>;
-        ti,vmon-slot-no = <1>;
-};
-
-- 
2.28.0

