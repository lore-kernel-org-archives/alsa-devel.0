From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 10/12] ALSA: sparc: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:58 +0530
Message-ID: <1502961360-22063-11-git-send-email-bhumirks@gmail.com>
References: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/sparc/amd7930.c | 2 +-
 sound/sparc/cs4231.c  | 4 ++--
 sound/sparc/dbri.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 35c1f6a..a6864fd 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -666,7 +666,7 @@ static snd_pcm_uframes_t snd_amd7930_capture_pointer(struct snd_pcm_substream *s
 }
 
 /* Playback and capture have identical properties.  */
-static struct snd_pcm_hardware snd_amd7930_pcm_hw =
+static const struct snd_pcm_hardware snd_amd7930_pcm_hw =
 {
 	.info			= (SNDRV_PCM_INFO_MMAP |
 				   SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 3d7d425..f5192b3 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1089,7 +1089,7 @@ static int snd_cs4231_probe(struct snd_cs4231 *chip)
 	return 0;		/* all things are ok.. */
 }
 
-static struct snd_pcm_hardware snd_cs4231_playback = {
+static const struct snd_pcm_hardware snd_cs4231_playback = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_MMAP_VALID |
@@ -1113,7 +1113,7 @@ static int snd_cs4231_probe(struct snd_cs4231 *chip)
 	.periods_max		= 1024,
 };
 
-static struct snd_pcm_hardware snd_cs4231_capture = {
+static const struct snd_pcm_hardware snd_cs4231_capture = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 52063b2..72b6c4a 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -1980,7 +1980,7 @@ static irqreturn_t snd_dbri_interrupt(int irq, void *dev_id)
 /****************************************************************************
 		PCM Interface
 ****************************************************************************/
-static struct snd_pcm_hardware snd_dbri_pcm_hw = {
+static const struct snd_pcm_hardware snd_dbri_pcm_hw = {
 	.info		= SNDRV_PCM_INFO_MMAP |
 			  SNDRV_PCM_INFO_INTERLEAVED |
 			  SNDRV_PCM_INFO_BLOCK_TRANSFER |
-- 
1.9.1
