Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32D8C433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Nov 2021 13:34:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82C57201D;
	Tue, 30 Nov 2021 14:34:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82C57201D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638279293;
	bh=coct70ajcV2zi0dztvNHFowQOMJGePRsCH+DvdQQJZM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DW5NkwGU/VG4oNKYjgYTbBq2tKD715x+z4DfmZjHZi4lbOt7K0V0z7CX6XN59BagZ
	 yphGBAOHrJKM0447cFYX3Z2eXosbt2w8zJ2mR9rykgx5oicF7tAcUeU7IYWffnw8E6
	 4psgxT6+01YL3n8lPERbC6NAejNVKsTGt15FKh4s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CF89F802E0;
	Tue, 30 Nov 2021 14:33:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16AF6F80290; Tue, 30 Nov 2021 12:17:27 +0100 (CET)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4416BF8020D
 for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2021 12:17:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4416BF8020D
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R371e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=cuibixuan@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UyrsuvV_1638270978; 
Received: from VM20210331-25.tbsite.net(mailfrom:cuibixuan@linux.alibaba.com
 fp:SMTPD_---0UyrsuvV_1638270978) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 30 Nov 2021 19:16:23 +0800
From: Bixuan Cui <cuibixuan@linux.alibaba.com>
To: alsa-devel@alsa-project.org,
	inux-kernel@vger.kernel.org
Subject: [PATCH -next] ALSA: Fix oversized kvmalloc() calls
Date: Tue, 30 Nov 2021 19:16:18 +0800
Message-Id: <1638270978-42412-1-git-send-email-cuibixuan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Mailman-Approved-At: Tue, 30 Nov 2021 14:33:13 +0100
Cc: cuibixuan@linux.alibaba.com, tiwai@suse.com
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

The commit 7661809d493b ("mm: don't allow oversized kvmalloc()
calls") limits the max allocatable memory via kvzalloc() to MAX_INT.

Reported-by: syzbot+bb348e9f9a954d42746f@syzkaller.appspotmail.com
Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
---
 sound/core/oss/pcm_plugin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 061ba06..61fccb5 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -68,6 +68,10 @@ static int snd_pcm_plugin_alloc(struct snd_pcm_plugin *plugin, snd_pcm_uframes_t
 	size /= 8;
 	if (plugin->buf_frames < frames) {
 		kvfree(plugin->buf);
+
+		if (size > INT_MAX)
+			return -ENOMEM;
+
 		plugin->buf = kvzalloc(size, GFP_KERNEL);
 		plugin->buf_frames = frames;
 	}
-- 
1.8.3.1

