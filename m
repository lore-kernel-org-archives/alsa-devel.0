From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 10/16] ALSA: ctxfi: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:22 +0530
Message-ID: <1502551888-30325-11-git-send-email-bhumirks@gmail.com>
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
 sound/pci/ctxfi/ctpcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ctxfi/ctpcm.c b/sound/pci/ctxfi/ctpcm.c
index 9749780..358f520 100644
--- a/sound/pci/ctxfi/ctpcm.c
+++ b/sound/pci/ctxfi/ctpcm.c
@@ -21,7 +21,7 @@
 #include <sound/pcm.h>
 
 /* Hardware descriptions for playback */
-static struct snd_pcm_hardware ct_pcm_playback_hw = {
+static const struct snd_pcm_hardware ct_pcm_playback_hw = {
 	.info			= (SNDRV_PCM_INFO_MMAP |
 				   SNDRV_PCM_INFO_INTERLEAVED |
 				   SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -46,7 +46,7 @@
 	.fifo_size		= 0,
 };
 
-static struct snd_pcm_hardware ct_spdif_passthru_playback_hw = {
+static const struct snd_pcm_hardware ct_spdif_passthru_playback_hw = {
 	.info			= (SNDRV_PCM_INFO_MMAP |
 				   SNDRV_PCM_INFO_INTERLEAVED |
 				   SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -69,7 +69,7 @@
 };
 
 /* Hardware descriptions for capture */
-static struct snd_pcm_hardware ct_pcm_capture_hw = {
+static const struct snd_pcm_hardware ct_pcm_capture_hw = {
 	.info			= (SNDRV_PCM_INFO_MMAP |
 				   SNDRV_PCM_INFO_INTERLEAVED |
 				   SNDRV_PCM_INFO_BLOCK_TRANSFER |
-- 
1.9.1
