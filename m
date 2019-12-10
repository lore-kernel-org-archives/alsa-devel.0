Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22949C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:17:33 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA678205ED
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA678205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 176A541;
	Tue, 10 Dec 2019 15:16:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 176A541
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575987451;
	bh=Ue+8CyamlhgICQ3uSzg6SbupItfIYTyKP7HBMGtfkuU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m+apgV+jZLORRbtAMzjO3n8jX9lGWlZa4BgMOKAD2A3zkxl1+nfO/yQ+riswsUlmW
	 V+/3MbLR7Q1ZQR0f7muXXUptU1XaS7k4SAD1vKhM31XYb4VZtTFtqXOtK61GbeXgT2
	 pT1hscVgt9kjBv9Y5kY/BiXMgMpm3pULkGWqOMVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87ACBF8025E;
	Tue, 10 Dec 2019 15:14:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A040F8011E; Tue, 10 Dec 2019 15:14:13 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B2AAF801D8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:14:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B2AAF801D8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E394AAF26;
 Tue, 10 Dec 2019 14:14:04 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2019 15:13:53 +0100
Message-Id: <20191210141356.18074-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210141356.18074-1-tiwai@suse.de>
References: <20191210141356.18074-1-tiwai@suse.de>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [alsa-devel] [PATCH for-5.6 1/4] staging: most: Use managed buffer
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
Also remove the unnecessary checks of channels in hw_params callback
as this is guaranteed by the hw constraints in anyway.
After these cleanups, the hw_params and hw_free callbacks became
empty, hence dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/most/sound/sound.c | 44 +-------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 723d0bd1cc21..7c212c0db980 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -322,45 +322,6 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-/**
- * pcm_hw_params - implements hw_params callback function for PCM middle layer
- * @substream: sub-stream pointer
- * @hw_params: contains the hardware parameters set by the application
- *
- * This is called when the hardware parameters is set by the application, that
- * is, once when the buffer size, the period size, the format, etc. are defined
- * for the PCM substream. Many hardware setups should be done is this callback,
- * including the allocation of buffers.
- *
- * Returns 0 on success or error code otherwise.
- */
-static int pcm_hw_params(struct snd_pcm_substream *substream,
-			 struct snd_pcm_hw_params *hw_params)
-{
-	struct channel *channel = substream->private_data;
-
-	if ((params_channels(hw_params) > channel->pcm_hardware.channels_max) ||
-	    (params_channels(hw_params) < channel->pcm_hardware.channels_min)) {
-		pr_err("Requested number of channels not supported.\n");
-		return -EINVAL;
-	}
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
-}
-
-/**
- * pcm_hw_free - implements hw_free callback function for PCM middle layer
- * @substream: substream pointer
- *
- * This is called to release the resources allocated via hw_params.
- * This function will be always called before the close callback is called.
- *
- * Returns 0 on success or error code otherwise.
- */
-static int pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 /**
  * pcm_prepare - implements prepare callback function for PCM middle layer
  * @substream: substream pointer
@@ -463,8 +424,6 @@ static const struct snd_pcm_ops pcm_ops = {
 	.open       = pcm_open,
 	.close      = pcm_close,
 	.ioctl      = snd_pcm_lib_ioctl,
-	.hw_params  = pcm_hw_params,
-	.hw_free    = pcm_hw_free,
 	.prepare    = pcm_prepare,
 	.trigger    = pcm_trigger,
 	.pointer    = pcm_pointer,
@@ -661,8 +620,7 @@ static int audio_probe_channel(struct most_interface *iface, int channel_id,
 	pcm->private_data = channel;
 	strscpy(pcm->name, device_name, sizeof(pcm->name));
 	snd_pcm_set_ops(pcm, direction, &pcm_ops);
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_VMALLOC,
-					      NULL, 0, 0);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_VMALLOC, NULL, 0, 0);
 
 	return 0;
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
