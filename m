From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 05/16] ALSA: cs5535audio: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:17 +0530
Message-ID: <1502551888-30325-6-git-send-email-bhumirks@gmail.com>
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
 sound/pci/cs5535audio/cs5535audio_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index c208c1d..ee7065f 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -33,7 +33,7 @@
 #include <sound/ac97_codec.h>
 #include "cs5535audio.h"
 
-static struct snd_pcm_hardware snd_cs5535audio_playback =
+static const struct snd_pcm_hardware snd_cs5535audio_playback =
 {
 	.info =			(
 				SNDRV_PCM_INFO_MMAP |
@@ -62,7 +62,7 @@
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_cs5535audio_capture =
+static const struct snd_pcm_hardware snd_cs5535audio_capture =
 {
 	.info =			(
 				SNDRV_PCM_INFO_MMAP |
-- 
1.9.1
