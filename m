Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD0C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 16:55:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A476109E
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 16:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A476109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAE841781;
	Tue, 18 May 2021 18:54:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAE841781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621356920;
	bh=IXuYW6K5GXRtYhY46/rVNlPK/BD2lkyO6zebNp7u76A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DyjFz+aopJbYKdC/UTrn8JooS6uyfBUcMmm1UnaZfbdO1qnpvTAhobsRC77eNILhv
	 6O3X5w20Cc+RL0nk3xNtLaTEzOksMC6C3hCisKfPuARJUHD07LDS/K+b3/1p21hNeZ
	 SPJSlKxXRhyDK3cMXx7oWb85wsra1ubU1ika04mg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D06E1F804B2;
	Tue, 18 May 2021 18:52:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD0B5F80475; Tue, 18 May 2021 18:52:13 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3287F80217
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 18:52:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3287F80217
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 668ADB1B6;
 Tue, 18 May 2021 16:52:03 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/7] ALSA: control: Minor optimization for
 SNDRV_CTL_IOCTL_POWER_STATE
Date: Tue, 18 May 2021 18:51:58 +0200
Message-Id: <20210518165201.24376-5-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210518165201.24376-1-tiwai@suse.de>
References: <20210518165201.24376-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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

The SNDRV_CTL_IOCTL_POWER_STATE is an obsoleted ioctl and now
practically it returns always D0.  Do some minor optimization.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 799d91ddccb0..5e8b77855e5d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1807,11 +1807,7 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_POWER:
 		return -ENOPROTOOPT;
 	case SNDRV_CTL_IOCTL_POWER_STATE:
-#ifdef CONFIG_PM
-		return put_user(card->power_state, ip) ? -EFAULT : 0;
-#else
 		return put_user(SNDRV_CTL_POWER_D0, ip) ? -EFAULT : 0;
-#endif
 	}
 	down_read(&snd_ioctl_rwsem);
 	list_for_each_entry(p, &snd_control_ioctls, list) {
-- 
2.26.2

