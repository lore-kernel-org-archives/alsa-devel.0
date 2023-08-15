Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D106DC04A6A
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Aug 2023 19:07:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1696CE76;
	Tue, 15 Aug 2023 21:06:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1696CE76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692126461;
	bh=28MyT8/GX2ozkIb2lgV7d8NHvXHYCTC7A3u7PLAE0Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vRvJ36bycMOpW5LvbUCY43EF6YysIhHvuxAEUUji7c/qoNTiNPEsMeHBbOe6bz0vt
	 v6eZZ8B1WLgBy4jKebJv8OK1dqneRPT/lS984aXMn2DUOLBuzvYx3YhLLGHMSlFF/R
	 gL8aR7Mvyb4Q1QhiSUgKYq/hBG2l8HilZ/ALD/uA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 881C7F80636; Tue, 15 Aug 2023 21:03:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DD40F805AA;
	Tue, 15 Aug 2023 21:02:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1BC9F80613; Tue, 15 Aug 2023 21:02:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 77A47F80551
	for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2023 21:01:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77A47F80551
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=EibpAQDL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=7JEM6T+I
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0182A219A6;
	Tue, 15 Aug 2023 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1692126109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEM0JpvvNXgVoPGt8/nKe1D2Fu2bJ0X4FKoHDA6Se7U=;
	b=EibpAQDLAN/yRjiNCq/uE8i3OxdTYBb42hURvRfthILWuqeX+gBir/9W+Pjhz935yylD+o
	wWs1lT8U+1sxQ0aGvijxUwQcWjUuTOymxaYwwiiZ/giSNilRF+LvQIC35pYlQATUtngoJ3
	DRjR9zmMiR6pRTlG94A7EJ3o30fhZoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692126109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEM0JpvvNXgVoPGt8/nKe1D2Fu2bJ0X4FKoHDA6Se7U=;
	b=7JEM6T+II07WgfoPcy/rD9Db457zakf+uG9uEhqMZhR+vrdBuaGL852MElvfV++ae7gXz3
	fQHOHQ1224bg5EBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3DC31353E;
	Tue, 15 Aug 2023 19:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ELXaMpzL22QTVAAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:48 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 12/25] ALSA: hdsp: Convert to generic PCM copy ops
Date: Tue, 15 Aug 2023 21:01:23 +0200
Message-Id: <20230815190136.8987-13-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815190136.8987-1-tiwai@suse.de>
References: <20230815190136.8987-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XT35KHFQXKRDGOWGKTWLCPRY7GH56V76
X-Message-ID-Hash: XT35KHFQXKRDGOWGKTWLCPRY7GH56V76
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XT35KHFQXKRDGOWGKTWLCPRY7GH56V76/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch converts the hdsp driver code to use the new unified PCM
copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is adjusted accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdsp.c | 42 ++++++----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 65add92c88aa..e7d1b43471a2 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3961,7 +3961,7 @@ static signed char *hdsp_channel_buffer_location(struct hdsp *hdsp,
 
 static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream,
 				  int channel, unsigned long pos,
-				  void __user *src, unsigned long count)
+				  struct iov_iter *src, unsigned long count)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
 	signed char *channel_buf;
@@ -3972,28 +3972,14 @@ static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream,
 	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
 	if (snd_BUG_ON(!channel_buf))
 		return -EIO;
-	if (copy_from_user(channel_buf + pos, src, count))
+	if (copy_from_iter(channel_buf + pos, count, src) != count)
 		return -EFAULT;
 	return 0;
 }
 
-static int snd_hdsp_playback_copy_kernel(struct snd_pcm_substream *substream,
-					 int channel, unsigned long pos,
-					 void *src, unsigned long count)
-{
-	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	signed char *channel_buf;
-
-	channel_buf = hdsp_channel_buffer_location(hdsp, substream->pstr->stream, channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	memcpy(channel_buf + pos, src, count);
-	return 0;
-}
-
 static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream,
 				 int channel, unsigned long pos,
-				 void __user *dst, unsigned long count)
+				 struct iov_iter *dst, unsigned long count)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
 	signed char *channel_buf;
@@ -4004,25 +3990,11 @@ static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream,
 	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
 	if (snd_BUG_ON(!channel_buf))
 		return -EIO;
-	if (copy_to_user(dst, channel_buf + pos, count))
+	if (copy_to_iter(channel_buf + pos, count, dst) != count)
 		return -EFAULT;
 	return 0;
 }
 
-static int snd_hdsp_capture_copy_kernel(struct snd_pcm_substream *substream,
-					int channel, unsigned long pos,
-					void *dst, unsigned long count)
-{
-	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	signed char *channel_buf;
-
-	channel_buf = hdsp_channel_buffer_location(hdsp, substream->pstr->stream, channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	memcpy(dst, channel_buf + pos, count);
-	return 0;
-}
-
 static int snd_hdsp_hw_silence(struct snd_pcm_substream *substream,
 			       int channel, unsigned long pos,
 			       unsigned long count)
@@ -4950,8 +4922,7 @@ static const struct snd_pcm_ops snd_hdsp_playback_ops = {
 	.prepare =	snd_hdsp_prepare,
 	.trigger =	snd_hdsp_trigger,
 	.pointer =	snd_hdsp_hw_pointer,
-	.copy_user =	snd_hdsp_playback_copy,
-	.copy_kernel =	snd_hdsp_playback_copy_kernel,
+	.copy =		snd_hdsp_playback_copy,
 	.fill_silence =	snd_hdsp_hw_silence,
 };
 
@@ -4963,8 +4934,7 @@ static const struct snd_pcm_ops snd_hdsp_capture_ops = {
 	.prepare =	snd_hdsp_prepare,
 	.trigger =	snd_hdsp_trigger,
 	.pointer =	snd_hdsp_hw_pointer,
-	.copy_user =	snd_hdsp_capture_copy,
-	.copy_kernel =	snd_hdsp_capture_copy_kernel,
+	.copy =		snd_hdsp_capture_copy,
 };
 
 static int snd_hdsp_create_hwdep(struct snd_card *card, struct hdsp *hdsp)
-- 
2.35.3

