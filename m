From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 13/16] ALSA: rme9652: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:25 +0530
Message-ID: <1502551888-30325-14-git-send-email-bhumirks@gmail.com>
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
 sound/pci/rme9652/hdsp.c    | 4 ++--
 sound/pci/rme9652/rme9652.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index fe36d44..9535e6a 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4211,7 +4211,7 @@ static int snd_hdsp_prepare(struct snd_pcm_substream *substream)
 	return result;
 }
 
-static struct snd_pcm_hardware snd_hdsp_playback_subinfo =
+static const struct snd_pcm_hardware snd_hdsp_playback_subinfo =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_MMAP_VALID |
@@ -4241,7 +4241,7 @@ static int snd_hdsp_prepare(struct snd_pcm_substream *substream)
 	.fifo_size =		0
 };
 
-static struct snd_pcm_hardware snd_hdsp_capture_subinfo =
+static const struct snd_pcm_hardware snd_hdsp_capture_subinfo =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 150d088..eff4993 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -2181,7 +2181,7 @@ static int snd_rme9652_prepare(struct snd_pcm_substream *substream)
 	return result;
 }
 
-static struct snd_pcm_hardware snd_rme9652_playback_subinfo =
+static const struct snd_pcm_hardware snd_rme9652_playback_subinfo =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_MMAP_VALID |
@@ -2205,7 +2205,7 @@ static int snd_rme9652_prepare(struct snd_pcm_substream *substream)
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_rme9652_capture_subinfo =
+static const struct snd_pcm_hardware snd_rme9652_capture_subinfo =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
