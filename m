Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F45C388F9
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 03:08:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2992145D
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 03:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="neboJ87q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2992145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD1E2169F;
	Fri, 20 Nov 2020 04:07:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD1E2169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605841698;
	bh=ZKTdhfjoVc6xO8eGBxQ679qhWlbyLS9fBT6Fk8HZHPI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=neboJ87qGC2tlbwko4Y/lJGQ9Oif+PihKdRMluleDfWPgsrXgosTd4w94TwtQNZ+G
	 JOHP7L46GovKGGwBQHxJ3JKjHeYefItW7ZI4G5nfZgCs4OSfPVSCGytJI2G7Jn5f+p
	 9Yy6hhaNVflvaRFkxBmDX5uEVP8nVSTxfE4deFQs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93A5FF8016C;
	Fri, 20 Nov 2020 04:06:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05319F80258; Fri, 20 Nov 2020 04:06:40 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id 14AB9F80166
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 04:06:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14AB9F80166
X-UUID: 134a31710ab441c0a6ee90afef59f650-20201120
X-UUID: 134a31710ab441c0a6ee90afef59f650-20201120
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 867907177; Fri, 20 Nov 2020 11:06:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Nov 2020 11:06:15 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Nov 2020 11:06:14 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>,
 <tzungbi@google.com>, <alsa-devel@alsa-project.org>, <robh+dt@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>, 
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: mt6359: Fix regulator_dev_lookup() fails for id
 "LDO_VAUD18"
Date: Fri, 20 Nov 2020 11:06:11 +0800
Message-ID: <1605841573-1442-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: shane.chien@mediatek.com, Trevor.Wu@mediatek.com,
 Jiaxin Yu <jiaxin.yu@mediatek.com>
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

This series fixed "LDO_VAUD18-supply" regulator register fail.
We can see the error log "mt6359-sound supply LDO_VAUD18 not found, using
dummy regulator" when register the DAPM widget "LDO_VAUD18"
Otherwise, the power can not be turned on correctly when recording.

Jiaxin Yu (2):
  ASoC: mediatek: mt6359: Fix regulator_dev_lookup() fails for id
    "LDO_VAUD18"
  dt-bindings: mediatek: mt6359: remove unused property for mt6359

 Documentation/devicetree/bindings/sound/mt6359.yaml | 9 ---------
 sound/soc/codecs/mt6359.c                           | 7 ++++---
 2 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.18.0

