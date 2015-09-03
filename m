From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 09/12] ASoC: kirkwood: Fix module autoload for OF platform
 driver
Date: Thu, 3 Sep 2015 12:59:32 +0200
Message-ID: <20150903105932.GA17000@goodgumbo.baconseed.org>
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
 sound/soc/kirkwood/armada-370-db.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/kirkwood/armada-370-db.c b/sound/soc/kirkwood/armada-370-db.c
index de7563b..e0304d5 100644
--- a/sound/soc/kirkwood/armada-370-db.c
+++ b/sound/soc/kirkwood/armada-370-db.c
@@ -130,6 +130,7 @@ static const struct of_device_id a370db_dt_ids[] = {
 	{ .compatible = "marvell,a370db-audio" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, a370db_dt_ids);
 
 static struct platform_driver a370db_driver = {
 	.driver		= {
-- 
2.4.6
