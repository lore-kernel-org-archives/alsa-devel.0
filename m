Return-Path: <SRS0=XYKd=JY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9DC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 10:27:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF05613D1
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 10:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF05613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75DAA16DF;
	Tue, 27 Apr 2021 12:27:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75DAA16DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619519270;
	bh=C6ZtBkAlvbCAE7frVrMF/o0mtctg/OUoQhqwMg2flz8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=juMAYNna5o0XpjulL9vXOGAwGGFXul9RCrm0AcE+5JfAviy77cFUd2pW0WVY7AP77
	 eQk9sQMZBOyfZ8OCnxlnEXGQ5qr5EQgaSuFh/CJo/R9S4nTCxfq9KqDOKYWt/IMsSc
	 4IR59bHnGnj6nTZKjXzLqc8buRnSDZRP014CRrnc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E17CFF801D8;
	Tue, 27 Apr 2021 12:26:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EAACF801EC; Tue, 27 Apr 2021 12:26:58 +0200 (CEST)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDF42F80117
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 12:26:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDF42F80117
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0UWzF1d5_1619519195; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0UWzF1d5_1619519195) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 27 Apr 2021 18:26:41 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: perex@perex.cz
Subject: [PATCH] ALSA: usb-audio: Remove redundant assignment to len
Date: Tue, 27 Apr 2021 18:26:34 +0800
Message-Id: <1619519194-57806-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org
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

Variable len is set to zero but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed.

Cleans up the following clang-analyzer warning:

sound/usb/mixer.c:2713:3: warning: Value stored to 'len' is never read
[clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/usb/mixer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b004b2e..937bc17 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2710,7 +2710,6 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 #define MAX_ITEM_NAME_LEN	64
 	for (i = 0; i < desc->bNrInPins; i++) {
 		struct usb_audio_term iterm;
-		len = 0;
 		namelist[i] = kmalloc(MAX_ITEM_NAME_LEN, GFP_KERNEL);
 		if (!namelist[i]) {
 			err = -ENOMEM;
-- 
1.8.3.1

