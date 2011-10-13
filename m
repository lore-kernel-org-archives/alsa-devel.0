From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] ASoC: twl6040: Remove Capture restriction
	for 17.64MHz sysclk
Date: Thu, 13 Oct 2011 15:05:41 +0300
Message-ID: <1318507544-26856-2-git-send-email-peter.ujfalusi@ti.com>
References: <1318507544-26856-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CF2710384E
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 14:05:53 +0200 (CEST)
Received: by ggmi1 with SMTP id i1so2216186ggm.26
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 05:05:52 -0700 (PDT)
In-Reply-To: <1318507544-26856-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Capture is supported in all PLL configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 6369230..d078099 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1351,13 +1351,6 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 				rate);
 			return -EINVAL;
 		}
-		/* Capture is not supported with 17.64MHz sysclk */
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-			dev_err(codec->dev,
-				"capture mode is not supported at %dHz\n",
-				rate);
-			return -EINVAL;
-		}
 		priv->sysclk = 17640000;
 		break;
 	case 8000:
-- 
1.7.7
