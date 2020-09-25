Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFF7C4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:00:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A6C21D91
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eWLncyZu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cHFQInIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A6C21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 233DD187E;
	Fri, 25 Sep 2020 12:59:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 233DD187E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601031648;
	bh=U307HY/ZDzAMKpi8sDBhtB/MESBHBXk9DoWcq/Wt9rc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eWLncyZuVJdOoMJPq69Giz2Sl1JRqWxM/+wM/A+CkPmpcn7SlRRwCvFIKrGq+nyjd
	 waHJb+OWVJdD0erJCpqC6DFiy40iTTJ6bytjzra9tpb+8VdJR7F4X+8AsE/NCislc6
	 67i0b6ZajDtKFT02/gZNuDwbA8eEmF90pcmyNpYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DC84F800F6;
	Fri, 25 Sep 2020 12:59:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3210AF80254; Fri, 25 Sep 2020 12:59:56 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EB21F800F6
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 12:59:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EB21F800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="cHFQInIf"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 08PAtnxK012375; Fri, 25 Sep 2020 05:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=aHsAD30eplTLAmyfrhAwqb/bjmQuLl4rTfeV9gEtaIw=;
 b=cHFQInIfkQ80up1qAbRxFsgZlZeCNR3fXs9/TxlA/yDEDJa7xxTndM91Fj6h80ePZPUE
 oxySyXN8gx/qnlm5J8MMmAA2LPoyzCX0T17TtI6BajpNm9bN1n81yksiMj+0Kjg0S1wC
 KeQ5uBqZBYLtMxUQpuM2A7Zf2Wh/jBu9fucGl8FGbxD5gWvtI7nB38An7dnUnQxbFsl0
 PJktqpoRxqQqtB64Z5F1lh5nOFtu8BfEpV8LJcAMAOMVplEU283nvkL+rJEXVDn70ClB
 wSR0hgFXjEZpZkNUuXdBKqeE7tQc11q7yu89AfEhZjHhvE4KdDie/2r8wX7aHHUQ+Fmw Ww== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 33nedn7xpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 25 Sep 2020 05:59:42 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 11:59:41 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 25 Sep 2020 11:59:41 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com
 [198.61.64.158])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 838AA2C3;
 Fri, 25 Sep 2020 10:59:34 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH 1/3] ASoC: cs4234: Add dtschema binding document
Date: Fri, 25 Sep 2020 11:59:06 +0100
Message-ID: <20200925105908.20640-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250076
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

