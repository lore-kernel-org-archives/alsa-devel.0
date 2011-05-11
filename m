From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: snd_soc_hw_bulk_write_raw: Use the
	codec's hw_write callback
Date: Wed, 11 May 2011 12:05:14 -0700
Message-ID: <1305140714-10953-1-git-send-email-lars@metafoo.de>
References: <1305134752-20571-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-081.synserver.de (smtp-out-084.synserver.de
	[212.40.185.84])
	by alsa0.perex.cz (Postfix) with ESMTP id D62ED10395A
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 21:05:50 +0200 (CEST)
In-Reply-To: <1305134752-20571-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently there are two places in the snd_soc_cache code where the function to
write to the hardware is determined by looking at the control_type.
One lookup is done when the cache is initialized the other is done in
snd_soc_hw_bulk_write_raw. This requires, that when the spi or i2c write function
is changed, that both places are updated.
To avoid missing one of them use the codec's hw_write callback in
snd_soc_hw_bulk_write_raw instead of looking at the control_type.

Also this allows to use other bus types to do raw writes instead of limiting it
to spi and i2c.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-cache.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 06b7b81..fb34d65 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -308,21 +308,7 @@ static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int r
 	    && reg < codec->driver->reg_cache_size)
 		return -EINVAL;
 
-	switch (codec->control_type) {
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-	case SND_SOC_I2C:
-		ret = i2c_master_send(codec->control_data, data, len);
-		break;
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	case SND_SOC_SPI:
-		ret = spi_write(codec->control_data, data, len);
-		break;
-#endif
-	default:
-		BUG();
-	}
-
+	ret = codec->hw_write(codec, data, len);
 	if (ret == len)
 		return 0;
 	if (ret < 0)
-- 
1.7.2.5
