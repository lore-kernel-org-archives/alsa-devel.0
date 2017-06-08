From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 7/8] ALSA: pcm: use helper functions to
	check whether parameters are determined
Date: Fri,  9 Jun 2017 06:37:05 +0900
Message-ID: <20170608213706.5420-8-o-takashi@sakamocchi.jp>
References: <20170608213706.5420-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 38A3D2673B7
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:37:29 +0200 (CEST)
In-Reply-To: <20170608213706.5420-1-o-takashi@sakamocchi.jp>
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

A commit 8bea869c5e56 ("ALSA: PCM midlevel: improve fifo_size handling")
allows drivers to implement calculation of fifo size in parameter
structure. This calculation runs only when two of the other parameters
have single value.

In ALSA PCM core, there're some helper functions for the case. This commit
applies the functions instead of value comparison.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 40560e579d33..80275aa0bcca 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -443,8 +443,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	if (!params->fifo_size) {
 		m = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-		if (snd_mask_min(m) == snd_mask_max(m) &&
-                    snd_interval_min(i) == snd_interval_max(i)) {
+		if (snd_mask_single(m) && snd_interval_single(i)) {
 			err = substream->ops->ioctl(substream,
 					SNDRV_PCM_IOCTL1_FIFO_SIZE, params);
 			if (err < 0)
-- 
2.11.0
