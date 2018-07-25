From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ASoC: pcm186x: Declare PCM format with
	snd_pcm_format_t
Date: Wed, 25 Jul 2018 23:17:21 +0200
Message-ID: <20180725211722.18944-6-tiwai@suse.de>
References: <20180725211722.18944-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 66638267786
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:17:29 +0200 (CEST)
In-Reply-To: <20180725211722.18944-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The PCM format type is with __bitwise, so we should use the dedicated
snd_pcm_format_t instead of int.

This fixes the sparse warning like:
  sound/soc/codecs/pcm186x.c:268:44: warning: incorrect type in initializer (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/pcm186x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index 88fde70b1e9e..690c26e7389e 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -265,7 +265,7 @@ static int pcm186x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct pcm186x_priv *priv = snd_soc_component_get_drvdata(component);
 	unsigned int rate = params_rate(params);
-	unsigned int format = params_format(params);
+	snd_pcm_format_t format = params_format(params);
 	unsigned int width = params_width(params);
 	unsigned int channels = params_channels(params);
 	unsigned int div_lrck;
-- 
2.18.0
