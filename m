Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B95C83F37
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Aug 2023 19:47:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EF96741;
	Thu, 31 Aug 2023 21:47:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EF96741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693511272;
	bh=5f1rmA597mEfI75sjK5V+g0nGliaKv8lhSke21Lpwaw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=t8haVcA5/nYY9tpiWrwLMSGo6IT1mwxoIOVw6KqN+hkxf9RHwSSppXjBFnbfSKfua
	 W87eOC28MXneMG60A8GFsMkwK1ZDiexKPKdJqPUk2WUSFQ/HJ14l5vnJfasBG3cL1A
	 1BB+PZYjqJVd1gG2N2mG7x7cZ+4O1pxGiDqnaaew=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE643F804DA; Thu, 31 Aug 2023 21:46:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C745F800F5;
	Thu, 31 Aug 2023 21:46:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3617CF80155; Thu, 31 Aug 2023 21:46:36 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F5DAF80094
	for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2023 21:46:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F5DAF80094
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400";
   d="scan'208";a="178339736"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2023 04:46:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CE35B40062C9;
	Fri,  1 Sep 2023 04:46:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <x1077012@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/3] Match data improvements for tlv320aic32x4 driver
Date: Thu, 31 Aug 2023 20:46:19 +0100
Message-Id: <20230831194622.87653-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IXF4NSREW3GWXTJ2GSVOF33V3AZAEWNZ
X-Message-ID-Hash: IXF4NSREW3GWXTJ2GSVOF33V3AZAEWNZ
X-MailFrom: biju.das.jz@bp.renesas.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IXF4NSREW3GWXTJ2GSVOF33V3AZAEWNZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series aims to add match data improvements for tlv320aic32x4
driver.

This patch series is only compile tested.

v2->v3:
 * Added Rb tag from Andy for patch#1 and patch#2
 * Simplified aic32x4_spi_probe() in patch#3.
v1->v2:
 * Created patch#1 for adding enum aic32x4_type to aic32x4_probe() and
   drop using dev_set_drvdata() from tlv320aic32x4_{i2c,spi} drivers.
 * Return value of i2c_get_match_data() passed to type paramemter in
   aic32x4_probe().

Biju Das (3):
  ASoC: codec: tlv320aic32x4: Add enum aic32x4_type to aic32x4_probe()
  ASoC: tlv320aic32x4-i2c: Simplify probe()
  ASoC: tlv320aic32x4-spi: Simplify probe()

 sound/soc/codecs/tlv320aic32x4-i2c.c | 19 +++----------------
 sound/soc/codecs/tlv320aic32x4-spi.c | 18 +++---------------
 sound/soc/codecs/tlv320aic32x4.c     |  5 +++--
 sound/soc/codecs/tlv320aic32x4.h     |  3 ++-
 4 files changed, 11 insertions(+), 34 deletions(-)

-- 
2.25.1

