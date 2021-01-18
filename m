Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B35C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 10:35:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44CE2222F
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 10:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44CE2222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 673F41791;
	Mon, 18 Jan 2021 11:34:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 673F41791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610966133;
	bh=+CBCSN9YJnA/iCesfZkr43LG6ee7kj0hZYmBoGttR3k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rBKjbXPY9P51F/ucZpmRgs9wWj2jWY6aGjAl0I7ZsA+unJfKznx7FosH9k3c1MOD+
	 4EU5z4a8HvZ/KtMA44uG9yDeNjlmmwVYrdY66qHlW0+9HdcyBts1mfrXKj0jaKHQDI
	 Vu14asYE/r4gA3DwdFwjg34uCEbB5iF6Mec7hHNA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0C24F80166;
	Mon, 18 Jan 2021 11:34:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E01CF8016E; Mon, 18 Jan 2021 11:34:41 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1640F800E7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 11:34:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1640F800E7
IronPort-SDR: FSf2BmyUIQzTT92nmNchAxsE6aanGeRLI3CBCrtWFw7g2pM6xtPm29X1aOrd152uZrgPNVkXel
 tGjgnR1SLWyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="178872088"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; d="scan'208";a="178872088"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2021 02:34:25 -0800
IronPort-SDR: QJaEC6pc7e/BKk/6HUMEPmM2E8mIegX2R5dFk+Amp5Myg9uefSr1O7zUpDnRBg91P8qKfudwIG
 Xmuhi4mdxCVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; d="scan'208";a="365299894"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by orsmga002.jf.intel.com with ESMTP; 18 Jan 2021 02:34:22 -0800
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] dt-bindings: sound: intel, keembay-i2s: Fix dt binding errors
Date: Mon, 18 Jan 2021 18:27:06 +0800
Message-Id: <20210118102706.6125-1-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: jee.heng.sia@intel.com, broonie@kernel.org, lgirdwood@gmail.com,
 robh+dt@kernel.org
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

Fix devicetree binding errors caused by newly added parameters

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
---
 .../devicetree/bindings/sound/intel,keembay-i2s.yaml        | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
index e0658f122cbb..dba25c33f0b0 100644
--- a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
@@ -47,13 +47,11 @@ properties:
 
   dmas:
     items:
-      - description: DMA controller phandle and DMA channel
-                     for TX and RX
+      - description: DMA TX channel
+      - description: DMA RX channel
 
   dma-names:
     items:
-      - description: "tx" for the transmit channel
-                     "rx" for the receive channel
       - const: tx
       - const: rx
 
-- 
2.17.1

