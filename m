Return-Path: <SRS0=TlZm=FT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93F3C4361B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 05:41:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0C5207A0
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 05:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0C5207A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 058AF17BE;
	Tue, 15 Dec 2020 06:40:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 058AF17BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608010880;
	bh=3tSDbfVBt6kmwJIhc6jP5G91e1Zak81ckSNzcDVpuOs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LjJTIr/kAF/+Vu1sfv9Qvnb/T0i8Yx00aj8J/WSU5RuxNLr0HA10Xk/rQ2szvgJ3l
	 4RSYuNu/6qa/DWanezIOtm/r5tlEjLoLUwGU4XgcTaIGIshOXFNP06S1gGjRtajw6a
	 aHIXOwSuyAflNT8TZgs2Bh0ijeAozyJUl0/M0/h4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5AB0F804AC;
	Tue, 15 Dec 2020 06:39:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54B66F804AE; Tue, 15 Dec 2020 06:39:46 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80522F8027B
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2020 06:39:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80522F8027B
IronPort-SDR: GySGX4qMdT3klTUVh20Xo7gRJG/GZ19R3Jcjlga1qUJvGw11UZQItBDENmQv02mRUsdQgCpYNk
 UoKJHbKwxb5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="174938478"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="174938478"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 21:39:36 -0800
IronPort-SDR: GSPHFDp4TDUkeHJLEsHQkx6gey8pLUmInMUvkJ02mIkwiqM1xkqPFgzS+Ok0QATtMFEFijo7T9
 PYHDqFeh4gvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="341384711"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by orsmga006.jf.intel.com with ESMTP; 14 Dec 2020 21:39:31 -0800
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] dt-bindings: sound: intel,
 keembay-i2s: Add info for device to use DMA
Date: Tue, 15 Dec 2020 13:33:06 +0800
Message-Id: <20201215053307.24128-2-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215053307.24128-1-michael.wei.hong.sit@intel.com>
References: <20201215053307.24128-1-michael.wei.hong.sit@intel.com>
Cc: cezary.rojewski@intel.com, lars@metafoo.de, tiwai@suse.com,
 jee.heng.sia@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

Add descriptions for entries needed for audio device to use DMA
channels for audio playback and capture.

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../bindings/sound/intel,keembay-i2s.yaml          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
index d346e61ab708..e0658f122cbb 100644
--- a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
@@ -45,6 +45,18 @@ properties:
       - const: osc
       - const: apb_clk
 
+  dmas:
+    items:
+      - description: DMA controller phandle and DMA channel
+                     for TX and RX
+
+  dma-names:
+    items:
+      - description: "tx" for the transmit channel
+                     "rx" for the receive channel
+      - const: tx
+      - const: rx
+
 required:
   - compatible
   - "#sound-dai-cells"
@@ -70,4 +82,6 @@ examples:
          interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
          clock-names = "osc", "apb_clk";
          clocks = <&scmi_clk KEEM_BAY_PSS_AUX_I2S3>, <&scmi_clk KEEM_BAY_PSS_I2S3>;
+         dmas = <&axi_dma0 29 &axi_dma0 33>;
+         dma-names = "tx", "rx";
      };
-- 
2.17.1

