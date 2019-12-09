Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CA2C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:29:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A413B2077B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bXvJyW55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A413B2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE82316A5;
	Mon,  9 Dec 2019 11:28:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE82316A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575887355;
	bh=urwJ247kbfWFCtYh2PnNb7bVGi2EbiPo9k6CKv4Ii+4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bXvJyW558Xregpxrxn8fxiH6HxFmJM7vqA6f7X2mP0zsCQRokqo6jpPg6Qy6V4xMP
	 rfO6cFYqqnrbu0YSqivXc3wg7IUEA8iePca9VFZYcIey4RswyHsa8wsIuGtvfFZYZt
	 DR18IhGcsI0FQU1LdTuQrWiEArSz+/FEtFPgRcwM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C34D5F80539;
	Mon,  9 Dec 2019 10:52:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F9DCF8036C; Mon,  9 Dec 2019 10:51:06 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0641F80291
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0641F80291
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A2890B2CF
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:48 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:16 +0100
Message-Id: <20191209094943.14984-45-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 44/71] ALSA: lola: Use managed buffer
	allocation
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

Clean up the driver with the new managed buffer allocation API.
The superfluous snd_pcm_lib_malloc_pages() and
snd_pcm_lib_free_pages() calls are dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/lola/lola_pcm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/pci/lola/lola_pcm.c b/sound/pci/lola/lola_pcm.c
index 856bcca60128..a01a06896084 100644
--- a/sound/pci/lola/lola_pcm.c
+++ b/sound/pci/lola/lola_pcm.c
@@ -282,8 +282,7 @@ static int lola_pcm_hw_params(struct snd_pcm_substream *substream,
 	str->bufsize = 0;
 	str->period_bytes = 0;
 	str->format_verb = 0;
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
+	return 0;
 }
 
 static int lola_pcm_hw_free(struct snd_pcm_substream *substream)
@@ -296,7 +295,7 @@ static int lola_pcm_hw_free(struct snd_pcm_substream *substream)
 	lola_stream_reset(chip, str);
 	lola_cleanup_slave_streams(pcm, str);
 	mutex_unlock(&chip->open_mutex);
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 /*
@@ -610,9 +609,9 @@ int lola_create_pcm(struct lola *chip)
 			snd_pcm_set_ops(pcm, i, &lola_pcm_ops);
 	}
 	/* buffer pre-allocation */
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
-					      &chip->pci->dev,
-					      1024 * 64, 32 * 1024 * 1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
+				       &chip->pci->dev,
+				       1024 * 64, 32 * 1024 * 1024);
 	return 0;
 }
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
