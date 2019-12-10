Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47254C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:16:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58F7206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XO3D3QQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58F7206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18FA6166F;
	Tue, 10 Dec 2019 07:15:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18FA6166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575958583;
	bh=mJZlxsAKAy5a4TNM3ug7fHe7lr32921452/6l4pevQs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XO3D3QQakXsLtfCIQSLKE25bhCWqXQ9ThzOfP5rNkyyNepO59cCZC2yC6gFKOZRFS
	 ba67rSOLjQoTaPZLYUI71IdmDnMiJmldeA6vJcRjBUaKKDQRIfaq1mbNyn82M/xj1g
	 ++hpQ/O+DpXFETaNE3R9qa9JPXGBy3PwsYA3K0rE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CCB5F8028C;
	Tue, 10 Dec 2019 07:12:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7DC6F80276; Tue, 10 Dec 2019 07:12:14 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED3CFF80217
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED3CFF80217
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C5D35B1DA
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:30 +0100
Message-Id: <20191210061145.24641-9-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 08/23] ALSA: mips: Drop superfluous ioctl PCM
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
 sound/mips/hal2.c       | 2 --
 sound/mips/sgio2audio.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index e80ebe521218..db44d9d691db 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -684,7 +684,6 @@ static int hal2_capture_ack(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops hal2_playback_ops = {
 	.open =        hal2_playback_open,
 	.close =       hal2_playback_close,
-	.ioctl =       snd_pcm_lib_ioctl,
 	.prepare =     hal2_playback_prepare,
 	.trigger =     hal2_playback_trigger,
 	.pointer =     hal2_playback_pointer,
@@ -694,7 +693,6 @@ static const struct snd_pcm_ops hal2_playback_ops = {
 static const struct snd_pcm_ops hal2_capture_ops = {
 	.open =        hal2_capture_open,
 	.close =       hal2_capture_close,
-	.ioctl =       snd_pcm_lib_ioctl,
 	.prepare =     hal2_capture_prepare,
 	.trigger =     hal2_capture_trigger,
 	.pointer =     hal2_capture_pointer,
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 481f5ffff61b..f10a08a8777f 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -649,7 +649,6 @@ snd_sgio2audio_pcm_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_sgio2audio_playback1_ops = {
 	.open =        snd_sgio2audio_playback1_open,
 	.close =       snd_sgio2audio_pcm_close,
-	.ioctl =       snd_pcm_lib_ioctl,
 	.hw_params =   snd_sgio2audio_pcm_hw_params,
 	.hw_free =     snd_sgio2audio_pcm_hw_free,
 	.prepare =     snd_sgio2audio_pcm_prepare,
@@ -660,7 +659,6 @@ static const struct snd_pcm_ops snd_sgio2audio_playback1_ops = {
 static const struct snd_pcm_ops snd_sgio2audio_playback2_ops = {
 	.open =        snd_sgio2audio_playback2_open,
 	.close =       snd_sgio2audio_pcm_close,
-	.ioctl =       snd_pcm_lib_ioctl,
 	.hw_params =   snd_sgio2audio_pcm_hw_params,
 	.hw_free =     snd_sgio2audio_pcm_hw_free,
 	.prepare =     snd_sgio2audio_pcm_prepare,
@@ -671,7 +669,6 @@ static const struct snd_pcm_ops snd_sgio2audio_playback2_ops = {
 static const struct snd_pcm_ops snd_sgio2audio_capture_ops = {
 	.open =        snd_sgio2audio_capture_open,
 	.close =       snd_sgio2audio_pcm_close,
-	.ioctl =       snd_pcm_lib_ioctl,
 	.hw_params =   snd_sgio2audio_pcm_hw_params,
 	.hw_free =     snd_sgio2audio_pcm_hw_free,
 	.prepare =     snd_sgio2audio_pcm_prepare,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
