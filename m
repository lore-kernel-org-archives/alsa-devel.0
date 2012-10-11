From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH] ASoC: codecs: da9055: Add support for DSP mode
 of AIF
Date: Thu, 11 Oct 2012 13:44:39 +0530
Message-ID: <1349943279.24126.4.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 394F52616DA
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 10:03:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch adds AIF DSP mode support for da9055 codec driver.


Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <david.chen@diasemi.com>
---
 sound/soc/codecs/da9055.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 185d8dd..27c4454 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -173,6 +173,7 @@
 #define DA9055_AIF_FORMAT_I2S_MODE	(0 << 0)
 #define DA9055_AIF_FORMAT_LEFT_J	(1 << 0)
 #define DA9055_AIF_FORMAT_RIGHT_J	(2 << 0)
+#define DA9055_AIF_FORMAT_DSP		(3 << 0)
 #define DA9055_AIF_WORD_S16_LE		(0 << 2)
 #define DA9055_AIF_WORD_S20_3LE		(1 << 2)
 #define DA9055_AIF_WORD_S24_LE		(2 << 2)
@@ -1155,6 +1156,9 @@ static int da9055_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_RIGHT_J:
 		aif_ctrl = DA9055_AIF_FORMAT_RIGHT_J;
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		aif_ctrl = DA9055_AIF_FORMAT_DSP;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.7.1
