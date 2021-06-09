Return-Path: <SRS0=8Lk6=LD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40775C48BCD
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 16:27:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65EF61246
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 16:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65EF61246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CB7716BF;
	Wed,  9 Jun 2021 18:26:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CB7716BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623256018;
	bh=EjXnkhdcqFkWNeyEmZ8Iv9+Nkx8z+df/e7iBjz8SGBQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=becSMr0h9SOiiQnyC3+MFUIFIsI1XnyI+HgVOcmxXNNIY97rsPshibaj2Is/yNRbg
	 C14mU2nmT/KBVjQXEC8tGpQWdsy0xb5GNpZ6NaTDYS8NUxQQpZYRsBY4LMeQdGbLZC
	 bjJD8cOSBYKiUlPxLVr0tr3SfOQNuxUzdCFugUUQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08668F800F4;
	Wed,  9 Jun 2021 18:26:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4288DF8032B; Wed,  9 Jun 2021 18:26:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE17DF80116
 for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2021 18:25:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE17DF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="ZQ2xP6NH"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="uk3ZN3SF"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 442781FD64
 for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2021 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623255954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjUs4Eyhqb2gXIIa3bpD8A3F9HPoFXWYVW3xxFskUYE=;
 b=ZQ2xP6NH/1sgKwQkegBS+aZvzmRJOP3uD2zNW3SJwU9nnfq8y7WHRG7z9TAr8piknq3C9s
 ixpApIIxB183fY5EmUfVf0gvgB6bYwvagh7JnhfYBhS8rC+TepcegNqwR214aHOgAC7ABr
 ZNIPPZa84mD2ijh1cv9YwU0q8zcZOqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623255954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjUs4Eyhqb2gXIIa3bpD8A3F9HPoFXWYVW3xxFskUYE=;
 b=uk3ZN3SFr+ovVMypMfDKxIUgwo09y6yylOKvBCzbC/dk08m7nX6Ie/N/aYdo+4+b4aGCz+
 mpWrNuUUsf5E/IBQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 3FDAFA3B8B;
 Wed,  9 Jun 2021 16:25:54 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/5] ALSA: core: Drop snd_sgbuf_get_ptr()
Date: Wed,  9 Jun 2021 18:25:48 +0200
Message-Id: <20210609162551.7842-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210609162551.7842-1-tiwai@suse.de>
References: <20210609162551.7842-1-tiwai@suse.de>
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

snd_sgbuf_get_ptr() and its sibling snd_pcm_sgbuf_get_ptr() are no
longer used by any drivers.  Let's drop them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/memalloc.h | 19 -------------------
 include/sound/pcm.h      | 11 -----------
 2 files changed, 30 deletions(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 5daa937684a4..3ab084438fdc 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -103,19 +103,6 @@ static inline dma_addr_t snd_sgbuf_get_addr(struct snd_dma_buffer *dmab,
 	return addr + offset % PAGE_SIZE;
 }
 
-/*
- * return the virtual address at the corresponding offset
- */
-static inline void *snd_sgbuf_get_ptr(struct snd_dma_buffer *dmab,
-				     size_t offset)
-{
-	struct snd_sg_buf *sgbuf = dmab->private_data;
-
-	if (!sgbuf)
-		return dmab->area + offset;
-	return sgbuf->table[offset >> PAGE_SHIFT].buf + offset % PAGE_SIZE;
-}
-
 unsigned int snd_sgbuf_get_chunk_size(struct snd_dma_buffer *dmab,
 				      unsigned int ofs, unsigned int size);
 #else
@@ -126,12 +113,6 @@ static inline dma_addr_t snd_sgbuf_get_addr(struct snd_dma_buffer *dmab,
 	return dmab->addr + offset;
 }
 
-static inline void *snd_sgbuf_get_ptr(struct snd_dma_buffer *dmab,
-				      size_t offset)
-{
-	return dmab->area + offset;
-}
-
 #define snd_sgbuf_get_chunk_size(dmab, ofs, size)	(size)
 
 #endif /* CONFIG_SND_DMA_SGBUF */
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2e1200d17d0c..11e0a68335bd 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1272,17 +1272,6 @@ snd_pcm_sgbuf_get_addr(struct snd_pcm_substream *substream, unsigned int ofs)
 	return snd_sgbuf_get_addr(snd_pcm_get_dma_buf(substream), ofs);
 }
 
-/**
- * snd_pcm_sgbuf_get_ptr - Get the virtual address at the corresponding offset
- * @substream: PCM substream
- * @ofs: byte offset
- */
-static inline void *
-snd_pcm_sgbuf_get_ptr(struct snd_pcm_substream *substream, unsigned int ofs)
-{
-	return snd_sgbuf_get_ptr(snd_pcm_get_dma_buf(substream), ofs);
-}
-
 /**
  * snd_pcm_sgbuf_get_chunk_size - Compute the max size that fits within the
  * contig. page from the given size
-- 
2.26.2

