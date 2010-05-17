From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/3] ALSA: hda-intel: add support for disabling
	period irq
Date: Mon, 17 May 2010 11:14:49 +0200
Message-ID: <4BF10909.3070003@ladisch.de>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>		<4BDABDDD.4050502@ladisch.de>		<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>		<s5hsk5uq4u4.wl%tiwai@suse.de>		<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C3E91245CC
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 11:15:09 +0200 (CEST)
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

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1224,7 +1224,8 @@ static int azx_setup_periods(struct azx
 			pos_adj = 0;
 		} else {
 			ofs = setup_bdle(substream, azx_dev,
-					 &bdl, ofs, pos_adj, 1);
+					 &bdl, ofs, pos_adj,
+					 !substream->runtime->no_period_irq);
 			if (ofs < 0)
 				goto error;
 		}
@@ -1236,7 +1237,8 @@ static int azx_setup_periods(struct azx
 					 period_bytes - pos_adj, 0);
 		else
 			ofs = setup_bdle(substream, azx_dev, &bdl, ofs,
-					 period_bytes, 1);
+					 period_bytes,
+					 !substream->runtime->no_period_irq);
 		if (ofs < 0)
 			goto error;
 	}
@@ -1505,7 +1507,8 @@ static struct snd_pcm_hardware azx_pcm_h
 				 /* No full-resume yet implemented */
 				 /* SNDRV_PCM_INFO_RESUME |*/
 				 SNDRV_PCM_INFO_PAUSE |
-				 SNDRV_PCM_INFO_SYNC_START),
+				 SNDRV_PCM_INFO_SYNC_START |
+				 SNDRV_PCM_INFO_NO_PERIOD_IRQ),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_48000,
 	.rate_min =		48000,
