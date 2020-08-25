Return-Path: <SRS0=PqWm=CF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E0C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:53:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383FC207DF
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DqDuTe2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383FC207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5507180A;
	Thu, 27 Aug 2020 18:52:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5507180A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598547199;
	bh=RaOz6ulOiqof/phL3MP0hG7EUAcdRaw+8zD75bpd6EI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DqDuTe2ae1+cPh3FMm2PE9mBvAt0TtkJpeFRRkkTJnKjmWQTz0CbnR5ncoiytX8PA
	 NeGnRORSmUehtkE2+X/gSYWjmIkyouCgdkOjuh4HDGJn3L0GujCiNlcUxXob0r0B5p
	 5FdT8+tMw6ZS2WB/51ohdKN21i2B0xBeTtrNOH9Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC404F8027B;
	Thu, 27 Aug 2020 18:50:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24021F80245; Tue, 25 Aug 2020 14:06:18 +0200 (CEST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37376F8025A
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 14:06:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37376F8025A
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 35D83423E0EFD375A76F;
 Tue, 25 Aug 2020 20:06:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 25 Aug 2020
 20:05:51 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <timur@kernel.org>, <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>,
 <festevam@gmail.com>, <shengjiu.wang@gmail.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
 <linux-imx@nxp.com>, <xobs@kosagi.com>
Subject: [PATCH 0/2] do exception handling appropriately in imx_es8328_probe()
Date: Tue, 25 Aug 2020 20:05:29 +0800
Message-ID: <20200825120531.1479304-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 27 Aug 2020 18:50:46 +0200
Cc: alsa-devel@alsa-project.org, yi.zhang@huawei.com,
 linux-kernel@vger.kernel.org, yukuai@huawei.com, linuxppc-dev@lists.ozlabs.org,
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

Yu Kuai (2):
  ASoC: fsl: imx-es8328: add missing kfree() call in imx_es8328_probe()
  ASoC: fsl: imx-es8328: add missing put_device() call in
    imx_es8328_probe()

 sound/soc/fsl/imx-es8328.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.25.4

