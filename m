From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/7] ALSA: au88x0: constify snd_pcm_ops structures
Date: Thu, 10 Aug 2017 17:17:33 +0530
Message-ID: <1502365658-24723-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502365658-24723-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502365658-24723-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/pci/au88x0/au88x0_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/au88x0/au88x0_pcm.c b/sound/pci/au88x0/au88x0_pcm.c
index 1aa9701..848eb3c 100644
--- a/sound/pci/au88x0/au88x0_pcm.c
+++ b/sound/pci/au88x0/au88x0_pcm.c
@@ -439,7 +439,7 @@ static snd_pcm_uframes_t snd_vortex_pcm_pointer(struct snd_pcm_substream *substr
 }
 
 /* operators */
-static struct snd_pcm_ops snd_vortex_playback_ops = {
+static const struct snd_pcm_ops snd_vortex_playback_ops = {
 	.open = snd_vortex_pcm_open,
 	.close = snd_vortex_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
-- 
1.9.1
