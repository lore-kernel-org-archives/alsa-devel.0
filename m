Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56C7C7EE23
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 10:47:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DC3F209;
	Tue, 23 May 2023 12:46:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DC3F209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684838863;
	bh=r5lCQjPTlHJnOGM3BFs7+vTFrnErwdZcvaUyiVJX/Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E+yB+3aVia5nigrstlFUBQns39cwtfDXWBHbTg6oi0x97sYPKw0sMXzae/pKlfiDl
	 zvjA4Orx4+h7bUyZxoqJ9g8+hvr8SxIA8plKgmjOb0qA36ViCtsBtAph0MD+Wre/bK
	 wL0SPy98iSBhP6J9OsIJiH2hMDSLJ0LMQTY1VgKA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D496F80551; Tue, 23 May 2023 12:46:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AECBF8024E;
	Tue, 23 May 2023 12:46:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED063F8026A; Tue, 23 May 2023 12:46:17 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1B8E9F80249
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 12:46:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B8E9F80249
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id B988F2416E;
	Tue, 23 May 2023 06:46:12 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1q1PWu-pk4-00; Tue, 23 May 2023 12:46:12 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 2/2] ALSA: emu10k1: pass raw FX send config to
 snd_emu10k1_pcm_init_voice()
Date: Tue, 23 May 2023 12:46:12 +0200
Message-Id: <20230523104612.198884-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230523104612.198884-1-oswald.buddenhagen@gmx.de>
References: <20230523104612.198884-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NM75KVYYZ7VTEK372TYFASHP5PI3NRNK
X-Message-ID-Hash: NM75KVYYZ7VTEK372TYFASHP5PI3NRNK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NM75KVYYZ7VTEK372TYFASHP5PI3NRNK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

... instead of passing in a high-level mixer struct. Let the
higher-level functions handle the differences between the voice types.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emupcm.c | 54 +++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 65af94d08b47..0572dfb80943 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -233,37 +233,21 @@ static u16 emu10k1_send_target_from_amount(u8 amount)
 }
 
 static void snd_emu10k1_pcm_init_voice(struct snd_emu10k1 *emu,
-				       int master, int extra,
 				       struct snd_emu10k1_voice *evoice,
 				       bool w_16, bool stereo,
 				       unsigned int start_addr,
 				       unsigned int end_addr,
-				       struct snd_emu10k1_pcm_mixer *mix)
+				       const unsigned char *send_routing,
+				       const unsigned char *send_amount)
 {
 	struct snd_pcm_substream *substream = evoice->epcm->substream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int silent_page, tmp;
+	unsigned int silent_page;
 	int voice;
-	unsigned char send_amount[8];
-	unsigned char send_routing[8];
-	unsigned long flags;
 	unsigned int pitch_target;
 
 	voice = evoice->number;
 
-	spin_lock_irqsave(&emu->reg_lock, flags);
-
-	/* volume parameters */
-	if (extra) {
-		for (int i = 0; i < 8; i++)
-			send_routing[i] = i;
-		memset(send_amount, 0, sizeof(send_amount));
-	} else {
-		/* mono, left, right (master voice = left) */
-		tmp = stereo ? (master ? 1 : 2) : 0;
-		memcpy(send_routing, &mix->send_routing[tmp][0], 8);
-		memcpy(send_amount, &mix->send_volume[tmp][0], 8);
-	}
 	if (emu->card_capabilities->emu_model)
 		pitch_target = PITCH_48000; /* Disable interpolators on emu1010 card */
 	else
@@ -308,32 +292,42 @@ static void snd_emu10k1_pcm_init_voice(struct snd_emu10k1 *emu,
 	}
 
 	emu->voices[voice].dirty = 1;
-
-	spin_unlock_irqrestore(&emu->reg_lock, flags);
 }
 
 static void snd_emu10k1_pcm_init_voices(struct snd_emu10k1 *emu,
 					struct snd_emu10k1_voice *evoice,
 					bool w_16, bool stereo,
 					unsigned int start_addr,
 					unsigned int end_addr,
 					struct snd_emu10k1_pcm_mixer *mix)
 {
-	snd_emu10k1_pcm_init_voice(emu, 1, 0, evoice, w_16, stereo,
-				   start_addr, end_addr, mix);
+	unsigned long flags;
+
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	snd_emu10k1_pcm_init_voice(emu, evoice, w_16, stereo,
+				   start_addr, end_addr,
+				   &mix->send_routing[stereo][0],
+				   &mix->send_volume[stereo][0]);
 	if (stereo)
-		snd_emu10k1_pcm_init_voice(emu, 0, 0, evoice + 1, w_16, true,
-					   start_addr, end_addr, mix);
+		snd_emu10k1_pcm_init_voice(emu, evoice + 1, w_16, true,
+					   start_addr, end_addr,
+					   &mix->send_routing[2][0],
+					   &mix->send_volume[2][0]);
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
 }
 
 static void snd_emu10k1_pcm_init_extra_voice(struct snd_emu10k1 *emu,
 					     struct snd_emu10k1_voice *evoice,
 					     bool w_16,
 					     unsigned int start_addr,
 					     unsigned int end_addr)
 {
-	snd_emu10k1_pcm_init_voice(emu, 1, 1, evoice, w_16, false,
-				   start_addr, end_addr, NULL);
+	static const unsigned char send_routing[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
+	static const unsigned char send_amount[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
+
+	snd_emu10k1_pcm_init_voice(emu, evoice, w_16, false,
+				   start_addr, end_addr,
+				   send_routing, send_amount);
 }
 
 static int snd_emu10k1_playback_hw_params(struct snd_pcm_substream *substream,
@@ -447,9 +441,9 @@ static int snd_emu10k1_efx_playback_prepare(struct snd_pcm_substream *substream)
 
 	epcm->ccca_start_addr = start_addr;
 	for (i = 0; i < NUM_EFX_PLAYBACK; i++) {
-		snd_emu10k1_pcm_init_voice(emu, 0, 0, epcm->voices[i], true, false,
-					   start_addr, start_addr + channel_size,
-					   &emu->efx_pcm_mixer[i]);
+		snd_emu10k1_pcm_init_voices(emu, epcm->voices[i], true, false,
+					    start_addr, start_addr + channel_size,
+					    &emu->efx_pcm_mixer[i]);
 		start_addr += channel_size;
 	}
 
-- 
2.40.0.152.g15d061e6df

