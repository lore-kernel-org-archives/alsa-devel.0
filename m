From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 11/11] ASoC: Allow PCMs to restrict the
	supported formats
Date: Mon,  6 Jan 2014 14:19:16 +0100
Message-ID: <1389014356-7014-11-git-send-email-lars@metafoo.de>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 989A0261A2B
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 14:19:03 +0100 (CET)
In-Reply-To: <1389014356-7014-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolin Chen <b42378@freescale.com>, Timur Tabi <timur@tabi.org>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Some DMA cores might add additional restrictions on which in memory audio
formats can be supported by the compound sound card. If the PCM component
specifies a set of formats it supports (by setting the formats field to non 0)
take these into account when calculating the format set for the compound sound
card.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Timur Tabi <timur@tabi.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Nicolin Chen <b42378@freescale.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
---
New in v1. Note that this patch will only affect fsl/, all other platforms set
the formats field to 0 now.
---
 sound/soc/soc-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 86b670e..0457e70 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -240,7 +240,10 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
 		cpu_stream->channels_min);
 	hw->channels_max = min(codec_stream->channels_max,
 		cpu_stream->channels_max);
-	hw->formats = codec_stream->formats & cpu_stream->formats;
+	if (hw->formats)
+		hw->formats &= codec_stream->formats & cpu_stream->formats;
+	else
+		hw->formats = codec_stream->formats & cpu_stream->formats;
 	hw->rates = codec_stream->rates & cpu_stream->rates;
 	if (codec_stream->rates
 		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
-- 
1.8.0
