Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BA3C04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:54:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F74D6128D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F74D6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2388382A;
	Mon, 24 May 2021 16:53:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2388382A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621868053;
	bh=1IYDyVXakbWlqPPxz3zhjImOYU2dRk9Db7ijwLOxpIU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YencdhPqlWH9UxrQDd6Brb4uoI5Xgg1uHC8lf4hrq9kJ3q82F5OxD92kFEU85UaGC
	 9er+uDEr2m1FD1k80NBhO7TKZklzFNB3DL8pKxu6aIZ6KH0ZQVZ0MBN9opy+hBBAfR
	 fPc5/K1jie7ZTy/PmXnvjuGjXjl6iSMo4zv7AxQI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26853F80149;
	Mon, 24 May 2021 16:49:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08682F80431; Mon, 24 May 2021 16:49:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0C85F80424
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 16:49:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0C85F80424
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YDXBsoJH"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C967461439;
 Mon, 24 May 2021 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621867748;
 bh=1IYDyVXakbWlqPPxz3zhjImOYU2dRk9Db7ijwLOxpIU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YDXBsoJHMJcyBhEykInfWS+6zyvp49VYt8MnMuM9+qa3bT3OXFrfhgB4wn8DPEnG+
 38JPF4m/CW/5BHOTGuQbd6ULs14gH3n6jR0+X3ZDQZ0tz5bKogXNPkkfBrKfg9FVCj
 lOcnHKClWDVoASCsDDNtn9lp/uyBtwiLH0LFUNVKV/I/1anjP4Yup3+9eLQLY5Fdfn
 O3esX3LUon3pwEkWzEvh1wmJ4yYwOAVwTRfZ0NBAOF/ut/cwOvIkdOmDWW5kuONYDq
 sQeVxVCqQKJc1Mi0tp1foEjllyWHrT8JAMDDbMtfeOE3fHyUVbp2gn1uhcjybvU4Fa
 ChLyLFDec4l7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/52] Revert "ALSA: sb: fix a missing check of
 snd_ctl_add"
Date: Mon, 24 May 2021 10:48:14 -0400
Message-Id: <20210524144903.2498518-4-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524144903.2498518-1-sashal@kernel.org>
References: <20210524144903.2498518-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
 Sasha Levin <sashal@kernel.org>, Aditya Pakki <pakki001@umn.edu>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 4b059ce1f4b368208c2310925f49be77f15e527b ]

This reverts commit beae77170c60aa786f3e4599c18ead2854d8694d.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It is safe to ignore this error as the
mixer element is optional, and the driver is very legacy.

Cc: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20210503115736.2104747-8-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/sb/sb16_main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 0768bbf8fd71..679f9f48370f 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -864,14 +864,10 @@ int snd_sb16dsp_pcm(struct snd_sb *chip, int device)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_sb16_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_sb16_capture_ops);
 
-	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16) {
-		err = snd_ctl_add(card, snd_ctl_new1(
-					&snd_sb16_dma_control, chip));
-		if (err)
-			return err;
-	} else {
+	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16)
+		snd_ctl_add(card, snd_ctl_new1(&snd_sb16_dma_control, chip));
+	else
 		pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
-	}
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      card->dev,
-- 
2.30.2

