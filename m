Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2129C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 04:26:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D2720756
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 04:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ODAFEwT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D2720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD2831660;
	Tue, 11 Aug 2020 06:25:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD2831660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597119984;
	bh=kiDiO7wej7+alDCKt+sbkcth0myaeRfk4yAiF+Tfs9g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ODAFEwT2QBE/XCKpnIKDcXPTLE9XCJrIqclnOKtq6sOo74o99vzutZoDduZCo+aHi
	 1jRmS2iCO1vASaqASGfZhOziGWfVcgHlm6yKSGYrmcJWPKn54fx5thxQkf5kd+oE3n
	 MELsER9hh1rDkDv/DUhdQF97qcHohLs4QDeLBe6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53175F80259;
	Tue, 11 Aug 2020 06:24:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D7B0F8027B; Tue, 11 Aug 2020 06:24:06 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9AC30F80162
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 06:23:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9AC30F80162
IronPort-SDR: CaBsuL0TYzFRODvtMtl4SsYeKyrimlV3SVRvZKXoNNlW2lQgl97Xmb3uViJ/4oUWyrbDffnAnh
 So3y9WYGnqyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151344268"
X-IronPort-AV: E=Sophos;i="5.75,459,1589266800"; d="scan'208";a="151344268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 21:23:57 -0700
IronPort-SDR: UmuRdHVYka3Zhko/wqUDPRgNgZqTGlY79TTNACAfiBV62oW1Ifun/IpuQJPPVFPsaqzXZUTcOr
 3bWj7fGmH8jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,459,1589266800"; d="scan'208";a="495020886"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2020 21:23:55 -0700
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/2] dt-bindings: sound: intel,
 keembay-i2s: Add new compatible string
Date: Tue, 11 Aug 2020 12:18:36 +0800
Message-Id: <20200811041836.999-3-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811041836.999-1-michael.wei.hong.sit@intel.com>
References: <20200811041836.999-1-michael.wei.hong.sit@intel.com>
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

Add a new compatible string that configures the interface to the
desired format.

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Reviewed-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
index 175e4fb0c315..973ecccbe27c 100644
--- a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - intel,keembay-i2s
+      - intel,keembay-tdm
 
   "#sound-dai-cells":
     const: 0
-- 
2.17.1

