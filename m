From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/9] ALSA: snd_pcm_oss_period_size: Use
	round{up, down}_pow_of_two()
Date: Mon, 29 Dec 2014 19:41:45 +0100
Message-ID: <1419878506-28684-8-git-send-email-lars@metafoo.de>
References: <1419878506-28684-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 693CF261A40
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:41:54 +0100 (CET)
In-Reply-To: <1419878506-28684-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Instead of opencoding them use the standard roundup_pow_of_two() and
rounddown_pow_of_two() helper functions. This gets rids one of the few users
of the custom ld2() function and also makes it a bit more obvious what the
code does.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/core/oss/pcm_oss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index ada69d7..80423a4c 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -719,7 +719,7 @@ static int snd_pcm_oss_period_size(struct snd_pcm_substream *substream,
 
 	oss_buffer_size = snd_pcm_plug_client_size(substream,
 						   snd_pcm_hw_param_value_max(slave_params, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, NULL)) * oss_frame_size;
-	oss_buffer_size = 1 << ld2(oss_buffer_size);
+	oss_buffer_size = rounddown_pow_of_two(oss_buffer_size);
 	if (atomic_read(&substream->mmap_count)) {
 		if (oss_buffer_size > runtime->oss.mmap_bytes)
 			oss_buffer_size = runtime->oss.mmap_bytes;
@@ -755,14 +755,14 @@ static int snd_pcm_oss_period_size(struct snd_pcm_substream *substream,
 	min_period_size = snd_pcm_plug_client_size(substream,
 						   snd_pcm_hw_param_value_min(slave_params, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, NULL));
 	min_period_size *= oss_frame_size;
-	min_period_size = 1 << (ld2(min_period_size - 1) + 1);
+	min_period_size = roundup_pow_of_two(min_period_size);
 	if (oss_period_size < min_period_size)
 		oss_period_size = min_period_size;
 
 	max_period_size = snd_pcm_plug_client_size(substream,
 						   snd_pcm_hw_param_value_max(slave_params, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, NULL));
 	max_period_size *= oss_frame_size;
-	max_period_size = 1 << ld2(max_period_size);
+	max_period_size = rounddown_pow_of_two(max_period_size);
 	if (oss_period_size > max_period_size)
 		oss_period_size = max_period_size;
 
-- 
1.8.0
