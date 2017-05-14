From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 13/21] ALSA: pcm: use helper functions to
	check whether parameters are determined
Date: Sun, 14 May 2017 17:57:48 +0900
Message-ID: <20170514085756.22382-14-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C6FE9266BC9
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:04 +0200 (CEST)
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
index 47af1a8..028d6a5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -512,8 +512,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	if (!params->fifo_size) {
 		m = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-		if (snd_mask_min(m) == snd_mask_max(m) &&
-                    snd_interval_min(i) == snd_interval_max(i)) {
+		if (snd_mask_single(m) && snd_interval_single(i)) {
 			changed = substream->ops->ioctl(substream,
 					SNDRV_PCM_IOCTL1_FIFO_SIZE, params);
 			if (changed < 0)
-- 
2.9.3
