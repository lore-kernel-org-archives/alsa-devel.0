From: preetam <preetamsashankreddy@gmail.com>
Subject: platform driver clarification in twl6040 codec driver
Date: Thu, 05 May 2011 11:28:27 +0530
Message-ID: <4DC23C83.1010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id D919824478
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 07:58:42 +0200 (CEST)
Received: by pzk26 with SMTP id 26so981018pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 04 May 2011 22:58:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hai,

I am building an ALSA ASoC driver based on the original twl6040 driver 
on omap 4 panda board. I notice that there is a platform_device being 
created in the machine driver which is getting bound to the 
platform_driver created by the alsa soc core. i.e  "soc-audio".

sound/soc/omap/sd4430.c
================
     sdp4430_snd_device = platform_device_alloc("soc-audio", -1);
     if (!sdp4430_snd_device) {
         printk(KERN_ERR "Platform device allocation failed\n");
         return -ENOMEM;
     }

     snd_soc_register_dais(&sdp4430_snd_device->dev, dai, ARRAY_SIZE(dai));

     platform_set_drvdata(sdp4430_snd_device, &snd_soc_sdp4430);

     ret = platform_device_add(sdp4430_snd_device);

soc-core.c
======
     static struct platform_driver soc_driver = {
         .driver        = {
             .name        = "soc-audio",
             .owner        = THIS_MODULE,
             .pm        = &soc_pm_ops,
         },
         .probe        = soc_probe,
         .remove        = soc_remove,
     };

However, I fail to understand, how the platform_driver in the twl6040.c 
file gets bound and who calls its probe.
sound/soc/codecs/twl6040.c
=================
     static struct platform_driver twl6040_codec_driver = {
         .driver = {
             .name = "twl6040-codec",
             .owner = THIS_MODULE,
         },
         .probe = twl6040_codec_probe,
         .remove = __devexit_p(twl6040_codec_remove),
     };

I have used the same model for my codec device driver and the probe 
function in the codec driver under platform_driver never gets invoked.

Can anyone give me a clarification on this?

Regards,
Preetam
