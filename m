From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: soc_pcm_init_runtime_hw: Fix
	rate_max calculation
Date: Wed, 27 Nov 2013 09:58:17 +0100
Message-ID: <1385542698-13362-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-115.synserver.de
 [212.40.185.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4751B2625D3
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 09:57:48 +0100 (CET)
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

In order to make sure that the sample rate is in the supported range of both
components the maximum rate of the card should be the minimum of the maximum
rate of each components. There is one special case to consider though, if
max_rate is set to 0 this means there is no maximum specified, so use
min_not_zero() macro which will give use the desired result.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 170ff96..c4ef880 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -220,7 +220,7 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_hardware *hw,
 	struct snd_soc_pcm_stream *cpu_stream)
 {
 	hw->rate_min = max(codec_stream->rate_min, cpu_stream->rate_min);
-	hw->rate_max = max(codec_stream->rate_max, cpu_stream->rate_max);
+	hw->rate_max = min_not_zero(codec_stream->rate_max, cpu_stream->rate_max);
 	hw->channels_min = max(codec_stream->channels_min,
 		cpu_stream->channels_min);
 	hw->channels_max = min(codec_stream->channels_max,
-- 
1.8.0
