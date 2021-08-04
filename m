Return-Path: <SRS0=vE6Q=M3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3222CC4338F
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 07:53:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D6560187
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 07:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55D6560187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C590A16FE;
	Wed,  4 Aug 2021 09:52:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C590A16FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628063607;
	bh=B8+q4u6hAQHw/aiU+vPcHjnJWWtCs1ZqQXz6BCoK/oI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fJzB2vEy+crMZAfgIUAIOWgz7MbvkIfPpyxPQKzFLNNCgti4nOMxA4xCJLN5sJ/Hq
	 a5ek0g8qhxkGGfjn0MrJ5oVw59Fmm2SsYSYi1aw1T7PEiTPO5kJfG3dr2juPLH14z8
	 3Ybj+dUu/c5QOffdg/JcY7KE6VNkWcOYmlgNQeLQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C2AFF801F7;
	Wed,  4 Aug 2021 09:52:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B7C7F8025F; Wed,  4 Aug 2021 09:52:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBBCCF8014D
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 09:52:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBBCCF8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="jEi1/9Z3"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="tXrj/FMb"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4D4E720108;
 Wed,  4 Aug 2021 07:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628063548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=I/bFanim3q0KLSxSIePSJPHpTH8ki6gDibgAEyQ6m7U=;
 b=jEi1/9Z34ny8rhWYpO2VEVBxFqCS3+gEUn75uWjkvxXP5YYNJJit6eHnBGtXKBCgeiGbtk
 84GF8TZgJSmAOAZyzqf+wKZFiogNLQgq/e12BpGlOjOhtZqDQc/kfmbU9+opV4GWzeyH7K
 ePDBQR5Zhx+aM6qQbsGcur2M3IpCdjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628063548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=I/bFanim3q0KLSxSIePSJPHpTH8ki6gDibgAEyQ6m7U=;
 b=tXrj/FMbhv5q3/v6jP4PanA6xMXHuY1ts9gqOAgCaPhqYTewd2TN9REFn6EyETc5UTLfFn
 jtizUpu9FTD4qUAQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 3BB16A3B8D;
 Wed,  4 Aug 2021 07:52:28 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: amd: vangogh: Drop superfluous mmap callback
Date: Wed,  4 Aug 2021 09:52:23 +0200
Message-Id: <20210804075223.9823-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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

The mmap callback of vangogh driver just calls the default mmap
handler, and it's superfluous, as the PCM core would call it if not
set.  Let's drop the superfluous mmap callback.

Fixes: 361414dc1f07 ("ASoC: amd: add vangogh i2s dma driver pm ops")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index 9f8eb72ac834..f10de38976cb 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -315,13 +315,6 @@ static int acp5x_dma_new(struct snd_soc_component *component,
 	return 0;
 }
 
-static int acp5x_dma_mmap(struct snd_soc_component *component,
-			  struct snd_pcm_substream *substream,
-			  struct vm_area_struct *vma)
-{
-	return snd_pcm_lib_default_mmap(substream, vma);
-}
-
 static int acp5x_dma_close(struct snd_soc_component *component,
 			   struct snd_pcm_substream *substream)
 {
@@ -364,7 +357,6 @@ static const struct snd_soc_component_driver acp5x_i2s_component = {
 	.close		= acp5x_dma_close,
 	.hw_params	= acp5x_dma_hw_params,
 	.pointer	= acp5x_dma_pointer,
-	.mmap		= acp5x_dma_mmap,
 	.pcm_construct	= acp5x_dma_new,
 };
 
-- 
2.26.2

