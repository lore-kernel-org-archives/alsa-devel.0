From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/4] ASoC: max98095: Check for
	clk_prepare_enable() error
Date: Sat, 20 Jun 2015 15:55:53 -0300
Message-ID: <1434826553-11484-4-git-send-email-festevam@gmail.com>
References: <1434826553-11484-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 by alsa0.perex.cz (Postfix) with ESMTP id A1302260713
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 20:56:22 +0200 (CEST)
Received: by qgal13 with SMTP id l13so44539642qga.3
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 11:56:21 -0700 (PDT)
In-Reply-To: <1434826553-11484-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/max98095.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 9a46d3d..66afd2b 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1653,10 +1653,13 @@ static int max98095_set_bias_level(struct snd_soc_codec *codec,
 		if (IS_ERR(max98095->mclk))
 			break;
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
 			clk_disable_unprepare(max98095->mclk);
-		else
-			clk_prepare_enable(max98095->mclk);
+		} else {
+			ret = clk_prepare_enable(max98095->mclk);
+			if (ret)
+				return ret;
+		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-- 
1.9.1
