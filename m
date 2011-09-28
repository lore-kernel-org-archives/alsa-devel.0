From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix setting adau1373_dai->master for
 SND_SOC_DAIFMT_CBS_CFS
Date: Wed, 28 Sep 2011 15:14:56 +0800
Message-ID: <1317194096.2498.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In the case of SND_SOC_DAIFMT_CBS_CFS, adau1373_dai->master should be false.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/adau1373.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 2aa40c3..1ccf8dd 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -974,7 +974,7 @@ static int adau1373_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		ctrl = 0;
-		adau1373_dai->master = true;
+		adau1373_dai->master = false;
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.4.1
