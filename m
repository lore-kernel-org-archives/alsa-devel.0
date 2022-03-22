Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE7AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Mar 2022 17:10:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE52F174B;
	Tue, 22 Mar 2022 18:09:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE52F174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647969004;
	bh=KAormVgH8Kif3qqCfNO5+GOjtb3ughnVbLlzmt4Q9CI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=miFUhFyS+7OszMSC/jEgky3YUxLJDdW8AR8/L1+RPMAuZbUR6P7T7MPQP7eNvfxGU
	 DCUQwaJw2zX7rCfQoGRUvUOKEZ4WCjhrN6/wUdXBPRZ77oXuzDtitM1d+oJ6EkO32z
	 c4U5wOOCxT0znMJMjlNmwwfRkgWwFLVcXqUcrbcI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8300EF8051D;
	Tue, 22 Mar 2022 18:08:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07CF6F8051D; Tue, 22 Mar 2022 18:07:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6FAAF804B2
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2022 18:07:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6FAAF804B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="zkL58OMq"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="OVOtNP13"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3F0E5210F1;
 Tue, 22 Mar 2022 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647968867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CYXBkEmUaFG3FfKkSPLLXjGyKZ1eQzGvz99I1XhLxQ=;
 b=zkL58OMq5m9rO+mLy98V1NI+YcCjw1sPmH4arSaidEYt8b3J5LHZLPI5xNWbPK5OK/XHGS
 YKojgiwsW6+AM0WTiSUzUctuvpFi2ogMBvAtSIEMjI485eFC7XYJ4AU+RsBSltuJY7b9PO
 aWKS4yTdvUmMa8ldC+Wz56/+mhwp1Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647968867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CYXBkEmUaFG3FfKkSPLLXjGyKZ1eQzGvz99I1XhLxQ=;
 b=OVOtNP13gEiVstfwWb2gabKAA+rWqAJDUALsnyA4f0dE5OpRRbkr8cLGA9FcJXEKvFfMNq
 /QqEQubfoFJbDrDQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 388C5A3B87;
 Tue, 22 Mar 2022 17:07:47 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ALSA: pcm: Fix races among concurrent prealloc proc writes
Date: Tue, 22 Mar 2022 18:07:20 +0100
Message-Id: <20220322170720.3529-5-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220322170720.3529-1-tiwai@suse.de>
References: <20220322170720.3529-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Hu Jiahui <kirin.say@gmail.com>, linux-kernel@vger.kernel.org
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

We have no protection against concurrent PCM buffer preallocation
changes via proc files, and it may potentially lead to UAF or some
weird problem.  This patch applies the PCM open_mutex to the proc
write operation for avoiding the racy proc writes and the PCM stream
open (and further operations).

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index b70ce3b69ab4..8848d2f3160d 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -163,19 +163,20 @@ static void snd_pcm_lib_preallocate_proc_write(struct snd_info_entry *entry,
 	size_t size;
 	struct snd_dma_buffer new_dmab;
 
+	mutex_lock(&substream->pcm->open_mutex);
 	if (substream->runtime) {
 		buffer->error = -EBUSY;
-		return;
+		goto unlock;
 	}
 	if (!snd_info_get_line(buffer, line, sizeof(line))) {
 		snd_info_get_str(str, line, sizeof(str));
 		size = simple_strtoul(str, NULL, 10) * 1024;
 		if ((size != 0 && size < 8192) || size > substream->dma_max) {
 			buffer->error = -EINVAL;
-			return;
+			goto unlock;
 		}
 		if (substream->dma_buffer.bytes == size)
-			return;
+			goto unlock;
 		memset(&new_dmab, 0, sizeof(new_dmab));
 		new_dmab.dev = substream->dma_buffer.dev;
 		if (size > 0) {
@@ -189,7 +190,7 @@ static void snd_pcm_lib_preallocate_proc_write(struct snd_info_entry *entry,
 					 substream->pcm->card->number, substream->pcm->device,
 					 substream->stream ? 'c' : 'p', substream->number,
 					 substream->pcm->name, size);
-				return;
+				goto unlock;
 			}
 			substream->buffer_bytes_max = size;
 		} else {
@@ -201,6 +202,8 @@ static void snd_pcm_lib_preallocate_proc_write(struct snd_info_entry *entry,
 	} else {
 		buffer->error = -EINVAL;
 	}
+ unlock:
+	mutex_unlock(&substream->pcm->open_mutex);
 }
 
 static inline void preallocate_info_init(struct snd_pcm_substream *substream)
-- 
2.31.1

