Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D5FC7EE21
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 00:47:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 434F82A5B;
	Fri,  5 May 2023 02:46:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 434F82A5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683247631;
	bh=wOWuKYLJBw0R+gxa+WFMSkLj4rih8kspUTk5aH6Nm48=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Cr9jGFPtEXBfvEQpW/XZx/SiN85Jej0eq5sztb9C15+ORFvYzWn9NYO73m2HN6cH6
	 nb10o/sbFUj2WfvGnjbuc4zGFFdYQVRdvMVGoSRAQaPVEq94r8hpb2tZfnqZ9y8UKt
	 3rKk8CPK6X2tLOM55OlZiPVi0yCtETAXx9l5tFbE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17D0BF80529;
	Fri,  5 May 2023 02:45:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23A19F8052D; Fri,  5 May 2023 02:45:52 +0200 (CEST)
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 59091F804B1
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 02:45:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59091F804B1
X-Alimail-AntiSpam: 
 AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VhmeKHO_1683247539;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VhmeKHO_1683247539)
          by smtp.aliyun-inc.com;
          Fri, 05 May 2023 08:45:40 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: lgirdwood@gmail.com
Subject: [PATCH -next] ASoC: codecs: wcd938x: Remove unneeded semicolon
Date: Fri,  5 May 2023 08:45:38 +0800
Message-Id: <20230505004538.70270-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OWYZPVHMO54S5I6X5DETU5Q57HF5BB32
X-Message-ID-Hash: OWYZPVHMO54S5I6X5DETU5Q57HF5BB32
X-MailFrom: yang.lee@linux.alibaba.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: broonie@kernel.org, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OWYZPVHMO54S5I6X5DETU5Q57HF5BB32/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

./sound/soc/codecs/wcd938x-sdw.c:1274:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4862
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/wcd938x-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 402286dfaea4..5befae414636 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1271,7 +1271,7 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 
 		/* Start in cache-only until device is enumerated */
 		regcache_cache_only(wcd->regmap, true);
-	};
+	}
 
 	pm_runtime_set_autosuspend_delay(dev, 3000);
 	pm_runtime_use_autosuspend(dev);
-- 
2.20.1.7.g153144c

