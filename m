From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix reg_cache_size for stac9766
Date: Mon, 05 Dec 2011 10:06:04 +0800
Message-ID: <1323050764.6086.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E1631038AE
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 03:06:17 +0100 (CET)
Received: by yenl7 with SMTP id l7so1497761yen.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 18:06:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

reg_cache_size is supposed to be the number of elements in the register cache,
not the size in bytes.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/stac9766.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 5581953..da71615 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -380,7 +380,7 @@ static struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
 	.remove = stac9766_codec_remove,
 	.suspend = stac9766_codec_suspend,
 	.resume = stac9766_codec_resume,
-	.reg_cache_size = sizeof(stac9766_reg),
+	.reg_cache_size = ARRAY_SIZE(stac9766_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = stac9766_reg,
-- 
1.7.5.4
