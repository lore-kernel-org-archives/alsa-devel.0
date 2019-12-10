Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E0C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:25:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FAF20663
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DcrBdJpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FAF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 753CB169E;
	Tue, 10 Dec 2019 07:24:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 753CB169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575959125;
	bh=OHVDc+k8w4FL0DciI3BrUdG3UWp/Hkp6t58G6fL64Qk=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DcrBdJpz2NX7RIwmeODggeYTEuiMZNBleFVRQgx5w7mrb6J34YpfuvOvlTV1qR32G
	 YpSBrM8lVJDLql9otxpYYiRepE5zBNC+48iKdb1p7+yytofVxwYkKO52agwJWY5iRQ
	 jWgaX+hfc/LZm/AQ9GkyUFHX8exmoMeOV2oETS7E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8665F8033D;
	Tue, 10 Dec 2019 07:13:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A3F4F802C4; Tue, 10 Dec 2019 07:12:59 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A983F8025E
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A983F8025E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5266AB1EC
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:40 +0100
Message-Id: <20191210061145.24641-19-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 18/23] ALSA: sh: Drop superfluous ioctl PCM ops
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
 sound/sh/aica.c         | 1 -
 sound/sh/sh_dac_audio.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 8ff88d71439e..f3cd12ff09c3 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -399,7 +399,6 @@ static unsigned long snd_aicapcm_pcm_pointer(struct snd_pcm_substream
 static const struct snd_pcm_ops snd_aicapcm_playback_ops = {
 	.open = snd_aicapcm_pcm_open,
 	.close = snd_aicapcm_pcm_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.prepare = snd_aicapcm_pcm_prepare,
 	.trigger = snd_aicapcm_pcm_trigger,
 	.pointer = snd_aicapcm_pcm_pointer,
diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 1406b50f3f78..b1e171dfe361 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -228,7 +228,6 @@ snd_pcm_uframes_t snd_sh_dac_pcm_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_sh_dac_pcm_ops = {
 	.open		= snd_sh_dac_pcm_open,
 	.close		= snd_sh_dac_pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
 	.prepare	= snd_sh_dac_pcm_prepare,
 	.trigger	= snd_sh_dac_pcm_trigger,
 	.pointer	= snd_sh_dac_pcm_pointer,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
