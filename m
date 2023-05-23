Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE6BC7EE26
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 20:10:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF58E82A;
	Tue, 23 May 2023 22:09:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF58E82A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684872621;
	bh=wEAYHJocm6hW1PKtYP4ulBxwt0TbrB+UJ/zmX0qWGOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=H7pTXHdZFC3thVaP0NCn8TuVGfBEaqgtbzJf6kO7x7vIMUhlBTqRg8+7wvmSIXH3K
	 9tUgAUKYioL30M+/425vtdQiXk8tjZicRWZAuCYfqlAQUECGk39U9S5JV46mJkVNgl
	 cIiXnAPQyskYLsQTMXlIA9R3XqhWY+T8EJWDKrqI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72A4EF805C9; Tue, 23 May 2023 22:07:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CC4D8F805C6;
	Tue, 23 May 2023 22:07:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86636F805B6; Tue, 23 May 2023 22:07:36 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25AE2F80249
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 22:07:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25AE2F80249
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 4B06524263;
	Tue, 23 May 2023 16:07:10 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1q1YHm-zPu-00; Tue, 23 May 2023 22:07:10 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 3/4] ALSA: emu10k1: don't restrict capture channel count to
 powers of two
Date: Tue, 23 May 2023 22:07:08 +0200
Message-Id: <20230523200709.236059-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230523200709.236059-1-oswald.buddenhagen@gmx.de>
References: <20230523200709.236059-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TUPVHKFUV6JYV5HJ3B5P5WWZQQIDFRK4
X-Message-ID-Hash: TUPVHKFUV6JYV5HJ3B5P5WWZQQIDFRK4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TUPVHKFUV6JYV5HJ3B5P5WWZQQIDFRK4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The hardware can deal with primes up to 7 and power-of-two multiples
thereof; the limitation is reflected by the possible buffer sizes.

Note that setting the voice mask will not allow more than 16 channels
even on Sound Blaster Audigy anymore, as 32 seems a bit excessive (the
code overall appears to think so, just not in this case).

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emupcm.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index fd3fc96c08e9..ac10b53525fd 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -122,6 +122,17 @@ static int snd_emu10k1_pcm_channel_alloc(struct snd_emu10k1_pcm *epcm,
 	return 0;
 }
 
+// Primes 2-7 and 2^n multiples thereof, up to 16.
+static const unsigned int efx_capture_channels[] = {
+	1, 2, 3, 4, 5, 6, 7, 8, 10, 12, 14, 16
+};
+
+static const struct snd_pcm_hw_constraint_list hw_constraints_efx_capture_channels = {
+	.count = ARRAY_SIZE(efx_capture_channels),
+	.list = efx_capture_channels,
+	.mask = 0
+};
+
 static const unsigned int capture_buffer_sizes[31] = {
 	384,	448,	512,	640,
 	384*2,	448*2,	512*2,	640*2,
@@ -1216,7 +1227,7 @@ static int snd_emu10k1_capture_efx_open(struct snd_pcm_substream *substream)
 	struct snd_emu10k1_pcm *epcm;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int nefx = emu->audigy ? 64 : 32;
-	int idx;
+	int idx, err;
 
 	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
@@ -1302,6 +1313,12 @@ static int snd_emu10k1_capture_efx_open(struct snd_pcm_substream *substream)
 	epcm->capture_cr_val = emu->efx_voices_mask[0];
 	epcm->capture_cr_val2 = emu->efx_voices_mask[1];
 	spin_unlock_irq(&emu->reg_lock);
+	err = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					 &hw_constraints_efx_capture_channels);
+	if (err < 0) {
+		kfree(epcm);
+		return err;
+	}
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				   &hw_constraints_capture_buffer_sizes);
 	emu->capture_efx_interrupt = snd_emu10k1_pcm_efx_interrupt;
@@ -1466,22 +1483,16 @@ static int snd_emu10k1_pcm_efx_voices_mask_put(struct snd_kcontrol *kcontrol, st
 	struct snd_emu10k1 *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int nval[2], bits;
 	int nefx = emu->audigy ? 64 : 32;
-	int nefxb = emu->audigy ? 7 : 6;
 	int change, idx;
 	
 	nval[0] = nval[1] = 0;
 	for (idx = 0, bits = 0; idx < nefx; idx++)
 		if (ucontrol->value.integer.value[idx]) {
 			nval[idx / 32] |= 1 << (idx % 32);
 			bits++;
 		}
 
-	// Check that the number of requested channels is a power of two
-	// not bigger than the number of available channels.
-	for (idx = 0; idx < nefxb; idx++)
-		if (1 << idx == bits)
-			break;
-	if (idx >= nefxb)
+	if (bits == 9 || bits == 11 || bits == 13 || bits == 15 || bits > 16)
 		return -EINVAL;
 
 	spin_lock_irq(&emu->reg_lock);
-- 
2.40.0.152.g15d061e6df

