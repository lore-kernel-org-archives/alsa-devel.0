Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CE4C33CAC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:40:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3875B20838
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YDtIQxN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3875B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63A43169D;
	Thu,  6 Feb 2020 17:39:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63A43169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581007245;
	bh=4jv/x66lt+qIqev/J0NXieWK0EG4F0IhyKjUBRNv3p4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YDtIQxN6rInaEqX7liA510kQmTG5Sg1RloJ2G1YA+ARshbcA/lDZpptiVGWxgxw/h
	 /hicI5bpzGZySDTUZIskJJmBmxszWwwRCGxJZSbEpTfcwILKFqabTxWr0I2ZDC32aQ
	 ihxLArMA1tgC4E37HUHS1Ch29P6gZKh1Zsw0IIDA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDADEF8025F;
	Thu,  6 Feb 2020 17:39:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EA2AF80277; Thu,  6 Feb 2020 17:39:52 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAA1FF800AB
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 17:39:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAA1FF800AB
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F0599AD93
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 16:39:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu,  6 Feb 2020 17:39:38 +0100
Message-Id: <20200206163945.6797-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200206163945.6797-1-tiwai@suse.de>
References: <20200206163945.6797-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 1/8] ALSA: aloop: Fix PCM format assignment
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

Fix sparse warnings about PCM format assignment regarding the strong
typed snd_pcm_format_t:
  sound/drivers/aloop.c:352:45: warning: restricted snd_pcm_format_t degrades to integer
  sound/drivers/aloop.c:355:39: warning: incorrect type in assignment (different base types)
  sound/drivers/aloop.c:355:39:    expected unsigned int format
  sound/drivers/aloop.c:355:39:    got restricted snd_pcm_format_t [usertype] format
  sound/drivers/aloop.c:1435:34: warning: incorrect type in assignment (different base types)
  sound/drivers/aloop.c:1435:34:    expected long max
  sound/drivers/aloop.c:1435:34:    got restricted snd_pcm_format_t [usertype]
  sound/drivers/aloop.c:1565:39: warning: incorrect type in assignment (different base types)
  sound/drivers/aloop.c:1565:39:    expected unsigned int format
  sound/drivers/aloop.c:1565:39:    got restricted snd_pcm_format_t [usertype]

Some code in this driver assigns an integer value to snd_pcm_format_t
via control API, and they need to be with the explicit cast.

No functional changes, just sparse warning fixes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index d78a27271d6d..251eaf1152e2 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -118,7 +118,7 @@ struct loopback_cable {
 struct loopback_setup {
 	unsigned int notify: 1;
 	unsigned int rate_shift;
-	unsigned int format;
+	snd_pcm_format_t format;
 	unsigned int rate;
 	unsigned int channels;
 	struct snd_ctl_elem_id active_id;
@@ -1432,7 +1432,7 @@ static int loopback_format_info(struct snd_kcontrol *kcontrol,
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = SNDRV_PCM_FORMAT_LAST;
+	uinfo->value.integer.max = (__force int)SNDRV_PCM_FORMAT_LAST;
 	uinfo->value.integer.step = 1;
 	return 0;
 }                                  
@@ -1443,7 +1443,7 @@ static int loopback_format_get(struct snd_kcontrol *kcontrol,
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
 	ucontrol->value.integer.value[0] =
-		loopback->setup[kcontrol->id.subdevice]
+		(__force int)loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].format;
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
