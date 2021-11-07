Return-Path: <SRS0=XTqg=P2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9EBC433F5
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Nov 2021 16:40:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E0661004
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Nov 2021 16:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2E0661004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63FB5165D;
	Sun,  7 Nov 2021 17:39:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63FB5165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636303213;
	bh=0yREcpZQbng+PGSWxA/Rx/oeSpGRmuUTlApGJjoPH3o=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RIg+XWBVxi+vWR3PjO8eeXZTGIOc8xs9tLZ7A1GdbM3/sY/isbkY6UL69Ad7ig+4G
	 ZfEdvFVcYcL3xB7rvhIGyfvRtLHVCld4/R6UnVgbYExMI/w8VcwP/TL/UdksNigbxO
	 hN7PDDiuMBlZU2ZA8/by9EshbVLVhcDQMbAntA+k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB84EF80224;
	Sun,  7 Nov 2021 17:39:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0890F802D2; Sun,  7 Nov 2021 17:39:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FA24F8012A
 for <alsa-devel@alsa-project.org>; Sun,  7 Nov 2021 17:39:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FA24F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="ujbaGbpy"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="+yrbDxP8"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9E53E1FD46
 for <alsa-devel@alsa-project.org>; Sun,  7 Nov 2021 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636303152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0Z4e4j0d3pgWzt8N5YCFWbrQyHMYs4wlkBBaS2hUg50=;
 b=ujbaGbpyX8ZDyov3OiP2XJk59u+nJ90sLnGpKYtb1k7S6c96itFL1p0og1OXbSdxGl/7Lt
 FTCeR0mCx/VIsCKqbuFG/tn8A66axw1F3VFJueX8IJ0gUaMDK+ZsrtjXR0e+I77rJzpe95
 oe1KWw25lGsiakJGs/wydEDBcZ+ixjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636303152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0Z4e4j0d3pgWzt8N5YCFWbrQyHMYs4wlkBBaS2hUg50=;
 b=+yrbDxP86FoENFNE0gULAC8Qs6t3MWjPy/gKJ9j9Y9PPDVVz84zDPo4pp+WbuCZi+SVLuk
 OeO1/fZ7uGYB+dCg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 8DEF0A3B81;
 Sun,  7 Nov 2021 16:39:12 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: PCM: Fix NULL dereference at mmap checks
Date: Sun,  7 Nov 2021 17:39:11 +0100
Message-Id: <20211107163911.13534-1-tiwai@suse.de>
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

The recent refactoring of mmap handling caused Oops on some devices
that don't use the standard memory allocations.  This patch addresses
it by allowing snd_dma_buffer_mmap() helper to receive the NULL
pointer dmab argument (and return an error appropriately).

Fixes: a202bd1ad86d ("ALSA: core: Move mmap handler into memalloc ops")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 0145dabda56d..de7e9d2df39d 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -183,8 +183,11 @@ EXPORT_SYMBOL_GPL(snd_devm_alloc_dir_pages);
 int snd_dma_buffer_mmap(struct snd_dma_buffer *dmab,
 			struct vm_area_struct *area)
 {
-	const struct snd_malloc_ops *ops = snd_dma_get_ops(dmab);
+	const struct snd_malloc_ops *ops;
 
+	if (!dmab)
+		return -ENOENT;
+	ops = snd_dma_get_ops(dmab);
 	if (ops && ops->mmap)
 		return ops->mmap(dmab, area);
 	else
-- 
2.31.1

