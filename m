Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13460C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 01:40:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E82764E45
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 01:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E82764E45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C31F1679;
	Fri, 19 Mar 2021 02:39:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C31F1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616117999;
	bh=NiWbj7gQYwCWaARdvFDy38H5XskCNaSflUEW3413ld8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KNQkGP2GxBGQqO1AphNdvt8LqXOR5Cclrk0EG/OqfA8xkPwhOFECXqGBP8l68oJJN
	 W4lBrDtAHgJMNFPQ5DxXO9hvI+zvFr9tNDIgJT4ebRsYa4fN7otPS4A2/B3RI5y77v
	 3+HJ291uYfJ2ozt206++aJg5n5sEFJO0U+dscPnQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E444BF80163;
	Fri, 19 Mar 2021 02:39:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1E57F80165; Fri, 19 Mar 2021 02:39:06 +0100 (CET)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.133])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38A77F80124
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 02:38:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38A77F80124
Received: from localhost (unknown [192.168.167.235])
 by lucky1.263xmail.com (Postfix) with ESMTP id 12FF4CCD98;
 Fri, 19 Mar 2021 09:38:56 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
 by smtp.263.net (postfix) whith ESMTP id
 P24306T139684564936448S1616117934878107_; 
 Fri, 19 Mar 2021 09:38:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8cbaed4f43e2e12c294ac281d62bc47a>
X-RL-SENDER: huangjianghui@uniontech.com
X-SENDER: huangjianghui@uniontech.com
X-LOGIN-NAME: huangjianghui@uniontech.com
X-FST-TO: perex@perex.cz
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: huangjianghui <huangjianghui@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: hda: Fix spelling mistakes
Date: Fri, 19 Mar 2021 09:38:54 +0800
Message-Id: <20210319013854.48830-1-huangjianghui@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Mohan Kumar <mkumard@nvidia.com>
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

Signed-off-by: huangjianghui <huangjianghui@uniontech.com>
---
 sound/hda/hdac_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index a6ed3dc35f7e..1eb8563db2df 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -618,7 +618,7 @@ void snd_hdac_stream_sync_trigger(struct hdac_stream *azx_dev, bool set,
 EXPORT_SYMBOL_GPL(snd_hdac_stream_sync_trigger);
 
 /**
- * snd_hdac_stream_sync - sync with start/strop trigger operation
+ * snd_hdac_stream_sync - sync with start/stop trigger operation
  * @azx_dev: HD-audio core stream (master stream)
  * @start: true = start, false = stop
  * @streams: bit flags of streams to sync
-- 
2.20.1



