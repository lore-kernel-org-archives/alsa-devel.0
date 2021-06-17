Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD88FC2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:41:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5419D61026
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5419D61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA4131743;
	Thu, 17 Jun 2021 16:40:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA4131743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623940898;
	bh=dpgXzX6KBWOASS630dMFOOuwA+GpWTe6uk+83IT3DUY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RK4Fm9Q0VE/BbmXlGyRrG5FDlrXJXHLnp2sGFsz53QKFQFpcMNAVpUdXrG3HBYCAD
	 kaNxhFeYVoyJD/BHuYmqJFn6+dWVSYxQa4kXbZHak1ydwYhixRUNlRgq7urTYzFVtk
	 9V4M8Xy/HQPtEvmuweq7urvia4HlV2aEftMLjNys=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 131F1F80535;
	Thu, 17 Jun 2021 16:35:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4E32F8025A; Thu, 17 Jun 2021 07:48:43 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1699F80088
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 07:48:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1699F80088
X-UUID: 0e29273f71e6465eaf1a7fb97a1ea95d-20210617
X-UUID: 0e29273f71e6465eaf1a7fb97a1ea95d-20210617
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1345642492; Thu, 17 Jun 2021 13:48:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 13:48:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 17 Jun 2021 13:48:20 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>
Subject: [PATCH 0/8] ASoC: mediatek: Add support for MT8195 SoC
Date: Thu, 17 Jun 2021 13:47:31 +0800
Message-ID: <20210617054740.8081-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Approved-At: Thu, 17 Jun 2021 16:34:46 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, bicycle.tsai@mediatek.com, linux-kernel@vger.kernel.org,
 jiaxin.yu@mediatek.com, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, linux-arm-kernel@lists.infradead.org
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

This series of patches adds support for Mediatek AFE of MT8195 SoC.
Patches are based on broonie tree "for-next" branch.

Trevor Wu (8):
  ASoC: mediatek: mt8195: update mediatek common driver
  ASoC: mediatek: mt8195: support etdm in platform driver
  ASoC: mediatek: mt8195: support adda in platform driver
  ASoC: mediatek: mt8195: support pcm in platform driver
  ASoC: mediatek: mt8195: add platform driver
  dt-bindings: mediatek: mt8195: add audio afe document
  ASoC: mediatek: mt8195: add machine driver with mt6359, rt1019 and
    rt5682
  dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1019-rt5682
    document

 .../bindings/sound/mt8195-afe-pcm.yaml        |   72 +
 .../sound/mt8195-mt6359-rt1019-rt5682.yaml    |   39 +
 sound/soc/mediatek/Kconfig                    |   23 +
 sound/soc/mediatek/Makefile                   |    1 +
 sound/soc/mediatek/common/mtk-afe-fe-dai.c    |   20 +-
 sound/soc/mediatek/common/mtk-base-afe.h      |   10 +-
 sound/soc/mediatek/mt8195/Makefile            |   14 +
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c    |  899 +++++
 sound/soc/mediatek/mt8195/mt8195-afe-clk.h    |  201 +
 sound/soc/mediatek/mt8195/mt8195-afe-common.h |  200 +
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    | 3264 +++++++++++++++++
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c   |  929 +++++
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c   | 2666 ++++++++++++++
 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c    |  393 ++
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      |  974 +++++
 sound/soc/mediatek/mt8195/mt8195-reg.h        | 2793 ++++++++++++++
 16 files changed, 12494 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
 create mode 100644 sound/soc/mediatek/mt8195/Makefile
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-reg.h

-- 
2.18.0

