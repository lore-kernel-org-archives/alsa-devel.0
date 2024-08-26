Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDDEC54735
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:03:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 117D284A;
	Tue, 27 Aug 2024 14:03:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 117D284A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724760233;
	bh=5POpXNON5NQRXTjqqdtKhe5QaC0FzuhkdRz7WSB7mH4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gZcq+u4601Ee1WLRT+wgAAarutPDFak78D7hTuNJ6hvUopX5nVX2X9Usl1u0z5H1J
	 ihBlvzZXSX87V4UkYaCn6qCs3ISVhJJ6JLu2aayCduEm5KfOyivP35k3SyGBXfi/ma
	 RnM1bed12nOr9ED41nNL/85TNdUHflKL9AIxvZos=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83CB8F805D3; Tue, 27 Aug 2024 14:03:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5966FF805E5;
	Tue, 27 Aug 2024 14:03:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67379F80518; Mon, 26 Aug 2024 10:58:04 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1F6A2F80494
	for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2024 10:57:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F6A2F80494
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wsl1L2MjWz1S8wj;
	Mon, 26 Aug 2024 16:57:26 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AF30140120;
	Mon, 26 Aug 2024 16:57:35 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 16:57:35 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <cezary.rojewski@intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<kai.vehmanen@linux.intel.com>, <liaochen4@huawei.com>,
	<u.kleine-koenig@pengutronix.de>, <andy.shevchenko@gmail.com>,
	<kuninori.morimoto.gx@renesas.com>, <robh@kernel.org>
Subject: [PATCH -next 1/4] ASoC: intel: fix module autoloading
Date: Mon, 26 Aug 2024 08:49:21 +0000
Message-ID: <20240826084924.368387-2-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826084924.368387-1-liaochen4@huawei.com>
References: <20240826084924.368387-1-liaochen4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.77]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500020.china.huawei.com (7.185.36.49)
X-MailFrom: liaochen4@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: GIOYIFYQ2QMIE6RZQVZBKTZG4UYMQXU2
X-Message-ID-Hash: GIOYIFYQ2QMIE6RZQVZBKTZG4UYMQXU2
X-Mailman-Approved-At: Tue, 27 Aug 2024 12:02:46 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GIOYIFYQ2QMIE6RZQVZBKTZG4UYMQXU2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 sound/soc/intel/keembay/kmb_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/keembay/kmb_platform.c b/sound/soc/intel/keembay/kmb_platform.c
index 37ea2e1d2e92..aa5de167e790 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -814,6 +814,7 @@ static const struct of_device_id kmb_plat_of_match[] = {
 	{ .compatible = "intel,keembay-tdm", .data = &intel_kmb_tdm_dai},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_plat_of_match);
 
 static int kmb_plat_dai_probe(struct platform_device *pdev)
 {
-- 
2.34.1

