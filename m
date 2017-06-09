From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: pcm: move fixup of info flag after
	selecting single parameters
Date: Fri,  9 Jun 2017 09:34:40 +0900
Message-ID: <20170609003440.4178-4-o-takashi@sakamocchi.jp>
References: <20170609003440.4178-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E718A2674B6
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 02:34:48 +0200 (CEST)
In-Reply-To: <20170609003440.4178-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When drivers register no flags about information of PCM hardware, ALSA
PCM core fixups it roughly. Currently, this operation places in a
function snd_pcm_hw_refine(). It can be moved to a function
fixup_unreferenced_params() because it doesn't affects operations
between these two functions.

This idea is better to bundle codes with similar purposes and this commit
achieves it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index dfe6113a6a60..3293db0172db 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -472,13 +472,21 @@ static int fixup_unreferenced_params(struct snd_pcm_substream *substream,
 		}
 	}
 
+	if (!params->info) {
+		params->info = substream->runtime->hw.info;
+		params->info &= ~(SNDRV_PCM_INFO_FIFO_IN_FRAMES |
+				  SNDRV_PCM_INFO_DRAIN_TRIGGER);
+		if (!hw_support_mmap(substream))
+			params->info &= ~(SNDRV_PCM_INFO_MMAP |
+					  SNDRV_PCM_INFO_MMAP_VALID);
+	}
+
 	return 0;
 }
 
 int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_hardware *hw;
 	int err;
 
 	params->info = 0;
@@ -502,16 +510,8 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
-	hw = &substream->runtime->hw;
-	if (!params->info) {
-		params->info = hw->info & ~(SNDRV_PCM_INFO_FIFO_IN_FRAMES |
-					    SNDRV_PCM_INFO_DRAIN_TRIGGER);
-		if (!hw_support_mmap(substream))
-			params->info &= ~(SNDRV_PCM_INFO_MMAP |
-					  SNDRV_PCM_INFO_MMAP_VALID);
-	}
-
 	params->rmask = 0;
+
 	return 0;
 }
 EXPORT_SYMBOL(snd_pcm_hw_refine);
-- 
2.11.0
