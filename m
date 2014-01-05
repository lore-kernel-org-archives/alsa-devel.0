From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/5] ASoC: mc13783: Use
	module_platform_driver_probe()
Date: Sun,  5 Jan 2014 11:38:31 +0400
Message-ID: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [94.100.177.102])
 by alsa0.perex.cz (Postfix) with ESMTP id CB22C2617BB
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 08:38:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

mc13783-codec is probed only by MC13XXX MFD core driver so
use module_platform_driver_probe().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/codecs/mc13783.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index bae6016..8ab9668 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -750,7 +750,7 @@ static struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
 	.num_dapm_routes = ARRAY_SIZE(mc13783_routes),
 };
 
-static int mc13783_codec_probe(struct platform_device *pdev)
+static int __init mc13783_codec_probe(struct platform_device *pdev)
 {
 	struct mc13xxx *mc13xxx;
 	struct mc13783_priv *priv;
@@ -804,11 +804,9 @@ static struct platform_driver mc13783_codec_driver = {
 		   .name = "mc13783-codec",
 		   .owner = THIS_MODULE,
 		   },
-	.probe = mc13783_codec_probe,
 	.remove = mc13783_codec_remove,
 };
-
-module_platform_driver(mc13783_codec_driver);
+module_platform_driver_probe(mc13783_codec_driver, mc13783_codec_probe);
 
 MODULE_DESCRIPTION("ASoC MC13783 driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>");
-- 
1.8.3.2
