Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAF5C77B7D
	for <alsa-devel@archiver.kernel.org>; Wed, 17 May 2023 17:44:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68DCA1F7;
	Wed, 17 May 2023 19:43:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68DCA1F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684345446;
	bh=2etLEtgvIJ2TjIR3wXWC/6365d0yR+BIGVcAVMSgjig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=j5VZEIha22ZYIiWnyl06X96UBltopjlouoniQ7gPr5CuvTSynuVSIBQuFpRyh/zL6
	 OMx5WBgKaWRa3+3UH0lAJ0OQ6ix0jHMujfgW8Ec06xJ30pMxHqot52vCIMAY3S44aL
	 7B8s6WiY24fwRIb7YhXEqQHNawLdEB+raL9qIzrs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09092F80549; Wed, 17 May 2023 19:43:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2ECEBF80272;
	Wed, 17 May 2023 19:43:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AABAAF80551; Wed, 17 May 2023 19:43:08 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 284A5F8024E
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2023 19:43:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 284A5F8024E
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id A339724208;
	Wed, 17 May 2023 13:42:56 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pzLAu-LNP-00; Wed, 17 May 2023 19:42:56 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 4/9] ALSA: emu10k1: skip pointless cache setup for extra
 voices
Date: Wed, 17 May 2023 19:42:51 +0200
Message-Id: <20230517174256.3657060-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230517174256.3657060-1-oswald.buddenhagen@gmx.de>
References: <20230517174256.3657060-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DIJQPOHC4YXTH4LIMARWUPHKU77OH52Q
X-Message-ID-Hash: DIJQPOHC4YXTH4LIMARWUPHKU77OH52Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DIJQPOHC4YXTH4LIMARWUPHKU77OH52Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Given that the data is going to be ignored anyway, and that the cache
does not influence interrupt timing (which is the purpose of the extra
voices), it's pointless to pre-fill the cache.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emupcm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 16e7d0ff97a4..a6c4f1895a08 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -528,14 +528,15 @@ static int snd_emu10k1_capture_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void snd_emu10k1_playback_invalidate_cache(struct snd_emu10k1 *emu, int extra, struct snd_emu10k1_voice *evoice)
+static void snd_emu10k1_playback_invalidate_cache(struct snd_emu10k1 *emu,
+						  struct snd_emu10k1_voice *evoice)
 {
 	struct snd_pcm_runtime *runtime;
 	unsigned int voice, stereo, i, ccis, cra = 64, cs, sample;
 
 	runtime = evoice->epcm->substream->runtime;
 	voice = evoice->number;
-	stereo = (!extra && runtime->channels == 2);
+	stereo = (runtime->channels == 2);
 	sample = snd_pcm_format_width(runtime->format) == 16 ? 0 : 0x80808080;
 	ccis = emu10k1_ccis(stereo, sample == 0);
 	/* set cs to 2 * number of cache registers beside the invalidated */
@@ -658,8 +659,7 @@ static int snd_emu10k1_playback_trigger(struct snd_pcm_substream *substream,
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_emu10k1_playback_invalidate_cache(emu, 1, epcm->extra);	/* do we need this? */
-		snd_emu10k1_playback_invalidate_cache(emu, 0, epcm->voices[0]);
+		snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[0]);
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -803,9 +803,8 @@ static int snd_emu10k1_efx_playback_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 		/* prepare voices */
 		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
-			snd_emu10k1_playback_invalidate_cache(emu, 0, epcm->voices[i]);
+			snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[i]);
 		}
-		snd_emu10k1_playback_invalidate_cache(emu, 1, epcm->extra);
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-- 
2.40.0.152.g15d061e6df

