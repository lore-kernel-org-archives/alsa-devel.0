Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62905C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:33:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC11C2077B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EXW7J+oI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC11C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E93B16E1;
	Mon,  9 Dec 2019 11:32:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E93B16E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575887597;
	bh=GJ60QSeEh9VvayEorugtbKHtz4tVyc4UcyXsBaaHp3o=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EXW7J+oIdAZCt0Z6PJk4boSUYMvBmgEqapE//byF0rWgZ3LtN+43Rd3BgXDw+zAml
	 ChAkVCfFet+mkMk+QOkt199fd83MK2MEQiyRncsdMnsyXjzSpgiXTHLeuet+2rl3Lu
	 V9kGjGNGgGLkFR2PRlp2XDjwoHVrQBq5JAk2YXFc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1B6AF805AA;
	Mon,  9 Dec 2019 10:52:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D84FEF8037D; Mon,  9 Dec 2019 10:51:14 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F10C9F802A0
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F10C9F802A0
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 040D2B2D6
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:24 +0100
Message-Id: <20191209094943.14984-53-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 52/71] ALSA: sis7019: Use managed buffer
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
The hw_params and hw_free callbacks became superfluous and got
dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/sis7019.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index ef7dd290ae05..4639bc21b42d 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -499,18 +499,6 @@ static int sis_substream_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int sis_playback_hw_params(struct snd_pcm_substream *substream,
-					struct snd_pcm_hw_params *hw_params)
-{
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-}
-
-static int sis_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int sis_pcm_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -701,11 +689,6 @@ static int sis_capture_hw_params(struct snd_pcm_substream *substream,
 	if (rc)
 		goto out;
 
-	rc = snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-	if (rc < 0)
-		goto out;
-
 	rc = sis_alloc_timing_voice(substream, hw_params);
 
 out:
@@ -864,8 +847,6 @@ static const struct snd_pcm_ops sis_playback_ops = {
 	.open = sis_playback_open,
 	.close = sis_substream_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = sis_playback_hw_params,
-	.hw_free = sis_hw_free,
 	.prepare = sis_pcm_playback_prepare,
 	.trigger = sis_pcm_trigger,
 	.pointer = sis_pcm_pointer,
@@ -876,7 +857,6 @@ static const struct snd_pcm_ops sis_capture_ops = {
 	.close = sis_substream_close,
 	.ioctl = snd_pcm_lib_ioctl,
 	.hw_params = sis_capture_hw_params,
-	.hw_free = sis_hw_free,
 	.prepare = sis_pcm_capture_prepare,
 	.trigger = sis_pcm_trigger,
 	.pointer = sis_pcm_pointer,
@@ -904,9 +884,8 @@ static int sis_pcm_create(struct sis7019 *sis)
 	/* Try to preallocate some memory, but it's not the end of the
 	 * world if this fails.
 	 */
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &sis->pci->dev,
-					      64*1024, 128*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &sis->pci->dev, 64*1024, 128*1024);
 
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
