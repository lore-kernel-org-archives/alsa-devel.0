Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C9EC6FA8F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Aug 2023 02:51:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C6C084A;
	Fri, 25 Aug 2023 04:50:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C6C084A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692931888;
	bh=ur4gPBxKZOt8tVLAOQq/LBoqL3l4/SGfzL97SZlb1XI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=O7HZUDn4TFZneAEaQ29D5UfdoEdyc/eCEktfbSu8VrKFW2DoC5/CJMdiUbw74bvsg
	 ictc582AL3M7xQeQjKudyAZ7VX0xV70TksKTXSage2HH6EeakreFp32QYQz0+bI/OH
	 GigW92L+tzOe1Xd1Y9EQxcpD92KebXEur5FuhMp4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6506F804F3; Fri, 25 Aug 2023 04:50:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ABEE9F800AE;
	Fri, 25 Aug 2023 04:50:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2A8DF8023B; Fri, 25 Aug 2023 04:49:58 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8DAF2F80074
	for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2023 04:49:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DAF2F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=X3XBEWf/
X-UUID: 07f816ba42f211ee9cb5633481061a41-20230825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=gSYhZkHSCCzdMmaFCeh8M3KuCNiXviLZbYMre67Qkt0=;
	b=X3XBEWf/YbM3MNoyITimnSMftVNjSIVjsDcFSdpCRG7KYS+mFsxRoKLr9Tj54PEFHyUKofHp/q2EF1ltW6tubKEgNUlGo7merjKdEV24NoL669pZ2lYm+ushCGqIyfQjyhbTgwSKe41Mtck1/zx5F6PhEIY9m+6zBsBNOe3kedM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:8e0f7408-c5bc-4ccd-a1cc-62621f200998,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:93b3ba1f-33fd-4aaa-bb43-d3fd68d9d5ae,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 07f816ba42f211ee9cb5633481061a41-20230825
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com
	(envelope-from <trevor.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1264400844; Fri, 25 Aug 2023 10:49:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Aug 2023 10:49:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Aug 2023 10:49:36 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
	<perex@perex.cz>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>
CC: <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
	<linux-mediatek@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RESEND,v3 0/3] ASoC: mt8188-mt6359: add SOF support
Date: Fri, 25 Aug 2023 10:49:32 +0800
Message-ID: <20230825024935.10878-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Message-ID-Hash: YQSL5YRIJBPM6ZK2X6TXXAHLHPJNJCNF
X-Message-ID-Hash: YQSL5YRIJBPM6ZK2X6TXXAHLHPJNJCNF
X-MailFrom: trevor.wu@mediatek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YQSL5YRIJBPM6ZK2X6TXXAHLHPJNJCNF/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series introduces dynamic pinctrl and adds support for the SOF on
the mt8188-mt6359 machine driver.

Changes since v2:
  - revise mtk_sof_check_tplg_be_dai_link_fixup().
  
Changes since v1:
  - minor changes to incorporate the suggestions from the reviewer.

Trevor Wu (3):
  ASoC: mediatek: mt8188-mt6359: support dynamic pinctrl
  ASoC: mediatek: common: revise SOF common code
  ASoC: mediatek: mt8188-mt6359: add SOF support

 .../soc/mediatek/common/mtk-dsp-sof-common.c  | 113 +++++++--
 .../soc/mediatek/common/mtk-dsp-sof-common.h  |   8 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     | 239 +++++++++++++++++-
 3 files changed, 332 insertions(+), 28 deletions(-)

-- 
2.18.0

