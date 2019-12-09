Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5CFC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:39:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61ECD207FF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TBH3exGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ECD207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B33921705;
	Mon,  9 Dec 2019 11:38:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B33921705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575887983;
	bh=8mmDQ2WAoPfSEcXC/eA7HfPBoWNjihyA+c4ZsIAOzzU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TBH3exGrNbTQd4cVeiLL7RCLR8dVNBt/UrBBGSdraYZjtgSqznUGGBy93CYWAbBYg
	 yQbUw/72LQB/nF8StmCJcrfDW0xZPEJR1jGFIUD6DovfEPwpIUykvpxe1hTK/sXnSY
	 1kk5GZtXgsnc7tzibLNjUAMo7D8BB7ReLcwtqXUk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3D26F805FC;
	Mon,  9 Dec 2019 10:52:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48AD3F80393; Mon,  9 Dec 2019 10:51:31 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA278F802DC
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA278F802DC
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 75847B2E1
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:33 +0100
Message-Id: <20191209094943.14984-62-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 61/71] ALSA: sh: Use managed buffer
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
 sound/sh/sh_dac_audio.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index f9e36abc98ac..1406b50f3f78 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -125,18 +125,6 @@ static int snd_sh_dac_pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_sh_dac_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *hw_params)
-{
-	return snd_pcm_lib_malloc_pages(substream,
-			params_buffer_bytes(hw_params));
-}
-
-static int snd_sh_dac_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int snd_sh_dac_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
@@ -241,8 +229,6 @@ static const struct snd_pcm_ops snd_sh_dac_pcm_ops = {
 	.open		= snd_sh_dac_pcm_open,
 	.close		= snd_sh_dac_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= snd_sh_dac_pcm_hw_params,
-	.hw_free	= snd_sh_dac_pcm_hw_free,
 	.prepare	= snd_sh_dac_pcm_prepare,
 	.trigger	= snd_sh_dac_pcm_trigger,
 	.pointer	= snd_sh_dac_pcm_pointer,
@@ -267,10 +253,8 @@ static int snd_sh_dac_pcm(struct snd_sh_dac *chip, int device)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_sh_dac_pcm_ops);
 
 	/* buffer size=48K */
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-					      NULL,
-							48 * 1024,
-							48 * 1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+				       NULL, 48 * 1024, 48 * 1024);
 
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
