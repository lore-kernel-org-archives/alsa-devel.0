From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 08/16] ALSA: lx6464es: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:20 +0530
Message-ID: <1502551888-30325-9-git-send-email-bhumirks@gmail.com>
References: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, T-Bone@parisc-linux.org, perex@perex.cz, tiwai@suse.com, clemens@ladisch.de, jayakumar.alsa@gmail.com, linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it is only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/lx6464es/lx6464es.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index f9c3e86..9655b08 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -77,7 +77,7 @@
 
 
 /* alsa callbacks */
-static struct snd_pcm_hardware lx_caps = {
+static const struct snd_pcm_hardware lx_caps = {
 	.info             = (SNDRV_PCM_INFO_MMAP |
 			     SNDRV_PCM_INFO_INTERLEAVED |
 			     SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
