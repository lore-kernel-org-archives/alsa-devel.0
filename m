From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 09/16] ALSA: mixart: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:21 +0530
Message-ID: <1502551888-30325-10-git-send-email-bhumirks@gmail.com>
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
 sound/pci/mixart/mixart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 6d7fbf3..aca3b34 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -675,7 +675,7 @@ static int snd_mixart_hw_free(struct snd_pcm_substream *subs)
 /*
  *  TODO CONFIGURATION SPACE for all pcms, mono pcm must update channels_max
  */
-static struct snd_pcm_hardware snd_mixart_analog_caps =
+static const struct snd_pcm_hardware snd_mixart_analog_caps =
 {
 	.info             = ( SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_MMAP_VALID |
@@ -696,7 +696,7 @@ static int snd_mixart_hw_free(struct snd_pcm_substream *subs)
 	.periods_max      = (32*1024/256),
 };
 
-static struct snd_pcm_hardware snd_mixart_digital_caps =
+static const struct snd_pcm_hardware snd_mixart_digital_caps =
 {
 	.info             = ( SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
