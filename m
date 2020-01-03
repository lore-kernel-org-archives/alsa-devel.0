Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E53C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:29:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6BE20848
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fUoRltQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6BE20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 466FA1744;
	Fri,  3 Jan 2020 09:28:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 466FA1744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578040159;
	bh=teqsTpECef2w6r4yN6XkOEQCS0YOBfyWGq2RSC4Xx2E=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fUoRltQSLjtLGOYvL6SHrp7Mb7fJlUHOR8pmiFvB6C/n6ODaDwhM/aI5IImr7M34n
	 gMdw/6uFl3hev40qSKBFDuET1+QJb0WIuO7Y+mLhn+7SNMf3wMUyeghR0jkmBBHAiC
	 tZOwB5+jWOyoyrVrN95aRrc0r1baL4EhZSa943PA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18008F8036E;
	Fri,  3 Jan 2020 09:18:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C01F8F80331; Fri,  3 Jan 2020 09:17:52 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76207F80278
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76207F80278
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 84AB0B269
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:20 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:36 +0100
Message-Id: <20200103081714.9560-21-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 20/58] ALSA: timer: Constify snd_timer_hardware
	definitions
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Most of snd_timer_hardware definitions do simply copying to another
struct as-is.  Mark them as const for further optimization.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_timer.c | 2 +-
 sound/core/timer.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_timer.c b/sound/core/pcm_timer.c
index 7928bda235c1..c43484b22b34 100644
--- a/sound/core/pcm_timer.c
+++ b/sound/core/pcm_timer.c
@@ -75,7 +75,7 @@ static int snd_pcm_timer_stop(struct snd_timer * timer)
 	return 0;
 }
 
-static struct snd_timer_hardware snd_pcm_timer =
+static const struct snd_timer_hardware snd_pcm_timer =
 {
 	.flags =	SNDRV_TIMER_HW_AUTO | SNDRV_TIMER_HW_SLAVE,
 	.resolution =	0,
diff --git a/sound/core/timer.c b/sound/core/timer.c
index d53bc1f3a48a..8835ff91a893 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1199,7 +1199,7 @@ static int snd_timer_s_close(struct snd_timer *timer)
 	return 0;
 }
 
-static struct snd_timer_hardware snd_timer_system =
+static const struct snd_timer_hardware snd_timer_system =
 {
 	.flags =	SNDRV_TIMER_HW_FIRST | SNDRV_TIMER_HW_TASKLET,
 	.resolution =	1000000000L / HZ,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
