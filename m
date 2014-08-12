From: Matt Flax <flatmax@flatmax.org>
Subject: generic i2s driver problems on an Exynos 5250 A15 board
Date: Tue, 12 Aug 2014 18:17:15 +1000
Message-ID: <53E9CD8B.4000101@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by alsa0.perex.cz (Postfix) with ESMTP id F03E9261A83
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 10:17:11 +0200 (CEST)
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

hi there,

I am writing a very generic alsa soc i2s driver for a very generic i2s 
device.
The platform is an Exynos 5250 SoC board.

Having trouble was looking for some help ...

I have tried to start this driver in two ways. 1] Using the 
module_init/module_exit method and 2] Using the module_platform_driver 
approach.

I have implemented the following :
soc/codecs/implant.c
soc/samsung/implant.c

In both cases I have :
static struct snd_soc_ops implant_ops = {
     .hw_params = implant_hw_params,
};

static struct snd_soc_dai_link implant_dai = {
     .name        = "implant",
     .stream_name    = "IMPLANT",
     .cpu_dai_name = "samsung-i2s.0",
     .codec_dai_name = "implant-pcm",
     .platform_name = "samsung-i2s.0",
     .codec_name    = "implant.0-001a",
     .ignore_suspend = 1,
     .ops = &implant_ops,
};

I have setup the device tree as expected for sound@3830000
     sound@3830000 {
         samsung,codec-type = "implant";
     };

1]    Approach using module_init/module_exit
static struct snd_soc_card snd_soc_machine_implant = {
     .name        = "Implant",
     .owner        = THIS_MODULE,
     .dai_link    = &implant_dai,
     .num_links    = 1,

     .dapm_widgets    = widgets,
     .num_dapm_widgets = ARRAY_SIZE(widgets),
     .dapm_routes    = audio_paths,
     .num_dapm_routes = ARRAY_SIZE(audio_paths),
};

Here is the output of the kernel :

[    1.802645] soc-audio soc-audio: ASoC: machine Implant should use 
snd_soc_register_card()
[    1.802656] soc-audio soc-audio: ASoC: CPU DAI samsung-i2s.0 not 
registered
[    1.802679] platform soc-audio: Driver soc-audio requests probe deferral
[    2.271140] soc-audio: probe of soc-audio failed with error -22

Not sure why it fails.

The only thing I know is that my driver exits the init function 
returning 0 (module_init(implant_init)).
This appears to be correct.

2]     Approach using module_platform_driver
When I switch to using snd_soc_register_card with :
module_platform_driver(implant_driver);

static struct platform_driver implant_driver = {
     .driver = {
         .name = "implant",
         .owner = THIS_MODULE,
     },
     .probe = implant_probe,
     .remove = implant_remove,
};

I get the following from dmesg :
[    1.802430] Error: Driver 'implant' is already registered, aborting...

However I don't see any of my printk statements from dmesg ...


Matt
