From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5100: Remove stubs of ASoC-level
	register map code
Date: Tue, 19 Jun 2012 12:43:09 +0100
Message-ID: <1340106189-8435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FFEF24464
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 13:56:15 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index ba52534..33aa363 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2517,13 +2517,6 @@ static int wm5100_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int wm5100_soc_volatile(struct snd_soc_codec *codec,
-			       unsigned int reg)
-{
-	return true;
-}
-
-
 static struct snd_soc_codec_driver soc_codec_dev_wm5100 = {
 	.probe =	wm5100_probe,
 	.remove =	wm5100_remove,
@@ -2531,8 +2524,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm5100 = {
 	.set_sysclk = wm5100_set_sysclk,
 	.set_pll = wm5100_set_fll,
 	.idle_bias_off = 1,
-	.reg_cache_size = WM5100_MAX_REGISTER,
-	.volatile_register = wm5100_soc_volatile,
 
 	.seq_notifier = wm5100_seq_notifier,
 	.controls = wm5100_snd_controls,
-- 
1.7.10
