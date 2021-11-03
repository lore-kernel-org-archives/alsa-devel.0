Return-Path: <SRS0=wMeK=PW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65322C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Nov 2021 10:01:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4E661156
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Nov 2021 10:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D4E661156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E49E167B;
	Wed,  3 Nov 2021 11:01:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E49E167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635933715;
	bh=xCJKd1g/YYKa58I9XL71tngFKm46+R83zubqewbYsVQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VaKZBcuduedzselEGItEQWXUT8CvHd/kWi+X6r0MwnGFLuYcC1+jF7hylFCD537GE
	 HGipEEQv+axCty/BslFfu+i9mT6ml5XWTSs6KRuKN7kYTC0XXSQeykYL73IoEmeqUF
	 5J01ZfQBmRA47QrAXJcyPXXZgv6Hu5wNVJYCFqlU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48B8FF800D2;
	Wed,  3 Nov 2021 11:01:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFC38F804C3; Wed,  3 Nov 2021 11:01:01 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9DFEF800D2
 for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2021 11:00:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9DFEF800D2
X-UUID: da6ae55821ea4e10bbf10a84365b9deb-20211103
X-UUID: da6ae55821ea4e10bbf10a84365b9deb-20211103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1341963609; Wed, 03 Nov 2021 18:00:45 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Wed, 3 Nov 2021 18:00:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 3 Nov 2021 18:00:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 3 Nov 2021 18:00:44 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>
Subject: [PATCH 0/4] ASoC: mediatek: Update MT8195 machine driver
Date: Wed, 3 Nov 2021 18:00:36 +0800
Message-ID: <20211103100040.11933-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, yc.hung@mediatek.com, daniel.baluta@nxp.com,
 linux-arm-kernel@lists.infradead.org
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

Thes series of patches adds support for RT5682s headset codec and
create a new machine driver for SOF support.
Patches are based on broonie tree "for-next" branch.


Trevor Wu (4):
  ASoC: mediatek: mt8195: add headset codec rt5682s support
  dt-bindings: mediatek: mt8195: add model property
  ASoC: mediatek: mt8195: separate the common code from machine driver
  ASoC: mediatek: mt8195: add machine driver for MT8195 SOF support

 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    |   4 +
 .../sound/mt8195-mt6359-rt1019-rt5682.yaml    |   4 +
 sound/soc/mediatek/Kconfig                    |   2 +
 sound/soc/mediatek/mt8195/Makefile            |  16 +-
 sound/soc/mediatek/mt8195/mt8195-common.c     | 398 ++++++++++++
 sound/soc/mediatek/mt8195/mt8195-common.h     |  33 +
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 591 +-----------------
 .../mt8195/mt8195-mt6359-rt1019-rt5682-sof.c  | 557 +++++++++++++++++
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 551 +---------------
 .../mediatek/mt8195/mt8195-realtek-common.c   | 161 +++++
 .../mediatek/mt8195/mt8195-realtek-common.h   |  34 +
 11 files changed, 1267 insertions(+), 1084 deletions(-)
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-common.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-common.h
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682-sof.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-realtek-common.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-realtek-common.h

-- 
2.18.0

