Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFBCC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 14:49:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAC7239D1
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 14:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAC7239D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B1CF1F06;
	Fri, 22 Jan 2021 15:48:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B1CF1F06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611326986;
	bh=WhUGQaGGsyrJxfqOrynii8drEhuZP3gCb5oJiqEncJo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=umaDh2VXDe1gIlEt7lP1d7lkZwZ+8IukraS6fgRJznbWMgQbqsToIdYusGmDWPJzb
	 HjlQ4P/EQra46/CH3fNCgndGeXisMqbhQj7JeQpwI+OovFLYDCnHBB/C7xiMdLAkz4
	 kYRiZQtPigAAq4eYTl4coC9V9cx4owGog6laaFqc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A43FEF8016E;
	Fri, 22 Jan 2021 15:48:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E94E1F80227; Fri, 22 Jan 2021 15:48:53 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9C63F80164
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 15:48:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9C63F80164
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B2506AE6D;
 Fri, 22 Jan 2021 14:48:45 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 4/4] pcm: share: Pass appl_ptr and hw_ptr in
 snd_pcm_status()
Date: Fri, 22 Jan 2021 15:48:42 +0100
Message-Id: <20210122144842.8843-5-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210122144842.8843-1-tiwai@suse.de>
References: <20210122144842.8843-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This one also has the same problem as others; the appl_ptr and hw_ptr
of share plugin aren't updated in snd_pcm_status() call.  Fix it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_share.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/pcm/pcm_share.c b/src/pcm/pcm_share.c
index bff9507d6422..72509491b366 100644
--- a/src/pcm/pcm_share.c
+++ b/src/pcm/pcm_share.c
@@ -711,6 +711,8 @@ static int snd_pcm_share_status(snd_pcm_t *pcm, snd_pcm_status_t *status)
  _notrunning:
 	status->delay = sd + d;
 	status->state = share->state;
+	status->appl_ptr = *pcm->appl.ptr;
+	status->hw_ptr = *pcm->hw.ptr;
 	status->trigger_tstamp = share->trigger_tstamp;
  _end:
 	Pthread_mutex_unlock(&slave->mutex);
-- 
2.26.2

