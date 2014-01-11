From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/5] ASoC: pcm: Properly initialize
	hw->rate_max
Date: Sat, 11 Jan 2014 10:24:40 +0100
Message-ID: <1389432284-6792-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id DFF4426167E
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2014 10:24:23 +0100 (CET)
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

If none of the components (CODEC or CPU DAI) sets a maximum sample rate we'll
end up with the rate_max field of the runtime hardware set to 0.  (Note that it
is still possible for the components to constrain the supported sample rates
using other methods, e.g. setting a list constraint) If rate_max is 0 this means
that the sound card doesn't support any rates at all, which is not the desired
result. So initialize rate_max to UINT_MAX. For symmetry reasons also set
rate_min to 0.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes in v2
---
 sound/soc/soc-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 313adba..b6e0c32 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -252,6 +252,9 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
 		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
 		hw->rates |= codec_stream->rates;
 
+	hw->rate_min = 0;
+	hw->rate_max = UINT_MAX;
+
 	snd_pcm_limit_hw_rates(runtime);
 
 	hw->rate_min = max(hw->rate_min, cpu_stream->rate_min);
-- 
1.8.0
