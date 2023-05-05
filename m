Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F27C77B7C
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 07:40:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53DFA2BE4;
	Fri,  5 May 2023 09:39:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53DFA2BE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683272423;
	bh=HIDVLCFxnleF6LhxCZtuHxZ1LiMM2aKCKP3WXUXdklk=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hLyr3v/Hk36/iusoxiPpdTT0/vOethyOEMh3rfuxnUAPzFzD5cUn8w+BamuhoItB6
	 fPWRN5l7/8wXGiL6NJnUfoO3hKwD9Ry9m7KRZ9YADkX0YN3ngmup173178/enCIilk
	 i+jFjVrLqRffd1xiQ85qNaVjPIVYMU8Ie/+86usE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD548F80542;
	Fri,  5 May 2023 09:38:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51DA5F80549; Fri,  5 May 2023 09:38:43 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4A18FF80544
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 09:38:41 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4EDC011E2;
	Fri,  5 May 2023 09:38:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4EDC011E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1683272320; bh=aL+Xd2IgKAFk6ghPerTDwNWIpiBvD0b91+EYJyTACpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6vgnXhnZODgjAgb29lR2K15cNNNPNyR60SfmcTxhgzkK79fNZ+9iNlZenS4vlslt
	 Chx1Q6ZR5ZD/DL0vnyaoPLPSSvACG+MIHQZfkfrwMoaRtF+Fph7T1pbSeCD3O2qC13
	 Zq8PaexALNnyx1vgDhuXP9WKuusCY75XGVGDkZ6A=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Fri,  5 May 2023 09:38:35 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH 2/5] ALSA: pcm: fix playback silence - use the actual
 new_hw_ptr for the threshold mode
Date: Fri,  5 May 2023 09:38:10 +0200
Message-Id: <20230505073813.1219175-3-perex@perex.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505073813.1219175-1-perex@perex.cz>
References: <20230505073813.1219175-1-perex@perex.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EINKIZEU7SKSXO5AM7ALREMCD4H7PACS
X-Message-ID-Hash: EINKIZEU7SKSXO5AM7ALREMCD4H7PACS
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Takashi Iwai <tiwai@suse.de>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Jeff Chua <jeff.chua.linux@gmail.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EINKIZEU7SKSXO5AM7ALREMCD4H7PACS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The snd_pcm_playback_hw_avail() function uses runtime->status->hw_ptr.
Unfortunately, in case when we call this function from snd_pcm_update_hw_ptr0(),
this variable contains the previous hardware pointer. Use the new_hw_ptr
argument to calculate hw_avail (filled samples by the user space) to
correct the threshold comparison.

The new_hw_ptr argument may also be set to ULONG_MAX which means the
initialization phase. In this case, use runtime->status->hw_ptr.

Suggested-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/core/pcm_lib.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index af1eb136feb0..8a01aeda2213 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -63,7 +63,15 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 		}
 		if (runtime->silence_filled >= runtime->buffer_size)
 			return;
-		noise_dist = snd_pcm_playback_hw_avail(runtime) + runtime->silence_filled;
+		/* initialization outside pointer updates */
+		if (new_hw_ptr == ULONG_MAX)
+			new_hw_ptr = runtime->status->hw_ptr;
+		/* get hw_avail with the boundary crossing */
+		noise_dist = appl_ptr - new_hw_ptr;
+		if (noise_dist < 0)
+			noise_dist += runtime->boundary;
+		/* total noise distance */
+		noise_dist += runtime->silence_filled;
 		if (noise_dist >= (snd_pcm_sframes_t) runtime->silence_threshold)
 			return;
 		frames = runtime->silence_threshold - noise_dist;
-- 
2.39.2

