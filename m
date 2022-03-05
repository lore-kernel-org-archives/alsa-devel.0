Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38079C433EF
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Mar 2022 08:34:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 238F81888;
	Sat,  5 Mar 2022 09:33:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 238F81888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646469250;
	bh=Ako60X91UkdmhXAVlX6NanB2sSOXfoIKBpa5biulbtY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aK1dmoulP+kdP4oO7DVUuZoVgHqP0ethIESFpwMot/OFo0zoem++Tq8QnvqWcOfMU
	 ORv0mPgbBipI4zpU6wtpN8Ton4QtgChyM6+kCE45gxAiRqjQSVgsYt8Q55RzQ/PlDi
	 pMMVQHhyCRgb/cKlZXM4EYLz1BPFCyirgbw1XB74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC8AEF800F0;
	Sat,  5 Mar 2022 09:33:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9135FF80237; Sat,  5 Mar 2022 09:33:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73378F800DF
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2022 09:33:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73378F800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="Lo/T8pee"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="zgZT8UWj"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C8AEA21121
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2022 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646469189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JmWyVRIGOKiGk4jUXeEb6o/qmvixcZw8lZD0PN1zwZ4=;
 b=Lo/T8peesC4ZrTX8QC7qPP8FNuTyUncTJh2zV8W4wG5UEE30TswDOrsxRVsHQcZfEl5B/r
 okXo087ofvKiuCgtNkxNZSbgoaeJMi/8jgbYsgZ993WqvqsdcJWOgjcML32y13Qra/kBJZ
 x19Ptis2183li5R7xF5IA6SiK7y7yys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646469189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JmWyVRIGOKiGk4jUXeEb6o/qmvixcZw8lZD0PN1zwZ4=;
 b=zgZT8UWj+OsY2u7lOPWEgCQgi16o4cCQ417TDMiQU99mJsKENgloh9914hpz6iq7xN90Um
 xqK2cEst2vdsdJBg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id B9A83A3B84;
 Sat,  5 Mar 2022 08:33:09 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: x86: Use standard mmap helper for Intel HDMI LPE audio
Date: Sat,  5 Mar 2022 09:33:08 +0100
Message-Id: <20220305083308.15718-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
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

Intel HDMI LPE audio driver has its own mmap callback that mimics with
the noncached page attributes, but this is rather superfluous and can
be replaced with the standard helper, as the device is only for
playback and the write-cache should suffice.

This patch drops the own code and just uses the standard helper.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 4a3ff6468aa7..b00634663346 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1253,18 +1253,6 @@ static snd_pcm_uframes_t had_pcm_pointer(struct snd_pcm_substream *substream)
 	return len;
 }
 
-/*
- * ALSA PCM mmap callback
- */
-static int had_pcm_mmap(struct snd_pcm_substream *substream,
-			struct vm_area_struct *vma)
-{
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	return remap_pfn_range(vma, vma->vm_start,
-			substream->runtime->dma_addr >> PAGE_SHIFT,
-			vma->vm_end - vma->vm_start, vma->vm_page_prot);
-}
-
 /*
  * ALSA PCM ops
  */
@@ -1276,7 +1264,6 @@ static const struct snd_pcm_ops had_pcm_ops = {
 	.trigger =	had_pcm_trigger,
 	.sync_stop =	had_pcm_sync_stop,
 	.pointer =	had_pcm_pointer,
-	.mmap =		had_pcm_mmap,
 };
 
 /* process mode change of the running stream; called in mutex */
-- 
2.31.1

