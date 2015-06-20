From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/4] ASoC: max98090: Check for
	clk_prepare_enable() error
Date: Sat, 20 Jun 2015 15:55:50 -0300
Message-ID: <1434826553-11484-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f48.google.com (mail-qg0-f48.google.com
 [209.85.192.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 464B8260719
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 20:56:12 +0200 (CEST)
Received: by qged89 with SMTP id d89so44629174qge.0
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 11:56:11 -0700 (PDT)
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
 sound/soc/codecs/max98090.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 78268f05..1697340 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1801,10 +1801,13 @@ static int max98090_set_bias_level(struct snd_soc_codec *codec,
 		if (IS_ERR(max98090->mclk))
 			break;
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
 			clk_disable_unprepare(max98090->mclk);
-		else
-			clk_prepare_enable(max98090->mclk);
+		} else {
+			ret = clk_prepare_enable(max98090->mclk);
+			if (ret)
+				return ret;
+		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-- 
1.9.1
