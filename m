Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2545C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 07:55:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EFB6135F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 07:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6EFB6135F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61B4F1658;
	Tue, 24 Aug 2021 09:54:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61B4F1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629791711;
	bh=CyuklNmCgWTBNVMwPsJ1HLGxPG7ZTCIGyePMJS3LPWU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EBohxO8UfJQkiYedr9GKlMxFzW+TF0fthUO76kE3zlK88xpaZZr/VagcjOV9iLPsl
	 stbIckhxZqcKQJNfwwh3qaBmLLw5eVcoqB1HNv/9DAsVPhB1oS2lfP9MZ10shly9zD
	 EDXYVZBO2AWvpCC+dLCVtl/+YmA5fvJhMqVri+PQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2609F804EC;
	Tue, 24 Aug 2021 09:53:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 188A6F804EC; Tue, 24 Aug 2021 09:53:13 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.131])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFBA7F800AE
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 09:53:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFBA7F800AE
Received: from localhost (unknown [192.168.167.16])
 by lucky1.263xmail.com (Postfix) with ESMTP id 49256C2B31;
 Tue, 24 Aug 2021 15:52:59 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P704T139881101649664S1629791566598648_; 
 Tue, 24 Aug 2021 15:52:59 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0251c0de1c471b486eada0e70c302daf>
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
Subject: [PATCH v1 4/7] ASoC: dt-bindings: rockchip: Add binding for rk3568 pdm
Date: Tue, 24 Aug 2021 15:52:34 +0800
Message-Id: <1629791557-13614-4-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629791446-13528-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629791446-13528-1-git-send-email-sugar.zhang@rock-chips.com>
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



