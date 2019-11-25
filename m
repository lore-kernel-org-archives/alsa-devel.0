Return-Path: <SRS0=E7cH=ZR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95223C432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2019 03:06:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D96E20828
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2019 03:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S+Sn5kvk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MZaDQ/yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D96E20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B320B189B;
	Mon, 25 Nov 2019 04:05:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B320B189B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574651156;
	bh=UbLOZDQLUd9yKY8MjD/9mmENiaKAO1D2HZCGU/5hgTs=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S+Sn5kvkzfiVQqss2hxMdfyECWuwuhtLUQyZLEwzJ7vw+W1yVkcbzlBNnBnf7bOs7
	 OHWddd2CvzvjBBagFzDWMrqZxPOGMf2yRguFSw2zVofqHFifrJztF9dCCVqM+hWers
	 r8P+S2IrjuDxabkFvR1zcWaINVItsqJmvaYAvnDM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC2FAF801DA;
	Mon, 25 Nov 2019 04:04:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FBECF80171; Mon, 25 Nov 2019 04:04:11 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa1.perex.cz (Postfix) with ESMTP id BA3BCF8014D
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2019 04:04:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA3BCF8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="MZaDQ/yG"
X-UUID: cffb1105da744d3c875d09a9bfd0b650-20191125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=xPwAuPbYqVTpCU+/Qwr9HRbYfn2HZlsgAk8+/UzaHEI=; 
 b=MZaDQ/yGQYYCwIAeMGMv+MS6RSBn3LccpITF7gB4LjWyMDAEQJjxXbcHUqhUQqDOckoDC+l7fcaTamCrwvaZWafVRnZtxmv7e+77iRyGgb+n15Y/J130gu0J6BAv9SGoqM4egC1j0FuX/Yr8V8tE+nCVC51y3GhrXOifHS79F2Y=;
X-UUID: cffb1105da744d3c875d09a9bfd0b650-20191125
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 257953151; Mon, 25 Nov 2019 11:04:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 25 Nov 2019 11:03:49 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Nov 2019 11:03:52 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <mark.rutland@arm.com>, <yingjoe.chen@mediatek.com>, 
 <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <linux@roeck-us.net>,
 <wim@linux-watchdog.org>
Date: Mon, 25 Nov 2019 11:03:48 +0800
Message-ID: <1574651030-29519-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
X-MTK: N
Cc: alsa-devel@alsa-project.org, yong.liang@mediatek.com, lgirdwood@gmail.com,
 jiaxin.yu@mediatek.com, tzungbi@google.com, linux-mediatek@lists.infradead.org,
 eason.yen@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH v5 0/2] ASoC: mt8183: fix audio playback slowly
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
machine driver during bootup, they depend on the for-next.

v5 changes:
	1. Add Signed-off-by tag and Reviewed-by tag.

v4 changes:
	1. Fixed wrong signed-off as correct mail suffix.
	2. Fixed patch subject that add patch version.

v3 changes:
	1. https://patchwork.kernel.org/patch/11164283/ and 
	   https://patchwork.kernel.org/patch/11164305/ has been merged.
	2. Change the name of mtk_wdt_compatible to mtk_wdt_data.
	3. Remove toprgu_reset struct and use mtk_wdt_dev instead.
	4. Get the value of sw_rst_num from .h file.
	5. Adddd mt2712-resets.h for mt2712.
	6. Improve commit message.

v2 changes:
	1. remove "WIP" that in the title of patches
	2. add hyper link for the patch that depends on
	3. patchwork list:
		https://patchwork.kernel.org/cover/11164285/
		https://patchwork.kernel.org/patch/11164295/
		https://patchwork.kernel.org/patch/11164299/
		https://patchwork.kernel.org/patch/11164283/
		https://patchwork.kernel.org/patch/11164305/

v1 changes:
	1. patchwork list:
		https://patchwork.kernel.org/cover/11164173/
		https://patchwork.kernel.org/patch/11164181/
		https://patchwork.kernel.org/patch/11164185/
		https://patchwork.kernel.org/patch/11164187/
		https://patchwork.kernel.org/patch/11164175/

yong.liang (2):
  dt-bindings: mediatek: mt8183: Add #reset-cells
  watchdog: mtk_wdt: mt8183: Add reset controller

 .../devicetree/bindings/watchdog/mtk-wdt.txt  |  10 +-
 drivers/watchdog/Kconfig                      |   1 +
 drivers/watchdog/mtk_wdt.c                    | 111 +++++++++++++++++-
 .../reset-controller/mt2712-resets.h          |  22 ++++
 .../reset-controller/mt8183-resets.h          |  15 +++
 5 files changed, 155 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/reset-controller/mt2712-resets.h

-- 
2.18.0
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
