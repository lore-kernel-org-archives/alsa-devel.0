Return-Path: <SRS0=Jips=PI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4957DC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 07:16:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C98660EB8
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 07:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C98660EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7EAC16A0;
	Wed, 20 Oct 2021 09:15:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7EAC16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634714167;
	bh=fRyqGIHgLPl5ADW9CXuiFhIGM29DpIcwIrL211rDfL4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gSgZuiE7B1FRfDl2F/bvqooMxFn48M0jGGOLvBFIQwzQ3Tlejzo/3M9CBZvtof51B
	 ylgok8Q49DklVMnsa2DbVBhi7khqXXI90g6MU/XQVaUspC8ZIqdqTklv67kj6bLOx7
	 4AWxU711PVjk8Zcn3wFm/F/Ao3oJK42B4OYW6h7A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB4A7F802A9;
	Wed, 20 Oct 2021 09:14:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 299C6F80300; Wed, 20 Oct 2021 09:14:49 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 091DAF80253
 for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2021 09:14:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 091DAF80253
X-UUID: 424603061424453fab1ea939c1861b06-20211020
X-UUID: 424603061424453fab1ea939c1861b06-20211020
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 756023333; Wed, 20 Oct 2021 15:14:33 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 20 Oct 2021 15:14:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 20 Oct 2021 15:14:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 20 Oct 2021 15:14:31 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>
Subject: [RESEND,
 v2 0/2] ASoC: mediatek: Add support for MT8195 sound card with rt1011
 and rt5682
Date: Wed, 20 Oct 2021 15:14:26 +0800
Message-ID: <20211020071428.14297-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com, aaronyu@google.com,
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

This series of patches adds support for mt8195 board with mt6359, rt1011
and rt5682.
Patches are based on broonie tree "for-next" branch.

Changes since v1:
  - refined code based on Pierre-Louis's suggestions
  - added missing of_node_put
  - fixed wrong fixup assignment on HDMITX

Trevor Wu (2):
  ASoC: mediatek: mt8195: add machine driver with mt6359, rt1011 and
    rt5682
  dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1011-rt5682
    document

 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    |   47 +
 sound/soc/mediatek/Kconfig                    |   15 +
 sound/soc/mediatek/mt8195/Makefile            |    1 +
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 1155 +++++++++++++++++
 4 files changed, 1218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c

-- 
2.18.0

