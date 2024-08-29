Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588DDCA0EE8
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2024 07:56:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90AB33E7;
	Fri, 30 Aug 2024 09:56:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90AB33E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725004608;
	bh=QxZOgjspyre0glDIFL+XQt9y841jY7bblDybTEVsbaE=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=WwMhRo1Y9ZQ4yhAv8jhmggUAha2R8TmngykBkJPF97sK7/lbm6wDRe1JfS7rZlTic
	 JAblC9+xjs+Oq0CSJJ2skfKzc86Sc0GUcg8xTT2HQN6SM6aG5/DbV2tHN4FSsBK4JK
	 c3Tfzs4Hhz83tVp/oZ4GveOrZEoddBW0safvpteo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C5C3F805E7; Fri, 30 Aug 2024 09:55:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 60A05F805D3;
	Fri, 30 Aug 2024 09:55:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13994F80518; Thu, 29 Aug 2024 08:47:20 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 14630F800AC
	for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2024 08:47:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14630F800AC
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvWt20FfLz20mhH;
	Thu, 29 Aug 2024 14:42:18 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (unknown [7.193.23.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D5E5180019;
	Thu, 29 Aug 2024 14:47:08 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 14:47:07 +0800
From: Lin Ruifeng <linruifeng4@huawei.com>
To: <johannes@sipsolutions.net>, <perex@perex.cz>, <tiwai@suse.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] aoa: core: Using helper function
 for_each_child_of_node()
Date: Thu, 29 Aug 2024 14:33:47 +0800
Message-ID: <20240829063347.69818-1-linruifeng4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-MailFrom: linruifeng4@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: AK6YV2ULLZQAE22KLWCNHAKZPI7WZMNA
X-Message-ID-Hash: AK6YV2ULLZQAE22KLWCNHAKZPI7WZMNA
X-Mailman-Approved-At: Fri, 30 Aug 2024 07:55:47 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AK6YV2ULLZQAE22KLWCNHAKZPI7WZMNA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Helper function for_each_child_of_node() can iterate
through the DT node, so we don't need to use while loop.

Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
---
 sound/aoa/core/gpio-feature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index 39bb409b27f6..01060f7c3862 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -72,7 +72,7 @@ static struct device_node *get_gpio(char *name,
 		gpio = of_find_node_by_name(NULL, "gpio");
 		if (!gpio)
 			return NULL;
-		while ((np = of_get_next_child(gpio, np))) {
+		for_each_child_of_node(gpio, np) {
 			audio_gpio = of_get_property(np, "audio-gpio", NULL);
 			if (!audio_gpio)
 				continue;
-- 
2.17.1

