From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 19/21] ALSA: pcm: move fixup of info flag
	after selecting single parameters
Date: Sun, 14 May 2017 17:57:54 +0900
Message-ID: <20170514085756.22382-20-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 21089266BEF
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:07 +0200 (CEST)
In-Reply-To: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, lars@metafoo.de
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
 sound/core/pcm_native.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 2875895..92ab8b2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -488,13 +488,21 @@ static int fixup_unreferenced_params(struct snd_pcm_substream *substream,
 		}
 	}
 
+	if (!params->info) {
+		params->info = substream.runtime->hw->info;
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
 	struct snd_pcm_hw_constraints *constrs;
 	int changed;
 
@@ -520,15 +528,6 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	if (changed < 0)
 		return changed;
 
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
 
 	return 0;
-- 
2.9.3
