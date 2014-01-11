From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 5/5] ASoC: pcm: Use
	snd_pcm_rate_mask_intersect() helper
Date: Sat, 11 Jan 2014 10:24:44 +0100
Message-ID: <1389432284-6792-5-git-send-email-lars@metafoo.de>
References: <1389432284-6792-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D8DC261734
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2014 10:24:28 +0100 (CET)
In-Reply-To: <1389432284-6792-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Instead of open-coding the intersecting of two rate masks (and getting slightly
wrong for some of the corner cases) use the new snd_pcm_rate_mask_intersect()
helper function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes in v2
---
 sound/soc/soc-pcm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index b6e0c32..5932971 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -244,13 +244,8 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
 		hw->formats &= codec_stream->formats & cpu_stream->formats;
 	else
 		hw->formats = codec_stream->formats & cpu_stream->formats;
-	hw->rates = codec_stream->rates & cpu_stream->rates;
-	if (codec_stream->rates
-		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
-		hw->rates |= cpu_stream->rates;
-	if (cpu_stream->rates
-		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
-		hw->rates |= codec_stream->rates;
+	hw->rates = snd_pcm_rate_mask_intersect(codec_stream->rates,
+		cpu_stream->rates);
 
 	hw->rate_min = 0;
 	hw->rate_max = UINT_MAX;
-- 
1.8.0
