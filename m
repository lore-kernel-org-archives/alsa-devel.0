From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 08/12] ASoC: jz4740: Fix module autoload for OF platform
 driver
Date: Thu, 3 Sep 2015 12:58:57 +0200
Message-ID: <20150903105857.GA16943@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index b05fb1c..794a349 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -485,6 +485,7 @@ static const struct of_device_id jz4740_of_matches[] = {
 	{ .compatible = "ingenic,jz4780-i2s", .data = (void *)JZ_I2S_JZ4780 },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, jz4740_of_matches);
 #endif
 
 static int jz4740_i2s_dev_probe(struct platform_device *pdev)
-- 
2.4.6
