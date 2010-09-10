From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix off-by-one bug in register cache
	size configuration
Date: Fri, 10 Sep 2010 18:24:08 +0100
Message-ID: <1284139448-12043-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 835142451A
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 19:23:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is a simple off-by-one bug, the size of the register cache is
incorrectly set to the maximum register index. Fix it by adding one.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 58ba2d3..30984dd 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1780,7 +1780,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8962 = {
 	.remove =	wm8962_remove,
 	.resume =	wm8962_resume,
 	.set_bias_level = wm8962_set_bias_level,
-	.reg_cache_size = WM8962_MAX_REGISTER,
+	.reg_cache_size = WM8962_MAX_REGISTER + 1,
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8962_reg,
 	.volatile_register = wm8962_volatile_register,
-- 
1.7.2.3
