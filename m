Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EE2C4360C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 10:33:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FDE217D7
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 10:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p7bLinfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FDE217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E2941614;
	Fri, 27 Sep 2019 12:32:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E2941614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569580386;
	bh=2Qk/oCJNqawU3pOUNn29sB7Jm4Ag6Lc5w5pbQ3Bdp5w=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p7bLinfxpwEoAv9IXKZ5nux5OBF0xW/xvhnD2zlMVq2bSIuIZWKk2hraTUjnNPzP3
	 y8RFvh6uc3YhPcfFsvmLwp3tNvFsYcWf+xjA2xr1QtnXP7ty1LMUdKxKNe/oaMeyc9
	 hlqZxVpW/Up/lzBLABS6EMDJ2pKPiuarr6Nv67as=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC08FF8044C;
	Fri, 27 Sep 2019 12:32:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91C9CF805A8; Fri, 27 Sep 2019 12:32:14 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id 0A137F80140
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 12:32:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A137F80140
X-UUID: ccbf7ee149e74c3faf74a0849cd0bc5e-20190927
X-UUID: ccbf7ee149e74c3faf74a0849cd0bc5e-20190927
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
 mailgw02.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1138489025; Fri, 27 Sep 2019 18:32:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 27 Sep 2019 18:31:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Sep 2019 18:31:57 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
 <linux@roeck-us.net>, <wim@linux-watchdog.org>
Date: Fri, 27 Sep 2019 18:31:53 +0800
Message-ID: <1569580317-21181-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9EC9B41ACD81D96D4657B1B000FF35A2B3D68B95758CA29C6DC62AD7B037718E2000:8
X-MTK: N
Cc: alsa-devel@alsa-project.org, yong.liang@mediatek.com, lgirdwood@gmail.com,
 jiaxin.yu@mediatek.com, tzungbi@google.com, linux-mediatek@lists.infradead.org,
 eason.yen@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH v2 0/4] ASoC: mt8183: fix audio playback slowly
	after playback
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This series patches add reset controller for MT8183, and audio will use it in 
machine driver during bootup, they depend on the following patch:

1. this series add support reset-controller in infra
	[v5,2/2] clk: reset: Modify reset-controller driver
	https://patchwork.kernel.org/patch/11060419/

v2 changes:
	1. remove "WIP" that in the title of patches
	2. add hyper link for the patch that depends on

Jiaxin Yu (2):
  dt-bindings: medaitek: mt8183: add property "resets" && "reset-names"
  ASoC: mt8183: fix audio playback slowly after playback during bootup

yong.liang (2):
  dt-bindings: mediatek: mt8183: Add #reset-cells
  watchdog: mtk_wdt: mt8183: Add reset controller

 .../bindings/sound/mt8183-afe-pcm.txt         |   6 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt  |   9 +-
 drivers/watchdog/Kconfig                      |   1 +
 drivers/watchdog/mtk_wdt.c                    | 110 +++++++++++++++++-
 .../reset-controller/mt8183-resets.h          |  13 +++
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c    |  15 +++
 6 files changed, 150 insertions(+), 4 deletions(-)

-- 
2.18.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
