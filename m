From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: pcm3168a: Enable TDM support for DSP_A/B
	modes
Date: Wed, 17 Apr 2019 14:31:40 +0300
Message-ID: <20190417113140.15572-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 706DEF89616
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2019 13:30:33 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The 24-bit TDM mode also applies to DSP_A and DSP_B modes.
Most dais on the SoC side can not interpret I2S/Left_j with other than 2
channels of audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/pcm3168a.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 08d3fe192e65..e0d5839fe1a7 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -457,13 +457,16 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	if (chan > 2) {
 		switch (fmt) {
 		case PCM3168A_FMT_I2S:
+		case PCM3168A_FMT_DSP_A:
 			fmt = PCM3168A_FMT_I2S_TDM;
 			break;
 		case PCM3168A_FMT_LEFT_J:
+		case PCM3168A_FMT_DSP_B:
 			fmt = PCM3168A_FMT_LEFT_J_TDM;
 			break;
 		default:
-			dev_err(component->dev, "TDM is supported under I2S/Left_J only\n");
+			dev_err(component->dev,
+				"TDM is supported under DSP/I2S/Left_J only\n");
 			return -EINVAL;
 		}
 	}
@@ -526,6 +529,8 @@ static int pcm3168a_startup(struct snd_pcm_substream *substream,
 		break;
 	case PCM3168A_FMT_LEFT_J:
 	case PCM3168A_FMT_I2S:
+	case PCM3168A_FMT_DSP_A:
+	case PCM3168A_FMT_DSP_B:
 		sample_min  = 24;
 		channel_max = channel_maxs[tx];
 		break;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
