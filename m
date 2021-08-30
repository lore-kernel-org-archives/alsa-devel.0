Return-Path: <SRS0=+0+W=NV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDBDC4320A
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 01:11:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C2260F51
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 01:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2C2260F51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF26A1690;
	Mon, 30 Aug 2021 03:10:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF26A1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630285862;
	bh=HZEvJ5CJM28vwAl8Y46ulux3yQqchGH/jViXKCt9Q78=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AFvefLIuukaF8KvRfmvNxoXgazSaW/fcdgP5cMxNJMowzxdX1w9TaH3fntxWLKh/K
	 B57ukn/LazdXpQ/X78KNaKI+rvB49pDE0/fdoqnv0mAkK792Sap9Rat5sVrrKnW1PD
	 VP/yZyiTVJTmWkgypwx47MG5xecRifausCQDYRA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40048F80254;
	Mon, 30 Aug 2021 03:10:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3361DF8025B; Mon, 30 Aug 2021 03:10:11 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.135])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAA91F80246
 for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2021 03:10:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAA91F80246
Received: from localhost (unknown [192.168.167.105])
 by lucky1.263xmail.com (Postfix) with ESMTP id 5E349B2B7F;
 Mon, 30 Aug 2021 09:10:03 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P21354T140059569596160S1630285801742244_; 
 Mon, 30 Aug 2021 09:10:02 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <fb0bbc06b9b6325a531ad37e82e002c3>
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
Subject: [PATCH v2 0/7] Patches to update for rockchip pdm
Date: Mon, 30 Aug 2021 09:09:48 +0800
Message-Id: <1630285788-28002-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
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

These patches fixup or update for rockchip pdm.

Changes in v2:
- Fix yamllint errors.

Sugar Zhang (7):
  ASoC: rockchip: Add support for rv1126 pdm
  ASoC: dt-bindings: rockchip: Add binding for rv1126 pdm
  ASoC: rockchip: pdm: Add support for rk3568 pdm
  ASoC: dt-bindings: rockchip: Add binding for rk3568 pdm
  ASoC: rockchip: pdm: Add support for path map
  ASoC: dt-bindings: rockchip: pdm: Document property
    'rockchip,path-map'
  ASoC: dt-bindings: rockchip: Convert pdm bindings to yaml

 .../devicetree/bindings/sound/rockchip,pdm.txt     |  46 ---------
 .../devicetree/bindings/sound/rockchip,pdm.yaml    | 115 +++++++++++++++++++++
 sound/soc/rockchip/rockchip_pdm.c                  | 112 ++++++++++++++++++--
 sound/soc/rockchip/rockchip_pdm.h                  |   6 ++
 4 files changed, 227 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/rockchip,pdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,pdm.yaml

-- 
2.7.4



