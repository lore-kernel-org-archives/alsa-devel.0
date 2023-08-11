Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08436C0015E
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Aug 2023 11:01:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 499F13E7;
	Fri, 11 Aug 2023 13:01:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 499F13E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691751715;
	bh=xATJr2U+AImbyLDr3q9VlU87G9S4MXuLHSkjahAY9eo=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=MKODH2xdSOqt0RR4ptWY4b5sS72SwDgmOP0vy+uysmE6AQeDjxcLB7JE/ILw4WKNv
	 L28/LrJ4cJqpDfz6LkozCAYqUdLvA7O/59uoVBQwUWxQLhEdbfskN30+fCR8Elz02/
	 MMxVTZNVpaDmakgeIxvJg4ZrByhsAwin9H/q9JJ4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D424F80510; Fri, 11 Aug 2023 13:00:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 138DCF80166;
	Fri, 11 Aug 2023 13:00:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3249DF80166; Fri, 11 Aug 2023 13:00:34 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3FD2CF800EE
	for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2023 13:00:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FD2CF800EE
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RMghy6thrzcddM;
	Fri, 11 Aug 2023 18:56:50 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 19:00:22 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <rjui@broadcom.com>, <sbranden@broadcom.com>,
	<yuehaibing@huawei.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] ASoC: cygnus: Remove unused declarations
Date: Fri, 11 Aug 2023 19:00:21 +0800
Message-ID: <20230811110021.31656-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Message-ID-Hash: HM6LIXOC32IAKMKNIWOAWWA7SEPC2S6G
X-Message-ID-Hash: HM6LIXOC32IAKMKNIWOAWWA7SEPC2S6G
X-MailFrom: yuehaibing@huawei.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HM6LIXOC32IAKMKNIWOAWWA7SEPC2S6G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Commit a6ee05d94e8f ("ASoC: cygnus: Add Cygnus audio DAI driver")
declared but never implemented these.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 sound/soc/bcm/cygnus-ssp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.h b/sound/soc/bcm/cygnus-ssp.h
index 74152b2d770d..4925e03c3c30 100644
--- a/sound/soc/bcm/cygnus-ssp.h
+++ b/sound/soc/bcm/cygnus-ssp.h
@@ -117,8 +117,6 @@ struct cygnus_audio {
 	unsigned long vco_rate;
 };
 
-extern int cygnus_ssp_get_mode(struct snd_soc_dai *cpu_dai);
-extern int cygnus_ssp_add_pll_tweak_controls(struct snd_soc_pcm_runtime *rtd);
 extern int cygnus_ssp_set_custom_fsync_width(struct snd_soc_dai *cpu_dai,
 						int len);
 extern int cygnus_soc_platform_register(struct device *dev,
-- 
2.34.1

