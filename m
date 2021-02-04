Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD219C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 02:03:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA6964E0F
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 02:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA6964E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88DA516E1;
	Thu,  4 Feb 2021 03:02:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88DA516E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612404198;
	bh=tu4MUcoCHm5I6FLxNbvRI0sKrEy3LsR8SFnXjhTYX24=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qv5Y8SxXEri91oMX3m9pIxG99goG2LxgaziopV3ekkE3bCNgWLn3t+P0bYZja+Ooe
	 KKGeWTozn4u0hKKQGGkUx0Ow60466NdTa56OS/4BC82pzIgs2QVkSqhqLqBWCyOnyz
	 Mpv5UpKjgwxA/kiPUOjP25o4i7OLKZzcVgO/uL50=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B62BCF802C9;
	Thu,  4 Feb 2021 03:00:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8F0BF8026B; Thu,  4 Feb 2021 03:00:52 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10587F80155
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 03:00:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10587F80155
IronPort-SDR: 4dEzbhgDHKDMBFcV3nLjkJkQRajn2b3PkMVuVRAm3GnsZIyuGwTudFD/0EzLxrttYlokKvp2wK
 289C9VQkZCFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245227990"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="245227990"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 18:00:41 -0800
IronPort-SDR: Up/NQRq6okm/lv+kmQuHa48QJfjVnH0onl2SKtJv59x+M4v8asTp/W4e7RY0A7XNgccXGcLAwl
 ujFsBmR2YQzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="433712052"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
 by orsmga001.jf.intel.com with ESMTP; 03 Feb 2021 18:00:40 -0800
From: Sia Jee Heng <jee.heng.sia@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH RFC 3/4] dt-bindings: sound: Intel,
 Keembay-i2s: Add hdmi-i2s compatible string
Date: Thu,  4 Feb 2021 09:42:57 +0800
Message-Id: <20210204014258.10197-4-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210204014258.10197-1-jee.heng.sia@intel.com>
References: <20210204014258.10197-1-jee.heng.sia@intel.com>
Cc: broonie@kernel.org, tiwai@suse.com, jee.heng.sia@intel.com,
 pierre-louis.bossart@linux.intel.com
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

Add intel,keembay-hdmi-i2s compatible string to support the
HDMI interface.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
index dba25c33f0b0..6f71294909a5 100644
--- a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - intel,keembay-i2s
       - intel,keembay-tdm
+      - intel,keembay-hdmi-i2s
 
   "#sound-dai-cells":
     const: 0
-- 
2.18.0

