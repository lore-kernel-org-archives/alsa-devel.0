Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE45AC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:11:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274982184C
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="InhboaEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274982184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5668F1674;
	Mon, 11 Nov 2019 12:10:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5668F1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573470680;
	bh=kFFn8ISQ0kW31uPYPk751hKhq7lg8Upm/GPI9ZRh71o=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=InhboaEcoJx115O9aOa+UzzoQyid1LE1Y+4UHv/HXqt1vipbfOxHh7le2SITD5t5u
	 RSFO7aDBuFkye6MEA2WfnKegqCEEWK0f0Jme9G1dItcEwFWhrxxtwxQnleUgXdENDX
	 de2vAHRojTOUuAo29HZAxwDDYLVF4WPwqFA1ZXSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01A8BF804FF;
	Mon, 11 Nov 2019 12:09:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CD8EF80518; Mon, 11 Nov 2019 12:09:34 +0100 (CET)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22FC2F802E0
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 12:09:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22FC2F802E0
IronPort-SDR: nGJK1LQfrdlH9LLDr/C45eSnThorlfXpJQmX/RxkSdCHwq8bhGOE9cQ73Uj51ABV4ImYMJR37H
 d5pIdua2XETxJN9zemdeasjjpAEvWlna5JhrNYhEzX/7lVEr3LmmtGngFho9tsP5kQn3HWwuNn
 nHPxW3lCZVW7Bk9NlzPAfhZ2VV+fEONndlT/nK42AnhnQlt8olvHvfxLPWofja4wDfEvzJGTFY
 I6sbYft33sYfDVbDN51ocnuYhlJBHtN8w5o0z54viWfVoddKfeDHA6kzOrsFiw6eq1+ENLi30B
 egs=
X-IronPort-AV: E=Sophos;i="5.68,292,1569312000"; d="scan'208";a="43051105"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 11 Nov 2019 03:09:29 -0800
IronPort-SDR: Ljtjv3fR9c7VCXF6BWzclaR6POPzKc2fpoySZPWSobspxQvozd16o0PhBz+DrD1mfF+rvgwOly
 ZOiC9GtS97L5RpSfDMYVwZ2lgiBxMMCqwPU/KzMgK/RqgXVKa00MmgOkZYMpG2bx5+yD2ASQMm
 4+7ecwEpdOZvH3wgPH4L6z4cQlPc/lZdlbz81wHLInZm87OaCqncRoqEYGuT84YWKxF3gJTPPq
 lwGCZ1dwhxzCZVZKzy+ogg43Kdhshfl47DnBYOO8o9HgxfvWunyH4RmmbXeOplmbU0umkEJ0Ol
 w2k=
From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
To: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timo Wischer
 <twischer@de.adit-jv.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
Date: Mon, 11 Nov 2019 05:08:40 -0600
Message-ID: <20191111110846.18223-2-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111110846.18223-1-andrew_gabbasov@mentor.com>
References: <20191111110846.18223-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Subject: [alsa-devel] [PATCH v3 1/7] ALSA: aloop: Describe units of variables
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Timo Wischer <twischer@de.adit-jv.com>

Describe the unit of the variables used to calculate the hw pointer
depending on jiffies ticks.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 9ccdad89c288..1f5982e09025 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -102,8 +102,10 @@ struct loopback_pcm {
 	/* flags */
 	unsigned int period_update_pending :1;
 	/* timer stuff */
-	unsigned int irq_pos;		/* fractional IRQ position */
-	unsigned int period_size_frac;
+	unsigned int irq_pos;		/* fractional IRQ position in jiffies
+					 * ticks
+					 */
+	unsigned int period_size_frac;	/* period size in jiffies ticks */
 	unsigned int last_drift;
 	unsigned long last_jiffies;
 	struct timer_list timer;
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
