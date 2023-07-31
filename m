Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125F4C001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 15:51:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B95AEFA;
	Mon, 31 Jul 2023 17:50:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B95AEFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690818685;
	bh=BaRj/8ZpGEEhMi9hEW4cAj/dE0W0YM4S574mQ12Lss8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UKb7upplC4lC1h8R3+BzZqyZmljOuSllCh6JLsiGBQRyJy5SYJjS/Av1+LkjL7mLX
	 JP2RtFMcwy1tignaT/MOY3tp1wimZTs32sdyA6+bkd9aRwFTYOXLNW+mrC5HjtxiM8
	 qJ31Rj19r7yKVbUuQ6mNz2+ya3Y4UCQ/Kk5eAolM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 154C5F805E9; Mon, 31 Jul 2023 17:48:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B5E23F805EA;
	Mon, 31 Jul 2023 17:48:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEB52F805C6; Mon, 31 Jul 2023 17:47:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B142EF80563
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 17:47:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B142EF80563
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=AaPgF3jt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=u9oL3cIG
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 544B7221DD;
	Mon, 31 Jul 2023 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1690818447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+C3IqiAtzyRck5SOIMPpE9nJUWr/QRNE9qYH2fab/7I=;
	b=AaPgF3jtWelpqbG7LZSqkOuNSLId6yEhdWtX3NffVUgIfnqKjTgUB0SenRhiZGtjpjnaOc
	7cbu7+cxAfwEfDI2IfLs5sCUvi5B5AGrPF5DoKTQUS1rF4Hna09qiPTOcdKf6MT2Dyh9o/
	eOwtg7jxw255dzvXFvyisNAK5um0O+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690818447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+C3IqiAtzyRck5SOIMPpE9nJUWr/QRNE9qYH2fab/7I=;
	b=u9oL3cIGF4x0y6F0TWVdy77Ue5QuSS2jZcT0zyqqRKQsqd2hXEhONyU6nvR1CVrobLFnSK
	02VM4771nS82Y9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A1D21322C;
	Mon, 31 Jul 2023 15:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2NZHCY/Xx2Q3fwAAMHmgww
	(envelope-from <tiwai@suse.de>); Mon, 31 Jul 2023 15:47:27 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 23/24] ASoC: pcm: Drop obsoleted PCM copy_user ops
Date: Mon, 31 Jul 2023 17:47:17 +0200
Message-Id: <20230731154718.31048-24-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230731154718.31048-1-tiwai@suse.de>
References: <20230731154718.31048-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HJ7JNXFOO6QZ7JHPVTSUZXURV2AVA2I4
X-Message-ID-Hash: HJ7JNXFOO6QZ7JHPVTSUZXURV2AVA2I4
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Now all ASoC users have been replaced to use the new PCM copy ops,
let's drop the obsoleted copy_user ops and its helper function.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc-component.h |  7 -------
 sound/soc/soc-component.c     | 20 --------------------
 sound/soc/soc-pcm.c           |  2 --
 3 files changed, 29 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index d9388eac82ee..8351e0c8e277 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -137,10 +137,6 @@ struct snd_soc_component_driver {
 		struct timespec64 *audio_ts,
 		struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 		struct snd_pcm_audio_tstamp_report *audio_tstamp_report);
-	int (*copy_user)(struct snd_soc_component *component,
-			 struct snd_pcm_substream *substream, int channel,
-			 unsigned long pos, void __user *buf,
-			 unsigned long bytes);
 	int (*copy)(struct snd_soc_component *component,
 		    struct snd_pcm_substream *substream, int channel,
 		    unsigned long pos, sockptr_t buf,
@@ -513,9 +509,6 @@ int snd_soc_pcm_component_pointer(struct snd_pcm_substream *substream);
 int snd_soc_pcm_component_ioctl(struct snd_pcm_substream *substream,
 				unsigned int cmd, void *arg);
 int snd_soc_pcm_component_sync_stop(struct snd_pcm_substream *substream);
-int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
-				    int channel, unsigned long pos,
-				    void __user *buf, unsigned long bytes);
 int snd_soc_pcm_component_copy(struct snd_pcm_substream *substream,
 			       int channel, unsigned long pos,
 			       sockptr_t buf, unsigned long bytes);
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index efae007f0f82..94802aada00f 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -1072,26 +1072,6 @@ int snd_soc_pcm_component_copy(struct snd_pcm_substream *substream,
 	return -EINVAL;
 }
 
-int snd_soc_pcm_component_copy_user(struct snd_pcm_substream *substream,
-				    int channel, unsigned long pos,
-				    void __user *buf, unsigned long bytes)
-{
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_component *component;
-	int i;
-
-	/* FIXME. it returns 1st copy now */
-	for_each_rtd_components(rtd, i, component)
-		if (component->driver->copy_user)
-			return soc_component_ret(
-				component,
-				component->driver->copy_user(
-					component, substream, channel,
-					pos, buf, bytes));
-
-	return -EINVAL;
-}
-
 struct page *snd_soc_pcm_component_page(struct snd_pcm_substream *substream,
 					unsigned long offset)
 {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 71403da28d37..ae02d1d80c88 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2975,8 +2975,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			rtd->ops.sync_stop	= snd_soc_pcm_component_sync_stop;
 		if (drv->copy)
 			rtd->ops.copy		= snd_soc_pcm_component_copy;
-		else if (drv->copy_user)
-			rtd->ops.copy_user	= snd_soc_pcm_component_copy_user;
 		if (drv->page)
 			rtd->ops.page		= snd_soc_pcm_component_page;
 		if (drv->mmap)
-- 
2.35.3

