Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F91C38142
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Jan 2023 09:29:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE678DFA;
	Tue, 24 Jan 2023 10:28:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE678DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674552578;
	bh=O83f4ppUCCmSMMut0SLfMhi/DqlEtsL172n/UX9rQL8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=W2krzt0H4AReTzzkY5Z8qLPdDnPjJ8969ld5M2+3y0c8lSxYjjOhM5w0QeO6mh3Cf
	 pnWG3+pjtuUxA7Iw4mXVLSrq/B8BSTWw8Vy34UK9Zk1jGqE32eF0JFx5m3Ci+tKFcB
	 paKMjsdEuSxz1liotjadk+qEHAvvqu14XVzhmqFc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55F65F80533;
	Tue, 24 Jan 2023 10:28:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53349F804D2; Tue, 24 Jan 2023 10:27:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14409F80163
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2023 10:27:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14409F80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=rbFW8x//; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=zOuHcpo7
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B16C51FE4B;
 Tue, 24 Jan 2023 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1674552469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jljjb+F8zDpSyXWZR7/ZtdjURcA3gFg8/M3ZvtquJfc=;
 b=rbFW8x//a6Z0JtNtRImd6mh9OQzGdYCM0JSrCBtej24iIq7GrnbbpsvUnEKT13QPIVy1Jp
 7oz/ltRtSkiYtj1L15uT+U/GyX81O2QOm17QA/hSZxPK59+Aa6oa3H4ABnrWMFE9m2aZFR
 ptJiH676qyP+jiPvdCYq3CqPmB9iNAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1674552469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jljjb+F8zDpSyXWZR7/ZtdjURcA3gFg8/M3ZvtquJfc=;
 b=zOuHcpo701S00jU9fjIoeJFbMWO4a5RQ4mH3qGyMqCIW4c/7yYClBvo3XyLkjZJQg5zdOB
 yOSLm8vdA2nv2xBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51F2E139FF;
 Tue, 24 Jan 2023 09:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AMmrEpWkz2NeUgAAMHmgww
 (envelope-from <tiwai@suse.de>); Tue, 24 Jan 2023 09:27:49 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: memalloc: Explicit SG-allocations for Xen PV and
 non-IOMMU systems
Date: Tue, 24 Jan 2023 10:27:43 +0100
Message-Id: <20230124092744.27370-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124092744.27370-1-tiwai@suse.de>
References: <20230124092744.27370-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

For non-IOMMU systems, it makes little sense (or even buggy) to use
dma_alloc_noncontiguous() as an x86 SG-buffer allocation, as it always
results in the big continuous pages instead of SG buffer.  Also, for
Xen PV, this seems also not working well as the pages allocated there
aren't guaranteed to be coherent.

This patch is a first step to address those problems.  It changes the
memalloc helper to go for the explicit SG-page allocations via the
existing fallback allocation primarily for such a platform instead of
dma_alloc_noncontiguous().

Fixes: a8d302a0b770 ("ALSA: memalloc: Revive x86-specific WC page allocations again")
Fixes: 9736a325137b ("ALSA: memalloc: Don't fall back for SG-buffer with IOMMU")
Reported-and-tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Link: https://lore.kernel.org/r/87tu256lqs.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 81025f50a542..30c9ad192986 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -541,10 +541,9 @@ static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
 	struct sg_table *sgt;
 	void *p;
 
-	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
-				      DEFAULT_GFP, 0);
 #ifdef CONFIG_SND_DMA_SGBUF
-	if (!sgt && !get_dma_ops(dmab->dev.dev)) {
+	if (cpu_feature_enabled(X86_FEATURE_XENPV) ||
+	    !get_dma_ops(dmab->dev.dev)) {
 		if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG)
 			dmab->dev.type = SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK;
 		else
@@ -552,6 +551,8 @@ static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
 		return snd_dma_sg_fallback_alloc(dmab, size);
 	}
 #endif
+	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
+				      DEFAULT_GFP, 0);
 	if (!sgt)
 		return NULL;
 
-- 
2.35.3

