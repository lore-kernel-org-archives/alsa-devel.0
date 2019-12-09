Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20A7C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:14:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D59C206D5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XNc9AfUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D59C206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFDF916BB;
	Mon,  9 Dec 2019 11:13:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFDF916BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575886473;
	bh=nZa9/veZ4Myv/F8ME8NDDiww/rUWqCKzLqTEwn1159g=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XNc9AfUbTwO+fwZ7CRzNzsIosTVrCgbmc0FUyHjBdEGxtXFyygVbErXfKHdkFvEyy
	 x1y2AFK1k2cjUKh9S57cma/GMiuuOAHa7KKK7S/+D9sT6J9nVIussbj6Gf4Fyxkrpn
	 CC8L7EAun8KXF6C83ipRPBuGvpt/SSiC0dIj9ToM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CDC6F803FA;
	Mon,  9 Dec 2019 10:51:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15CC7F8034B; Mon,  9 Dec 2019 10:50:51 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 064F9F8027D
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 064F9F8027D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7603BB2CE
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:48 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:12 +0100
Message-Id: <20191209094943.14984-41-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 40/71] ALSA: hda: Use managed buffer
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

Clean up the common driver module with the new managed buffer
allocation API.  The superfluous snd_pcm_lib_malloc_pages() and
snd_pcm_lib_free_pages() calls are dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 2f3b7a35f2d9..eb0bb2265685 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -107,7 +107,7 @@ static int azx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
 	struct azx_dev *azx_dev = get_azx_dev(substream);
-	int ret;
+	int ret = 0;
 
 	trace_azx_pcm_hw_params(chip, azx_dev);
 	dsp_lock(azx_dev);
@@ -119,8 +119,6 @@ static int azx_pcm_hw_params(struct snd_pcm_substream *substream,
 	azx_dev->core.bufsize = 0;
 	azx_dev->core.period_bytes = 0;
 	azx_dev->core.format_val = 0;
-	ret = snd_pcm_lib_malloc_pages(substream,
-				       params_buffer_bytes(hw_params));
 
 unlock:
 	dsp_unlock(azx_dev);
@@ -132,7 +130,6 @@ static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
-	int err;
 
 	/* reset BDL address */
 	dsp_lock(azx_dev);
@@ -141,10 +138,9 @@ static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	snd_hda_codec_cleanup(apcm->codec, hinfo, substream);
 
-	err = snd_pcm_lib_free_pages(substream);
 	azx_stream(azx_dev)->prepared = 0;
 	dsp_unlock(azx_dev);
-	return err;
+	return 0;
 }
 
 static int azx_pcm_prepare(struct snd_pcm_substream *substream)
@@ -766,9 +762,8 @@ int snd_hda_attach_pcm_stream(struct hda_bus *_bus, struct hda_codec *codec,
 		size = MAX_PREALLOC_SIZE;
 	if (chip->uc_buffer)
 		type = SNDRV_DMA_TYPE_DEV_UC_SG;
-	snd_pcm_lib_preallocate_pages_for_all(pcm, type,
-					      chip->card->dev,
-					      size, MAX_PREALLOC_SIZE);
+	snd_pcm_set_managed_buffer_all(pcm, type, chip->card->dev,
+				       size, MAX_PREALLOC_SIZE);
 	return 0;
 }
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
