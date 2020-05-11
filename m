Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844CCC54E8D
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 14:40:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066AF206F5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 14:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VkMdarR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066AF206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57ABF86F;
	Mon, 11 May 2020 16:39:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57ABF86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589208034;
	bh=+7+cUhR3VVfzc3G9Ic+MZLXZvFwRH0/gUZASB2upQoI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VkMdarR7i5MBJYJrIjh8bmD6bu/XotHnOfhKRmYsub6Hjto8TKzxJwDzqrZ15bEua
	 TgqUBoYPR/pMDrskQJV5pVExZ7iS7xtom55jkLKULHG7dQIm4M7xiincorJOMyUE/B
	 j0QwaKficGLmm3X0P5U3UdvubAIuSYa31DYCpD+I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD061F8014C;
	Mon, 11 May 2020 16:39:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26E43F80254; Mon, 11 May 2020 16:39:41 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F5DDF8014C
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 16:39:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F5DDF8014C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6EC0CAF10
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 14:39:36 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 2/3] pcm: rate: Fix uninitialized variable warning
Date: Mon, 11 May 2020 16:39:30 +0200
Message-Id: <20200511143931.31528-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200511143931.31528-1-tiwai@suse.de>
References: <20200511143931.31528-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The recent gcc warning indicates the uninitialized variable commit_err:
  pcm_rate.c:1104:6: warning: ‘commit_err’ may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (commit_err < 0)
         ^

Add a proper initialization to commit_err.

Fixes: 29041c522071 ("fix infinite draining of the rate plugin in SND_PCM_NONBLOCK mode")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_rate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 980fa44e4023..9ec8c85ef13f 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1051,7 +1051,7 @@ static int snd_pcm_rate_drain(snd_pcm_t *pcm)
 		/* commit the remaining fraction (if any) */
 		snd_pcm_uframes_t size, ofs, saved_avail_min;
 		snd_pcm_sw_params_t sw_params;
-		int commit_err;
+		int commit_err = 0;
 
 		__snd_pcm_lock(pcm);
 		/* temporarily set avail_min to one */
-- 
2.16.4

