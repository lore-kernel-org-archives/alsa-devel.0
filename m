Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFEAC432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:10:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28430224C7
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f72UIcwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28430224C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F0D016E3;
	Wed, 20 Nov 2019 13:02:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F0D016E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574251416;
	bh=dV9ShE1wTsUCiqFwE6oOZ4mA+oYik9ZtBTY7TgRLpA0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f72UIcwhei87DnKYJWPxZbSvWOEY4i4U06I7uIU68UONFeuGH+cysUXbR0VZgddFE
	 t/jeZlFlYrZ7DkTjuE2t6P3yTQvCmPjmaBvM+I7p1c9pY47d4pqbGnPCVsq0bpk5pC
	 oe+4gw2nE37DKFeX1m/DM0IImxOf+6u4XpgXT9uQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41618F80171;
	Wed, 20 Nov 2019 13:00:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 912B0F8015D; Wed, 20 Nov 2019 12:59:57 +0100 (CET)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DBE9F8014B
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 12:59:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DBE9F8014B
IronPort-SDR: pitpD4nUsKMBnmkfrBGCJGmRzmZOKD8MAf/uEMgSIR6H4T6bN0anb/2xb32xe1eE8md3DtNFvc
 ABaQGKfaeC7YW4gGSFAqeYDuImOI8aLw3n/WmOqy3vw1k/yUGs/DbvsGvxEH3uETbcST4pQh6R
 dhqzqFvvfDqoa1FJ5cVk5jhWpJVkdYMVu82vVwzroDqPVJo5ZoLxxw3+3HDTOdkYQfZHdoPddJ
 kRnit/ufG3OAD7kD8068w1dI8exnZ9klMLKiuTRfDMiboFb9cNzcUmlWJ/guLROG1PC0RZHjn/
 OPc=
X-IronPort-AV: E=Sophos;i="5.69,221,1571731200"; d="scan'208";a="45210015"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa1.mentor.iphmx.com with ESMTP; 20 Nov 2019 03:59:41 -0800
IronPort-SDR: pCvBI8xIi0vp5o3BR5Sn30iM9XY485jycBzR9roKDd4Zwk6TBDWL0EgxHn9Nz5Rmk/EM1nE0kA
 7Yn+ePeJVVeq4opuYexNaoH7/Pla2Jt3xW76YFYGNP4350N5N07scXYCWndnRvJuT3qw/nhvF7
 lvSXDleLMjagY+8Weym84JFxvdwXJGXhZsnmXsUeaYENZmK2OcgQshR4zXfiuIYlULWQxpu6ec
 aYAMGf+QmRHVrmRNtXcBLdrsrBNBQ7Ea03+wnuzz2bkwOVWYOOyLe+aUPPUwwD96ySxPFghZ14
 OB0=
From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
To: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timo Wischer
 <twischer@de.adit-jv.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
Date: Wed, 20 Nov 2019 05:58:53 -0600
Message-ID: <20191120115856.4125-5-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120115856.4125-4-andrew_gabbasov@mentor.com>
References: <20191120115856.4125-1-andrew_gabbasov@mentor.com>
 <20191120115856.4125-2-andrew_gabbasov@mentor.com>
 <20191120115856.4125-3-andrew_gabbasov@mentor.com>
 <20191120115856.4125-4-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Subject: [alsa-devel] [PATCH v4 4/7] ALSA: aloop: Rename all jiffies timer
	specific functions
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

This commit does not change the behaviour. It only separates the jiffies
timer specific implementation from the generic part.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 3bfd7c32803c..2f208aaa54cf 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -188,7 +188,7 @@ static inline unsigned int get_rate_shift(struct loopback_pcm *dpcm)
 }
 
 /* call in cable->lock */
-static int loopback_timer_start(struct loopback_pcm *dpcm)
+static int loopback_jiffies_timer_start(struct loopback_pcm *dpcm)
 {
 	unsigned long tick;
 	unsigned int rate_shift = get_rate_shift(dpcm);
@@ -209,7 +209,7 @@ static int loopback_timer_start(struct loopback_pcm *dpcm)
 }
 
 /* call in cable->lock */
-static inline int loopback_timer_stop(struct loopback_pcm *dpcm)
+static inline int loopback_jiffies_timer_stop(struct loopback_pcm *dpcm)
 {
 	del_timer(&dpcm->timer);
 	dpcm->timer.expires = 0;
@@ -217,7 +217,7 @@ static inline int loopback_timer_stop(struct loopback_pcm *dpcm)
 	return 0;
 }
 
-static inline int loopback_timer_stop_sync(struct loopback_pcm *dpcm)
+static inline int loopback_jiffies_timer_stop_sync(struct loopback_pcm *dpcm)
 {
 	del_timer_sync(&dpcm->timer);
 
@@ -502,7 +502,8 @@ static inline void bytepos_finish(struct loopback_pcm *dpcm,
 }
 
 /* call in cable->lock */
-static unsigned int loopback_pos_update(struct loopback_cable *cable)
+static unsigned int loopback_jiffies_timer_pos_update
+		(struct loopback_cable *cable)
 {
 	struct loopback_pcm *dpcm_play =
 			cable->streams[SNDRV_PCM_STREAM_PLAYBACK];
@@ -555,14 +556,15 @@ static unsigned int loopback_pos_update(struct loopback_cable *cable)
 	return running;
 }
 
-static void loopback_timer_function(struct timer_list *t)
+static void loopback_jiffies_timer_function(struct timer_list *t)
 {
 	struct loopback_pcm *dpcm = from_timer(dpcm, t, timer);
 	unsigned long flags;
 
 	spin_lock_irqsave(&dpcm->cable->lock, flags);
-	if (loopback_pos_update(dpcm->cable) & (1 << dpcm->substream->stream)) {
-		loopback_timer_start(dpcm);
+	if (loopback_jiffies_timer_pos_update(dpcm->cable) &
+			(1 << dpcm->substream->stream)) {
+		loopback_jiffies_timer_start(dpcm);
 		if (dpcm->period_update_pending) {
 			dpcm->period_update_pending = 0;
 			spin_unlock_irqrestore(&dpcm->cable->lock, flags);
@@ -731,18 +733,18 @@ static void free_cable(struct snd_pcm_substream *substream)
 
 static int loopback_jiffies_timer_open(struct loopback_pcm *dpcm)
 {
-	timer_setup(&dpcm->timer, loopback_timer_function, 0);
+	timer_setup(&dpcm->timer, loopback_jiffies_timer_function, 0);
 
 	return 0;
 }
 
 static struct loopback_ops loopback_jiffies_timer_ops = {
 	.open = loopback_jiffies_timer_open,
-	.start = loopback_timer_start,
-	.stop = loopback_timer_stop,
-	.stop_sync = loopback_timer_stop_sync,
-	.close_substream = loopback_timer_stop_sync,
-	.pos_update = loopback_pos_update,
+	.start = loopback_jiffies_timer_start,
+	.stop = loopback_jiffies_timer_stop,
+	.stop_sync = loopback_jiffies_timer_stop_sync,
+	.close_substream = loopback_jiffies_timer_stop_sync,
+	.pos_update = loopback_jiffies_timer_pos_update,
 	.dpcm_info = loopback_jiffies_timer_dpcm_info,
 };
 
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
