Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9589C432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 03:50:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFDA60184
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 03:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BFDA60184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C868176B;
	Wed,  1 Sep 2021 05:50:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C868176B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630468256;
	bh=e687hTzUpvs0r/pl/v8dNzzouNZg2lEnlUAth/79V6c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=leuoakhEO3kmlyW9yfzDcpSJa8KpYUHRdIKFlHFthwDGfuF/g5bndMZcnNJkF0v2+
	 lL0X09z32YOT8sv7EUV0BJ6sM+EVoIEnBUrN/TaWON9QFTWw1OFOQ00tcGAg69WzBc
	 iYj/L8+d/JsiHawhAksioKpljZ8rttESrfey0ByY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0B83F804C2;
	Wed,  1 Sep 2021 05:49:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2F78F804FD; Wed,  1 Sep 2021 05:48:59 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.131])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE683F804C2
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 05:48:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE683F804C2
Received: from localhost (unknown [192.168.167.172])
 by lucky1.263xmail.com (Postfix) with ESMTP id BCF0AC2BE0;
 Wed,  1 Sep 2021 11:48:22 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P6276T140523079702272S1630468091356880_; 
 Wed, 01 Sep 2021 11:48:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <02cde326fe641878c4d8da24f13fbfc4>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 6
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org,
	heiko@sntech.de
Subject: [PATCH v3 4/7] ASoC: dt-bindings: rockchip: Add binding for rk3568 pdm
Date: Wed,  1 Sep 2021 11:48:00 +0800
Message-Id: <1630468083-7248-4-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630468039-7186-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1630468039-7186-1-git-send-email-sugar.zhang@rock-chips.com>
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>,
 linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
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

This patch documents for rk3568 pdm.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
index 60e8630..54d94438 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
@@ -6,6 +6,7 @@ Required properties:
   - "rockchip,px30-pdm"
   - "rockchip,rk1808-pdm"
   - "rockchip,rk3308-pdm"
+  - "rockchip,rk3568-pdm"
   - "rockchip,rv1126-pdm"
 - reg: physical base address of the controller and length of memory mapped
   region.
-- 
2.7.4



