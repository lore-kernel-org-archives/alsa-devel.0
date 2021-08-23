Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5EEC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 10:56:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41B961186
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 10:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D41B961186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E47C167A;
	Mon, 23 Aug 2021 12:55:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E47C167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629716169;
	bh=F1v0KJqe1miw68YlrI9px6GhghiX/DEPC6wu4gzLQAE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KbxsSNCRsZcFXNH5ntZe5AcXs6eVdfBsS6pbwYqrPNsvQ8aL3CM8J+ng0Zh8tOqsM
	 kDOdToDoB1JOZED7eQzbWKraMFx71mMvPCY/wqY/DNNh47xcFize3zIfDyB0cPpZ5e
	 ggcn97geLJRRYYk03z8kD3pBqpXu5f1Ba1Wd5gRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CAB8F80431;
	Mon, 23 Aug 2021 12:54:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFFB7F804E6; Mon, 23 Aug 2021 12:54:48 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.132])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 602CCF8020C
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 12:54:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 602CCF8020C
Received: from localhost (unknown [192.168.167.225])
 by lucky1.263xmail.com (Postfix) with ESMTP id F36DBFB5F6;
 Mon, 23 Aug 2021 18:54:38 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P10596T140297356953344S1629716077595046_; 
 Mon, 23 Aug 2021 18:54:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7744b2575fba8ab9f2f9be421384bba5>
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
Subject: [PATCH 11/15] ASoC: rockchip: i2s: Add compatible for more SoCs
Date: Mon, 23 Aug 2021 18:54:32 +0800
Message-Id: <1629716076-21465-2-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
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

This patch adds more compatible strings for SoCs.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Change-Id: I980a7c34a7f6c82a066a37e7f97fa4e69cbae583
---
 sound/soc/rockchip/rockchip_i2s.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index cedfe47..a0f2778 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -613,10 +613,20 @@ static const struct rk_i2s_pins rk3399_i2s_pins = {
 };
 
 static const struct of_device_id rockchip_i2s_match[] __maybe_unused = {
+	{ .compatible = "rockchip,px30-i2s", },
+	{ .compatible = "rockchip,rk1808-i2s", },
+	{ .compatible = "rockchip,rk3036-i2s", },
 	{ .compatible = "rockchip,rk3066-i2s", },
+	{ .compatible = "rockchip,rk3128-i2s", },
 	{ .compatible = "rockchip,rk3188-i2s", },
+	{ .compatible = "rockchip,rk3228-i2s", },
 	{ .compatible = "rockchip,rk3288-i2s", },
+	{ .compatible = "rockchip,rk3308-i2s", },
+	{ .compatible = "rockchip,rk3328-i2s", },
+	{ .compatible = "rockchip,rk3366-i2s", },
+	{ .compatible = "rockchip,rk3368-i2s", },
 	{ .compatible = "rockchip,rk3399-i2s", .data = &rk3399_i2s_pins },
+	{ .compatible = "rockchip,rv1126-i2s", },
 	{},
 };
 
-- 
2.7.4



