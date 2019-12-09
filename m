Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3DEC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:33:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79442077B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h8u9OG+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79442077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E6C11661;
	Mon,  9 Dec 2019 11:33:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E6C11661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575887631;
	bh=k4gNcbHJKovhx+RHbhOGA0tR4C3albWNFjyhFbl+5dY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h8u9OG+rBt4Rk+EjAwO/ywiXJuus0+5COFZF/naE63Dker81+5cg4jRAYmJblTPoP
	 XN+MZUSVUFHtJo29lTIDiAfRciCPTgTxoAS+kp+EIt80v73b0xEXonvtUkx+EKCZBt
	 N4dQFs33Xrd4gC1sZ0VmIwBId9uAGiiOusGFzJOk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEC9BF805C1;
	Mon,  9 Dec 2019 10:52:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0DE8F8037D; Mon,  9 Dec 2019 10:51:15 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 625A4F802A7
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 625A4F802A7
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 13056B2D8
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:25 +0100
Message-Id: <20191209094943.14984-54-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 53/71] ALSA: sonicvibes: Use managed buffer
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
 sound/pci/sonicvibes.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 31cbc811ad37..e117d8450b2d 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -681,17 +681,6 @@ static int snd_sonicvibes_capture_trigger(struct snd_pcm_substream *substream,
 	return snd_sonicvibes_trigger(sonic, 2, cmd);
 }
 
-static int snd_sonicvibes_hw_params(struct snd_pcm_substream *substream,
-				    struct snd_pcm_hw_params *hw_params)
-{
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
-}
-
-static int snd_sonicvibes_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int snd_sonicvibes_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct sonicvibes *sonic = snd_pcm_substream_chip(substream);
@@ -847,8 +836,6 @@ static const struct snd_pcm_ops snd_sonicvibes_playback_ops = {
 	.open =		snd_sonicvibes_playback_open,
 	.close =	snd_sonicvibes_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_sonicvibes_hw_params,
-	.hw_free =	snd_sonicvibes_hw_free,
 	.prepare =	snd_sonicvibes_playback_prepare,
 	.trigger =	snd_sonicvibes_playback_trigger,
 	.pointer =	snd_sonicvibes_playback_pointer,
@@ -858,8 +845,6 @@ static const struct snd_pcm_ops snd_sonicvibes_capture_ops = {
 	.open =		snd_sonicvibes_capture_open,
 	.close =	snd_sonicvibes_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_sonicvibes_hw_params,
-	.hw_free =	snd_sonicvibes_hw_free,
 	.prepare =	snd_sonicvibes_capture_prepare,
 	.trigger =	snd_sonicvibes_capture_trigger,
 	.pointer =	snd_sonicvibes_capture_pointer,
@@ -883,9 +868,8 @@ static int snd_sonicvibes_pcm(struct sonicvibes *sonic, int device)
 	strcpy(pcm->name, "S3 SonicVibes");
 	sonic->pcm = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &sonic->pci->dev,
-					      64*1024, 128*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &sonic->pci->dev, 64*1024, 128*1024);
 
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
