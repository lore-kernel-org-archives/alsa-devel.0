Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A7CC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 07:31:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DDE6101E
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 07:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37DDE6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89E3A16AD;
	Wed, 29 Sep 2021 09:30:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89E3A16AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632900708;
	bh=dVVFzWR0q9jcsFIp8DEzDh3gMV1UVweQU6++XmpgyDI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gYgXQ6O9RfRzesEcOtTLo7UkMdwBY9c3T4O4W0Y3UWx9XKcN1DrpBB0DuWnFZNmt7
	 NbuM045qIu2v0mMF8fEU5gBpSS28vrXAtvIr1RWluetdI+gu8kyQe7wQY1FNLBO2aK
	 DraHB0m2qhkmJ5H5n35fem5SQCul0RfrIrqVIE9k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBC0AF804CC;
	Wed, 29 Sep 2021 09:30:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0869F80105; Wed, 29 Sep 2021 09:29:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 458FDF80227
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 09:29:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 458FDF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="d+TjNMv7"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="DgIxZiN2"
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id AFA39224EC;
 Wed, 29 Sep 2021 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632900577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9vriSXr0uYTC7qEdXYhx70imaN8sZwMiLoedNHUyDY=;
 b=d+TjNMv7nID7c+ESFSEBbiR6acicZ2+PqDQGLaGVOzwgK5BfNAFrFS9LsBFuGGZRyFKpbY
 AulouytuAWgibzeijKbfN/3whPa/wQzy4UMoyicHek/cgzykAzpEyxoo2izS123lYqwj7J
 JhT86izRPf6ysrvXwEqXaqvShRtSvQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632900577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9vriSXr0uYTC7qEdXYhx70imaN8sZwMiLoedNHUyDY=;
 b=DgIxZiN2al0gjMirdsLMC7HCuMuwwhTamQgvYzAQBEfK0KWj9IbEi1vii4RWBsBFoiLTjH
 uF7kQelMXgKb1mDA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay1.suse.de (Postfix) with ESMTP id 9ED7F25D50;
 Wed, 29 Sep 2021 07:29:37 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/2] ALSA: hda: Use position buffer for SKL+ again
Date: Wed, 29 Sep 2021 09:29:34 +0200
Message-Id: <20210929072934.6809-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210929072934.6809-1-tiwai@suse.de>
References: <20210929072934.6809-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

The commit f87e7f25893d ("ALSA: hda - Improved position reporting on
SKL+") changed the PCM position report for SKL+ chips to use DPIB, but
according to Pierre, DPIB is no best choice for the accurate position
reports and it often reports too early.  The recommended method is
rather the classical position buffer.

This patch makes the PCM position reporting on SKL+ back to the
position buffer again.

Fixes: f87e7f25893d ("ALSA: hda - Improved position reporting on SKL+")
Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9989ec4dc324..14298f015fba 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -880,27 +880,6 @@ static int azx_get_delay_from_fifo(struct azx *chip, struct azx_dev *azx_dev,
 	return substream->runtime->delay;
 }
 
-static unsigned int azx_skl_get_dpib_pos(struct azx *chip,
-					 struct azx_dev *azx_dev)
-{
-	return _snd_hdac_chip_readl(azx_bus(chip),
-				    AZX_REG_VS_SDXDPIB_XBASE +
-				    (AZX_REG_VS_SDXDPIB_XINTERVAL *
-				     azx_dev->core.index));
-}
-
-/* get the current DMA position with correction on SKL+ chips */
-static unsigned int azx_get_pos_skl(struct azx *chip, struct azx_dev *azx_dev)
-{
-	/* DPIB register gives a more accurate position for playback */
-	if (azx_dev->core.substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		return azx_skl_get_dpib_pos(chip, azx_dev);
-
-	/* read of DPIB fetches the actual posbuf */
-	azx_skl_get_dpib_pos(chip, azx_dev);
-	return azx_get_pos_posbuf(chip, azx_dev);
-}
-
 static void __azx_shutdown_chip(struct azx *chip, bool skip_link_reset)
 {
 	azx_stop_chip(chip);
@@ -1590,7 +1569,7 @@ static void assign_position_fix(struct azx *chip, int fix)
 		[POS_FIX_POSBUF] = azx_get_pos_posbuf,
 		[POS_FIX_VIACOMBO] = azx_via_get_position,
 		[POS_FIX_COMBO] = azx_get_pos_lpib,
-		[POS_FIX_SKL] = azx_get_pos_skl,
+		[POS_FIX_SKL] = azx_get_pos_posbuf,
 		[POS_FIX_FIFO] = azx_get_pos_fifo,
 	};
 
-- 
2.26.2

