Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E1DC7619A
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Apr 2023 20:16:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3488820;
	Wed,  5 Apr 2023 22:15:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3488820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680725803;
	bh=370f80z1SBdqSRvKTxSJIxv8/zVuK6gY58k882KmcRA=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=OBIQ8icz0zZcDLbsm+9Q35GeFhPyp+aSqdSKs4f5zsNPP0K55GhqcOc3UZ0pDCBf4
	 X3PboKS3EchsI0gMffbw7XTHMOh/sxRstp8BLY8u+hOFGtAuDbuf4fIkxye3F9TlJ3
	 YI0mFZZmiK9ve7BnkSrBpmGdVtW45aYBFTnzPO2Y=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 75FCAF805A8;
	Wed,  5 Apr 2023 22:13:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55CE4F8057F; Wed,  5 Apr 2023 22:12:55 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 447C3F8052E
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2023 22:12:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 447C3F8052E
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 439DD2425D
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2023 16:12:21 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pk9US-Dml-00
	for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2023 22:12:20 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: emu10k1: don't create old pass-through playback device
 on Audigy
Date: Wed,  5 Apr 2023 22:12:20 +0200
Message-Id: <20230405201220.2197938-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: M4ML4JRYRBDQBZQ2RDYLODBJFSPZR7WF
X-Message-ID-Hash: M4ML4JRYRBDQBZQ2RDYLODBJFSPZR7WF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M4ML4JRYRBDQBZQ2RDYLODBJFSPZR7WF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

It could have never worked, as snd_emu10k1_fx8010_playback_prepare() and
snd_emu10k1_fx8010_playback_hw_free() assume the emu10k1 offset for the
ETRAM, and the default DSP code includes no handler for it. It also
wouldn't make a lot of sense to make it work, as Audigy has an own, much
simpler, pass-through mechanism. So just skip creation of the device.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emupcm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 48af77ae8020..b1a35b41411a 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1781,17 +1781,21 @@ int snd_emu10k1_pcm_efx(struct snd_emu10k1 *emu, int device)
 	struct snd_kcontrol *kctl;
 	int err;
 
-	err = snd_pcm_new(emu->card, "emu10k1 efx", device, 8, 1, &pcm);
+	err = snd_pcm_new(emu->card, "emu10k1 efx", device, emu->audigy ? 0 : 8, 1, &pcm);
 	if (err < 0)
 		return err;
 
 	pcm->private_data = emu;
 
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1_fx8010_playback_ops);
+	if (!emu->audigy)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1_fx8010_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_emu10k1_capture_efx_ops);
 
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "Multichannel Capture/PT Playback");
+	if (emu->audigy)
+		strcpy(pcm->name, "Multichannel Capture");
+	else
+		strcpy(pcm->name, "Multichannel Capture/PT Playback");
 	emu->pcm_efx = pcm;
 
 	/* EFX capture - record the "FXBUS2" channels, by default we connect the EXTINs 
-- 
2.40.0.152.g15d061e6df

