Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A56C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:21:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797F420663
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KtXPSy1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797F420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5BE61614;
	Tue, 10 Dec 2019 07:20:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5BE61614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575958881;
	bh=qBg6mB7A7hvLaQtL/XFOnOxY7Nv49wK+wbmiC5W/dTo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KtXPSy1eb27IGOTsTWyy8R8MWSPjSzaluC0Shl5SBJKV/Q1eljPueXIk8ZJC7hr/v
	 PfExcll7XYOzEW66sVYbOJZLSk83TdMMKHyS0/c5594NdwmEttVW8k6pflUPYO0oEu
	 2JzF4WFDeSCWTTRMGXnhO5ft+6+VOqO8/FVuqWaM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71724F802E8;
	Tue, 10 Dec 2019 07:13:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88EF5F802A8; Tue, 10 Dec 2019 07:12:43 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73EDEF80254
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73EDEF80254
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 14493B1E3
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:35 +0100
Message-Id: <20191210061145.24641-14-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 13/23] ALSA: asihpi: Drop superfluous ioctl PCM
	ops
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

snd_card_asihpi_playback_ioctl() and snd_card_asihpi_capture_ioctl()
do nothing but calling the default handler.
Now PCM core accepts NULL as the default ioctl ops, so let's drop
altogether.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/asihpi/asihpi.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index ccdaaf28dcf8..1fdb9f9f0ae0 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -943,15 +943,6 @@ static void snd_card_asihpi_isr(struct hpi_adapter *a)
 }
 
 /***************************** PLAYBACK OPS ****************/
-static int snd_card_asihpi_playback_ioctl(struct snd_pcm_substream *substream,
-					  unsigned int cmd, void *arg)
-{
-	char name[16];
-	snd_pcm_debug_name(substream, name, sizeof(name));
-	snd_printddd(KERN_INFO "%s ioctl %d\n", name, cmd);
-	return snd_pcm_lib_ioctl(substream, cmd, arg);
-}
-
 static int snd_card_asihpi_playback_prepare(struct snd_pcm_substream *
 					    substream)
 {
@@ -1118,7 +1109,6 @@ static int snd_card_asihpi_playback_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_card_asihpi_playback_mmap_ops = {
 	.open = snd_card_asihpi_playback_open,
 	.close = snd_card_asihpi_playback_close,
-	.ioctl = snd_card_asihpi_playback_ioctl,
 	.hw_params = snd_card_asihpi_pcm_hw_params,
 	.hw_free = snd_card_asihpi_hw_free,
 	.prepare = snd_card_asihpi_playback_prepare,
@@ -1143,12 +1133,6 @@ snd_card_asihpi_capture_pointer(struct snd_pcm_substream *substream)
 	return bytes_to_frames(runtime, dpcm->pcm_buf_dma_ofs % dpcm->buffer_bytes);
 }
 
-static int snd_card_asihpi_capture_ioctl(struct snd_pcm_substream *substream,
-					 unsigned int cmd, void *arg)
-{
-	return snd_pcm_lib_ioctl(substream, cmd, arg);
-}
-
 static int snd_card_asihpi_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1284,7 +1268,6 @@ static int snd_card_asihpi_capture_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_card_asihpi_capture_mmap_ops = {
 	.open = snd_card_asihpi_capture_open,
 	.close = snd_card_asihpi_capture_close,
-	.ioctl = snd_card_asihpi_capture_ioctl,
 	.hw_params = snd_card_asihpi_pcm_hw_params,
 	.hw_free = snd_card_asihpi_hw_free,
 	.prepare = snd_card_asihpi_capture_prepare,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
