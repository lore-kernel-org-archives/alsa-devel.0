From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 15/16] ALSA: ymfpci: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:27 +0530
Message-ID: <1502551888-30325-16-git-send-email-bhumirks@gmail.com>
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
 sound/pci/ymfpci/ymfpci_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 1114166..edfd5824 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -845,7 +845,7 @@ static irqreturn_t snd_ymfpci_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct snd_pcm_hardware snd_ymfpci_playback =
+static const struct snd_pcm_hardware snd_ymfpci_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_MMAP_VALID | 
@@ -867,7 +867,7 @@ static irqreturn_t snd_ymfpci_interrupt(int irq, void *dev_id)
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_ymfpci_capture =
+static const struct snd_pcm_hardware snd_ymfpci_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
