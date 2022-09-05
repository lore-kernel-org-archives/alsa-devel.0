Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FCAECAAD5
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Sep 2022 06:08:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87AE7163B;
	Mon,  5 Sep 2022 08:07:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87AE7163B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662358095;
	bh=pYULycoBOoegbsULPCCtHdmQivsvWwutEPznNsy4SA8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rrrmLZK0ffkAvReSya8+x5lqXE4Nn/QiD1vA1sQfHAs5aF6+4GylhCfutg8C4MlLF
	 fWiCkfbgG1SMukpT2AzvLtWVnUf1kyoadaxe6HL/SyBOJG0MgEIbYb5DOHGARxHc7n
	 jkBhzSupc+6VcUp2ibeBXe4de9N+xwn6znHCyYso=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 312FCF80424;
	Mon,  5 Sep 2022 08:07:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E108AF80482; Mon,  5 Sep 2022 08:07:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8D59F800E8
 for <alsa-devel@alsa-project.org>; Mon,  5 Sep 2022 08:07:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8D59F800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="Ok/HImQa"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="kXK2Ei75"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9303B3876C;
 Mon,  5 Sep 2022 06:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662358037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8phcVlwd2urHM2fHy60YLtWbC0rs6qkut+D2e6oMNWM=;
 b=Ok/HImQaXYfFWEcQaZ3PJR2vYiyImLVz4PYU5RMw3cVg6jYrOetkmBq1RAkCITyqTDGH2h
 13AQ/GjLxRY/E/Pqc2UClv+XvPHlsOKo4iojOeZT/PSQLDKa5Xgk/3b/csmIWYeCp9ofb4
 taz91JQ5mOvrKqS+J4c+scOfl4XueOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662358037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8phcVlwd2urHM2fHy60YLtWbC0rs6qkut+D2e6oMNWM=;
 b=kXK2Ei757fFiIlKMAgUPz/NwgQjGUdNWHXPQ0zBZO3soxJXDbEaWP4CRkD/QMtHMdnxhW2
 xX+nWuGdmhsefODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 704F213A66;
 Mon,  5 Sep 2022 06:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /XEqGhWSFWMPUQAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 05 Sep 2022 06:07:17 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: pcm: oss: Fix race at SNDCTL_DSP_SYNC
Date: Mon,  5 Sep 2022 08:07:14 +0200
Message-Id: <20220905060714.22549-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: butt3rflyh4ck <butterflyhuangxx@gmail.com>
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

There is a small race window at snd_pcm_oss_sync() that is called from
OSS PCM SNDCTL_DSP_SYNC ioctl; namely the function calls
snd_pcm_oss_make_ready() at first, then takes the params_lock mutex
for the rest.  When the stream is set up again by another thread
between them, it leads to inconsistency, and may result in unexpected
results such as NULL dereference of OSS buffer as a fuzzer spotted
recently.

The fix is simply to cover snd_pcm_oss_make_ready() call into the same
params_lock mutex with snd_pcm_oss_make_ready_locked() variant.

Reported-and-tested-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/CAFcO6XN7JDM4xSXGhtusQfS2mSBcx50VJKwQpCq=WeLt57aaZA@mail.gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_oss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 90c3a367d7de..02df915eb3c6 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1672,14 +1672,14 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file *pcm_oss_file)
 		runtime = substream->runtime;
 		if (atomic_read(&substream->mmap_count))
 			goto __direct;
-		err = snd_pcm_oss_make_ready(substream);
-		if (err < 0)
-			return err;
 		atomic_inc(&runtime->oss.rw_ref);
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			atomic_dec(&runtime->oss.rw_ref);
 			return -ERESTARTSYS;
 		}
+		err = snd_pcm_oss_make_ready_locked(substream);
+		if (err < 0)
+			goto unlock;
 		format = snd_pcm_oss_format_from(runtime->oss.format);
 		width = snd_pcm_format_physical_width(format);
 		if (runtime->oss.buffer_used > 0) {
-- 
2.35.3

