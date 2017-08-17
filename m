From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 02/12] ALSA: atmel: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:50 +0530
Message-ID: <1502961360-22063-3-git-send-email-bhumirks@gmail.com>
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
 sound/atmel/ac97c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 52b0522..f3f582e 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -66,7 +66,7 @@ struct atmel_ac97c {
 #define ac97c_readl(chip, reg)				\
 	__raw_readl((chip)->regs + AC97C_##reg)
 
-static struct snd_pcm_hardware atmel_ac97c_hw = {
+static const struct snd_pcm_hardware atmel_ac97c_hw = {
 	.info			= (SNDRV_PCM_INFO_MMAP
 				  | SNDRV_PCM_INFO_MMAP_VALID
 				  | SNDRV_PCM_INFO_INTERLEAVED
-- 
1.9.1
