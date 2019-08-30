From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] ASoC: ti: davinci-i2s: Add S32_LE as
	support format
Date: Fri, 30 Aug 2019 13:38:38 +0300
Message-ID: <20190830103841.25128-2-peter.ujfalusi@ti.com>
References: <20190830103841.25128-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33C49F80096
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 12:38:22 +0200 (CEST)
In-Reply-To: <20190830103841.25128-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

ASP/McBSP can support 8/16/20/24/32 bits word in theory. I have only tested
S16_LE and S32_LE, the other formats might not work so only extend the
supported formats with S32_LE for now.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 92c1bdc69086..f04d9fb5130f 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -612,6 +612,8 @@ static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 }
 
 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
+#define DAVINCI_I2S_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+				 SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops davinci_i2s_dai_ops = {
 	.shutdown	= davinci_i2s_shutdown,
@@ -639,12 +641,14 @@ static struct snd_soc_dai_driver davinci_i2s_dai = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = DAVINCI_I2S_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = DAVINCI_I2S_FORMATS,
+	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = DAVINCI_I2S_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.formats = DAVINCI_I2S_FORMATS,
+	},
 	.ops = &davinci_i2s_dai_ops,
 
 };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
