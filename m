Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1334C677C4
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Jun 2025 19:35:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9262860208;
	Tue, 10 Jun 2025 21:35:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9262860208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749584111;
	bh=/r9pwoqHSypc19PvCxVj/r8Ve69yToxx+Vy37CM3NUI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XHLfxETYFQCS+N1LkDMATsLR1ak/5UpsVYPqA1rAwj7odudoph5czYB4WVxAEh37B
	 p74aY9sW14XC/11KAa741qGJTTTtDz0QyHYCMxkLoB1HxsWqbFj9+MDrB0kC3GKOgC
	 e+5Y315jBsgPfgUCEr5U+gP1gp8BSwzvoICm3WKQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38BC0F806A5; Tue, 10 Jun 2025 21:33:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F98EF806A5;
	Tue, 10 Jun 2025 21:33:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ACD29F800F0; Fri,  6 Jun 2025 08:52:37 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CEC7BF8003A
	for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2025 08:52:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEC7BF8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=I0lxQSqm
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5566qXBa1331324;
	Fri, 6 Jun 2025 01:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749192753;
	bh=WWmGvKTM9mfHp7Y8pdnp8aSwGoQqZcaC+mkl9jwP7YU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=I0lxQSqmVVcn7eTcJaibSeEoy712WMsUgl4gyyqKY/XBuy5Kl3Jwz8oS98Sgq5AQJ
	 AbXoRtnxbNPu6whdyl/Y4nzfXJZFHKS2CbwRZ8vL4epFSebVoNseKh9+9FIgcWeswJ
	 F7zJZXL6oO6wmlyqNLLYIGUqGIfKKfe1j7VU4FVo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5566qWeS1386643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 6 Jun 2025 01:52:33 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Jun 2025 01:52:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Jun 2025 01:52:32 -0500
Received: from LTPW0EX92E.dhcp.ti.com (ltpw0ex92e.dhcp.ti.com
 [172.24.149.200])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5566q4Oh677113;
	Fri, 6 Jun 2025 01:52:29 -0500
From: Niranjan H Y <niranjan.hy@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <tiwai@suse.de>,
        <alsa-devel@alsa-project.org>, <baojun.xu@ti.com>, <jesse-ji@ti.com>,
        <shenghao-ding@ti.com>, <liam.r.girdwood@intel.com>, <navada@ti.com>,
        <v-hampiholi@ti.com>, <niranjan.hy@ti.com>
Subject: [PATCH v1 4/4] ASoc: pcm6240: dt-bindings device support list update
Date: Fri, 6 Jun 2025 12:21:36 +0530
Message-ID: <20250606065136.1821-5-niranjan.hy@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20250606065136.1821-1-niranjan.hy@ti.com>
References: <20250606065136.1821-1-niranjan.hy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-MailFrom: niranjan.hy@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: N4V6TH2GLBZFIDQF3UFC6ZLGFMMQTSLZ
X-Message-ID-Hash: N4V6TH2GLBZFIDQF3UFC6ZLGFMMQTSLZ
X-Mailman-Approved-At: Tue, 10 Jun 2025 19:33:03 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N4V6TH2GLBZFIDQF3UFC6ZLGFMMQTSLZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Removed taa* and tad* device from the support list
as these devices are supported by tac5x1x codec driver

Signed-off-by: Niranjan H Y <niranjan.hy@ti.com>
---
 .../devicetree/bindings/sound/ti,pcm6240.yaml          | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
index d89b4255b51c..b0d5f57dc0f5 100644
--- a/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
@@ -29,8 +29,6 @@ description: |
     https://www.ti.com/lit/gpn/pcm9211
     https://www.ti.com/lit/gpn/pcmd3140
     https://www.ti.com/lit/gpn/pcmd3180
-    https://www.ti.com/lit/gpn/taa5212
-    https://www.ti.com/lit/gpn/tad5212
 
 properties:
   compatible:
@@ -81,10 +79,6 @@ properties:
       ti,pcmd3180: Eight-channel pulse-density-modulation input to TDM or
       I2S output converter.
 
-      ti,taa5212: Low-power high-performance stereo audio ADC with 118-dB
-      dynamic range.
-
-      ti,tad5212: Low-power stereo audio DAC with 120-dB dynamic range.
     oneOf:
       - items:
           - enum:
@@ -98,8 +92,6 @@ properties:
           - enum:
               - ti,pcmd512x
               - ti,pcm9211
-              - ti,taa5212
-              - ti,tad5212
           - const: ti,adc6120
       - items:
           - enum:
@@ -114,8 +106,6 @@ properties:
               - ti,pcmd3140
               - ti,pcmd3180
               - ti,pcm1690
-              - ti,taa5412
-              - ti,tad5412
           - const: ti,pcm6240
       - enum:
           - ti,adc6120
-- 
2.45.2

