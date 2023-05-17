Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADF1C7EE2A
	for <alsa-devel@archiver.kernel.org>; Wed, 17 May 2023 17:46:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 128206C0;
	Wed, 17 May 2023 19:45:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 128206C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684345604;
	bh=6nrCUrK/zzsQKS+Bb0KbIKVSAqgcpK0MkZO8oThv2F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z0UE6yC3lDp8N72KyIitccCtCsWzl50T4d+r1rQnWOZ5gisA5F3E5L1MMlnyS91cH
	 j35BG4RSZXY+zfu6bD+k2gqJWMJQc8uHuahtWpLCGBQibYTDgXIJThMhni/oBS0Twy
	 fyOVQPM+H2nOjOvEM4vvvXbBISwLCEXKWKNlr1t8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 015BEF805E8; Wed, 17 May 2023 19:43:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27655F805E3;
	Wed, 17 May 2023 19:43:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4BE07F805B3; Wed, 17 May 2023 19:43:28 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 295D0F80548
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2023 19:43:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 295D0F80548
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id B61D52421F;
	Wed, 17 May 2023 13:42:56 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pzLAu-LNn-00; Wed, 17 May 2023 19:42:56 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 8/9] ALSA: emu10k1: refactor PCM playback cache filling
Date: Wed, 17 May 2023 19:42:55 +0200
Message-Id: <20230517174256.3657060-8-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230517174256.3657060-1-oswald.buddenhagen@gmx.de>
References: <20230517174256.3657060-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: N2GDFG2LWMJNAJQXBNEZVZOK5DW6J3R2
X-Message-ID-Hash: N2GDFG2LWMJNAJQXBNEZVZOK5DW6J3R2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N2GDFG2LWMJNAJQXBNEZVZOK5DW6J3R2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Rename snd_emu10k1_playback_invalidate_cache() to the more apt
snd_emu10k1_playback_fill_cache(), and factor out
snd_emu10k1_playback_prepare_voices(), which calls the former for all
channels.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emupcm.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 7924d185cf92..2af210961a87 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -510,16 +510,12 @@ static int snd_emu10k1_capture_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void snd_emu10k1_playback_invalidate_cache(struct snd_emu10k1 *emu,
-						  struct snd_emu10k1_voice *evoice,
-						  bool w_16, bool stereo)
+static void snd_emu10k1_playback_fill_cache(struct snd_emu10k1 *emu,
+					    unsigned voice,
+					    u32 sample, bool stereo)
 {
-	unsigned voice, sample;
 	u32 ccr;
 
-	voice = evoice->number;
-	sample = w_16 ? 0 : 0x80808080;
-
 	// We assume that the cache is resting at this point (i.e.,
 	// CCR_CACHEINVALIDSIZE is very small).
 
@@ -538,6 +534,22 @@ static void snd_emu10k1_playback_invalidate_cache(struct snd_emu10k1 *emu,
 	snd_emu10k1_ptr_write(emu, CCR, voice, ccr);
 }
 
+static void snd_emu10k1_playback_prepare_voices(struct snd_emu10k1 *emu,
+						struct snd_emu10k1_pcm *epcm,
+						bool w_16, bool stereo,
+						int channels)
+{
+	u32 sample = w_16 ? 0 : 0x80808080;
+
+	for (int i = 0; i < channels; i++) {
+		unsigned voice = epcm->voices[i]->number;
+		snd_emu10k1_playback_fill_cache(emu, voice, sample, stereo);
+	}
+
+	// It takes a moment until the cache fills complete,
+	// but the unmuting takes long enough for that.
+}
+
 static void snd_emu10k1_playback_commit_volume(struct snd_emu10k1 *emu,
 					       struct snd_emu10k1_voice *evoice,
 					       unsigned int vattn)
@@ -631,7 +643,7 @@ static int snd_emu10k1_playback_trigger(struct snd_pcm_substream *substream,
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[0], w_16, stereo);
+		snd_emu10k1_playback_prepare_voices(emu, epcm, w_16, stereo, 1);
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -773,10 +785,7 @@ static int snd_emu10k1_efx_playback_trigger(struct snd_pcm_substream *substream,
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		/* prepare voices */
-		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
-			snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[i], true, false);
-		}
+		snd_emu10k1_playback_prepare_voices(emu, epcm, true, false, NUM_EFX_PLAYBACK);
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-- 
2.40.0.152.g15d061e6df

