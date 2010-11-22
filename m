From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix multi-component mismerge in WM8523
Date: Mon, 22 Nov 2010 19:12:56 +0000
Message-ID: <1290453176-21019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 105CA243E4
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 20:13:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8523.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index d331888..bf44ec7 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -147,7 +147,6 @@ static int wm8523_startup(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	return 0;
 	snd_pcm_hw_constraint_list(substream->runtime, 0,
 				   SNDRV_PCM_HW_PARAM_RATE,
 				   &wm8523->rate_constraint);
-- 
1.7.1
