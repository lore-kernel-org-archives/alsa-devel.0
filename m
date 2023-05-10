Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FD1C77B7D
	for <alsa-devel@archiver.kernel.org>; Wed, 10 May 2023 17:38:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B1131013;
	Wed, 10 May 2023 19:37:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B1131013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683740326;
	bh=XXJr1tgoAPJbZ1oJ/P8rlLa1cbxLccGxHOSyvGO/sx0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=n/PhBqBYKt5VSIXV3twsYlggF0epB9GuGPfPB+nIdItMJglt/11irNVS8aRUTfcQ+
	 +aQA5f+u4Ka8N98MZS3SkAy2jw37byny0fPyCEoww+DcwOiEGa5s/eU4AvWttbI36J
	 Bkk0k9YrQrdpGCKiIB/UKfZHIqeInKPhkXY2S8R0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D48FBF8032D;
	Wed, 10 May 2023 19:37:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 710FCF8032D; Wed, 10 May 2023 19:37:26 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 90019F80087
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2023 19:37:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90019F80087
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 777802008A;
	Wed, 10 May 2023 13:37:22 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pwnkg-tHc-00; Wed, 10 May 2023 19:37:22 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: emu10k1: don't create regular S/PDIF controls for E-MU
 cards
Date: Wed, 10 May 2023 19:37:22 +0200
Message-Id: <20230510173722.3072439-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YL3IV37HSLTSLUIEMBYJXSZXGEOKTNJQ
X-Message-ID-Hash: YL3IV37HSLTSLUIEMBYJXSZXGEOKTNJQ
X-MailFrom: ossi@kde.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YL3IV37HSLTSLUIEMBYJXSZXGEOKTNJQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

These ports are unused on these cards.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emumixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 610700be1e37..48f0d3f8b8e7 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -2055,7 +2055,7 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		mix->attn[0] = 0xffff;
 	}
 	
-	if (! emu->card_capabilities->ecard) { /* FIXME: APS has these controls? */
+	if (!emu->card_capabilities->ecard && !emu->card_capabilities->emu_model) {
 		/* sb live! and audigy */
 		kctl = snd_ctl_new1(&snd_emu10k1_spdif_mask_control, emu);
 		if (!kctl)
-- 
2.40.0.152.g15d061e6df

