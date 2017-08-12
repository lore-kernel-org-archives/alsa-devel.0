From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 14/16] ALSA: trident: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:26 +0530
Message-ID: <1502551888-30325-15-git-send-email-bhumirks@gmail.com>
References: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, T-Bone@parisc-linux.org, perex@perex.cz, tiwai@suse.com, clemens@ladisch.de, jayakumar.alsa@gmail.com, linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/trident/trident_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 4561040..191047a 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -1727,7 +1727,7 @@ static snd_pcm_uframes_t snd_trident_spdif_pointer(struct snd_pcm_substream *sub
  *  Playback support device description
  */
 
-static struct snd_pcm_hardware snd_trident_playback =
+static const struct snd_pcm_hardware snd_trident_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -1752,7 +1752,7 @@ static snd_pcm_uframes_t snd_trident_spdif_pointer(struct snd_pcm_substream *sub
  *  Capture support device description
  */
 
-static struct snd_pcm_hardware snd_trident_capture =
+static const struct snd_pcm_hardware snd_trident_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -1777,7 +1777,7 @@ static snd_pcm_uframes_t snd_trident_spdif_pointer(struct snd_pcm_substream *sub
  *  Foldback capture support device description
  */
 
-static struct snd_pcm_hardware snd_trident_foldback =
+static const struct snd_pcm_hardware snd_trident_foldback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -1801,7 +1801,7 @@ static snd_pcm_uframes_t snd_trident_spdif_pointer(struct snd_pcm_substream *sub
  *  SPDIF playback support device description
  */
 
-static struct snd_pcm_hardware snd_trident_spdif =
+static const struct snd_pcm_hardware snd_trident_spdif =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -1822,7 +1822,7 @@ static snd_pcm_uframes_t snd_trident_spdif_pointer(struct snd_pcm_substream *sub
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_trident_spdif_7018 =
+static const struct snd_pcm_hardware snd_trident_spdif_7018 =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-- 
1.9.1
