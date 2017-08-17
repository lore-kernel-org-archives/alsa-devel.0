From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 11/12] ALSA: usb: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:59 +0530
Message-ID: <1502961360-22063-12-git-send-email-bhumirks@gmail.com>
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
 sound/usb/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 9aa5b18..a4f3390 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -857,7 +857,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	return ret;
 }
 
-static struct snd_pcm_hardware snd_usb_hardware =
+static const struct snd_pcm_hardware snd_usb_hardware =
 {
 	.info =			SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
