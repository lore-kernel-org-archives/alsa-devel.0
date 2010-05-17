From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/3] ALSA: oxygen: add support for disabling
	period irq
Date: Mon, 17 May 2010 11:15:16 +0200
Message-ID: <4BF10924.7070209@ladisch.de>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>		<4BDABDDD.4050502@ladisch.de>		<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>		<s5hsk5uq4u4.wl%tiwai@suse.de>		<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C6AF210383C
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 11:15:19 +0200 (CEST)
In-Reply-To: <4BF1086F.9070900@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- a/sound/pci/oxygen/oxygen_pcm.c
+++ b/sound/pci/oxygen/oxygen_pcm.c
@@ -39,7 +39,8 @@ static const struct snd_pcm_hardware oxy
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_PAUSE |
-		SNDRV_PCM_INFO_SYNC_START,
+		SNDRV_PCM_INFO_SYNC_START |
+		SNDRV_PCM_INFO_NO_PERIOD_IRQ,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE |
 		   SNDRV_PCM_FMTBIT_S32_LE,
 	.rates = SNDRV_PCM_RATE_32000 |
@@ -65,7 +66,8 @@ static const struct snd_pcm_hardware oxy
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_PAUSE |
-		SNDRV_PCM_INFO_SYNC_START,
+		SNDRV_PCM_INFO_SYNC_START |
+		SNDRV_PCM_INFO_NO_PERIOD_IRQ,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE |
 		   SNDRV_PCM_FMTBIT_S32_LE,
 	.rates = SNDRV_PCM_RATE_32000 |
@@ -91,7 +93,8 @@ static const struct snd_pcm_hardware oxy
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_PAUSE |
-		SNDRV_PCM_INFO_SYNC_START,
+		SNDRV_PCM_INFO_SYNC_START |
+		SNDRV_PCM_INFO_NO_PERIOD_IRQ,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.rates = SNDRV_PCM_RATE_48000,
 	.rate_min = 48000,
@@ -530,7 +533,10 @@ static int oxygen_prepare(struct snd_pcm
 	oxygen_set_bits8(chip, OXYGEN_DMA_FLUSH, channel_mask);
 	oxygen_clear_bits8(chip, OXYGEN_DMA_FLUSH, channel_mask);
 
-	chip->interrupt_mask |= channel_mask;
+	if (substream->runtime->no_period_irq)
+		chip->interrupt_mask &= ~channel_mask;
+	else
+		chip->interrupt_mask |= channel_mask;
 	oxygen_write16(chip, OXYGEN_INTERRUPT_MASK, chip->interrupt_mask);
 	spin_unlock_irq(&chip->reg_lock);
 	return 0;
