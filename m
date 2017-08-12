From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 03/16] ALSA: cs46xx: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:15 +0530
Message-ID: <1502551888-30325-4-git-send-email-bhumirks@gmail.com>
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
 sound/pci/cs46xx/cs46xx_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 709fb1a..0020fd0 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -1438,7 +1438,7 @@ static irqreturn_t snd_cs46xx_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct snd_pcm_hardware snd_cs46xx_playback =
+static const struct snd_pcm_hardware snd_cs46xx_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED | 
@@ -1460,7 +1460,7 @@ static irqreturn_t snd_cs46xx_interrupt(int irq, void *dev_id)
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_cs46xx_capture =
+static const struct snd_pcm_hardware snd_cs46xx_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
-- 
1.9.1
