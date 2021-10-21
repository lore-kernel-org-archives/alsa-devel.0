Return-Path: <SRS0=mh1Z=PJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7847CC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Oct 2021 04:00:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2787F60F6E
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Oct 2021 03:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2787F60F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A22BD167D;
	Thu, 21 Oct 2021 05:59:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A22BD167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634788796;
	bh=WYvEyVgwpBo/8rUv9z+gWEKOs3Ovhqt8tAsTktxi6vA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ec3/WxxL8m86TUKbBximNBWFCi9U5Wr1gQepPGPlzN75V5aoA4wpKxXPXGsN7Xivy
	 qpFABJorbmHMgwd+i0qDZV0ed2z/2x1aNm7IbLmNSv248G7aHaAldJdsBE/XpOGvQ0
	 SkdJxcZft4gN0QcaCvzl5o6Dg92HIevXA763Z3Lk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C4BCF80246;
	Thu, 21 Oct 2021 05:59:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7000FF80249; Thu, 21 Oct 2021 05:59:03 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44D01F8011C
 for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2021 05:58:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44D01F8011C
X-UUID: bac1888e3b3d40c59257dc7eb9aad423-20211021
X-UUID: bac1888e3b3d40c59257dc7eb9aad423-20211021
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yc.hung@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1747227135; Thu, 21 Oct 2021 11:58:46 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Oct 2021 11:58:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 21 Oct 2021 11:58:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 21 Oct 2021 11:58:45 +0800
From: YC Hung <yc.hung@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>
Subject: [PATCH v2 0/2] Add code to manage DSP clocks and provide dts-binding
 document
Date: Thu, 21 Oct 2021 11:58:39 +0800
Message-ID: <20211021035841.2365-1-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 allen-kh.cheng@mediatek.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 yc.hung@mediatek.com, daniel.baluta@nxp.com,
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

From: "yc.hung" <yc.hung@mediatek.com>

This code is based on top of SOF topic/sof-dev branch and we want to have a review 
with ALSA and device Tree communities the it will be merged to SOF tree and then
merged into ALSA tree. It provides two patches, one is for mt8195 dsp clocks related.
Another is for mt8195 dsp dts binding decription.

YC Hung (2):
  ASoC: SOF: mediatek: Add mt8195 dsp clock support
  dt-bindings: dsp: mediatek: Add mt8195 DSP binding support

 .../bindings/dsp/mtk,mt8195-dsp.yaml          | 139 +++++++++++++++
 sound/soc/sof/mediatek/mt8195/Makefile        |   2 +-
 sound/soc/sof/mediatek/mt8195/mt8195-clk.c    | 164 ++++++++++++++++++
 sound/soc/sof/mediatek/mt8195/mt8195-clk.h    |  29 ++++
 sound/soc/sof/mediatek/mt8195/mt8195.c        |  23 ++-
 5 files changed, 354 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.c
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.h

-- 
2.18.0

