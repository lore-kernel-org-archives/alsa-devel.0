Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC99C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jul 2022 10:50:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C79CD170F;
	Wed, 13 Jul 2022 12:49:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C79CD170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657709438;
	bh=X2OO6F8mNUYiRcEaxVDfkP+diJyD2ATjSBhBzi9Dmwk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Umrd36W7gTmU4bn1+A1oE+/wfOR+dxC7wHK4KW4nS+Bu0PkL0WW1mtiT9iYE7blU6
	 yqWEUIRIM4k2LhyAY18gyBD+itmKbIVJVQAVrI/vLTY4Cd55Xhwzr8hnEOCyvioH80
	 MmNMKNJIFUVAN5jvVFqL4XYigxkJjZYTWtr94doo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E445F804CA;
	Wed, 13 Jul 2022 12:48:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 758BCF80567; Wed, 13 Jul 2022 12:48:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EB56F8012B
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2022 12:48:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EB56F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="XWV9BMAs"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="lCx40oG4"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D62B33B11;
 Wed, 13 Jul 2022 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657709287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqcjypMQZoIRENC2jxuhHjeNZEM0BQoE4Id9Rztg9hI=;
 b=XWV9BMAsmQn/LpJvJgUWWws9PQhuX/U5euiv2dR7OSkoIftS4ngecNaZQc5wRdwCFTfVIv
 ev8L5+7Q0ozzzwbJoD+uENJVbti1AFFIA7xdCkcrYlH2AUySq6LJsSYcq3lJjQATuOIIFl
 rxp31PST1gsqwaELJbeKYJZftCBn5rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657709287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqcjypMQZoIRENC2jxuhHjeNZEM0BQoE4Id9Rztg9hI=;
 b=lCx40oG4lND/HV73owUFTFx6M0Ry0nImdbBLqrl9xPRlvdt6rgyhXaBP4bX4L3ZLy/ucJS
 5RmEF6zE78FI2YCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E78AB13754;
 Wed, 13 Jul 2022 10:48:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +G51N+aizmLceAAAMHmgww
 (envelope-from <tiwai@suse.de>); Wed, 13 Jul 2022 10:48:06 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 6/7] ALSA: memalloc: Fix missing return value comments for
 kernel docs
Date: Wed, 13 Jul 2022 12:47:58 +0200
Message-Id: <20220713104759.4365-7-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220713104759.4365-1-tiwai@suse.de>
References: <20220713104759.4365-1-tiwai@suse.de>
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

Each kernel doc comment expects the definition of the return value in
a proper format.  This patch adds or fixes the missing entries for
memory allocation helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 8cfdaee77905..d3885cb02270 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -147,7 +147,7 @@ static void __snd_release_pages(struct device *dev, void *res)
  * hence it can't work with SNDRV_DMA_TYPE_CONTINUOUS or
  * SNDRV_DMA_TYPE_VMALLOC type.
  *
- * The function returns the snd_dma_buffer object at success, or NULL if failed.
+ * Return: the snd_dma_buffer object at success, or NULL if failed
  */
 struct snd_dma_buffer *
 snd_devm_alloc_dir_pages(struct device *dev, int type,
@@ -179,6 +179,8 @@ EXPORT_SYMBOL_GPL(snd_devm_alloc_dir_pages);
  * snd_dma_buffer_mmap - perform mmap of the given DMA buffer
  * @dmab: buffer allocation information
  * @area: VM area information
+ *
+ * Return: zero if successful, or a negative error code
  */
 int snd_dma_buffer_mmap(struct snd_dma_buffer *dmab,
 			struct vm_area_struct *area)
@@ -219,6 +221,8 @@ EXPORT_SYMBOL_GPL(snd_dma_buffer_sync);
  * snd_sgbuf_get_addr - return the physical address at the corresponding offset
  * @dmab: buffer allocation information
  * @offset: offset in the ring buffer
+ *
+ * Return: the physical address
  */
 dma_addr_t snd_sgbuf_get_addr(struct snd_dma_buffer *dmab, size_t offset)
 {
@@ -235,6 +239,8 @@ EXPORT_SYMBOL(snd_sgbuf_get_addr);
  * snd_sgbuf_get_page - return the physical page at the corresponding offset
  * @dmab: buffer allocation information
  * @offset: offset in the ring buffer
+ *
+ * Return: the page pointer
  */
 struct page *snd_sgbuf_get_page(struct snd_dma_buffer *dmab, size_t offset)
 {
@@ -253,6 +259,8 @@ EXPORT_SYMBOL(snd_sgbuf_get_page);
  * @dmab: buffer allocation information
  * @ofs: offset in the ring buffer
  * @size: the requested size
+ *
+ * Return: the chunk size
  */
 unsigned int snd_sgbuf_get_chunk_size(struct snd_dma_buffer *dmab,
 				      unsigned int ofs, unsigned int size)
-- 
2.35.3

