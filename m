Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BECC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:09:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2762077B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lBhydzdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2762077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15EFF167C;
	Mon,  9 Dec 2019 11:09:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15EFF167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575886193;
	bh=Gy2ObAsL/o+dZwbVNaNVqnjlZG9vipmiI1t4XcLRkrE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lBhydzdxzG2tCgJfDC5kf7Q1VQdD4J/BtqwQInQURN2WlPYXQUdQrIGfUgyuyLZ7j
	 n5tSFYbK6ipegqO5sRe1d9nXIsFgGfNVbgb2srus+WiKxKSc3zqBSZBikrgM75cPqR
	 s5oNxgJo+atzUId0G+INNNidj7ehCOQMgZ9Ti5kM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD6C0F8027C;
	Mon,  9 Dec 2019 10:51:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 456D2F80271; Mon,  9 Dec 2019 10:50:38 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D5C3F80274
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D5C3F80274
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EAD6DB2C4
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:47 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:03 +0100
Message-Id: <20191209094943.14984-32-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 31/71] ALSA: cs4281: Use managed buffer
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
 sound/pci/cs4281.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 058c1414b777..ea665d42107e 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -780,17 +780,6 @@ static void snd_cs4281_mode(struct cs4281 *chip, struct cs4281_dma *dma,
 	snd_cs4281_pokeBA0(chip, dma->regFSIC, 0);
 }
 
-static int snd_cs4281_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *hw_params)
-{
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
-}
-
-static int snd_cs4281_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int snd_cs4281_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -939,8 +928,6 @@ static const struct snd_pcm_ops snd_cs4281_playback_ops = {
 	.open =		snd_cs4281_playback_open,
 	.close =	snd_cs4281_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_cs4281_hw_params,
-	.hw_free =	snd_cs4281_hw_free,
 	.prepare =	snd_cs4281_playback_prepare,
 	.trigger =	snd_cs4281_trigger,
 	.pointer =	snd_cs4281_pointer,
@@ -950,8 +937,6 @@ static const struct snd_pcm_ops snd_cs4281_capture_ops = {
 	.open =		snd_cs4281_capture_open,
 	.close =	snd_cs4281_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_cs4281_hw_params,
-	.hw_free =	snd_cs4281_hw_free,
 	.prepare =	snd_cs4281_capture_prepare,
 	.trigger =	snd_cs4281_trigger,
 	.pointer =	snd_cs4281_pointer,
@@ -974,9 +959,8 @@ static int snd_cs4281_pcm(struct cs4281 *chip, int device)
 	strcpy(pcm->name, "CS4281");
 	chip->pcm = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &chip->pci->dev,
-					      64*1024, 512*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, &chip->pci->dev,
+				       64*1024, 512*1024);
 
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
