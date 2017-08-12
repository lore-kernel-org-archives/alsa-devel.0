From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 04/16] ALSA: korg1212: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:16 +0530
Message-ID: <1502551888-30325-5-git-send-email-bhumirks@gmail.com>
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
 sound/pci/korg1212/korg1212.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index b28fe49..04cd71c 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -1231,7 +1231,7 @@ static int snd_korg1212_downloadDSPCode(struct snd_korg1212 *korg1212)
         return 0;
 }
 
-static struct snd_pcm_hardware snd_korg1212_playback_info =
+static const struct snd_pcm_hardware snd_korg1212_playback_info =
 {
 	.info =              (SNDRV_PCM_INFO_MMAP |
                               SNDRV_PCM_INFO_MMAP_VALID |
@@ -1252,7 +1252,7 @@ static int snd_korg1212_downloadDSPCode(struct snd_korg1212 *korg1212)
         .fifo_size =          0,
 };
 
-static struct snd_pcm_hardware snd_korg1212_capture_info =
+static const struct snd_pcm_hardware snd_korg1212_capture_info =
 {
         .info =              (SNDRV_PCM_INFO_MMAP |
                               SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
