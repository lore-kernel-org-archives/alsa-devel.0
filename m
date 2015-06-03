From: Jack Mitchell <ml@embed.me.uk>
Subject: simple-audio-card with omap4-dmic
Date: Wed, 03 Jun 2015 16:37:02 +0100
Message-ID: <556F1F1E.8040405@embed.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from owm.eumx.net (eumx.net [91.82.101.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3238B2606CA
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 17:36:57 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

I'm currently working with a PandaBoard clone (OMAP44xx) which doesn't 
have the usual twl6040 codec, however I would like to attach a digital 
microphone directly into the OMAP.

I have added the following to my device tree:

         sound {
                 compatible = "simple-audio-card";
                 simple-audio-card,name = "dmic-card";

                 simple-audio-card,format = "pdm";

                 status = "okay";

                 simple-audio-card,dai-link@0 {
                         cpu {
                                 sound-dai = <&dmic>;
                         };

                         codec {
                                 sound-dai = <&dmic_codec>;
                         };
                 };
         };

         dmic_codec: dmic_codec {
                 #sound-dai-cells = <0>;
                 compatible = "linux,dmic-codec";
         };

and created a small patch to allow the generic dmic-hifi codec to be 
instantiated from device tree.

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index fde5325..67b9198 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -69,11 +69,18 @@ static int dmic_dev_remove(struct platform_device *pdev)
         return 0;
  }

-MODULE_ALIAS("platform:dmic-codec");
+#ifdef CONFIG_OF
+static const struct of_device_id dmic_dt_ids[] = {
+        { .compatible = "linux,dmic-codec", },
+        { }
+};
+MODULE_DEVICE_TABLE(of, dmic_dt_ids);
+#endif

  static struct platform_driver dmic_driver = {
         .driver = {
                 .name = "dmic-codec",
+               .of_match_table = of_match_ptr(dmic_dt_ids),
         },
         .probe = dmic_dev_probe,
         .remove = dmic_dev_remove,
@@ -81,6 +88,7 @@ static struct platform_driver dmic_driver = {

  module_platform_driver(dmic_driver);

+MODULE_ALIAS("platform:dmic-codec");
  MODULE_DESCRIPTION("Generic DMIC driver");
  MODULE_AUTHOR("Liam Girdwood <lrg@slimlogic.co.uk>");
  MODULE_LICENSE("GPL");

However, no soundcards get loaded, and I don't get error or warnings in 
dmesg, so I'm at a bit of a loss at where I'm going wrong. Can anybody 
see any glaring mistakes? I know the driver is definitely getting loaded 
as I have seen errors relating to me not specifying the sound-dai-cells 
from the simple-audio-card driver.

Any ideas would be greatly recieved!

Cheers,
