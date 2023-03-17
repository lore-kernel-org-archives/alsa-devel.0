Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D729C74A5B
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Mar 2023 06:39:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1123F44;
	Fri, 17 Mar 2023 07:38:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1123F44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679035170;
	bh=5wXtzIpkEIsMF/xaIVgsn6Y/GgomsislbZBGax2jlwU=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mR5sgGZUGCmwd7p6RbbvhDTsSEsUtUTG4pb570ocuo5xsMK3F/q6R7504OwWYYH36
	 t8DAsACWNfZKSV6Zm5dP1KU9qR5DFxsXpDuRRFO9GE7gN4hQTpLwiPQpV67SzobwM9
	 NONlB+p+nSHMPjtY0UKHIRtE6aBQcJNJiLGin248=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AD02F80272;
	Fri, 17 Mar 2023 07:38:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98809F80423; Fri, 17 Mar 2023 07:35:21 +0100 (CET)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AEF4AF80093
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2023 07:33:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEF4AF80093
X-Alimail-AntiSpam: 
 AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ve1oRe9_1679034819;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0Ve1oRe9_1679034819)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 14:33:44 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: perex@perex.cz
Subject: [PATCH] ALSA: drivers: Remove the unused variable portman_read_data
Date: Fri, 17 Mar 2023 14:33:38 +0800
Message-Id: <20230317063338.18029-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DE7WWPNS3BW6ALKMRMZK3CTUQH2DZOW2
X-Message-ID-Hash: DE7WWPNS3BW6ALKMRMZK3CTUQH2DZOW2
X-MailFrom: jiapeng.chong@linux.alibaba.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DE7WWPNS3BW6ALKMRMZK3CTUQH2DZOW2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Variable portman_read_data is not effectively used, so delete it.

sound/drivers/portman2x4.c:195:18: warning: unused function 'portman_read_data'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4557
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/drivers/portman2x4.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 52a656735365..41b46f9ae731 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -192,11 +192,6 @@ static inline u8 portman_read_status(struct portman *pm)
 	return parport_read_status(pm->pardev->port);
 }
 
-static inline u8 portman_read_data(struct portman *pm)
-{
-	return parport_read_data(pm->pardev->port);
-}
-
 static inline void portman_write_data(struct portman *pm, u8 value)
 {
 	parport_write_data(pm->pardev->port, value);
-- 
2.20.1.7.g153144c

