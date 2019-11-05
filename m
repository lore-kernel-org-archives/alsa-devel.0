Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765CEC5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:11:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4D6217F4
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ru9kgCKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4D6217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F94416F6;
	Tue,  5 Nov 2019 20:10:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F94416F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572981096;
	bh=V3O1eLsFVFIOZEmzGU7WOkxkeGBtmyRtAVzivxe2x44=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ru9kgCKbaI/78MrsoEZ56VqBjf/37OiOPCyjJ5z8VMtx86ZZoKE5NH8nFsmo/swCb
	 MijWw9qzAUypoB/KrFX/eMygR6Xizu1y+9kQDVytowI5hiSUSKrrZ2xUh8e4CSehlY
	 AEMSQI97QlCcsEIXsTcDP1TZ5AkRjFBm3RHiORdM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5103AF805DF;
	Tue,  5 Nov 2019 20:10:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93EF0F8015B; Tue,  5 Nov 2019 20:10:15 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7B46F8049B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 20:10:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7B46F8049B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CBDC3B418
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 19:10:11 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 20:10:07 +0100
Message-Id: <20191105191007.18150-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105191007.18150-1-tiwai@suse.de>
References: <20191105191007.18150-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 2/2] ALSA: pcm: Create proc files only for
	non-empty preallocations
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

It makes little sense to create prealloc proc files for streams that
have the zero max size, which is a typical case for vmalloc buffers.
Skip the proc file creations to save resources in such a case.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 19407f79b638..17ee361ce791 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -203,7 +203,8 @@ static void snd_pcm_lib_preallocate_pages1(struct snd_pcm_substream *substream,
 	if (substream->dma_buffer.bytes > 0)
 		substream->buffer_bytes_max = substream->dma_buffer.bytes;
 	substream->dma_max = max;
-	preallocate_info_init(substream);
+	if (max > 0)
+		preallocate_info_init(substream);
 }
 
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
