Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE20C2D0C5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:16:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A80214D8
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vM2/Dd2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A80214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E81A21687;
	Tue, 10 Dec 2019 16:09:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E81A21687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575990600;
	bh=ommI2Y+KhOxbYryQbuX7iMVY0vFZM27qw91TIrWpX6M=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vM2/Dd2n1nQ1FYtJywpq6ATkx2fg4xs8ATby689znxxdpBwnlxX3qvBlbgyxdJfqd
	 pmRmjWYpZVsSwB6t580XwyJiAD0ahjRwwXKbqjO6EqVEBQq70zYOjMRyNkvFEy/KrB
	 py2q/wYNjDuwr2V1ZC3hPb6yDqlgTZiXynlifxZs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9162F8034F;
	Tue, 10 Dec 2019 15:55:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D107F802A8; Tue, 10 Dec 2019 15:54:50 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64016F80264
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:54:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64016F80264
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 622E2AF92;
 Tue, 10 Dec 2019 14:54:13 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:54:06 +0100
Message-Id: <20191210145406.21419-24-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210145406.21419-1-tiwai@suse.de>
References: <20191210145406.21419-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH for-5.6 23/23] ASoC: Drop
	snd_soc_pcm_lib_ioctl()
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

Now all snd_soc_pcm_lib_ioctl() calls were dropped, and it became
superfluous.  Let's kill it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc.h  |  5 -----
 sound/soc/soc-core.c | 12 ------------
 2 files changed, 17 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c28a1ed5e8df..66648f0e3a87 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1408,11 +1408,6 @@ static inline void snd_soc_dapm_mutex_unlock(struct snd_soc_dapm_context *dapm)
 	mutex_unlock(&dapm->card->dapm_mutex);
 }
 
-/* bypass */
-int snd_soc_pcm_lib_ioctl(struct snd_soc_component *component,
-			  struct snd_pcm_substream *substream,
-			  unsigned int cmd, void *arg);
-
 #include <sound/soc-component.h>
 
 #endif
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 062653ab03a3..0e33edf79f39 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -277,18 +277,6 @@ static inline void snd_soc_debugfs_exit(void)
 
 #endif
 
-/*
- * This is glue code between snd_pcm_lib_ioctl() and
- * snd_soc_component_driver :: ioctl
- */
-int snd_soc_pcm_lib_ioctl(struct snd_soc_component *component,
-			  struct snd_pcm_substream *substream,
-			  unsigned int cmd, void *arg)
-{
-	return snd_pcm_lib_ioctl(substream, cmd, arg);
-}
-EXPORT_SYMBOL_GPL(snd_soc_pcm_lib_ioctl);
-
 static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 			      struct snd_soc_component *component)
 {
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
