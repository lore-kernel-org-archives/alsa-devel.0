From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Fix word length configuration
Date: Wed,  1 Feb 2012 10:05:24 +0000
Message-ID: <1328090724-5572-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B21B4103914
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 11:06:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Susan Gao <sgao@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Susan Gao <sgao@opensource.wolfsonmicro.com>

Signed-off-by: Susan Gao <sgao@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index de74af7..c713d55 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2594,13 +2594,13 @@ static int wm8962_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S16_LE:
 		break;
 	case SNDRV_PCM_FORMAT_S20_3LE:
-		aif0 |= 0x40;
+		aif0 |= 0x4;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		aif0 |= 0x80;
+		aif0 |= 0x8;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		aif0 |= 0xc0;
+		aif0 |= 0xc;
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.9.rc1
