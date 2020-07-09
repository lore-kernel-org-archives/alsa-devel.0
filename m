Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B15C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:20:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058CE20772
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VJBhpkrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058CE20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76CED10E;
	Thu,  9 Jul 2020 13:19:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76CED10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594293620;
	bh=5qqXd2Jv8yywg0B9hioCTzi5qtyfFlZlBFyBUTqDaMg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VJBhpkrNPj1asrzwRjR/YANNDvjbZc4FHsx6Il516U0wNEKl41Z78JfSSiCMsGgtR
	 7vGWr0+Vu4U+GweM1qZ8X0fz6Hw3C3Ld3H/Q8AdQv0NJ+MyqESbd3fw0Q14KDyByKA
	 T7A7B01e6r5tDkv0Jdjkr78aV1kdUHzZ39lE9DTY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1FC5F8011F;
	Thu,  9 Jul 2020 13:18:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E33EF802BD; Thu,  9 Jul 2020 13:18:00 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB015F8011F
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2020 13:17:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB015F8011F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0CEB6AEA5;
 Thu,  9 Jul 2020 11:17:53 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ALSA: atmel: Remove invalid "fall through" comments
Date: Thu,  9 Jul 2020 13:17:48 +0200
Message-Id: <20200709111750.8337-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200709111750.8337-1-tiwai@suse.de>
References: <20200709111750.8337-1-tiwai@suse.de>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>
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

The comments about fall through in sound/atmel/ac97.c are just
superfluous and rather confusing.  Let's remove them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/atmel/ac97c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index a62f1cdad68f..1006458f7f85 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -219,7 +219,7 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		break;
-	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
+	case SNDRV_PCM_FORMAT_S16_BE:
 		word &= ~(AC97C_CMR_CEM_LITTLE);
 		break;
 	default:
@@ -301,7 +301,7 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		break;
-	case SNDRV_PCM_FORMAT_S16_BE: /* fall through */
+	case SNDRV_PCM_FORMAT_S16_BE:
 		word &= ~(AC97C_CMR_CEM_LITTLE);
 		break;
 	default:
-- 
2.16.4

