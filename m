From: noman pouigt <variksla@gmail.com>
Subject: audio mcbsp1 broken for beagleboard-xm -OMAP
Date: Thu, 19 Feb 2015 22:45:00 -0800
Message-ID: <CAES_P+_LNczMuQsUW=ghJ-SQjLn_+AokDHfY4k+zmoFBb8cF0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A9C52605D2
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 07:45:02 +0100 (CET)
Received: by mail-ob0-f180.google.com with SMTP id vb8so22323584obc.11
 for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2015 22:45:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "jarkko.nikula@bitmer.com" <jarkko.nikula@bitmer.com>, "broonie@kernel.org" <broonie@kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello,

I am trying to integrate max98090 codec with $subject board.  I am
running the mcBSP in slave mode as i have not changed the hw_parms for
omap-twl4030.c file. With below changes i see wait_for_avail is
getting stuck i.e. mcbsp is not getting any interrupt and nothing is
playing.

Kernel version:
VERSION = 3
PATCHLEVEL = 19
SUBLEVEL = 0
EXTRAVERSION =
NAME = Diseased Newt

Setup information:
Using beagle board -xm and connected max98090 codec to mcbsp1 pins.
Connected only 4 pins.

Changed the omap-twl4030.c machine file as below to disable the twl4030:
static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
       {
+               .name = "max98090",
+               .stream_name = "max98090",
               .cpu_dai_name = "omap-mcbsp.1",
+               .codec_dai_name = "HiFi",
               .platform_name = "omap-mcbsp.1",
+               .codec_name = "max98090.1-0010",
               .ops = &omap_twl4030_ops,
       },

DTSI file change:arch/arm/boot/dts/omap3-beagle-xm.dts

&i2c2 {
       clock-frequency = <400000>;
+
+       max98090: max98090@10 {
+               compatible = "maxim,max98090";
+               reg = <0x10>;
+       };
};

omap/omap-twl4030.c
added in hw_params below function to set internal oscillator for 98090
for generating PLL for master clock.
snd_soc_dai_set_sysclk(codec_dai, 26000000, 0, SND_SOC_CLOCK_IN);

I am able to see that the cpu_dai is mapped with codec_dai and
configuration is ok. kernel logs at https://ideone.com/oezNSj

I think i don't need to configure the mcbsp1 pins right as it uses default.

Please guide me.I have tried IRC channel also but not getting the right folks.

https://github.com/CircuitCo/BeagleBoard-xM-RevC/blob/master/BeagleBoard-xM_revC_SCH.pdf?raw=true

Thanks,
