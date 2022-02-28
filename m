Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C41C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 03:08:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9422016FA;
	Mon, 28 Feb 2022 04:07:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9422016FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646017683;
	bh=FpX9z5b+OxYrK++zK+uXniUAhQeGh9Oho1tL1oHlPdk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AaWjpZVCI9zuOS70i7VoEvWXOBxSI1Vw9zoQ+D1Gy+9oBoZhh+otmvAsdFnO/qZw3
	 72hTF/BqhRAK1/X+1zTXuhkHuIMqWMaFJIc4UNqGjN2ABRRpHxr7M3gJhzkKuneDtr
	 bS62PG/HNaURcyZg5iap20H0YZROPxxde1j/ui3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D04B7F80054;
	Mon, 28 Feb 2022 04:06:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFB68F8013C; Mon, 28 Feb 2022 04:06:40 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FB30F80125
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 04:06:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FB30F80125
X-QQ-mid: bizesmtp71t1646017585tf1kv1pq
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 28 Feb 2022 11:06:23 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000000A0000000
X-QQ-FEAT: F3yR32iATbhMswa43cCXQHfEbNdpcZJqhgsZXmS4JMIo72f+8AuPrT0TAHQCl
 3y5g5/xie4JEhHs+aoXSf+l8rQkoNAHdopjLIhi+BgCH6KvsLyXQb/tzCZ62OYo9mBH8riq
 t6UVCHTCbr4TZ+PZCGDHjfMW6GNWeEL7wTtXA5kPHnCR3uWIFncMVDkpXJ2jmNZFOmAEcpf
 ar+WJgpSKDo3mtKdB1+LxC+pGIuF3JXcpT6dA8EU1aW7sesbM3cIq6pPe6fGGK9lJz14kga
 xze6NaDfaendO/f5YXVbCkVwLW+XQHMgASwqi3oi/8VoHPz3FoLhnwfMCejmiuP6qWDSBGu
 3D6Qx4A5UjiALhhE/ItXBhN68JhKCltWb90MD5I
X-QQ-GoodBg: 1
From: Meng Tang <tangmeng@uniontech.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH v2 2/2] ALSA: core: Remove redundant 'err' variable
Date: Mon, 28 Feb 2022 11:06:14 +0800
Message-Id: <20220228030614.10606-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220228030614.10606-1-tangmeng@uniontech.com>
References: <20220228030614.10606-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Cc: Meng Tang <tangmeng@uniontech.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

Return the result from file->f_op->open() directly instead of
taking this in another redundant variable.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/sound_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index aa4a57e488e5..3ac679ea31c7 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -582,13 +582,12 @@ static int soundcore_open(struct inode *inode, struct file *file)
 		 * We rely upon the fact that we can't be unloaded while the
 		 * subdriver is there.
 		 */
-		int err = 0;
 		replace_fops(file, new_fops);
 
 		if (file->f_op->open)
-			err = file->f_op->open(inode,file);
+			return file->f_op->open(inode, file);
 
-		return err;
+		return 0;
 	}
 	return -ENODEV;
 }
-- 
2.20.1



