From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 01/16] ALSA: aw2: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:13 +0530
Message-ID: <1502551888-30325-2-git-send-email-bhumirks@gmail.com>
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
 sound/pci/aw2/aw2-alsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 8356180..9a49e42 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -52,7 +52,7 @@
  * TYPEDEFS
  ********************************/
   /* hardware definition */
-static struct snd_pcm_hardware snd_aw2_playback_hw = {
+static const struct snd_pcm_hardware snd_aw2_playback_hw = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID),
@@ -69,7 +69,7 @@
 	.periods_max = 1024,
 };
 
-static struct snd_pcm_hardware snd_aw2_capture_hw = {
+static const struct snd_pcm_hardware snd_aw2_capture_hw = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID),
-- 
1.9.1
