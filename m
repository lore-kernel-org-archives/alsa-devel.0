From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 11/12] ASoC: mop500: Fix module autoload for OF platform
 driver
Date: Thu, 3 Sep 2015 13:00:40 +0200
Message-ID: <20150903110040.GA17060@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Markus Elfring <elfring@users.sourceforge.net>, Wolfram Sang <wsa@the-dreams.de>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 sound/soc/ux500/mop500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 4e0c0e5..ba9fc09 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -152,6 +152,7 @@ static const struct of_device_id snd_soc_mop500_match[] = {
 	{ .compatible = "stericsson,snd-soc-mop500", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, snd_soc_mop500_match);
 
 static struct platform_driver snd_soc_mop500_driver = {
 	.driver = {
-- 
2.4.6
