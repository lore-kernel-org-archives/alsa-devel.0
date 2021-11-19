Return-Path: <SRS0=cfk+=QG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A53C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 10:27:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C0A61B72
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 10:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96C0A61B72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D09CB17B0;
	Fri, 19 Nov 2021 11:26:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D09CB17B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637317649;
	bh=uZGg8AyI0f0mwfwJi0LG8t8CKp90/PGRvzReNGbbtwM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JOX1JUdlcR/9Z2H3IRq0Dsz9HH4+PD/J+6ho3WJCT2ziGPOZAufPt/ZmzCLqAbg1m
	 KykoKJt0m54h7UptYFMJUhbbzjUTU6xN7MqvMWvz4x6rOkNva3BCm+a7rncHWC+y6k
	 g5+xI5Ox91DZdIgm55ZOcHqCB/6YMOqFoilEA4Fo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 766BBF80115;
	Fri, 19 Nov 2021 11:26:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06462F8010B; Fri, 19 Nov 2021 11:26:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E88FEF8010B
 for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2021 11:26:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E88FEF8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="s8zHaADs"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="MQzwOO+W"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B618A21637
 for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2021 10:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637317590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EsNgNYH2p20Mu2Po8feVZYaKzgReFQ3EqDk94Kv6pfw=;
 b=s8zHaADsffr3ibY40+6SbTpqrBBDuBmuLrN/c9rsQBiMcNILO0m+k4rgpgb7KxdVgsJLsr
 uhbPTk3Bph+g/8oLvL5IW23gCnRAc5xmjkB6SJkJnGdsox5QqgQNJ5x1suQIc1C642ZND+
 /jRJTK9RPP2u40xPucNjhk/q+H5UPq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637317590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EsNgNYH2p20Mu2Po8feVZYaKzgReFQ3EqDk94Kv6pfw=;
 b=MQzwOO+W/wxdoxhvv73PIgecqsH8RzEQyKO50Xv7H/CALKDJ0iXi52bef6au2ivI8J7va/
 VfoO/apPKo/sYqDQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id A6D64A3B87;
 Fri, 19 Nov 2021 10:26:30 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Don't start stream for capture at prepare
Date: Fri, 19 Nov 2021 11:26:29 +0100
Message-Id: <20211119102629.7476-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The recent change made mistakenly the stream for capture started at
prepare stage.  Add the stream direction check to avoid it.

Fixes: 9c9a3b9da891 ("ALSA: usb-audio: Rename early_playback_start flag with lowlatency_playback")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 57b046e73bfe..cec6e91afea2 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -640,7 +640,8 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	runtime->delay = 0;
 
 	subs->lowlatency_playback = lowlatency_playback_available(runtime, subs);
-	if (!subs->lowlatency_playback)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	    !subs->lowlatency_playback)
 		ret = start_endpoints(subs);
 
  unlock:
-- 
2.26.2

