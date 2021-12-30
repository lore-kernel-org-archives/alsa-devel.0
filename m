Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82791C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Dec 2021 08:49:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1DD3176E;
	Thu, 30 Dec 2021 09:48:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1DD3176E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640854175;
	bh=bj5BIlweHxcwhhM3SBJXwwffJgrkZaLUDgZ+Tu6kneQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=myGxb8NDSZrB0al82OoASly0opFIWBWPNaPI3J7QRvUQZlwDiAFtJdU4CoPw9VGLy
	 FNPdIi8/Jcgvk4k0KYBEJlj3zi4OZDfb83D07A85eW2SEHYdPwVQszhP850MqRIFVu
	 aM+E24ToATHoXJs3kBW3HEeH/3rl9UkxkazAcneY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97694F804D2;
	Thu, 30 Dec 2021 09:47:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B018F8012A; Thu, 30 Dec 2021 09:47:53 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D11DF800D3
 for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2021 09:47:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D11DF800D3
X-UUID: 1f78bb900dfc4a70958dc36edc81acf2-20211230
X-UUID: 1f78bb900dfc4a70958dc36edc81acf2-20211230
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1311688746; Thu, 30 Dec 2021 16:47:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Dec 2021 16:47:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 30 Dec 2021 16:47:34 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
Subject: [PATCH 0/2] ASoC: mediatek: mt8195: repair pcmif BE dai
Date: Thu, 30 Dec 2021 16:47:29 +0800
Message-ID: <20211230084731.31372-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

This series of patches repairs some problems for pcmif BE dai.
The unexpected control flow is corrected, and the missing playback
support of DPCM is added.

Patches are based on broonie tree "for-next" branch.

Trevor Wu (2):
  ASoC: mediatek: mt8195: correct pcmif BE dai control flow
  ASoC: mediatek: mt8195: add playback support to PCM1_BE dai_link

 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c    | 73 ++++++-------------
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      |  1 +
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      |  1 +
 sound/soc/mediatek/mt8195/mt8195-reg.h        |  1 +
 4 files changed, 24 insertions(+), 52 deletions(-)

-- 
2.18.0

