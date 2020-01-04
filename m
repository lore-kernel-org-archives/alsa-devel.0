Return-Path: <SRS0=svzq=2Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF30C2D0C2
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:02:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7A724650
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fV08Sz6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7A724650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67F3916CF;
	Sat,  4 Jan 2020 12:01:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67F3916CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578135720;
	bh=pbsqTwA1ygabrM6MAx7+IOIgopHGz4fd4Gny3+82/j8=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fV08Sz6RbpBkkChHLlC5alq29fpEYwdk3lE7r4bvIE8ypXaspMMEJKcqIdW8R8Smt
	 2kMqkAiVFvssuGpnPovSi+nr+2kCDCssfOx6Gf2vvj31kcvjtY9hJMtX8EDnrLeD5t
	 9HIx5gqu4SL2pREa5XGw4IJoi+HSdLjpPHs7ow4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08FF3F80100;
	Sat,  4 Jan 2020 12:01:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35DA7F8020B; Sat,  4 Jan 2020 12:01:08 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09D2AF8014F
 for <alsa-devel@alsa-project.org>; Sat,  4 Jan 2020 12:01:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09D2AF8014F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 09720B08C
 for <alsa-devel@alsa-project.org>; Sat,  4 Jan 2020 11:01:04 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sat,  4 Jan 2020 12:00:57 +0100
Message-Id: <20200104110057.13875-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: sh: Fix unused variable warnings
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

Remove unused variables that are left over after the conversion of new
PCM ops:
  sound/sh/sh_dac_audio.c:166:26: warning: unused variable 'runtime'
  sound/sh/sh_dac_audio.c:186:26: warning: unused variable 'runtime'
  sound/sh/sh_dac_audio.c:205:26: warning: unused variable 'runtime'

Fixes: 1cc2f8ba0b3e ("ALSA: sh: Convert to the new PCM ops")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sh/sh_dac_audio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 4affdc128119..feb28502940f 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -163,7 +163,6 @@ static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream,
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	if (copy_from_user_toio(chip->data_buffer + pos, src, count))
 		return -EFAULT;
@@ -183,7 +182,6 @@ static int snd_sh_dac_pcm_copy_kernel(struct snd_pcm_substream *substream,
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	memcpy_toio(chip->data_buffer + pos, src, count);
 	chip->buffer_end = chip->data_buffer + pos + count;
@@ -202,7 +200,6 @@ static int snd_sh_dac_pcm_silence(struct snd_pcm_substream *substream,
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	memset_io(chip->data_buffer + pos, 0, count);
 	chip->buffer_end = chip->data_buffer + pos + count;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
