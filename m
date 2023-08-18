Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75270C05052
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Aug 2023 07:13:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFF1784A;
	Fri, 18 Aug 2023 09:12:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFF1784A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692342822;
	bh=t/bjMVLZjGZ8NkQmLGaUDp4vfCoLnCNyJD7eUzCvL7U=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=oAeChcivfhD2M2jt/xquJE1RWIyS6dydW+xpiKTGvWsDsswJdL2EuBEmMYOwRwm9U
	 A60Nqx84DrmutkXGPKji2IqrIXDmVD3fJlYSb0h4D3x4G825yXpxdNQvLmDjU1W4TA
	 OPa0c4HOm5ViNPmS04kIZTvgiMyKN4eIV1xAAenI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83616F801EB; Fri, 18 Aug 2023 09:12:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E7297F801EB;
	Fri, 18 Aug 2023 09:12:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 07822F801EB; Fri, 18 Aug 2023 09:09:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0A759F800EE
	for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2023 09:09:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A759F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=hkVCheOo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=DgcBz6jz
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05D0B21884;
	Fri, 18 Aug 2023 07:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1692342557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=AylOwZ/k8g9/SwXH4r5Ib6FS47paENZBVD6O1nNkmfQ=;
	b=hkVCheOo6L3mlbd5+YiWknlYbRCSyWBD9RrN0tjhBvbnHLshrdByVhJjb1R+NPBXuJcBB+
	ZL/5Qq102y5V6+5dX7zTN/dzuAPHNkgEQvjyjYE+bJlTWu44/gBsVnhPvPlBU5ml2614wN
	0gJqHzC8dNgp2S0bp4QmsEhoK2t1imA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692342557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=AylOwZ/k8g9/SwXH4r5Ib6FS47paENZBVD6O1nNkmfQ=;
	b=DgcBz6jzzsuy0yfdppnc+jYWtXyc7s86+MTyClx7dMaQcISRwK2lR6MQp/alo6MJDHaj7Z
	JWg1mRkwnQ7fzzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD36913441;
	Fri, 18 Aug 2023 07:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 57cBNRwZ32SzYwAAMHmgww
	(envelope-from <tiwai@suse.de>); Fri, 18 Aug 2023 07:09:16 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: aoa: Fix typos in PCM fix patch
Date: Fri, 18 Aug 2023 09:09:13 +0200
Message-Id: <20230818070913.23336-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VJQQPCP5LYKQRIHKLDS6OPVGI2K5WOT4
X-Message-ID-Hash: VJQQPCP5LYKQRIHKLDS6OPVGI2K5WOT4
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VJQQPCP5LYKQRIHKLDS6OPVGI2K5WOT4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There was typos in the previous fix for PCM to detach the struct
device that caused build errors.  Corrected here.

Fixes: bc41a7228ced ("ALSA: pcm: Don't embed device")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308181347.q3XPr3Lm-lkp@intel.com/
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/aoa/soundbus/i2sbus/pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 3680eb6eabc9..07df5cc0f2d7 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -972,7 +972,7 @@ i2sbus_attach_codec(struct soundbus_dev *dev, struct snd_card *card,
 			goto out_put_ci_module;
 		snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				&i2sbus_playback_ops);
-		dev->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK]->dev.parent =
+		dev->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].dev->parent =
 			&dev->ofdev.dev;
 		i2sdev->out.created = 1;
 	}
@@ -989,7 +989,7 @@ i2sbus_attach_codec(struct soundbus_dev *dev, struct snd_card *card,
 			goto out_put_ci_module;
 		snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_CAPTURE,
 				&i2sbus_record_ops);
-		dev->pcm->streams[SNDRV_PCM_STREAM_CAPTURE]->dev.parent =
+		dev->pcm->streams[SNDRV_PCM_STREAM_CAPTURE].dev->parent =
 			&dev->ofdev.dev;
 		i2sdev->in.created = 1;
 	}
-- 
2.35.3

