From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH] ASoC: bcm2835-i2s: Fix module autoload for OF platform
 drivers
Date: Thu, 27 Aug 2015 17:04:01 +0200
Message-ID: <20150827150401.GA32653@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These platform drivers have a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 sound/soc/bcm/bcm2835-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 03fa1cb..8c435be 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -862,6 +862,8 @@ static const struct of_device_id bcm2835_i2s_of_match[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(of, bcm2835_i2s_of_match);
+
 static struct platform_driver bcm2835_i2s_driver = {
 	.probe		= bcm2835_i2s_probe,
 	.driver		= {
-- 
2.4.6
