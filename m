Return-Path: <SRS0=XtK2=PY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC02C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 10:22:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9D060F21
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 10:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB9D060F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 966F8165D;
	Fri,  5 Nov 2021 11:21:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 966F8165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636107726;
	bh=4OhHVQQIs0bF+HMW3FUiJ54PFpzy7+RMtDKxrL7AmXc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EAKeZ6EPJvbQQkok7KZekKiCPtkcwPDurRD4DBNbfmmMmPmrIe4dHNOYa6sEWwgiZ
	 qHSeDYcJRlOao9tyrvPEvDnGPcDwggHImRI48Qk01YGDucCLmVjT75kVmXW3SjaAk6
	 KGGsn5tVpZRmjUYZGVdQmZjoiwijkax/ef0q+uGs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25F0EF80148;
	Fri,  5 Nov 2021 11:21:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D00B9F8026A; Fri,  5 Nov 2021 11:21:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC563F80224
 for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2021 11:21:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC563F80224
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="1vdMVCeB"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="5h0USV7U"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AD7AE212BB
 for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2021 10:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636107665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kZw4A7Tixt7gwkJbsdNVapGkXdC6w1fot026JxImMzo=;
 b=1vdMVCeB0P9cnZogiyqIicLDpb1QJmlXkXT4hNSlgtD8jGPZqIf/gKkte0JiF1lO1zcJFP
 bIAn0INtCFxGIPMXwqRitg26T8VHQLCsAo588sgmLCJsOQ0BZBEeB/vP2SLtBMO9bPdtss
 Ak9BCsX/d1HbhnThVrIhP6UNKaE45Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636107665;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kZw4A7Tixt7gwkJbsdNVapGkXdC6w1fot026JxImMzo=;
 b=5h0USV7UTaFaMie6x4wUwXor5FQEkwM7UHNFz9MdT/EfByvQV/4t/QbWD1u349IWMl2adX
 OUpEijdrg59sA7Bw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 9E9352C157;
 Fri,  5 Nov 2021 10:21:05 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: memalloc: Catch call with NULL snd_dma_buffer pointer
Date: Fri,  5 Nov 2021 11:21:03 +0100
Message-Id: <20211105102103.28148-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
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

Although we've covered all calls with NULL dma buffer pointer, so far,
there may be still some else in the wild.  For catching such a case
more easily, add a WARN_ON_ONCE() in snd_dma_get_ops().

Fixes: 37af81c5998f ("ALSA: core: Abstract memory alloc helpers")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index ea778f868cf3..ea9698cea2e3 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -631,6 +631,8 @@ static const struct snd_malloc_ops *dma_ops[] = {
 
 static const struct snd_malloc_ops *snd_dma_get_ops(struct snd_dma_buffer *dmab)
 {
+	if (WARN_ON_ONCE(!dmab))
+		return NULL;
 	if (WARN_ON_ONCE(dmab->dev.type <= SNDRV_DMA_TYPE_UNKNOWN ||
 			 dmab->dev.type >= ARRAY_SIZE(dma_ops)))
 		return NULL;
-- 
2.31.1

