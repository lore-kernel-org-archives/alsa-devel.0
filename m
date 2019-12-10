Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38EFC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:15:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D677206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MscVj5Q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D677206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0012166A;
	Tue, 10 Dec 2019 07:14:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0012166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575958548;
	bh=gNPeUJc0ESDUpuYC93dlby9G2l7x+mziN1HKB76MkrY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MscVj5Q65pEUG7rnQ5xezyK73tD/0rZJm1/8yh6YkbbNAdd/1qG6Y6tMFyoLR4Q+H
	 4aXJFictUnSmNUV15lU6/dZgTpgkr7PoNIJn36HvGpWG/zmwGDX5caY5gCCJd8F2Jx
	 9V2h1V0jx5pCiY1I1QVLD8Af1DNBgKHETUM19pzI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DE97F80258;
	Tue, 10 Dec 2019 07:12:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A382F80277; Tue, 10 Dec 2019 07:12:14 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 206B5F80248
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 206B5F80248
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8FFDDB1C2
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:25 +0100
Message-Id: <20191210061145.24641-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 03/23] ALSA: atmel: Drop superfluous ioctl PCM
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

PCM core deals the empty ioctl field now as default.
Let's kill the redundant lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/atmel/ac97c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 44507e43ed28..658b4d385249 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -447,7 +447,6 @@ atmel_ac97c_capture_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops atmel_ac97_playback_ops = {
 	.open		= atmel_ac97c_playback_open,
 	.close		= atmel_ac97c_playback_close,
-	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= atmel_ac97c_playback_hw_params,
 	.prepare	= atmel_ac97c_playback_prepare,
 	.trigger	= atmel_ac97c_playback_trigger,
@@ -457,7 +456,6 @@ static const struct snd_pcm_ops atmel_ac97_playback_ops = {
 static const struct snd_pcm_ops atmel_ac97_capture_ops = {
 	.open		= atmel_ac97c_capture_open,
 	.close		= atmel_ac97c_capture_close,
-	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= atmel_ac97c_capture_hw_params,
 	.prepare	= atmel_ac97c_capture_prepare,
 	.trigger	= atmel_ac97c_capture_trigger,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
