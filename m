Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35204C04AA5
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Aug 2022 06:55:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C127C825;
	Thu, 25 Aug 2022 08:54:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C127C825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661410528;
	bh=KPleJ5QgTSxWPvL4EMAITBlHh6CcBRarfGPXmod4SEc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dq01eDDQUoqPkso44NCIBZkyOA9wWm9KgJ8wDi6tLdudzwObWUbf1wp5hKEBqyTi5
	 gthjNZIxobdrsVDH1HOuuCJ39Li9BxKWHZQ5wyHupSAaE9v7qENMMzwtT+UFvzWMDE
	 Hk3xHnavIM5mc2lOrHqYvYFjnL6JQDkuEIMm2df8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 674C2F80527;
	Thu, 25 Aug 2022 08:54:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10405F8027C; Thu, 25 Aug 2022 08:54:34 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F1E9F80245;
 Thu, 25 Aug 2022 08:54:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F1E9F80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="HsTdFNr6"
X-UUID: 73386ac644e046bdb9aae3f3620b8d62-20220825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=6GuUro5qIlUHirZ1NQir7sOfvYDYHGHkP5HZ51CeuWg=; 
 b=HsTdFNr6trkpUbgYTstZ9vZT2medPEl3/ZWODx1wMtetMPak/+/+AtxGGMjjVvWbFqZ8hDiEySfxOK7S3efBCkGGNHkb6BdnjDzLC+AQWeGaXCKF96XyZ+l0KEQK5EdkeP2RwpU7twnkOJfh7zyNpdyzCEM1K+zi7IIQRlFx2yI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10, REQID:83d8d903-c623-4a30-b1a4-4401ef5b2b3d, OB:0,
 L
 OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
 Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18, CLOUDID:5bc68655-e800-47dc-8adf-0c936acf4f1b,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 73386ac644e046bdb9aae3f3620b8d62-20220825
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <chunxu.li@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1777537172; Thu, 25 Aug 2022 14:54:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 25 Aug 2022 14:54:15 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via
 Frontend Transport; Thu, 25 Aug 2022 14:54:14 +0800
From: Chunxu Li <chunxu.li@mediatek.com>
To: <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
 <peter.ujfalusi@linux.intel.com>, <lgirdwood@gmail.com>,
 <angelogioacchino.delregno@collabora.com>, <daniel.baluta@nxp.com>
Subject: [PATCH 0/3] ASoC: SOF: mediatek: update SOF driver for mt8186
Date: Thu, 25 Aug 2022 14:54:08 +0800
Message-ID: <20220825065411.31279-1-chunxu.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, Chunxu Li <chunxu.li@mediatek.com>,
 linux-kernel@vger.kernel.org,
 project_global_chrome_upstream_group@mediatek.com,
 linux-mediatek@lists.infradead.org, yc.hung@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 sound-open-firmware@alsa-project.org
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

In these patches, we update SOF driver for mt8186

Chunxu Li (3):
  ASoC: SOF: mediatek: Add dai driver for mt8186
  ASoC: SOF: mediatek: add snd_sof_dsp_ops callbacks for pcm and mail
    box
  ASoC: SOF: mediatek: Use generic implementation for .ipc_msg_data
    field

 sound/soc/sof/mediatek/mt8186/mt8186.c | 49 ++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 7 deletions(-)

-- 
2.25.1

