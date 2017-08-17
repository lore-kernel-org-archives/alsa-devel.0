From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 12/12] ALSA: parisc: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:46:00 +0530
Message-ID: <1502961360-22063-13-git-send-email-bhumirks@gmail.com>
References: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used in a copy operation.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/parisc/harmony.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 5911eb3..cb2bc54 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -260,7 +260,7 @@
 	return HARMONY_SR_44KHZ;
 }
 
-static struct snd_pcm_hardware snd_harmony_playback =
+static const struct snd_pcm_hardware snd_harmony_playback =
 {
 	.info =	(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED | 
 		 SNDRV_PCM_INFO_JOINT_DUPLEX | SNDRV_PCM_INFO_MMAP_VALID |
@@ -281,7 +281,7 @@
 	.fifo_size = 0,
 };
 
-static struct snd_pcm_hardware snd_harmony_capture =
+static const struct snd_pcm_hardware snd_harmony_capture =
 {
         .info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
                  SNDRV_PCM_INFO_JOINT_DUPLEX | SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
