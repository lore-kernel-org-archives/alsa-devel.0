Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E180C7EE26
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 12:24:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2361820C;
	Tue, 23 May 2023 14:23:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2361820C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684844666;
	bh=FFTV97KGwlzyZT7eZUaMnRLOwkX3bb0oBudnDcRbf30=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tGn+Ue1/69GNvOb0FwQtvsscQCKeUMkHFMckT/doZ7icE4P+AF4nO2M0hutp4tpwU
	 C7Mz2P1X3H95WnV5h9rS6L6agH8YXECrMFB7NVHy7tn2I1Xy0ZzDs2nsXAf0+VUFh2
	 oTXwv0i7wMWwCPDCwkqqmW/QLyaYkkDMNF7kk4hQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49C18F80553; Tue, 23 May 2023 14:23:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E0B19F80552;
	Tue, 23 May 2023 14:23:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBF28F80553; Tue, 23 May 2023 14:22:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 976FFF8016A
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 14:22:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 976FFF8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=gjvqb+em;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=MMBEzgIU
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A78622A32;
	Tue, 23 May 2023 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1684844574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62pj/mPtBE9uzih/1y6PBxRI1aKgGvmc6jZMFMDUQP0=;
	b=gjvqb+emvtRLu2bQgEVQ0+8TRwi4aduTUzonPHy3Fp+rRg/R6lePw74PyGWEGC+u1t755S
	E3JyK9SwgaFazOJMytaLW438gPumHmLrRVI6agiMdgort/jYXoA/UtzYmvo84Jy2kEzpyh
	mv2KtGYtbbWWSngqB+v8/p0Um1XJemc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1684844574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62pj/mPtBE9uzih/1y6PBxRI1aKgGvmc6jZMFMDUQP0=;
	b=MMBEzgIUV2cB5mkq4KD9hVVkTP/45JLZ8HZOJDeb6//3yr4XhzKQuyka/TMeoNNZs6gNaY
	ilMtAveYTQgB9pBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FB3A13588;
	Tue, 23 May 2023 12:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wAKVAh6wbGQNKAAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 23 May 2023 12:22:54 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib v2 02/10] uapi: Update control API to 2.0.9
Date: Tue, 23 May 2023 14:22:39 +0200
Message-Id: <20230523122247.11744-3-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523122247.11744-1-tiwai@suse.de>
References: <20230523122247.11744-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KTJAW6HHD4EYK5TD76TEW7ALZVK5Z7XC
X-Message-ID-Hash: KTJAW6HHD4EYK5TD76TEW7ALZVK5Z7XC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KTJAW6HHD4EYK5TD76TEW7ALZVK5Z7XC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Copied from the kernel uapi header for control API.
A few new ioctls have been added for the support of UMP next device
and inquiries of UMP Endpoint and Block info.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/uapi/asound.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/sound/uapi/asound.h b/include/sound/uapi/asound.h
index cf11a6b73e2d..80cd57e968e5 100644
--- a/include/sound/uapi/asound.h
+++ b/include/sound/uapi/asound.h
@@ -1008,7 +1008,7 @@ struct snd_timer_tread {
  *                                                                          *
  ****************************************************************************/
 
-#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 8)
+#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 9)
 
 struct snd_ctl_card_info {
 	int card;			/* card number */
@@ -1169,6 +1169,9 @@ struct snd_ctl_tlv {
 #define SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE _IOWR('U', 0x40, int)
 #define SNDRV_CTL_IOCTL_RAWMIDI_INFO	_IOWR('U', 0x41, struct snd_rawmidi_info)
 #define SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE _IOW('U', 0x42, int)
+#define SNDRV_CTL_IOCTL_UMP_NEXT_DEVICE	_IOWR('U', 0x43, int)
+#define SNDRV_CTL_IOCTL_UMP_ENDPOINT_INFO _IOWR('U', 0x44, struct snd_ump_endpoint_info)
+#define SNDRV_CTL_IOCTL_UMP_BLOCK_INFO	_IOWR('U', 0x45, struct snd_ump_block_info)
 #define SNDRV_CTL_IOCTL_POWER		_IOWR('U', 0xd0, int)
 #define SNDRV_CTL_IOCTL_POWER_STATE	_IOR('U', 0xd1, int)
 
-- 
2.35.3

