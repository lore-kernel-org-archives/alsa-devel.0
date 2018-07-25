From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/14] ALSA: ymfpci: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:01 +0200
Message-ID: <20180725212414.19795-2-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 63E9A26775C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:16 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1DDB5AD96
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The bank values are all little-endians, so they should be defined with
__le32.  This fixes lots of sparse warnings like:
  sound/pci/ymfpci/ymfpci_main.c:315:23: warning: cast to restricted __le32
  sound/pci/ymfpci/ymfpci_main.c:342:32: warning: incorrect type in assignment (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ymfpci/ymfpci.h      | 78 +++++++++++++++++-----------------
 sound/pci/ymfpci/ymfpci_main.c |  6 +--
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/sound/pci/ymfpci/ymfpci.h b/sound/pci/ymfpci/ymfpci.h
index aa9bb065f385..e2fa7e360d79 100644
--- a/sound/pci/ymfpci/ymfpci.h
+++ b/sound/pci/ymfpci/ymfpci.h
@@ -185,50 +185,50 @@
  */
 
 struct snd_ymfpci_playback_bank {
-	u32 format;
-	u32 loop_default;
-	u32 base;			/* 32-bit address */
-	u32 loop_start;			/* 32-bit offset */
-	u32 loop_end;			/* 32-bit offset */
-	u32 loop_frac;			/* 8-bit fraction - loop_start */
-	u32 delta_end;			/* pitch delta end */
-	u32 lpfK_end;
-	u32 eg_gain_end;
-	u32 left_gain_end;
-	u32 right_gain_end;
-	u32 eff1_gain_end;
-	u32 eff2_gain_end;
-	u32 eff3_gain_end;
-	u32 lpfQ;
-	u32 status;
-	u32 num_of_frames;
-	u32 loop_count;
-	u32 start;
-	u32 start_frac;
-	u32 delta;
-	u32 lpfK;
-	u32 eg_gain;
-	u32 left_gain;
-	u32 right_gain;
-	u32 eff1_gain;
-	u32 eff2_gain;
-	u32 eff3_gain;
-	u32 lpfD1;
-	u32 lpfD2;
+	__le32 format;
+	__le32 loop_default;
+	__le32 base;			/* 32-bit address */
+	__le32 loop_start;		/* 32-bit offset */
+	__le32 loop_end;		/* 32-bit offset */
+	__le32 loop_frac;		/* 8-bit fraction - loop_start */
+	__le32 delta_end;		/* pitch delta end */
+	__le32 lpfK_end;
+	__le32 eg_gain_end;
+	__le32 left_gain_end;
+	__le32 right_gain_end;
+	__le32 eff1_gain_end;
+	__le32 eff2_gain_end;
+	__le32 eff3_gain_end;
+	__le32 lpfQ;
+	__le32 status;
+	__le32 num_of_frames;
+	__le32 loop_count;
+	__le32 start;
+	__le32 start_frac;
+	__le32 delta;
+	__le32 lpfK;
+	__le32 eg_gain;
+	__le32 left_gain;
+	__le32 right_gain;
+	__le32 eff1_gain;
+	__le32 eff2_gain;
+	__le32 eff3_gain;
+	__le32 lpfD1;
+	__le32 lpfD2;
  };
 
 struct snd_ymfpci_capture_bank {
-	u32 base;			/* 32-bit address */
-	u32 loop_end;			/* 32-bit offset */
-	u32 start;			/* 32-bit offset */
-	u32 num_of_loops;		/* counter */
+	__le32 base;			/* 32-bit address */
+	__le32 loop_end;		/* 32-bit offset */
+	__le32 start;			/* 32-bit offset */
+	__le32 num_of_loops;		/* counter */
 };
 
 struct snd_ymfpci_effect_bank {
-	u32 base;			/* 32-bit address */
-	u32 loop_end;			/* 32-bit offset */
-	u32 start;			/* 32-bit offset */
-	u32 temp;
+	__le32 base;			/* 32-bit address */
+	__le32 loop_end;		/* 32-bit offset */
+	__le32 start;			/* 32-bit offset */
+	__le32 temp;
 };
 
 struct snd_ymfpci_pcm;
@@ -316,7 +316,7 @@ struct snd_ymfpci {
 	dma_addr_t work_base_addr;
 	struct snd_dma_buffer ac3_tmp_base;
 
-	u32 *ctrl_playback;
+	__le32 *ctrl_playback;
 	struct snd_ymfpci_playback_bank *bank_playback[YDSXG_PLAYBACK_VOICES][2];
 	struct snd_ymfpci_capture_bank *bank_capture[YDSXG_CAPTURE_VOICES][2];
 	struct snd_ymfpci_effect_bank *bank_effect[YDSXG_EFFECT_VOICES][2];
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 6f81396aadc9..a4926fb03991 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -336,7 +336,7 @@ static void snd_ymfpci_pcm_interrupt(struct snd_ymfpci *chip, struct snd_ymfpci_
 			unsigned int subs = ypcm->substream->number;
 			unsigned int next_bank = 1 - chip->active_bank;
 			struct snd_ymfpci_playback_bank *bank;
-			u32 volume;
+			__le32 volume;
 			
 			bank = &voice->bank[next_bank];
 			volume = cpu_to_le32(chip->pcm_mixer[subs].left << 15);
@@ -505,7 +505,7 @@ static void snd_ymfpci_pcm_init_voice(struct snd_ymfpci_pcm *ypcm, unsigned int
 	u32 lpfK = snd_ymfpci_calc_lpfK(runtime->rate);
 	struct snd_ymfpci_playback_bank *bank;
 	unsigned int nbank;
-	u32 vol_left, vol_right;
+	__le32 vol_left, vol_right;
 	u8 use_left, use_right;
 	unsigned long flags;
 
@@ -2135,7 +2135,7 @@ static int snd_ymfpci_memalloc(struct snd_ymfpci *chip)
 
 	chip->bank_base_playback = ptr;
 	chip->bank_base_playback_addr = ptr_addr;
-	chip->ctrl_playback = (u32 *)ptr;
+	chip->ctrl_playback = (__le32 *)ptr;
 	chip->ctrl_playback[0] = cpu_to_le32(YDSXG_PLAYBACK_VOICES);
 	ptr += ALIGN(playback_ctrl_size, 0x100);
 	ptr_addr += ALIGN(playback_ctrl_size, 0x100);
-- 
2.18.0
