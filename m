Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB31C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:11:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F24217F4
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KBn6oXL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F24217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D837A16DA;
	Tue,  5 Nov 2019 20:10:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D837A16DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572981067;
	bh=YsoZ8Cy9RDmrmMc/HMuBk3itpgYcAMA+/rC+2BuJlfA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KBn6oXL1yvp5wWEZuIuxWwJKNsW3uQY9UyRaQHnsvVxCOZ8jagEIuN0AsYVY6vi0B
	 O2CxF113XPs7tYDjzM0UxhseRHPL9tUbdX7mX6JdJhZSbEVoub+dA0KoxusmX3Zf8z
	 5s7YqSKwaLiZINZObEr/DL+g0jHDO0VS9d2M+bEU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 760EDF80446;
	Tue,  5 Nov 2019 20:10:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B097F805DF; Tue,  5 Nov 2019 20:10:15 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99CF7F8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 20:10:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99CF7F8015B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BA277B417
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 19:10:11 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 20:10:06 +0100
Message-Id: <20191105191007.18150-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105191007.18150-1-tiwai@suse.de>
References: <20191105191007.18150-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 1/2] ALSA: pcm: Warn if doubly preallocated
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

Warn if snd_pcm_lib_preallocate_pages*() is applied to the stream that
has already the preallocated buffers and skip the allocation.  It's a
clearly a driver bug.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 7600dcdf5fd4..19407f79b638 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -221,6 +221,8 @@ void snd_pcm_lib_preallocate_pages(struct snd_pcm_substream *substream,
 				  int type, struct device *data,
 				  size_t size, size_t max)
 {
+	if (snd_BUG_ON(substream->dma_buffer.dev.type))
+		return;
 	substream->dma_buffer.dev.type = type;
 	substream->dma_buffer.dev.dev = data;
 	snd_pcm_lib_preallocate_pages1(substream, size, max);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
