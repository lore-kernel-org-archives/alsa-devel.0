From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 07/12] ASoC: fsl_sai: Fix module autoload for OF platform
 driver
Date: Thu, 3 Sep 2015 12:58:23 +0200
Message-ID: <20150903105823.GA16890@goodgumbo.baconseed.org>
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
 sound/soc/fsl/fsl_sai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5c73bea..ec14427 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -801,6 +801,7 @@ static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,imx6sx-sai", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, fsl_sai_ids);
 
 static struct platform_driver fsl_sai_driver = {
 	.probe = fsl_sai_probe,
-- 
2.4.6
