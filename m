From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 02/16] ALSA: ca0106: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:14 +0530
Message-ID: <1502551888-30325-3-git-send-email-bhumirks@gmail.com>
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
 sound/pci/ca0106/ca0106_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 6165a57..2be30b8 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -296,7 +296,7 @@
 };
 
 /* hardware definition */
-static struct snd_pcm_hardware snd_ca0106_playback_hw = {
+static const struct snd_pcm_hardware snd_ca0106_playback_hw = {
 	.info =			SNDRV_PCM_INFO_MMAP | 
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -317,7 +317,7 @@
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_ca0106_capture_hw = {
+static const struct snd_pcm_hardware snd_ca0106_capture_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP | 
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-- 
1.9.1
