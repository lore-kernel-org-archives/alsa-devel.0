From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 01/12] ASoC: atmel_wm8904: Fix module autoload for OF
 platform driver
Date: Thu, 3 Sep 2015 12:55:08 +0200
Message-ID: <20150903105508.GA16710@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 sound/soc/atmel/atmel_wm8904.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index aa354e1..1933bcd 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -176,6 +176,7 @@ static const struct of_device_id atmel_asoc_wm8904_dt_ids[] = {
 	{ .compatible = "atmel,asoc-wm8904", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, atmel_asoc_wm8904_dt_ids);
 #endif
 
 static struct platform_driver atmel_asoc_wm8904_driver = {
-- 
2.4.6
