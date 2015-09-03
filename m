From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 12/12] ASoC: ux500: Fix module autoload for OF platform driver
Date: Thu, 3 Sep 2015 13:01:15 +0200
Message-ID: <20150903110115.GA17069@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa@the-dreams.de>, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 sound/soc/ux500/ux500_msp_dai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 978f2d7..a57a9b8 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -852,6 +852,7 @@ static const struct of_device_id ux500_msp_i2s_match[] = {
 	{ .compatible = "stericsson,ux500-msp-i2s", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ux500_msp_i2s_match);
 
 static struct platform_driver msp_i2s_driver = {
 	.driver = {
-- 
2.4.6
