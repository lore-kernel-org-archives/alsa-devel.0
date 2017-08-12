From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 12/16] ALSA: riptide: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:24 +0530
Message-ID: <1502551888-30325-13-git-send-email-bhumirks@gmail.com>
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
 sound/pci/riptide/riptide.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index f067c76..44f3b48 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1315,7 +1315,7 @@ static int riptide_reset(struct cmdif *cif, struct snd_riptide *chip)
 	return 0;
 }
 
-static struct snd_pcm_hardware snd_riptide_playback = {
+static const struct snd_pcm_hardware snd_riptide_playback = {
 	.info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP_VALID),
@@ -1334,7 +1334,7 @@ static int riptide_reset(struct cmdif *cif, struct snd_riptide *chip)
 	.periods_max = 64,
 	.fifo_size = 0,
 };
-static struct snd_pcm_hardware snd_riptide_capture = {
+static const struct snd_pcm_hardware snd_riptide_capture = {
 	.info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP_VALID),
-- 
1.9.1
