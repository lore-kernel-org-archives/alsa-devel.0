From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: max98095: Fix build failure
Date: Mon,  2 Apr 2012 15:03:11 +0100
Message-ID: <1333375391-17049-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 918D5244DC
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 16:03:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rhyland Klein <rklein@nvidia.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/max98095.c: In function 'max98095_jack_detect_enable':
sound/soc/codecs/max98095.c:2229:14: error: 'struct max98095_priv' has no member named 'jack_detect_delay'
sound/soc/codecs/max98095.c:2230:18: error: 'struct max98095_priv' has no member named 'jack_detect_delay'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/max98095.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 0752840..35179e2 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2226,8 +2226,8 @@ int max98095_jack_detect_enable(struct snd_soc_codec *codec)
 	if (max98095->pdata->jack_detect_pin5en)
 		detect_enable |= M98095_PIN5EN;
 
-	if (max98095->jack_detect_delay)
-		slew = max98095->jack_detect_delay;
+	if (max98095->pdata->jack_detect_delay)
+		slew = max98095->pdata->jack_detect_delay;
 
 	ret = snd_soc_write(codec, M98095_08E_JACK_DC_SLEW, slew);
 	if (ret < 0) {
-- 
1.7.9.1
