Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B18C7EE26
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 20:09:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E10C826;
	Tue, 23 May 2023 22:09:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E10C826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684872591;
	bh=r1ovQ+3Cgawk8weZFtffqivm6krcYNLIcY/abZsU+e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s+tlzXzl5aP1G8Ql5izkVWTTrIdsp3P+8m2EmM0giIfzoDEb5QKqzJ6hL4QYF+/Fc
	 nRXf2sin/CuHokB9MyWsKUCNZXbm+O7YPRnin4XibJJhVgXi7zkIe2jUy3xH5J8WmO
	 x2j3ARZwZhF1Ab14MVpUFrzbu7YfzbTH/mLk8jIg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A064AF805BD; Tue, 23 May 2023 22:07:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 38600F805B4;
	Tue, 23 May 2023 22:07:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D5EDF80552; Tue, 23 May 2023 22:07:18 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7126BF80544
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 22:07:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7126BF80544
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 42CB0241F7;
	Tue, 23 May 2023 16:07:10 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1q1YHm-zPi-00; Tue, 23 May 2023 22:07:10 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 1/4] ALSA: emu10k1: fix capture buffer size confusion
Date: Tue, 23 May 2023 22:07:06 +0200
Message-Id: <20230523200709.236059-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230523200709.236059-1-oswald.buddenhagen@gmx.de>
References: <20230523200709.236059-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4EWDI22KBM4VROZZ7ZYDWY7JMJ6IJJQE
X-Message-ID-Hash: 4EWDI22KBM4VROZZ7ZYDWY7JMJ6IJJQE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4EWDI22KBM4VROZZ7ZYDWY7JMJ6IJJQE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The buffer size register sets the size of the whole buffer, not just one
period. We actually handled it like that, except that the constraint was
set on the wrong parameter. The period size is implicitly constrained by
the buffer size and the fixed period count of 2.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emupcm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 0572dfb80943..6a24e3e80aea 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -122,20 +122,20 @@ static int snd_emu10k1_pcm_channel_alloc(struct snd_emu10k1_pcm *epcm,
 	return 0;
 }
 
-static const unsigned int capture_period_sizes[31] = {
+static const unsigned int capture_buffer_sizes[31] = {
 	384,	448,	512,	640,
 	384*2,	448*2,	512*2,	640*2,
 	384*4,	448*4,	512*4,	640*4,
 	384*8,	448*8,	512*8,	640*8,
 	384*16,	448*16,	512*16,	640*16,
 	384*32,	448*32,	512*32,	640*32,
 	384*64,	448*64,	512*64,	640*64,
 	384*128,448*128,512*128
 };
 
-static const struct snd_pcm_hw_constraint_list hw_constraints_capture_period_sizes = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_capture_buffer_sizes = {
 	.count = 31,
-	.list = capture_period_sizes,
+	.list = capture_buffer_sizes,
 	.mask = 0
 };
 
@@ -498,7 +498,7 @@ static int snd_emu10k1_capture_prepare(struct snd_pcm_substream *substream)
 	epcm->capture_bufsize = snd_pcm_lib_buffer_bytes(substream);
 	epcm->capture_bs_val = 0;
 	for (idx = 0; idx < 31; idx++) {
-		if (capture_period_sizes[idx] == epcm->capture_bufsize) {
+		if (capture_buffer_sizes[idx] == epcm->capture_bufsize) {
 			epcm->capture_bs_val = idx + 1;
 			break;
 		}
@@ -1154,9 +1154,10 @@ static int snd_emu10k1_capture_open(struct snd_pcm_substream *substream)
 	runtime->private_data = epcm;
 	runtime->private_free = snd_emu10k1_pcm_free_substream;
 	runtime->hw = snd_emu10k1_capture;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				   &hw_constraints_capture_buffer_sizes);
 	emu->capture_interrupt = snd_emu10k1_pcm_ac97adc_interrupt;
 	emu->pcm_capture_substream = substream;
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_capture_period_sizes);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_capture_rates);
 	return 0;
 }
@@ -1193,9 +1194,10 @@ static int snd_emu10k1_capture_mic_open(struct snd_pcm_substream *substream)
 	runtime->hw.rates = SNDRV_PCM_RATE_8000;
 	runtime->hw.rate_min = runtime->hw.rate_max = 8000;
 	runtime->hw.channels_min = 1;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				   &hw_constraints_capture_buffer_sizes);
 	emu->capture_mic_interrupt = snd_emu10k1_pcm_ac97mic_interrupt;
 	emu->pcm_capture_mic_substream = substream;
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_capture_period_sizes);
 	return 0;
 }
 
@@ -1300,9 +1302,10 @@ static int snd_emu10k1_capture_efx_open(struct snd_pcm_substream *substream)
 	epcm->capture_cr_val = emu->efx_voices_mask[0];
 	epcm->capture_cr_val2 = emu->efx_voices_mask[1];
 	spin_unlock_irq(&emu->reg_lock);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				   &hw_constraints_capture_buffer_sizes);
 	emu->capture_efx_interrupt = snd_emu10k1_pcm_efx_interrupt;
 	emu->pcm_capture_efx_substream = substream;
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_capture_period_sizes);
 	return 0;
 }
 
-- 
2.40.0.152.g15d061e6df

