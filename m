From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 01/12] ALSA: arm: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:49 +0530
Message-ID: <1502961360-22063-2-git-send-email-bhumirks@gmail.com>
References: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it is only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/arm/aaci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 4140b1b..74cf452 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -348,7 +348,7 @@ static irqreturn_t aaci_irq(int irq, void *devid)
 /*
  * ALSA support.
  */
-static struct snd_pcm_hardware aaci_hw_info = {
+static const struct snd_pcm_hardware aaci_hw_info = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_INTERLEAVED |
-- 
1.9.1
