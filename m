Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4024C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 06:02:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D205208A9
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 06:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GSJT9yNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D205208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01B631760;
	Thu, 30 Jul 2020 08:01:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01B631760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596088919;
	bh=hQrP27yrPw56UI3ygILOvPkDxxQCc7tpIdul/kzTVj8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GSJT9yNAY6yw/pOmkFk33z0hMWB0YrqDbkYKwsLnAnLdcqk0Qyg9lmPJbh8rTnUly
	 XsQYqLjjrHxTtTuNilf4wkp7OSj6Ui/C+08u3NRu11QsIQUxI0M5XQ0GfHmt707KVQ
	 7HLJt9ajbSMaIsLSn2a+lw8UP/lPb8tH0SxLKoHc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AAA4F802E2;
	Thu, 30 Jul 2020 07:58:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF272F802DF; Thu, 30 Jul 2020 07:58:48 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1311F802C3
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 07:58:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1311F802C3
IronPort-SDR: /BEZ/wx5ofKoI89PRNlq0thVbmq0imY99Pqf+TeH4JwjIaKvet9xp0E59GA8Z/Iyn3rDYyHQC7
 pk0RYN42TQog==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139545727"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="139545727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 22:58:40 -0700
IronPort-SDR: GRP24ZktKoeqLx64VHcUWznsW/XyniHkE7JRSHjDxIm0gJovVBmwF8+Rfj5NwRWXLG4Lf0l2ws
 3CU+fZ7+qFwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="434923896"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 22:58:38 -0700
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] dt-bindings: sound: intel,
 keembay-i2s: Add channel-max property
Date: Thu, 30 Jul 2020 13:53:19 +0800
Message-Id: <20200730055319.1522-5-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730055319.1522-1-michael.wei.hong.sit@intel.com>
References: <20200730055319.1522-1-michael.wei.hong.sit@intel.com>
Cc: cezary.rojewski@intel.com, andriy.shevchenko@intel.com, tiwai@suse.com,
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

Add a property that configures the interface to the desired max number
of capture channels. The platform may have multiple interfaces with
different number of capture channels.

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Reviewed-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../devicetree/bindings/sound/intel,keembay-i2s.yaml      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
index 175e4fb0c315..9345fc3a2b95 100644
--- a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
@@ -43,6 +43,10 @@ properties:
       - const: osc
       - const: apb_clk
 
+  channel-max:
+    items:
+      - description: Maximum audio input channels
+
 required:
   - compatible
   - "#sound-dai-cells"
@@ -51,6 +55,9 @@ required:
   - clock-names
   - interrupts
 
+optional:
+  - channel-max
+
 examples:
   - |
      #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -65,4 +72,5 @@ examples:
          interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
          clock-names = "osc", "apb_clk";
          clocks = <&scmi_clk KEEM_BAY_PSS_AUX_I2S3>, <&scmi_clk KEEM_BAY_PSS_I2S3>;
+         channel-max = <2>;
      };
-- 
2.17.1

