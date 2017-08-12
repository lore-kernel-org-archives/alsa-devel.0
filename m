From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 06/16] ALSA: emu10k1: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:18 +0530
Message-ID: <1502551888-30325-7-git-send-email-bhumirks@gmail.com>
References: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: julia.lawall@lip6.fr, T-Bone@parisc-linux.org, perex@perex.cz, tiwai@suse.com, clemens@ladisch.de, jayakumar.alsa@gmail.com, linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/emu10k1/emu10k1x.c |  4 ++--
 sound/pci/emu10k1/emupcm.c   | 10 +++++-----
 sound/pci/emu10k1/p16v.c     |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 77a4413..2c2b12a 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -254,7 +254,7 @@ struct emu10k1x {
 };
 
 /* hardware definition */
-static struct snd_pcm_hardware snd_emu10k1x_playback_hw = {
+static const struct snd_pcm_hardware snd_emu10k1x_playback_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP | 
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -273,7 +273,7 @@ struct emu10k1x {
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_emu10k1x_capture_hw = {
+static const struct snd_pcm_hardware snd_emu10k1x_capture_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP | 
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 5c9054a..2683b97 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -556,7 +556,7 @@ static int snd_emu10k1_efx_playback_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_hardware snd_emu10k1_efx_playback =
+static const struct snd_pcm_hardware snd_emu10k1_efx_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_NONINTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -975,7 +975,7 @@ static snd_pcm_uframes_t snd_emu10k1_capture_pointer(struct snd_pcm_substream *s
  *  Playback support device description
  */
 
-static struct snd_pcm_hardware snd_emu10k1_playback =
+static const struct snd_pcm_hardware snd_emu10k1_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -999,7 +999,7 @@ static snd_pcm_uframes_t snd_emu10k1_capture_pointer(struct snd_pcm_substream *s
  *  Capture support device description
  */
 
-static struct snd_pcm_hardware snd_emu10k1_capture =
+static const struct snd_pcm_hardware snd_emu10k1_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -1019,7 +1019,7 @@ static snd_pcm_uframes_t snd_emu10k1_capture_pointer(struct snd_pcm_substream *s
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_emu10k1_capture_efx =
+static const struct snd_pcm_hardware snd_emu10k1_capture_efx =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -1742,7 +1742,7 @@ static snd_pcm_uframes_t snd_emu10k1_fx8010_playback_pointer(struct snd_pcm_subs
 	return snd_pcm_indirect_playback_pointer(substream, &pcm->pcm_rec, ptr);
 }
 
-static struct snd_pcm_hardware snd_emu10k1_fx8010_playback =
+static const struct snd_pcm_hardware snd_emu10k1_fx8010_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_RESUME |
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index c11f1a2..a30da78 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -122,7 +122,7 @@
  */
 
  /* hardware definition */
-static struct snd_pcm_hardware snd_p16v_playback_hw = {
+static const struct snd_pcm_hardware snd_p16v_playback_hw = {
 	.info =			SNDRV_PCM_INFO_MMAP | 
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -143,7 +143,7 @@
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_p16v_capture_hw = {
+static const struct snd_pcm_hardware snd_p16v_capture_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-- 
1.9.1

