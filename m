From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 11/16] ALSA: pcxhr: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:23 +0530
Message-ID: <1502551888-30325-12-git-send-email-bhumirks@gmail.com>
References: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, T-Bone@parisc-linux.org, perex@perex.cz, tiwai@suse.com, clemens@ladisch.de, jayakumar.alsa@gmail.com, linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it is only used during a copy operation.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/pcxhr/pcxhr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index fa919f5..e6f9aa6 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -986,7 +986,7 @@ static int pcxhr_hw_free(struct snd_pcm_substream *subs)
 /*
  *  CONFIGURATION SPACE for all pcms, mono pcm must update channels_max
  */
-static struct snd_pcm_hardware pcxhr_caps =
+static const struct snd_pcm_hardware pcxhr_caps =
 {
 	.info             = (SNDRV_PCM_INFO_MMAP |
 			     SNDRV_PCM_INFO_INTERLEAVED |
-- 
1.9.1
