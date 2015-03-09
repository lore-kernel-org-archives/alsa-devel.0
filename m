From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] ASoC: cx20442: remove incorerct __exit markups
Date: Mon, 9 Mar 2015 11:15:28 -0700
Message-ID: <20150309181528.GA26428@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Even if bus is not hot-pluggable, the devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/codecs/cx20442.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 0b10979..0f334bc 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -420,7 +420,7 @@ static int cx20442_platform_probe(struct platform_device *pdev)
 			&cx20442_codec_dev, &cx20442_dai, 1);
 }
 
-static int __exit cx20442_platform_remove(struct platform_device *pdev)
+static int cx20442_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
@@ -431,7 +431,7 @@ static struct platform_driver cx20442_platform_driver = {
 		.name = "cx20442-codec",
 		},
 	.probe = cx20442_platform_probe,
-	.remove = __exit_p(cx20442_platform_remove),
+	.remove = cx20442_platform_remove,
 };
 
 module_platform_driver(cx20442_platform_driver);
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
