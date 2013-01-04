From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: arizona: Remove DSP B and left
	justified AIF modes
Date: Fri,  4 Jan 2013 10:49:07 +0000
Message-ID: <1357296548-859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ECA6D2616F3
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 11:49:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

These are not supported.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a4d7fb9..7724b4b 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -503,15 +503,9 @@ static int arizona_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_DSP_A:
 		mode = 0;
 		break;
-	case SND_SOC_DAIFMT_DSP_B:
-		mode = 1;
-		break;
 	case SND_SOC_DAIFMT_I2S:
 		mode = 2;
 		break;
-	case SND_SOC_DAIFMT_LEFT_J:
-		mode = 3;
-		break;
 	default:
 		arizona_aif_err(dai, "Unsupported DAI format %d\n",
 				fmt & SND_SOC_DAIFMT_FORMAT_MASK);
-- 
1.7.10.4
