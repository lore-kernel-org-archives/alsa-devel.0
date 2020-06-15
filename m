Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6FAC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:04:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD6020679
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UmrmzAgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD6020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2DA91671;
	Mon, 15 Jun 2020 18:03:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2DA91671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592237053;
	bh=vr7ekeB+F6CAQPVtrAHi2PbZiUv6+KUAk4yJbxE+ONY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UmrmzAgrsIq50LzEOs8EbnOCM7gixUEj8I6o+iA0y595BfG6QdETa7vc1favzAJv8
	 MSXIFojKJBxfFCPTEbE29zKOyOkyjh2Ebzu8qkzkcqmE1SzOs8u/Y8B+UNpmKloSLj
	 lussJ8HkgkjUd+Nod4tefWMyyXiRZVqTz8efHR4s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8DB7F802C4;
	Mon, 15 Jun 2020 18:01:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55B6CF802A2; Mon, 15 Jun 2020 18:01:00 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5EDE0F80162
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 18:00:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EDE0F80162
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4551EAE0A
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 16:00:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/4] ALSA: memalloc: Make SG-buffer helper usable for
 continuous buffer, too
Date: Mon, 15 Jun 2020 18:00:44 +0200
Message-Id: <20200615160045.2703-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200615160045.2703-1-tiwai@suse.de>
References: <20200615160045.2703-1-tiwai@suse.de>
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

We have a few helper functions for making the access to the buffer
address easier on SG-buffer.  Those are specific to the buffer that is
allocated with SG-buffer type, and it makes hard to use both SG and
non-SG buffers in the same code.

This patch adds a few simple checks and lets the helpers to deal with
both SG- and continuous buffers gracefully.  It's a preliminary step
for the upcoming patch that mimics the buffer type on the fly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/memalloc.h | 9 ++++++++-
 sound/core/sgbuf.c       | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 3b47832b1c1f..5daa937684a4 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -94,7 +94,11 @@ static inline dma_addr_t snd_sgbuf_get_addr(struct snd_dma_buffer *dmab,
 					   size_t offset)
 {
 	struct snd_sg_buf *sgbuf = dmab->private_data;
-	dma_addr_t addr = sgbuf->table[offset >> PAGE_SHIFT].addr;
+	dma_addr_t addr;
+
+	if (!sgbuf)
+		return dmab->addr + offset;
+	addr = sgbuf->table[offset >> PAGE_SHIFT].addr;
 	addr &= ~((dma_addr_t)PAGE_SIZE - 1);
 	return addr + offset % PAGE_SIZE;
 }
@@ -106,6 +110,9 @@ static inline void *snd_sgbuf_get_ptr(struct snd_dma_buffer *dmab,
 				     size_t offset)
 {
 	struct snd_sg_buf *sgbuf = dmab->private_data;
+
+	if (!sgbuf)
+		return dmab->area + offset;
 	return sgbuf->table[offset >> PAGE_SHIFT].buf + offset % PAGE_SIZE;
 }
 
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index c42217e2dd19..29ddb76187e5 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -142,6 +142,9 @@ unsigned int snd_sgbuf_get_chunk_size(struct snd_dma_buffer *dmab,
 	struct snd_sg_buf *sg = dmab->private_data;
 	unsigned int start, end, pg;
 
+	if (!sg)
+		return size;
+
 	start = ofs >> PAGE_SHIFT;
 	end = (ofs + size - 1) >> PAGE_SHIFT;
 	/* check page continuity */
-- 
2.16.4

