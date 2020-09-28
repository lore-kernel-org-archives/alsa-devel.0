Return-Path: <SRS0=2Byq=DF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7D7C2D0A8
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:20:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F108221775
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k/aenZfC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EXY1kpJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F108221775
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C00501F27;
	Mon, 28 Sep 2020 13:19:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C00501F27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601292034;
	bh=U307HY/ZDzAMKpi8sDBhtB/MESBHBXk9DoWcq/Wt9rc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k/aenZfC36KKL0/hhPe3+vHWYhGjdUCMx22orZROcK0tVILSvAVAMCTFTQDtTyRia
	 2J+vkCVhfV7U6qqP81ncX76gBJ4efldDon2woJnuuintlCK+I5Faca5HlNAP0rDG5J
	 o4FmJqbfomqGkfoeOXHylaY0GS/Z1u1Ynb7vU5w0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 403B1F802D2;
	Mon, 28 Sep 2020 13:18:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97C21F801F9; Mon, 28 Sep 2020 13:18:38 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A42BAF800DF
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2020 13:18:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A42BAF800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="EXY1kpJ+"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 08SBGBZE023725; Mon, 28 Sep 2020 06:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=aHsAD30eplTLAmyfrhAwqb/bjmQuLl4rTfeV9gEtaIw=;
 b=EXY1kpJ+Xd2zsMDwvksqlHgKAio3XoAjGDCgmD/p34L2+zI/X1Uf/f9AkzWbkUSRdtTg
 RJc3W85RdyIDgWqBgc/xao/9j1b7o7ZRVI9xDwujtGiC5EEocL+lRbYF/Ok2nDOxfvPt
 jlexAG5XjTD0ATs+AsQiVlWqcnucb2Z19DleQLMRmZS04QVQg+esdd0ycTr6Y1sbF+py
 qh6p9vYpo3oFhgLxPuqBPnFyApcOKQ/JM2WkS7cKvbSt9t33NqTOIQEbPQ/zC5G1lsQb
 DMskKFAmI/+lIqOtZf+rhHY7pWTulTmn+mPlrpms+b0lEHTmHqECIbkW73PC6oNqE7k/ kA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 33t22p25fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 28 Sep 2020 06:18:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 28 Sep
 2020 12:18:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 28 Sep 2020 12:18:24 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com
 [198.61.64.171])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5EC9845;
 Mon, 28 Sep 2020 11:18:23 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v2 1/2] ASoC: cs4234: Add dtschema binding document
Date: Mon, 28 Sep 2020 12:18:20 +0100
Message-ID: <20200928111821.26967-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280091
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

Document the bindings for the CS4234 ASoC codec driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 .../bindings/sound/cirrus,cs4234.yaml         | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs4234.yaml

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs4234.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs4234.yaml
new file mode 100644
index 000000000000..156560b2a980
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs4234.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs4234.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic cs4234 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description:
+  The CS4234 is a highly versatile CODEC that combines 4 channels of
+  high performance analog to digital conversion, 4 channels of high
+  performance digital to analog conversion for audio, and 1 channel of
+  digital to analog conversion to provide a nondelayed audio reference
+  signal to an external Class H tracking power supply. If not used to
+  drive a tracking power supply, the 5th DAC can instead be used as a
+  standard audio grade DAC, with performance specifications identical
+  to that of the 4 DACs in the audio path. Additionally, the CS4234
+  includes tunable group delay for each of the 4 audio DAC paths to
+  provide lead time for the external switch-mode power supply, and a
+  nondelayed path into the DAC outputs for input signals requiring a
+  low-latency path to the outputs.
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs4234
+
+  reg:
+    description:
+      The 7-bit I2C address depends on the state of the ADx pins, in
+      binary given by [0 0 1 0 AD2 AD1 AD0 0].
+    items:
+      minimum: 0x10
+      maximum: 0x17
+
+  VA-supply:
+    description:
+      Analogue power supply.
+
+  VL-supply:
+    description:
+      Interface power supply.
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - VA-supply
+  - VL-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c@e0004000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0xe0004000 0x1000>;
+
+        cs4234: codec@11 {
+            compatible = "cirrus,cs4234";
+            reg = <0x11>;
+
+            VA-supply = <&vdd3v3>;
+            VL-supply = <&vdd3v3>;
+
+            reset-gpios = <&gpio 0>;
+        };
+    };
-- 
2.20.1

