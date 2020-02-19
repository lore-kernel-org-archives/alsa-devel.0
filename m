Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18512C34031
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:10:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985F622B48
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TGnGmIyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985F622B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCCBF1686;
	Wed, 19 Feb 2020 01:09:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCCBF1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582071003;
	bh=KeEzxXuJaE23+vQhTScZ4baPavrsVlAEHLAJxRR/OmQ=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=TGnGmIyH3XCtYR0HjTOmiRo+tFnTahtPq7n9rhNiHoN6+/tiFDfafnjwJgvPxisqs
	 q02haJBrRME51RAeKaDKaaMVenSyrvHEjiH25nNgyPi2n7bCG0mwlTd2LRJLdtCSis
	 ze95Z5t2yx27KM0TSLh5wHWVCupH4Wddl23aAZX8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5917CF80148;
	Wed, 19 Feb 2020 01:09:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7D03F80148; Wed, 19 Feb 2020 01:09:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2E40AF80137
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 01:09:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E40AF80137
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F71B1FB;
 Tue, 18 Feb 2020 16:09:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72B63F68F;
 Tue, 18 Feb 2020 16:09:04 -0800 (PST)
Date: Wed, 19 Feb 2020 00:09:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ALSA: usx2y: use for_each_pcm_streams() macro" to the asoc
 tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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
Message-ID: <20200219000903.F6TdcHSHPBOFT8aXowQh-7-xm2i_-kONnmd96jYdPnQ@z>

The patch

   ALSA: usx2y: use for_each_pcm_streams() macro

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From ffd11d1e7ad4602d5d1c2b4517ad316f7587d4d9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Feb 2020 17:28:51 +0900
Subject: [PATCH] ALSA: usx2y: use for_each_pcm_streams() macro

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87sgj9aa8e.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/usb/usx2y/usbusx2yaudio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 772f6f3ccbb1..37d290fe9d43 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -906,11 +906,12 @@ static const struct snd_pcm_ops snd_usX2Y_pcm_ops =
  */
 static void usX2Y_audio_stream_free(struct snd_usX2Y_substream **usX2Y_substream)
 {
-	kfree(usX2Y_substream[SNDRV_PCM_STREAM_PLAYBACK]);
-	usX2Y_substream[SNDRV_PCM_STREAM_PLAYBACK] = NULL;
+	int stream;
 
-	kfree(usX2Y_substream[SNDRV_PCM_STREAM_CAPTURE]);
-	usX2Y_substream[SNDRV_PCM_STREAM_CAPTURE] = NULL;
+	for_each_pcm_streams(stream) {
+		kfree(usX2Y_substream[stream]);
+		usX2Y_substream[stream] = NULL;
+	}
 }
 
 static void snd_usX2Y_pcm_private_free(struct snd_pcm *pcm)
-- 
2.20.1

