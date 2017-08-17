From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 08/12] ALSA: ppc: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:56 +0530
Message-ID: <1502961360-22063-9-git-send-email-bhumirks@gmail.com>
References: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/ppc/pmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index a5843fc..45f0295 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -509,7 +509,7 @@ static void snd_pmac_pcm_update(struct snd_pmac *chip, struct pmac_stream *rec)
  * hw info
  */
 
-static struct snd_pcm_hardware snd_pmac_playback =
+static const struct snd_pcm_hardware snd_pmac_playback =
 {
 	.info =			(SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP |
@@ -528,7 +528,7 @@ static void snd_pmac_pcm_update(struct snd_pmac *chip, struct pmac_stream *rec)
 	.periods_max =		PMAC_MAX_FRAGS,
 };
 
-static struct snd_pcm_hardware snd_pmac_capture =
+static const struct snd_pcm_hardware snd_pmac_capture =
 {
 	.info =			(SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP |
-- 
1.9.1

