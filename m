Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1768C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:55:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278892072D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ELsMBfat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278892072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F2D21673;
	Mon,  9 Dec 2019 10:54:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F2D21673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885349;
	bh=AdhRgYVnR3+OQXcEb8qCUw3aeIjXbj7Qvljz9zfSC9s=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ELsMBfatesE0b8Vwa0eXQK2RHF6S2Xj6Sy95DeZyyx3HXJxDxabJ2AegCzv/f3bJ9
	 9SHXBj96Dbj047kXrCCgHQKoy6/aqkyuQJvX+/KArdlSEVvHf0jOlqCyOnoAeNO5JX
	 ea8kKWByWd9HhmDooPmYJik2OV5wOXo2BE9Db5ck=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CF02F8025E;
	Mon,  9 Dec 2019 10:50:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF6E8F80307; Mon,  9 Dec 2019 10:50:04 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B56E3F80240
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B56E3F80240
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D222AB2A3
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:42 +0100
Message-Id: <20191209094943.14984-11-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 10/71] ALSA: ad1816a: Use managed buffer
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
 sound/isa/ad1816a/ad1816a_lib.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index c4c60ebe2417..adc35051c5e9 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -206,17 +206,6 @@ static int snd_ad1816a_capture_trigger(struct snd_pcm_substream *substream, int
 				   SNDRV_PCM_STREAM_CAPTURE, cmd, 1);
 }
 
-static int snd_ad1816a_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *hw_params)
-{
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
-}
-
-static int snd_ad1816a_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int snd_ad1816a_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_ad1816a *chip = snd_pcm_substream_chip(substream);
@@ -645,8 +634,6 @@ static const struct snd_pcm_ops snd_ad1816a_playback_ops = {
 	.open =		snd_ad1816a_playback_open,
 	.close =	snd_ad1816a_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_ad1816a_hw_params,
-	.hw_free =	snd_ad1816a_hw_free,
 	.prepare =	snd_ad1816a_playback_prepare,
 	.trigger =	snd_ad1816a_playback_trigger,
 	.pointer =	snd_ad1816a_playback_pointer,
@@ -656,8 +643,6 @@ static const struct snd_pcm_ops snd_ad1816a_capture_ops = {
 	.open =		snd_ad1816a_capture_open,
 	.close =	snd_ad1816a_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_ad1816a_hw_params,
-	.hw_free =	snd_ad1816a_hw_free,
 	.prepare =	snd_ad1816a_capture_prepare,
 	.trigger =	snd_ad1816a_capture_trigger,
 	.pointer =	snd_ad1816a_capture_pointer,
@@ -680,9 +665,8 @@ int snd_ad1816a_pcm(struct snd_ad1816a *chip, int device)
 	strcpy(pcm->name, snd_ad1816a_chip_id(chip));
 	snd_ad1816a_init(chip);
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      chip->card->dev,
-					      64*1024, chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, chip->card->dev,
+				       64*1024, chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);
 
 	chip->pcm = pcm;
 	return 0;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
