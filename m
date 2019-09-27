Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F455C32774
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:28:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A8D217F4
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LAgZoS6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A8D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D840C15E4;
	Fri, 27 Sep 2019 11:27:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D840C15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569576487;
	bh=8jIH7KjcftYHkCYvsbXIOE1C8N62r4NcEzClES0wLJw=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LAgZoS6QYr2a6aG72uZ0YMstDISRxv6Oi8ndbrZ9apW6Bc/hodfnW6MqRon9Nrvy3
	 74jbj+e2wR43Ske4potP621e7LEBAc9P1dX526fpJ8ftDybJZgybi/LOW5DN/lGY/L
	 +s5sVPX0nB6C0+Put/l4L+7PFMb8gsDpfvMQ50XM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 479B2F80508;
	Fri, 27 Sep 2019 11:27:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 985EBF80138; Fri, 27 Sep 2019 11:27:15 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa1.perex.cz (Postfix) with ESMTP id A2864F80138
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 11:27:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2864F80138
X-UUID: cc2911bee61541b3b315a097d04a593f-20190927
X-UUID: cc2911bee61541b3b315a097d04a593f-20190927
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 413152314; Fri, 27 Sep 2019 17:27:04 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 27 Sep 2019 17:27:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Sep 2019 17:26:59 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
 <linux@roeck-us.net>, <wim@linux-watchdog.org>
Date: Fri, 27 Sep 2019 17:26:53 +0800
Message-ID: <1569576417-20663-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
X-TM-SNTS-SMTP: 18D6C949EEDF22B4409F390148C973DF1F529B149042EE7FEC12E467C586A3DB2000:8
X-MTK: N
Cc: alsa-devel@alsa-project.org, yong.liang@mediatek.com, lgirdwood@gmail.com,
 jiaxin.yu@mediatek.com, tzungbi@google.com, linux-mediatek@lists.infradead.org,
 eason.yen@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH 0/4] ASoC: mt8183: fix audio playback slowly
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

*** BLURB HERE ***

Jiaxin Yu (2):
  WIP: dt-bindings: medaitek: mt8183: add property "resets" &&
    "reset-names"
  WIP: ASoC: mt8183: fix audio playback slowly after playback during
    bootup

yong.liang (2):
  WIP: dt-bindings: mediatek: mt8183: Add #reset-cells
  WIP: watchdog: mtk_wdt: mt8183: Add reset controller

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
