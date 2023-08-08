Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFD8C001B0
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 10:42:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13A48E8C;
	Tue,  8 Aug 2023 12:41:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13A48E8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691491360;
	bh=svXAB4Vaet4LIesIVazgwCtxcXVvx7MxBLKjsGT8IzQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=cdr6EeKTyVKTpRf3vtJoEeZLggFsdMcdRf4garZGwhBs5rjDbBNw+JIEJMQg1RRn5
	 auDBDsnx5fS0Hh02hC4J76gVkiB8THoLmVqrAF3XKoiXO/n+TVpDT4D3XFaSLDz/5Y
	 nDKSW4uXnVZGoPVdykRtgx7xtqG0ezXnBQFnJYOQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 080EAF8068E; Tue,  8 Aug 2023 12:36:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 14B30F80689;
	Tue,  8 Aug 2023 12:36:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23918F8016D; Tue,  8 Aug 2023 04:18:07 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CEA19F80132
	for <alsa-devel@alsa-project.org>; Tue,  8 Aug 2023 04:17:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEA19F80132
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKcFY1mnJzNmvw;
	Tue,  8 Aug 2023 10:14:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 10:17:52 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <shengjiu.wang@gmail.com>, <Xiubo.Lee@gmail.com>, <festevam@gmail.com>,
	<nicoleotsuka@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <shawnguo@kernel.org>,
	<s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <linux-imx@nxp.com>
CC: <lizetao1@huawei.com>, <alsa-devel@alsa-project.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] ASoC: imx-audio-rpmsg: Remove redundant initialization
 owner in imx_audio_rpmsg_driver
Date: Tue, 8 Aug 2023 10:17:28 +0800
Message-ID: <20230808021728.2978035-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-MailFrom: lizetao1@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: BZGLM6JO2CWCTSUVELM4OOLSPFMQFNLR
X-Message-ID-Hash: BZGLM6JO2CWCTSUVELM4OOLSPFMQFNLR
X-Mailman-Approved-At: Tue, 08 Aug 2023 10:36:06 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BZGLM6JO2CWCTSUVELM4OOLSPFMQFNLR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The module_rpmsg_driver() will set "THIS_MODULE" to driver.owner when
register a rpmsg_driver driver, so it is redundant initialization to set
driver.owner in the statement. Remove it for clean code.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 sound/soc/fsl/imx-audio-rpmsg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audio-rpmsg.c b/sound/soc/fsl/imx-audio-rpmsg.c
index d5234ac4b09b..289e47c03d40 100644
--- a/sound/soc/fsl/imx-audio-rpmsg.c
+++ b/sound/soc/fsl/imx-audio-rpmsg.c
@@ -116,7 +116,6 @@ static struct rpmsg_device_id imx_audio_rpmsg_id_table[] = {
 
 static struct rpmsg_driver imx_audio_rpmsg_driver = {
 	.drv.name	= "imx_audio_rpmsg",
-	.drv.owner	= THIS_MODULE,
 	.id_table	= imx_audio_rpmsg_id_table,
 	.probe		= imx_audio_rpmsg_probe,
 	.callback	= imx_audio_rpmsg_cb,
-- 
2.34.1

