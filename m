Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68221C32771
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 13:59:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1B97E0E;
	Mon, 26 Sep 2022 15:58:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1B97E0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664200762;
	bh=mc2awtbPaPfr7eN+n6iVyDlW4kApfMurPs8wlQoTTc8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WqFgchQ01AOCZ7MA65LGOax7b7uvh0fWYp4VhVyNs4u7MDc5R+H+zkGvX6jBNjp55
	 TrrnWj+X2qqMMGCtwoLSVqxdMUp2H/EkZ1QAy/pkzKdpDvlykBZjl2B5sp/q9tVjA3
	 hX/kONy+3xm+UR5TUz0NVAtbgMoHArJvxN2QVH/U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BA5FF80551;
	Mon, 26 Sep 2022 15:56:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF243F80568; Mon, 26 Sep 2022 15:56:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A28D3F80539
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 15:56:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A28D3F80539
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="WJYvPksx"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="USUiq9Tl"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3283021DD9;
 Mon, 26 Sep 2022 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1664200574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uv2wjzNhqWjZsptPdc3bC1flrDuqWDDoQzwnc8zX9uo=;
 b=WJYvPksx5gEVD9/c+hxzpB1C+hjx0qUdGTEVmClwcTqcjN/8Q9HuZyr/xpHopk6+P91Qqn
 +AMuPHlchsae6ndmMu+o3poQkKdRMg/pnD3R/pc3ZCr8FUXYL50KOWNLxDFAnfbJiX82KK
 1TU0Pb4ugsoe6zqCkjBILEl+B838zNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1664200574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uv2wjzNhqWjZsptPdc3bC1flrDuqWDDoQzwnc8zX9uo=;
 b=USUiq9TljBf/9Rv5d0Oe3YG+iUx9EBjXHUTH5QSMpU04O+u839268CZA612CUpk6S/UlJY
 erjEmeR7+UnpIlDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 181FF139BD;
 Mon, 26 Sep 2022 13:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OFoJBX6vMWPxegAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 26 Sep 2022 13:56:14 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/11] ALSA: usx2y: Replace runtime->status->state reference
 to runtime->state
Date: Mon, 26 Sep 2022 15:55:55 +0200
Message-Id: <20220926135558.26580-9-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220926135558.26580-1-tiwai@suse.de>
References: <20220926135558.26580-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>
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

The recent change in ALSA core allows drivers to get the current PCM
state directly from runtime object.  Replace the calls accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/usbusx2yaudio.c | 3 +--
 sound/usb/usx2y/usx2yhwdeppcm.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 9cd5e3aae4f7..5197599e7aa6 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -822,8 +822,7 @@ static int snd_usx2y_pcm_hw_free(struct snd_pcm_substream *substream)
 		usx2y_urbs_release(subs);
 		if (!cap_subs->pcm_substream ||
 		    !cap_subs->pcm_substream->runtime ||
-		    !cap_subs->pcm_substream->runtime->status ||
-		    cap_subs->pcm_substream->runtime->status->state < SNDRV_PCM_STATE_PREPARED) {
+		    cap_subs->pcm_substream->runtime->state < SNDRV_PCM_STATE_PREPARED) {
 			atomic_set(&cap_subs->state, STATE_STOPPED);
 			usx2y_urbs_release(cap_subs);
 		}
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 240349b644f3..767a227d54da 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -374,8 +374,7 @@ static int snd_usx2y_usbpcm_hw_free(struct snd_pcm_substream *substream)
 		usx2y_usbpcm_urbs_release(subs);
 		if (!cap_subs->pcm_substream ||
 		    !cap_subs->pcm_substream->runtime ||
-		    !cap_subs->pcm_substream->runtime->status ||
-		    cap_subs->pcm_substream->runtime->status->state < SNDRV_PCM_STATE_PREPARED) {
+		    cap_subs->pcm_substream->runtime->state < SNDRV_PCM_STATE_PREPARED) {
 			atomic_set(&cap_subs->state, STATE_STOPPED);
 			if (cap_subs2)
 				atomic_set(&cap_subs2->state, STATE_STOPPED);
-- 
2.35.3

